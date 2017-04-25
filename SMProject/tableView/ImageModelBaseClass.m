//
//  ImageModelBaseClass.m
//
//  Created by shiliuhua  on 16/5/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ImageModelBaseClass.h"


NSString *const kImageModelBaseClassArchiveState = @"archiveState";
NSString *const kImageModelBaseClassId = @"id";
NSString *const kImageModelBaseClassMemberCard = @"memberCard";
NSString *const kImageModelBaseClassArchiveImageUrl = @"archiveImageUrl";
NSString *const kImageModelBaseClassArchiveDateTime = @"archiveDateTime";
NSString *const kImageModelBaseClassArchiveNumber = @"archiveNumber";
NSString *const kImageModelBaseClassArchiveSmallImageUrl = @"archiveSmallImageUrl";

@interface ImageModelBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImageModelBaseClass

@synthesize archiveState = _archiveState;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize memberCard = _memberCard;
@synthesize archiveImageUrl = _archiveImageUrl;
@synthesize archiveDateTime = _archiveDateTime;
@synthesize archiveNumber = _archiveNumber;
@synthesize archiveSmallImageUrl=_archiveSmallImageUrl;

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
            self.archiveState = [[self objectOrNilForKey:kImageModelBaseClassArchiveState fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kImageModelBaseClassId fromDictionary:dict] doubleValue];
            self.memberCard = [self objectOrNilForKey:kImageModelBaseClassMemberCard fromDictionary:dict];
            self.archiveImageUrl = [self objectOrNilForKey:kImageModelBaseClassArchiveImageUrl fromDictionary:dict];
            self.archiveDateTime = [self objectOrNilForKey:kImageModelBaseClassArchiveDateTime fromDictionary:dict];
            self.archiveNumber = [self objectOrNilForKey:kImageModelBaseClassArchiveNumber fromDictionary:dict];
        self.archiveSmallImageUrl=[self objectOrNilForKey:kImageModelBaseClassArchiveSmallImageUrl fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.archiveState] forKey:kImageModelBaseClassArchiveState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kImageModelBaseClassId];
    [mutableDict setValue:self.memberCard forKey:kImageModelBaseClassMemberCard];
    [mutableDict setValue:self.archiveImageUrl forKey:kImageModelBaseClassArchiveImageUrl];
    [mutableDict setValue:self.archiveDateTime forKey:kImageModelBaseClassArchiveDateTime];
    [mutableDict setValue:self.archiveNumber forKey:kImageModelBaseClassArchiveNumber];
    [mutableDict setValue:self.archiveSmallImageUrl forKey:kImageModelBaseClassArchiveSmallImageUrl];
    
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

    self.archiveState = [aDecoder decodeDoubleForKey:kImageModelBaseClassArchiveState];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kImageModelBaseClassId];
    self.memberCard = [aDecoder decodeObjectForKey:kImageModelBaseClassMemberCard];
    self.archiveImageUrl = [aDecoder decodeObjectForKey:kImageModelBaseClassArchiveImageUrl];
    self.archiveDateTime = [aDecoder decodeObjectForKey:kImageModelBaseClassArchiveDateTime];
    self.archiveNumber = [aDecoder decodeObjectForKey:kImageModelBaseClassArchiveNumber];
    self.archiveSmallImageUrl=[aDecoder decodeObjectForKey:kImageModelBaseClassArchiveSmallImageUrl];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_archiveState forKey:kImageModelBaseClassArchiveState];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kImageModelBaseClassId];
    [aCoder encodeObject:_memberCard forKey:kImageModelBaseClassMemberCard];
    [aCoder encodeObject:_archiveImageUrl forKey:kImageModelBaseClassArchiveImageUrl];
    [aCoder encodeObject:_archiveDateTime forKey:kImageModelBaseClassArchiveDateTime];
    [aCoder encodeObject:_archiveNumber forKey:kImageModelBaseClassArchiveNumber];
    [aCoder encodeObject:_archiveSmallImageUrl forKey:kImageModelBaseClassArchiveSmallImageUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImageModelBaseClass *copy = [[ImageModelBaseClass alloc] init];
    
    if (copy) {

        copy.archiveState = self.archiveState;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.memberCard = [self.memberCard copyWithZone:zone];
        copy.archiveImageUrl = [self.archiveImageUrl copyWithZone:zone];
        copy.archiveDateTime = [self.archiveDateTime copyWithZone:zone];
        copy.archiveNumber = [self.archiveNumber copyWithZone:zone];
        copy.archiveSmallImageUrl=[self.archiveSmallImageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
