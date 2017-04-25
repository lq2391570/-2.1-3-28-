//
//  ProjectList.m
//
//  Created by shiliuhua  on 17/3/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ProjectList.h"


NSString *const kProjectListXssj = @"xssj";
NSString *const kProjectListIname = @"iname";
NSString *const kProjectListUname = @"uname";
NSString *const kProjectListItname = @"itname";
NSString *const kProjectListIid = @"iid";


@interface ProjectList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProjectList

@synthesize xssj = _xssj;
@synthesize iname = _iname;
@synthesize uname = _uname;
@synthesize itname = _itname;
@synthesize iid = _iid;


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
            self.xssj = [self objectOrNilForKey:kProjectListXssj fromDictionary:dict];
            self.iname = [self objectOrNilForKey:kProjectListIname fromDictionary:dict];
            self.uname = [self objectOrNilForKey:kProjectListUname fromDictionary:dict];
            self.itname = [self objectOrNilForKey:kProjectListItname fromDictionary:dict];
            self.iid = [self objectOrNilForKey:kProjectListIid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.xssj forKey:kProjectListXssj];
    [mutableDict setValue:self.iname forKey:kProjectListIname];
    [mutableDict setValue:self.uname forKey:kProjectListUname];
    [mutableDict setValue:self.itname forKey:kProjectListItname];
    [mutableDict setValue:self.iid forKey:kProjectListIid];

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

    self.xssj = [aDecoder decodeObjectForKey:kProjectListXssj];
    self.iname = [aDecoder decodeObjectForKey:kProjectListIname];
    self.uname = [aDecoder decodeObjectForKey:kProjectListUname];
    self.itname = [aDecoder decodeObjectForKey:kProjectListItname];
    self.iid = [aDecoder decodeObjectForKey:kProjectListIid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_xssj forKey:kProjectListXssj];
    [aCoder encodeObject:_iname forKey:kProjectListIname];
    [aCoder encodeObject:_uname forKey:kProjectListUname];
    [aCoder encodeObject:_itname forKey:kProjectListItname];
    [aCoder encodeObject:_iid forKey:kProjectListIid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProjectList *copy = [[ProjectList alloc] init];
    
    if (copy) {

        copy.xssj = [self.xssj copyWithZone:zone];
        copy.iname = [self.iname copyWithZone:zone];
        copy.uname = [self.uname copyWithZone:zone];
        copy.itname = [self.itname copyWithZone:zone];
        copy.iid = [self.iid copyWithZone:zone];
    }
    
    return copy;
}


@end
