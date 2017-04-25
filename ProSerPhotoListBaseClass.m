//
//  ProSerPhotoListBaseClass.m
//
//  Created by shiliuhua  on 17/3/24
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ProSerPhotoListBaseClass.h"


NSString *const kProSerPhotoListBaseClassItname = @"itname";
NSString *const kProSerPhotoListBaseClassId = @"id";
NSString *const kProSerPhotoListBaseClassMemberCard = @"memberCard";
NSString *const kProSerPhotoListBaseClassIname = @"iname";
NSString *const kProSerPhotoListBaseClassIid = @"iid";
NSString *const kProSerPhotoListBaseClassSmallImageUrl = @"smallImageUrl";
NSString *const kProSerPhotoListBaseClassUname = @"uname";
NSString *const kProSerPhotoListBaseClassXssj = @"xssj";
NSString *const kProSerPhotoListBaseClassServiceDateTime = @"serviceDateTime";
NSString *const kProSerPhotoListBaseClassBigImageUrl = @"bigImageUrl";


@interface ProSerPhotoListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProSerPhotoListBaseClass

@synthesize itname = _itname;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize memberCard = _memberCard;
@synthesize iname = _iname;
@synthesize iid = _iid;
@synthesize smallImageUrl = _smallImageUrl;
@synthesize uname = _uname;
@synthesize xssj = _xssj;
@synthesize serviceDateTime = _serviceDateTime;
@synthesize bigImageUrl = _bigImageUrl;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.itname = [self objectOrNilForKey:kProSerPhotoListBaseClassItname fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kProSerPhotoListBaseClassId fromDictionary:dict] doubleValue];
            self.memberCard = [self objectOrNilForKey:kProSerPhotoListBaseClassMemberCard fromDictionary:dict];
            self.iname = [self objectOrNilForKey:kProSerPhotoListBaseClassIname fromDictionary:dict];
            self.iid = [self objectOrNilForKey:kProSerPhotoListBaseClassIid fromDictionary:dict];
            self.smallImageUrl = [self objectOrNilForKey:kProSerPhotoListBaseClassSmallImageUrl fromDictionary:dict];
            self.uname = [self objectOrNilForKey:kProSerPhotoListBaseClassUname fromDictionary:dict];
            self.xssj = [self objectOrNilForKey:kProSerPhotoListBaseClassXssj fromDictionary:dict];
            self.serviceDateTime = [self objectOrNilForKey:kProSerPhotoListBaseClassServiceDateTime fromDictionary:dict];
            self.bigImageUrl = [self objectOrNilForKey:kProSerPhotoListBaseClassBigImageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.itname forKey:kProSerPhotoListBaseClassItname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kProSerPhotoListBaseClassId];
    [mutableDict setValue:self.memberCard forKey:kProSerPhotoListBaseClassMemberCard];
    [mutableDict setValue:self.iname forKey:kProSerPhotoListBaseClassIname];
    [mutableDict setValue:self.iid forKey:kProSerPhotoListBaseClassIid];
    [mutableDict setValue:self.smallImageUrl forKey:kProSerPhotoListBaseClassSmallImageUrl];
    [mutableDict setValue:self.uname forKey:kProSerPhotoListBaseClassUname];
    [mutableDict setValue:self.xssj forKey:kProSerPhotoListBaseClassXssj];
    [mutableDict setValue:self.serviceDateTime forKey:kProSerPhotoListBaseClassServiceDateTime];
    [mutableDict setValue:self.bigImageUrl forKey:kProSerPhotoListBaseClassBigImageUrl];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.itname = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassItname];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kProSerPhotoListBaseClassId];
    self.memberCard = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassMemberCard];
    self.iname = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassIname];
    self.iid = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassIid];
    self.smallImageUrl = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassSmallImageUrl];
    self.uname = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassUname];
    self.xssj = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassXssj];
    self.serviceDateTime = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassServiceDateTime];
    self.bigImageUrl = [aDecoder decodeObjectForKey:kProSerPhotoListBaseClassBigImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_itname forKey:kProSerPhotoListBaseClassItname];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kProSerPhotoListBaseClassId];
    [aCoder encodeObject:_memberCard forKey:kProSerPhotoListBaseClassMemberCard];
    [aCoder encodeObject:_iname forKey:kProSerPhotoListBaseClassIname];
    [aCoder encodeObject:_iid forKey:kProSerPhotoListBaseClassIid];
    [aCoder encodeObject:_smallImageUrl forKey:kProSerPhotoListBaseClassSmallImageUrl];
    [aCoder encodeObject:_uname forKey:kProSerPhotoListBaseClassUname];
    [aCoder encodeObject:_xssj forKey:kProSerPhotoListBaseClassXssj];
    [aCoder encodeObject:_serviceDateTime forKey:kProSerPhotoListBaseClassServiceDateTime];
    [aCoder encodeObject:_bigImageUrl forKey:kProSerPhotoListBaseClassBigImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProSerPhotoListBaseClass *copy = [[ProSerPhotoListBaseClass alloc] init];
    
    if (copy) {

        copy.itname = [self.itname copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.memberCard = [self.memberCard copyWithZone:zone];
        copy.iname = [self.iname copyWithZone:zone];
        copy.iid = [self.iid copyWithZone:zone];
        copy.smallImageUrl = [self.smallImageUrl copyWithZone:zone];
        copy.uname = [self.uname copyWithZone:zone];
        copy.xssj = [self.xssj copyWithZone:zone];
        copy.serviceDateTime = [self.serviceDateTime copyWithZone:zone];
        copy.bigImageUrl = [self.bigImageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
