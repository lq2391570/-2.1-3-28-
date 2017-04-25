//
//  SerRecordBaseClass.m
//
//  Created by shiliuhua  on 17/3/24
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "SerRecordBaseClass.h"


NSString *const kSerRecordBaseClassSename = @"sename";
NSString *const kSerRecordBaseClassFwxpcount = @"fwxpcount";
NSString *const kSerRecordBaseClassIname = @"iname";
NSString *const kSerRecordBaseClassFwzpcount = @"fwzpcount";
NSString *const kSerRecordBaseClassIid = @"iid";
NSString *const kSerRecordBaseClassFwsj = @"fwsj";
NSString *const kSerRecordBaseClassUname = @"uname";
NSString *const kSerRecordBaseClassGsnumber = @"gsnumber";


@interface SerRecordBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SerRecordBaseClass

@synthesize sename = _sename;
@synthesize fwxpcount = _fwxpcount;
@synthesize iname = _iname;
@synthesize fwzpcount = _fwzpcount;
@synthesize iid = _iid;
@synthesize fwsj = _fwsj;
@synthesize uname = _uname;
@synthesize gsnumber = _gsnumber;


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
            self.sename = [self objectOrNilForKey:kSerRecordBaseClassSename fromDictionary:dict];
            self.fwxpcount = [[self objectOrNilForKey:kSerRecordBaseClassFwxpcount fromDictionary:dict] doubleValue];
            self.iname = [self objectOrNilForKey:kSerRecordBaseClassIname fromDictionary:dict];
            self.fwzpcount = [[self objectOrNilForKey:kSerRecordBaseClassFwzpcount fromDictionary:dict] doubleValue];
            self.iid = [self objectOrNilForKey:kSerRecordBaseClassIid fromDictionary:dict];
            self.fwsj = [self objectOrNilForKey:kSerRecordBaseClassFwsj fromDictionary:dict];
            self.uname = [self objectOrNilForKey:kSerRecordBaseClassUname fromDictionary:dict];
            self.gsnumber = [self objectOrNilForKey:kSerRecordBaseClassGsnumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.sename forKey:kSerRecordBaseClassSename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fwxpcount] forKey:kSerRecordBaseClassFwxpcount];
    [mutableDict setValue:self.iname forKey:kSerRecordBaseClassIname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fwzpcount] forKey:kSerRecordBaseClassFwzpcount];
    [mutableDict setValue:self.iid forKey:kSerRecordBaseClassIid];
    [mutableDict setValue:self.fwsj forKey:kSerRecordBaseClassFwsj];
    [mutableDict setValue:self.uname forKey:kSerRecordBaseClassUname];
    [mutableDict setValue:self.gsnumber forKey:kSerRecordBaseClassGsnumber];

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

    self.sename = [aDecoder decodeObjectForKey:kSerRecordBaseClassSename];
    self.fwxpcount = [aDecoder decodeDoubleForKey:kSerRecordBaseClassFwxpcount];
    self.iname = [aDecoder decodeObjectForKey:kSerRecordBaseClassIname];
    self.fwzpcount = [aDecoder decodeDoubleForKey:kSerRecordBaseClassFwzpcount];
    self.iid = [aDecoder decodeObjectForKey:kSerRecordBaseClassIid];
    self.fwsj = [aDecoder decodeObjectForKey:kSerRecordBaseClassFwsj];
    self.uname = [aDecoder decodeObjectForKey:kSerRecordBaseClassUname];
    self.gsnumber = [aDecoder decodeObjectForKey:kSerRecordBaseClassGsnumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sename forKey:kSerRecordBaseClassSename];
    [aCoder encodeDouble:_fwxpcount forKey:kSerRecordBaseClassFwxpcount];
    [aCoder encodeObject:_iname forKey:kSerRecordBaseClassIname];
    [aCoder encodeDouble:_fwzpcount forKey:kSerRecordBaseClassFwzpcount];
    [aCoder encodeObject:_iid forKey:kSerRecordBaseClassIid];
    [aCoder encodeObject:_fwsj forKey:kSerRecordBaseClassFwsj];
    [aCoder encodeObject:_uname forKey:kSerRecordBaseClassUname];
    [aCoder encodeObject:_gsnumber forKey:kSerRecordBaseClassGsnumber];
}

- (id)copyWithZone:(NSZone *)zone
{
    SerRecordBaseClass *copy = [[SerRecordBaseClass alloc] init];
    
    if (copy) {

        copy.sename = [self.sename copyWithZone:zone];
        copy.fwxpcount = self.fwxpcount;
        copy.iname = [self.iname copyWithZone:zone];
        copy.fwzpcount = self.fwzpcount;
        copy.iid = [self.iid copyWithZone:zone];
        copy.fwsj = [self.fwsj copyWithZone:zone];
        copy.uname = [self.uname copyWithZone:zone];
        copy.gsnumber = [self.gsnumber copyWithZone:zone];
    }
    
    return copy;
}


@end
