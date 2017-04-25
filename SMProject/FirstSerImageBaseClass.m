//
//  FirstSerImageBaseClass.m
//
//  Created by shiliuhua  on 17/3/23
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "FirstSerImageBaseClass.h"


NSString *const kFirstSerImageBaseClassBigImageUrl = @"bigImageUrl";
NSString *const kFirstSerImageBaseClassId = @"id";
NSString *const kFirstSerImageBaseClassMemberCard = @"memberCard";
NSString *const kFirstSerImageBaseClassSmallImageUrl = @"smallImageUrl";
NSString *const kFirstSerImageBaseClassServiceDateTime = @"serviceDateTime";


@interface FirstSerImageBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FirstSerImageBaseClass

@synthesize bigImageUrl = _bigImageUrl;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize memberCard = _memberCard;
@synthesize smallImageUrl = _smallImageUrl;
@synthesize serviceDateTime = _serviceDateTime;


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
            self.bigImageUrl = [self objectOrNilForKey:kFirstSerImageBaseClassBigImageUrl fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kFirstSerImageBaseClassId fromDictionary:dict] doubleValue];
            self.memberCard = [self objectOrNilForKey:kFirstSerImageBaseClassMemberCard fromDictionary:dict];
            self.smallImageUrl = [self objectOrNilForKey:kFirstSerImageBaseClassSmallImageUrl fromDictionary:dict];
            self.serviceDateTime = [self objectOrNilForKey:kFirstSerImageBaseClassServiceDateTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.bigImageUrl forKey:kFirstSerImageBaseClassBigImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kFirstSerImageBaseClassId];
    [mutableDict setValue:self.memberCard forKey:kFirstSerImageBaseClassMemberCard];
    [mutableDict setValue:self.smallImageUrl forKey:kFirstSerImageBaseClassSmallImageUrl];
    [mutableDict setValue:self.serviceDateTime forKey:kFirstSerImageBaseClassServiceDateTime];

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

    self.bigImageUrl = [aDecoder decodeObjectForKey:kFirstSerImageBaseClassBigImageUrl];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kFirstSerImageBaseClassId];
    self.memberCard = [aDecoder decodeObjectForKey:kFirstSerImageBaseClassMemberCard];
    self.smallImageUrl = [aDecoder decodeObjectForKey:kFirstSerImageBaseClassSmallImageUrl];
    self.serviceDateTime = [aDecoder decodeObjectForKey:kFirstSerImageBaseClassServiceDateTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_bigImageUrl forKey:kFirstSerImageBaseClassBigImageUrl];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kFirstSerImageBaseClassId];
    [aCoder encodeObject:_memberCard forKey:kFirstSerImageBaseClassMemberCard];
    [aCoder encodeObject:_smallImageUrl forKey:kFirstSerImageBaseClassSmallImageUrl];
    [aCoder encodeObject:_serviceDateTime forKey:kFirstSerImageBaseClassServiceDateTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    FirstSerImageBaseClass *copy = [[FirstSerImageBaseClass alloc] init];
    
    if (copy) {

        copy.bigImageUrl = [self.bigImageUrl copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.memberCard = [self.memberCard copyWithZone:zone];
        copy.smallImageUrl = [self.smallImageUrl copyWithZone:zone];
        copy.serviceDateTime = [self.serviceDateTime copyWithZone:zone];
    }
    
    return copy;
}


@end
