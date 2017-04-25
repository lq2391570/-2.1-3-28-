//
//  ACNPageResult.h
//  ACM
//
//  Created by terry zhang on 10-3-18.
//  Copyright 2010 Aicent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACNObject.h"

typedef enum {
	INTERNET_STATUS_ONLINE	= 0,
	INTERNET_STATUS_OFFLINE	= 1,
	INTERNET_STATUS_ERROR	= 2
} ACNInternetStatus;

@interface ACNPageResult : NSObject
{
	NSString * responseData;
@public
	NSInteger statusCode;
	NSString * location;
    NSString * sslErrMsg;
    NSString * originatingServer;
    ACNInternetStatus internetStatus;
    NSString * errorMsg;
}

@property(nonatomic,retain) NSString * responseData;
@property(nonatomic) NSInteger statusCode;
@property(nonatomic,retain) NSString* location;
@property(nonatomic,retain) NSString* sslErrMsg;
@property(nonatomic,retain) NSString* originatingServer;
@property(nonatomic,assign) ACNInternetStatus internetStatus;
@property(nonatomic,retain) NSString * errorMsg;

- (ACNPageResult*) initWithResponseData:(NSString *) responseStr;
- (NSString *)getRawData;
- (BOOL)isPageResultValid;
- (BOOL)responseHasKeyword:(NSString *)keyword;

@end

