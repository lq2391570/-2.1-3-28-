//
//  EBookManage.h
//  SMProject
//
//  Created by arvin yan on 4/15/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectManage.h"
#define kWSPath LocationIp
#define kEBookPath [NSString stringWithFormat:@"%@findAllEbookToIpad?compId=",LocationIp]
#define kEBookDetailPath [NSString stringWithFormat:@"%@findImagesLinkToIpad?comp.imagesIds=",LocationIp]

@interface EBookInfo : NSObject

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

- (EBookInfo *)init;

@end

@interface ImageInfo : NSObject

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
@property (nonatomic, strong) NSString * imagID;

- (ImageInfo *)init;

@end

//@interface OrderInfo : NSObject
//
//@property (nonatomic, strong) NSString * ID;
//@property (nonatomic, strong) NSString * name;
//@property (nonatomic, strong) NSString * price;
//@property (nonatomic, strong) NSString * money;
//@property (nonatomic, strong) NSString * rate;
//@property (nonatomic, strong) NSString * batch;
//@property (nonatomic, strong) NSString * counts;
//@property (nonatomic, strong) NSString * produce;
//@property (nonatomic, strong) NSString * type;
//@property (nonatomic, strong) NSString * skpmount;
//
//- (OrderInfo *)init;
//
//@end


@interface EBookManage : NSObject

@property (nonatomic,strong) NSString * redirectFlag;

+ (id)shardSingleton;
- (void)getBookRecordwithid:(NSString *)ID retun:(NSArray **)array;
- (void)getDetailRecordWithID:(NSString *)queryID returnList:(NSArray **)array;
- (void)searchInDbBycompId:(NSString *)ID returnArray:(NSArray **)array;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url withCoverName:(NSString *)name;
//- (NSDictionary *)getDetailRecordWithID:(NSString *)queryID;
- (BOOL)insertBookInfo:(ImageInfo *)info;
- (BOOL)isExistImageWithName:(NSString *)url withVersion:(NSString *)version withType:(int)type;
- (NSArray *)getBookRecordByImageName:(NSString *)name;
- (NSArray *)getBookRecordByVersion:(NSString *)version;
- (BOOL)deleteBookInfo:(NSString *)moduleID;

- (void)insertCompInDB:(EBookInfo *)info;

- (NSMutableArray *)findcoverbycompid:(NSString *)ID andArray:(NSMutableArray *)array;
- (BOOL)deletecover:(NSArray *)array;
- (NSMutableArray *)findbackBycompId:(NSString *)ID;
- (NSDictionary *)jsonParseWithURL:(NSString *)imageUrl;
- (BOOL)deleteOrderRecord:(NSString *)name;
- (BOOL)insertOrderInfo:(OrderInfo *)info;
@end
