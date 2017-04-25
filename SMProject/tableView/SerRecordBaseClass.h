//
//  SerRecordBaseClass.h
//
//  Created by shiliuhua  on 17/3/24
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SerRecordBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *sename;
@property (nonatomic, assign) double fwxpcount;
@property (nonatomic, strong) NSString *iname;
@property (nonatomic, assign) double fwzpcount;
@property (nonatomic, strong) NSString *iid;
@property (nonatomic, strong) NSString *fwsj;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *gsnumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
