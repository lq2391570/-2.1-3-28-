//
//  QDManage.h
//  SMProject
//
//  Created by arvin yan on 4/22/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface QDVideoInfo : NSObject

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * videoUrl;
@property (nonatomic, strong) NSString * videoName;

@end

@interface QDManage : NSObject

+ (id)shardSingleton;
- (BOOL)insertQDInfo:(QDVideoInfo *)info;
- (BOOL)isExistImageWithName:(NSString *)url;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url;
- (NSArray *)getQDRecord;
@end
