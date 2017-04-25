//
//  InformationManage.h
//  SMProject
//
//  Created by 石榴花科技 on 14-4-29.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWSPath LocationIp
#define kEBookPath [NSString stringWithFormat:@"%@findAllCelebrationToIpad?compId=",LocationIp]
#define kEBookDetailPath [NSString stringWithFormat:@"%@findImagesLinkToIpad?comp.imagesIds=",LocationIp]

@interface InformationInfo : NSObject
{
    
}
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * imagesIDs;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * startX;
@property (nonatomic, strong) NSString * endX;
@property (nonatomic, strong) NSString * startY;
@property (nonatomic, strong) NSString * endY;
@property (nonatomic, strong) NSString * bookVersion;
@property (nonatomic, strong) NSString * compId;

@property (nonatomic, strong) NSMutableArray * link;
@property (nonatomic, strong) NSMutableArray * urlArray;
@property (nonatomic, strong) NSMutableArray * detailImageArray;
@property (nonatomic, strong) NSMutableArray * smallLinksArray;

- (InformationInfo *)init;

@end

@interface IImageInfo : NSObject
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * startX;
@property (nonatomic, strong) NSString * endX;
@property (nonatomic, strong) NSString * startY;
@property (nonatomic, strong) NSString * endY;
@property (nonatomic, strong) NSString * linkurl;
@property (nonatomic, strong) NSString * bookVersion;
@property (nonatomic, strong) NSString * type;

- (IImageInfo *)init;

@end


@interface InformationManage : NSObject

@property (nonatomic,strong) NSString * redirectFlag;

+ (id)shardSingleton;
- (void)getBookRecordwithid:(NSString *)ID retun:(NSArray **)array;
- (void)searchInDbBycompId:(NSString *)ID returnArray:(NSArray **)array;

- (void)getDetailRecordWithID:(NSString *)queryID returnList:(NSArray **)array;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url withCoverName:(NSString *)name;
- (NSDictionary *)getDetailRecordWithID:(NSString *)queryID;
- (BOOL)insertBookInfo:(InformationInfo *)info;
- (BOOL)isExistImageWithName:(NSString *)url withVersion:(NSString *)version withType:(int)type;
- (NSArray *)getBookRecordByImageName:(NSString *)name;
- (NSArray *)getBookRecordByVersion:(NSString *)version;
- (BOOL)deleteBookInfo:(NSString *)moduleID;

- (void)insertCompInDB:(InformationInfo *)info;

- (NSMutableArray *)findcoverbycompid:(NSString *)ID andArray:(NSMutableArray *)array;
- (BOOL)deletecover:(NSArray *)array;
- (NSMutableArray *)findbackBycompId:(NSString *)ID;

@end
