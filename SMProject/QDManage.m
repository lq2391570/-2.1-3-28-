//
//  QDManage.m
//  SMProject
//
//  Created by arvin yan on 4/22/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "QDManage.h"

@implementation QDVideoInfo

@synthesize ID = _ID;
@synthesize videoName= _videoName;
@synthesize name = _name;
@synthesize imgUrl = _imgUrl;
@synthesize videoUrl = _videoUrl;


- (QDVideoInfo *)init
{
	self = [super init];
	return self;
}

@end

@implementation QDManage

+ (id)shardSingleton
{
    static dispatch_once_t pred;
    static QDManage * instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

- (NSDictionary *)jsonParseWithURL:(NSString *)imageUrl
{
    NSError * error = nil;
    
    //初始化 url
    NSURL* url = [NSURL URLWithString:imageUrl];
    //将文件内容读取到字符串中，
    NSString * jsonString = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"the json string is %@",jsonString);
    //将字符串写到缓冲区。
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonDict || error) {
        NSLog(@"JSON parse failed!");
    }
    return jsonDict;
    
}


- (NSString *)getDBPath
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:@"Project"];
    NSLog(@"the path is %@",dbPath);
    // NSString * dbPath = [modulesInUseDir stringByAppendingPathComponent:@"news.dat"];
    return dbPath;
}

- (void)saveImage:(UIImage *)image withURL:(NSString *)url
{
    NSString * path;
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString * fileName;
    
    if ([url rangeOfString:@"resources/img"].location != NSNotFound ) {
        
        // NSString * dirPath = [NSString stringWithFormat:@"cover/%@",name];
        path = [documentDirectory stringByAppendingPathComponent:@"qdcover"];
        NSArray * array = [url componentsSeparatedByString:@"resources/img/"];
        fileName = [array objectAtIndex:1];
        NSLog(@"the cover path  filename is %@",path);
    }
    else
    {
        return;
    }
    
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSLog(@"the file path is %@ exists",filePath);
        return;
    }
    [UIImageJPEGRepresentation(image, 0.5) writeToFile:filePath atomically:YES];
}


- (BOOL)isExistImageWithName:(NSString *)url
{
    BOOL result = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPath];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            NSString * execSelect;
            execSelect = [NSString stringWithFormat:@"select count(*) from QDVideoInfo where imgUrl = ? "];
    
            sqlite3_stmt * stmt;
            int count = 0;
            
            if (sqlite3_prepare_v2(database, [execSelect UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [url UTF8String], -1, NULL);
                
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    count = sqlite3_column_int(stmt, 0);
                }
            }
            if (count > 0)
            {
                result = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return result;
}

- (BOOL)insertQDInfo:(QDVideoInfo *)info
{
    BOOL execResultSuccess = NO;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * dbPath = [self getDBPath];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        // open database
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            int maxIndex = -1;
            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from QDVideoInfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into QDVideoInfo  (imgUrl,imageName,videoUrl,videoName,ID) values (?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            if (sqlite3_prepare(database, [execSelect UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    maxIndex = sqlite3_column_int(stmt, 0);
                }
            }
            //NSLog(@"maxIndex = %d",maxIndex);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [info.imgUrl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [info.name UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3,   [info.videoUrl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4,   [info.videoName UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 5, maxIndex+1);
            
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            else
            {
                execResultSuccess = YES;
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}

- (NSArray *)getQDRecord
{
    
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSMutableArray * newsArray = [NSMutableArray array];
    NSString * dbPath = [self getDBPath];
    if ([fileManager fileExistsAtPath:dbPath])
    {
        sqlite3 * database;
        if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
        {
            NSLog(@"Failed to open news.dat database!");
            sqlite3_close(database);
            return nil;
        }
        else
            
        {
            QDVideoInfo * videoInfo = nil;
            NSString *select = [NSString stringWithFormat:@"select imgUrl,imageName,videoUrl,ID from QDVideoInfo"];
            sqlite3_stmt *stmt;
            
            if (sqlite3_prepare_v2(database, [select UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    
                    videoInfo = [[QDVideoInfo alloc] init];
                    char * result;
                    result = (char *)sqlite3_column_text(stmt, 0);
                    videoInfo.imgUrl = result ? [NSString stringWithUTF8String : result]:@"";
                    result = (char *)sqlite3_column_text(stmt, 1);
                    videoInfo.name = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 2);
                    videoInfo.videoUrl = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 3);
                    videoInfo.ID = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    [newsArray addObject:videoInfo];
                    NSLog(@"the new array count is %@",newsArray);
                }
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
    return newsArray;
    
}

@end
