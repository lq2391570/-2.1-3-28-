//
//  FirstSerImageBaseClass.h
//
//  Created by shiliuhua  on 17/3/23
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FirstSerImageBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *bigImageUrl;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *memberCard;
@property (nonatomic, strong) NSString *smallImageUrl;
@property (nonatomic, strong) NSString *serviceDateTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
