//
//  DataBaseTool.m
//  SMProject
//
//  Created by DAIjun on 15-1-7.
//  Copyright (c) 2015年 石榴花科技. All rights reserved.
//

#import "DataBaseTool.h"
#import "FMDatabase.h"

@implementation DataBaseTool
FMDatabase *_db = nil;
+(void)initDatabase{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
    NSString *sandBoxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.sqlite"];
    NSFileManager *manager = [NSFileManager defaultManager];
    //如果沙盒Documents中没有数据库文件，就从工程文件夹中赋值过去一份
    if (![manager fileExistsAtPath:sandBoxPath]) {
        [manager copyItemAtPath:sourcePath toPath:sandBoxPath error:nil];
    }
    _db = [[FMDatabase alloc] initWithPath:sandBoxPath];
    [_db setShouldCacheStatements:YES];
    [_db open];
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS High (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone INTEGER)";
    
    //执行一条修改语句
    [_db executeUpdate:sql];
    
}

@end
