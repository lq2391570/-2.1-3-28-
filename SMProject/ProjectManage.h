//
//  ProjectManage.h
//  SMProject
//
//  Created by 石榴花科技 on 14-4-21.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWSPath LocationIp
#define kEBookPath [NSString stringWithFormat:@"%@findAllProjectManualToIpad?compId=",LocationIp]
#define kEBookDetailPath  [NSString stringWithFormat:@"%@findImagesLinkToIpad?comp.imagesIds=",LocationIp]

@interface ProjectInfo : NSObject
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

- (ProjectInfo *)init;

@end

@interface PImageInfo : NSObject
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * startX;
@property (nonatomic, strong) NSString * endX;
@property (nonatomic, strong) NSString * startY;
@property (nonatomic, strong) NSString * endY;
//@property (nonatomic, strong) NSNumber * startX;
//@property (nonatomic, strong) NSNumber * endX;
//@property (nonatomic, strong) NSNumber * startY;
//@property (nonatomic, strong) NSNumber * endY;

@property (nonatomic, strong) NSString * linkurl;

@property (nonatomic, strong) NSString * bookVersion;
@property (nonatomic, strong) NSString * type;

- (PImageInfo *)init;

@end

@interface OrderInfo : NSObject

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * rate;
@property (nonatomic, strong) NSString * batch;
@property (nonatomic, strong) NSString * counts;
@property (nonatomic, strong) NSString * produce;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * skpmount;

- (OrderInfo *)init;

@end

@interface ProjectManage : NSObject

@property (nonatomic,strong) NSString * redirectFlag;

+ (id)shardSingleton;
- (void)getBookRecordwithid:(NSString *)ID retun:(NSArray **)array;
- (void)searchInDbBycompId:(NSString *)ID returnArray:(NSArray **)array;
- (void)getDetailRecordWithID:(NSString *)queryID returnList:(NSArray **)array;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url;
- (void)saveImage:(UIImage *)image withURL:(NSString *)url withCoverName:(NSString *)name;
- (NSDictionary *)getDetailRecordWithID:(NSString *)queryID;
- (BOOL)insertBookInfo:(PImageInfo *)info;
- (BOOL)isExistImageWithName:(NSString *)url withVersion:(NSString *)version withType:(int)type;
- (NSArray *)getBookRecordByImageName:(NSString *)name;
- (NSArray *)getBookRecordByVersion:(NSString *)version;
- (BOOL)deleteBookInfo:(NSString *)moduleID;

- (void)insertCompInDB:(ProjectInfo *)info;

- (NSMutableArray *)findcoverbycompid:(NSString *)ID andArray:(NSMutableArray *)array;
- (BOOL)deletecover:(NSArray *)array;
- (NSMutableArray *)findbackBycompId:(NSString *)ID;
- (NSArray *)getOrderRecordWithType:(NSString *)type;
- (BOOL)insertOrderInfo:(OrderInfo *)info;
- (BOOL)updateOrderInfo:(OrderInfo *)info;
- (int)isExistOrderWithID:(NSString *)ID;
- (BOOL)deleteRecords;
- (BOOL)deleteOrderRecordWithName:(NSString *)name;
- (BOOL)updateOrder:(OrderInfo *)info;
@end
