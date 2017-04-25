//
//  ImageModelBaseClass.h
//
//  Created by shiliuhua  on 16/5/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ImageModelBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double archiveState;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *memberCard;
@property (nonatomic, strong) NSString *archiveImageUrl;
@property (nonatomic, strong) NSString *archiveDateTime;
@property (nonatomic, strong) NSString *archiveNumber;
@property (nonatomic,strong)NSString *archiveSmallImageUrl;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
