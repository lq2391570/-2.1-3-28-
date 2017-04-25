//
//  ACNVisitPage.h
//  ACM
//
//  Created by admin on 3/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACNPageResult.h"


typedef enum {
	AICENT_OK						= 0,
	// WISPr error code
	ERR_LOGIN_REJECT				= 100,
	ERR_LOGIN_RADIUS_ERROR			= 102,
	ERR_LOGIN_NETWORK_ERROR			= 105,
	ERR_LOGIN_ABORTED				= 151,
	ERR_PROXY_OPERATION				= 200,
	ERR_AUTH_PENDING				= 201,
	ERR_GATEWAY_ERROR				= 255,
	ERR_LOGIN_SUCCEEDED				= 50,
	// Aicent specific error code
	ERR_FAILED						= 1000,
	ERR_PB_NOT_FOUND				= 1001,
	ERR_CFG_NOT_FOUND				= 1002,
	ERR_READ_PB_ERR					= 1003,
	ERR_READ_CFG_ERR				= 1004,
    ERR_EAP_FAILED                  = 1005,
    ERR_NETWORK_NOT_DETECTED        = 1006,
	ERR_INTERNET_ERROR				= 1009,//-1003,-1004,-1005,-1006
	ERR_INVALID_UPDATE_MODULE		= 1011,
	ERR_INVALID_OPTION_FLAG			= 1012,
	ERR_INVALID_OPTION_VALUE		= 1013,
	ERR_INVALID_ACCOUNT				= 1021,
	ERR_INVALID_URL					= 1022,//-1000,-1002
	ERR_LOGIN_URL_NOT_FOUND			= 1023,
	ERR_LOGOFF_URL_NOT_FOUND		= 1024,
	ERR_INVALID_WISPR_RESPONSE		= 1025,
	ERR_INVALID_RESOURCE			= 1026,
	ERR_ABORT_UNSUPPORTED			= 1027,
	ERR_INVALID_PARAM				= 1028,
	ERR_PARTNER_NOT_FOUND			= 1029,
	ERR_FILE_NOT_FOUND				= 1030,
	ERR_WISPR_LOGIN_URL_NOT_FOUND	= 1031,
	ERR_SESSION_NOT_FOUND			= 1032,
	ERR_LIB_UNINITIALIZED			= 1033,
    ERR_LOGIN_TIMEOUT				= 1035,
	AICENT_INTERNET_AVAILABLE       = 1040,
    ERR_HTTP_TIMEOUT				= 1050,
	ERR_SSL_ISSUER_NOT_ACCEPT		= 1051,
	ERR_LOGIN_URL_NOT_HTTPS         = 1052,
	ERR_LOGIN_URL_DOMAIN_NOT_MATCH	= 1053,
	ERR_LOGIN_URL_IP_NOT_MATCH		= 1054,
	ERR_SSL_CERTIFICATE_EXPIRED		= 1055,
	ERR_SSL_CERTIFICATE_INVALID		= 1056,
    ERR_ACTIVATE_CHECK_INET_FAILED  = 1070,
    ERR_ACTIVATE_TOO_MANY_REDIRECTS = 1071,
    ERR_ACTIVATE_TRANSPORT_FAILURE  = 1072,
	ERR_UPDATE_ALREADY_IN_PROGRESS	= 1101,
	ERR_UNWRITABLE_FILE_PATH		= 1102,
	ERR_NO_UPDATE_FOUND				= 1103,
	ERR_GET_LOCAL_VERSION_FAILED	= 1104,
	ERR_QUERY_NEW_VERSION_FAILED	= 1105,
	ERR_DOWNLOAD_FAILED				= 1106,
	ERR_APPLY_FILE_FAILED			= 1107
} AicentErrorCode;

@interface ACNVisitPage : NSObject {
	NSString * userAgent;
	NSURLConnection *connection;
	NSString* responseData;
	BOOL isDidReceived;
	NSInteger statusCode;
	NSTimeInterval timeoutInterval;
	NSString * redirectLocation;
	BOOL autoRedirect;
    BOOL shouldAllowSelfSignedCert;
    NSString * sslErrMsg;
    NSString * errorMsg;
}
@property(nonatomic, retain) NSString * userAgent;
@property(nonatomic) NSInteger statusCode;
@property(nonatomic, retain) NSString* responseData;
@property(nonatomic)  BOOL isDidReceived;
@property(nonatomic,retain) NSString * redirectLocation;
@property(nonatomic,retain) NSURLConnection * connection;
@property(nonatomic) NSTimeInterval timeoutInterval;
@property(nonatomic) BOOL autoRedirect;
@property(nonatomic, assign) BOOL shouldAllowSelfSignedCert;
@property(nonatomic, retain) NSString * sslErrMsg;
@property(nonatomic, retain) NSString * errorMsg;

- (ACNVisitPage *)initWithUserAgent:(NSString *)agent;

- (void) getPage:(NSString *)url Method:(NSString *)method;
- (void) getPage:(NSString *)url Method:(NSString *)method withBody:(NSString *)body;

@end
