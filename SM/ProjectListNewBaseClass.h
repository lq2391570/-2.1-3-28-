//
//  ProjectListNewBaseClass.h
//
//  Created by shiliuhua  on 17/3/24
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProjectListNewBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *xssj;
@property (nonatomic, strong) NSString *iname;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *itname;
@property (nonatomic, strong) NSString *iid;
@property (nonatomic, assign) double count;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
