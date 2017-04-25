//
//  ProjectListNewBaseClass.m
//
//  Created by shiliuhua  on 17/3/24
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ProjectListNewBaseClass.h"


NSString *const kProjectListNewBaseClassXssj = @"xssj";
NSString *const kProjectListNewBaseClassIname = @"iname";
NSString *const kProjectListNewBaseClassUname = @"uname";
NSString *const kProjectListNewBaseClassItname = @"itname";
NSString *const kProjectListNewBaseClassIid = @"iid";
NSString *const kProjectListNewBaseClassCount = @"count";


@interface ProjectListNewBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProjectListNewBaseClass

@synthesize xssj = _xssj;
@synthesize iname = _iname;
@synthesize uname = _uname;
@synthesize itname = _itname;
@synthesize iid = _iid;
@synthesize count = _count;


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
            self.xssj = [self objectOrNilForKey:kProjectListNewBaseClassXssj fromDictionary:dict];
            self.iname = [self objectOrNilForKey:kProjectListNewBaseClassIname fromDictionary:dict];
            self.uname = [self objectOrNilForKey:kProjectListNewBaseClassUname fromDictionary:dict];
            self.itname = [self objectOrNilForKey:kProjectListNewBaseClassItname fromDictionary:dict];
            self.iid = [self objectOrNilForKey:kProjectListNewBaseClassIid fromDictionary:dict];
            self.count = [[self objectOrNilForKey:kProjectListNewBaseClassCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.xssj forKey:kProjectListNewBaseClassXssj];
    [mutableDict setValue:self.iname forKey:kProjectListNewBaseClassIname];
    [mutableDict setValue:self.uname forKey:kProjectListNewBaseClassUname];
    [mutableDict setValue:self.itname forKey:kProjectListNewBaseClassItname];
    [mutableDict setValue:self.iid forKey:kProjectListNewBaseClassIid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kProjectListNewBaseClassCount];

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

    self.xssj = [aDecoder decodeObjectForKey:kProjectListNewBaseClassXssj];
    self.iname = [aDecoder decodeObjectForKey:kProjectListNewBaseClassIname];
    self.uname = [aDecoder decodeObjectForKey:kProjectListNewBaseClassUname];
    self.itname = [aDecoder decodeObjectForKey:kProjectListNewBaseClassItname];
    self.iid = [aDecoder decodeObjectForKey:kProjectListNewBaseClassIid];
    self.count = [aDecoder decodeDoubleForKey:kProjectListNewBaseClassCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_xssj forKey:kProjectListNewBaseClassXssj];
    [aCoder encodeObject:_iname forKey:kProjectListNewBaseClassIname];
    [aCoder encodeObject:_uname forKey:kProjectListNewBaseClassUname];
    [aCoder encodeObject:_itname forKey:kProjectListNewBaseClassItname];
    [aCoder encodeObject:_iid forKey:kProjectListNewBaseClassIid];
    [aCoder encodeDouble:_count forKey:kProjectListNewBaseClassCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProjectListNewBaseClass *copy = [[ProjectListNewBaseClass alloc] init];
    
    if (copy) {

        copy.xssj = [self.xssj copyWithZone:zone];
        copy.iname = [self.iname copyWithZone:zone];
        copy.uname = [self.uname copyWithZone:zone];
        copy.itname = [self.itname copyWithZone:zone];
        copy.iid = [self.iid copyWithZone:zone];
        copy.count = self.count;
    }
    
    return copy;
}


@end
