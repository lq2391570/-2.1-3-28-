//
//  InformationManage.m
//  SMProject
//
//  Created by 石榴花科技 on 14-4-29.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "InformationManage.h"

#import <sqlite3.h>

@implementation InformationInfo

@synthesize ID = _ID;
@synthesize imagesIDs = _imagesIDs;
@synthesize name = _name;
@synthesize imgUrl = _imgUrl;
@synthesize link = _link;
@synthesize type = _type;
@synthesize urlArray =_urlArray;
@synthesize startX = _startX;
@synthesize endX =_endX;
@synthesize startY = _startY;
@synthesize endY = _endY;
@synthesize  detailImageArray = _detailImageArray;
@synthesize smallLinksArray = _smallLinksArray;
@synthesize bookVersion = _bookVersion;

- (InformationInfo *)init
{
    self = [super init];
    return self;
}
@end

@implementation IImageInfo

@synthesize ID = _ID;
@synthesize name = _name;
@synthesize imgUrl = _imgUrl;
@synthesize startX = _startX;
@synthesize endX =_endX;
@synthesize startY = _startY;
@synthesize endY = _endY;
@synthesize linkurl = _linkurl;
@synthesize bookVersion = _bookVersion;
@synthesize type = _type;

- (IImageInfo *)init
{
	self = [super init];
	return self;
}


@end


@implementation InformationManage

+ (id)shardSingleton
{
    static dispatch_once_t pred;
    static InformationManage * instance =  nil;
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

- (void)getBookRecordwithid:(NSString *)ID retun:(NSArray **)array
{
    NSString *newurl = [NSString stringWithFormat:@"%@%@",kEBookPath,ID];
    NSLog(@"newUrl is %@",newurl);
    NSDictionary * jsonDict = [self jsonParseWithURL:newurl];
    NSMutableArray * bookArray = [NSMutableArray arrayWithCapacity:10];
    if (jsonDict) {
        for (NSDictionary * dict in jsonDict)
        {
            InformationInfo * bookInfo = [[InformationInfo alloc] init];
            bookInfo.ID = [dict objectForKey:@"id"];
            bookInfo.imagesIDs = [dict objectForKey:@"imagesIds"];
            bookInfo.type = [dict objectForKey:@"type"];
            bookInfo.imgUrl = [dict objectForKey:@"imgUrl"];
            bookInfo.name = [dict objectForKey:@"name"];
            bookInfo.compId = [dict objectForKey:@"compId"];
            [bookArray addObject:bookInfo];
        }

    }
       *array = bookArray;
}

- (void)getDetailRecordWithID:(NSString *)queryID returnList:(NSArray **)array
{
    NSString * url = [kEBookDetailPath stringByAppendingString:queryID];
    NSLog(@"the product url is %@",url);
    NSDictionary * jsonDict = [self jsonParseWithURL:url];
    NSMutableArray * bookArray = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary * dict in jsonDict)
    {
        InformationInfo * bookInfo = [[InformationInfo alloc] init];
        bookInfo.ID = [dict objectForKey:@"id"];
        bookInfo.type = [dict objectForKey:@"type"];
        bookInfo.link = [dict objectForKey:@"link"];
        NSLog(@"the link count is %lu",[[bookInfo link] count]);
        bookInfo.imgUrl = [dict objectForKey:@"imgUrl"];
        bookInfo.bookVersion = [dict objectForKey:@"name"];
        NSLog(@"the book version is %@",bookInfo.bookVersion);
        [bookArray addObject:bookInfo];
    }
    *array = bookArray;
}

- (void)saveImage:(UIImage *)image withURL:(NSString *)url withCoverName:(NSString *)name
{
    NSString * path;
    NSArray * dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [dir objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString * fileName;
    
    if ([url rangeOfString:@"resources/img"].location != NSNotFound ) {
        
        NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"informationCover"];
        path = [dirPath stringByAppendingPathComponent:name];
        
        NSArray * array = [url componentsSeparatedByString:@"resources/img/"];
        fileName = [array objectAtIndex:1];
    }
    else if ([url rangeOfString:@"resources/images"].location != NSNotFound )
    {
        NSString * dirPath = [documentDirectory stringByAppendingPathComponent:@"ephoto"];
        path = [dirPath stringByAppendingPathComponent:name];
        
        NSArray * array = [url componentsSeparatedByString:@"resources/images/"];
        fileName = [array objectAtIndex:1];
    }
    else
    {
        return;
    }
    
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    NSString * filePath = [path stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSLog(@"the file path is %@ exists",filePath);
        return;
    }
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
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
        path = [documentDirectory stringByAppendingPathComponent:@"informationCover"];
        NSArray * array = [url componentsSeparatedByString:@"resources/img/"];
        fileName = [array objectAtIndex:1];
        NSLog(@"the cover path  filename is %@",path);
    }
    else if ([url rangeOfString:@"resources/images"].location != NSNotFound )
    {
        // NSString * dirPath = [NSString stringWithFormat:@"ephoto/%@",name];
        path = [documentDirectory stringByAppendingPathComponent:@"ephoto"];
        NSArray * array = [url componentsSeparatedByString:@"resources/images/"];
        fileName = [array objectAtIndex:1];
        NSLog(@"the filename path is %@",path);
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
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
}


- (NSString *)getDBPath
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:@"High"];
    NSLog(@"the path is %@",dbPath);
    // NSString * dbPath = [modulesInUseDir stringByAppendingPathComponent:@"news.dat"];
    return dbPath;
}

- (BOOL)isExistImageWithName:(NSString *)url withVersion:(NSString *)version withType:(int)type
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
            if (type == 0)
            {
                execSelect = [NSString stringWithFormat:@"select count(*) from newsinfo where imgUrl = ? and version = ?"];
            }
            else
            {
                execSelect = [NSString stringWithFormat:@"select count(*) from newsinfo where linkURL = ? and version = ?"];
                
            }
            sqlite3_stmt * stmt;
            int count = 0;
            
            if (sqlite3_prepare_v2(database, [execSelect UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [url UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [version UTF8String], -1, NULL);
                
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

- (BOOL)insertBookInfo:(IImageInfo *)info
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
            NSString * execSelect = [NSString stringWithFormat:@"select max(id) from newsinfo"];
            NSString * execInsert = [NSString stringWithFormat:@"insert into newsinfo  (version,id,imgUrl,linkURL,startX,startY,endX,endY,type) values (?,?,?,?,?,?,?,?,?);"];
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
                sqlite3_bind_text(stmt, 1, [info.bookVersion UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 2, maxIndex+1);
                
                sqlite3_bind_text(stmt, 3, [info.imgUrl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 4,   [info.linkurl UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 5,   [info.startX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 6,   [info.startY UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 7,   [info.endX UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 8,   [info.endY UTF8String], -1, NULL);
                NSLog(@"%@",info.type);
                sqlite3_bind_int(stmt, 9, [info.type intValue]);
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

- (NSArray *)getBookRecordByImageName:(NSString *)name
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
            IImageInfo  * imageInfo = nil;
            NSString *select = [NSString stringWithFormat:@"select linkURL,startX,startY,endX,endY,type from newsinfo where imgUrl like '%@%@'",@"%",name];
            sqlite3_stmt *stmt;
            
            if (sqlite3_prepare_v2(database, [select UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    
                    imageInfo = [[IImageInfo alloc] init];
                    char * result;
                    result = (char *)sqlite3_column_text(stmt, 0);
                    imageInfo.linkurl = result ? [NSString stringWithUTF8String : result]:@"";
                    NSLog(@" imageInfo.linkurl is %@", imageInfo.linkurl);
                    result = (char *)sqlite3_column_text(stmt, 1);
                    imageInfo.startX = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 2);
                    imageInfo.startY = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 3);
                    imageInfo.endX = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 4);
                    imageInfo.endY = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 5);
                    imageInfo.type = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    [newsArray addObject:imageInfo];
                }
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
    return newsArray;
}

- (NSArray *)getBookRecordByVersion:(NSString *)version
{
    
    NSLog(@"the version is %@",version);
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
            IImageInfo  * imageInfo = nil;
            NSString *select = [NSString stringWithFormat:@"select imgUrl,linkURL,startX,startY,endX,endY from newsinfo where version like '%@%@'",@"%",version];
            sqlite3_stmt *stmt;
            
            if (sqlite3_prepare_v2(database, [select UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    
                    imageInfo = [[IImageInfo alloc] init];
                    char * result;
                    result = (char *)sqlite3_column_text(stmt, 0);
                    imageInfo.imgUrl = result ? [NSString stringWithUTF8String : result]:@"";
                    result = (char *)sqlite3_column_text(stmt, 1);
                    imageInfo.linkurl = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 2);
                    imageInfo.startX = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 3);
                    imageInfo.startY = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 4);
                    imageInfo.endX = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 5);
                    imageInfo.endY = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 6);
                    imageInfo.type = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    [newsArray addObject:imageInfo];
                    NSLog(@"the new array count is %@",newsArray);
                }
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
    return newsArray;
    
}
- (BOOL)deleteBookInfo:(NSString *)moduleID
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
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            NSString * execDelete = @"delete from newsinfo where version = ?";
            if (sqlite3_prepare(database, [execDelete UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_text(stmt, 1, [moduleID UTF8String], -1, NULL);
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"delete from newsinfo table Failed");
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
- (NSMutableArray *)findcoverbycompid:(NSString *)ID andArray:(NSMutableArray *)array
{
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
            execSelect = [NSString stringWithFormat:@"select id from Information where compid = ? "];
            
            NSString * s;
            s = [NSString stringWithFormat:@"select id from Information where compid = %@ ",ID];
            NSLog(@" %@",s);
            
            sqlite3_stmt * stmt;
            
            
            if (sqlite3_prepare_v2(database, [execSelect UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, [ID intValue] );
                BOOL is = NO;
                NSMutableArray *newarray = [NSMutableArray arrayWithCapacity:2];
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    is = YES;
                    char *result = (char *)sqlite3_column_text(stmt, 0);
                    [array addObject:[NSString stringWithUTF8String:result]];
                    [newarray addObject:[NSString stringWithUTF8String:result]];
                }
                if (is) {
                    for (int i = 0; i < newarray.count; i++) {
                        array = [self findcoverbycompid:[newarray objectAtIndex:i] andArray:array];
                    }
                    
                }
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return array;
}

- (BOOL)deletecover:(NSArray *)array
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
            sqlite3_close(database);
        }
        else
        {
            sqlite3_stmt * stmt;
            
            NSString * execDelete = @"delete from Information ";
            
            if (array == nil || array.count == 0) {
                execDelete = [NSString stringWithFormat:@" where 1 != 1 "];
            }else
            {
                for (int i = 0; i <array.count; i++) {
                    if (i == 0){
                        execDelete = [NSString stringWithFormat:@"%@ where id = %@ ",execDelete,[array objectAtIndex:i]];
                    }else{
                        execDelete = [NSString stringWithFormat:@"%@ or id = %@ ",execDelete,[array objectAtIndex:i]];
                    }
                    
                }
            }
            NSLog(@"%@",execDelete);
            
            if (sqlite3_prepare(database, [execDelete UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                
                
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"delete from bookInfo table Failed");
            }
            else{
                execResultSuccess = YES;
            }
            
            
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    return execResultSuccess;
}

- (void)insertCompInDB:(InformationInfo *)info
{
    
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
            
            NSString * execInsert = [NSString stringWithFormat:@"insert into Information  (id,name,imgUrl,compId,imageIds) values (?,?,?,?,?);"];
            NSLog(@"the execInsert is %@",execInsert);
            
            if (sqlite3_prepare(database, [execInsert UTF8String], -1, &stmt, 0) == SQLITE_OK)
            {
                sqlite3_bind_int(stmt, 1, [info.ID intValue]);
                NSString *str1 = [NSString stringWithFormat:@"%@",info.name];
                sqlite3_bind_text(stmt, 2, [str1 UTF8String], -1, NULL);
                NSString *str2 = [NSString stringWithFormat:@"%@",info.imgUrl];
                sqlite3_bind_text(stmt, 3, [str2 UTF8String], -1, NULL);
                sqlite3_bind_int(stmt, 4, [info.compId intValue]);
                NSString *str = [NSString stringWithFormat:@"%@",info.imagesIDs];
                sqlite3_bind_text(stmt, 5,   [str UTF8String], -1, NULL);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"insert to  table Failed");
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
}

- (void)searchInDbBycompId:(NSString *)ID returnArray:(NSArray **)array
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
            return;
        }
        else
            
        {
            InformationInfo  * imageInfo = nil;
            NSString *select = [NSString stringWithFormat:@"select * from Information where compid = %@",ID];
            sqlite3_stmt *stmt;
            
            if (sqlite3_prepare_v2(database, [select UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    
                    imageInfo = [[InformationInfo alloc] init];
                    char * result;
                    result = (char *)sqlite3_column_text(stmt, 0);
                    imageInfo.ID = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 1);
                    imageInfo.name = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 2);
                    imageInfo.compId = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 3);
                    imageInfo.imagesIDs = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 4);
                    imageInfo.imgUrl = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    [newsArray addObject:imageInfo];
                }
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
    *array = newsArray;
}

- (NSMutableArray *)findbackBycompId:(NSString *)ID
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
            InformationInfo  * imageInfo = nil;
            NSString *select = [NSString stringWithFormat:@"select * from Information where compid=(select compid from Information where id=%@)",ID];
            NSLog(@"back id   %@",ID);
            sqlite3_stmt *stmt;
            
            if (sqlite3_prepare_v2(database, [select UTF8String], -1, &stmt, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(stmt) == SQLITE_ROW)
                {
                    
                    imageInfo = [[InformationInfo alloc] init];
                    char * result;
                    result = (char *)sqlite3_column_text(stmt, 0);
                    imageInfo.ID = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 1);
                    imageInfo.name = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 2);
                    imageInfo.compId = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 3);
                    imageInfo.imagesIDs = result ? [NSString stringWithUTF8String : result]:@"";
                    
                    result = (char *)sqlite3_column_text(stmt, 4);
                    imageInfo.imgUrl = result ? [NSString stringWithUTF8String : result]:@"";
                    NSLog(@"imageInfo %@",imageInfo);
                    [newsArray addObject:imageInfo];
                }
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
        }
    }
    
    return newsArray;
}


@end
