//
//  ACNVisitPage.m
//  ACM
//
//  Created by admin on 3/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ACNVisitPage.h"
#import "ACNPageResult.h"

@implementation ACNVisitPage

@synthesize userAgent;
@synthesize statusCode;
@synthesize redirectLocation;
@synthesize isDidReceived;
@synthesize responseData;
@synthesize connection;
@synthesize timeoutInterval;
@synthesize autoRedirect;
@synthesize shouldAllowSelfSignedCert;
@synthesize sslErrMsg;
@synthesize errorMsg;

- (ACNVisitPage *)initWithUserAgent:(NSString *)agent {
	if (self = [super init]) {
		self.userAgent = agent;
		self.isDidReceived = NO;
		self.responseData = @"";
		self.redirectLocation = @"";
		self.timeoutInterval = 60;
		self.autoRedirect = NO;
		self.statusCode = -1;
        self.sslErrMsg = @"";
        self.errorMsg = @"";
        
	}
	return self;
}



- (void)dealloc {
	[self.userAgent release];
	[self.responseData release];
	[self.connection release];
	[self.redirectLocation release];
    [self.sslErrMsg release];
    [self.errorMsg release];
	[super dealloc];
}

- (void)getPage:(NSString *)url Method:(NSString *)method withBody:(NSString *)body{
	//prepare request
	//ACNLog(ACN_DEBUG, @"HTTP Request: %@: %@", method, url);
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setTimeoutInterval:timeoutInterval];
	//[request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:method];
	[request addValue:userAgent forHTTPHeaderField: @"User-Agent"];
	
	if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame) {
		
		[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		//set post body
		[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
		
		//set url
		[request setURL:[NSURL URLWithString:url]];
	}
    
    //QoS detail info
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	
    

	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    while (!isDidReceived && [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
	{
		//ACNLog(ACN_DEBUG, @"waiting here");
	}
    
	//ACNLog(ACN_DEBUG, @"Response Message:\n%@", self.responseData);
	//ACNLog(ACN_DEBUG, @"return from visitpage");
}

- (void) getPage:(NSString *)url Method:(NSString *)method
{
	[self getPage:url Method:method withBody:nil];
}

//delegate

//maybe a bug:http://openradar.appspot.com/6700222
//http://www.cocoabuilder.com/archive/message/cocoa/2008/10/5/219452
//https://devforums.apple.com/message/66666
- (NSURLRequest *)connection:(NSURLConnection *)con willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
	if(redirectResponse) {
		if(!self.autoRedirect) {
           // ACNLog(ACN_DEBUG, @"response will redirect");
			
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 30000
			request = nil;
#endif
			
		}
	}
	return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
	if(data) {
		NSString * res_str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		if (res_str) {
			self.responseData = [self.responseData stringByAppendingFormat:@"%@",res_str];
		}
		[res_str release];
		//ACNLog(ACN_DEBUG, @"%@",self.responseData);
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        statusCode = [httpResponse statusCode];
        
        NSDictionary* responseHeaders;
        responseHeaders = [[httpResponse allHeaderFields] retain];
        
        NSEnumerator * enumerator = [responseHeaders keyEnumerator];
        NSMutableString * headerDetail = [[NSMutableString alloc] init];
        NSString * headerField;
        
        [headerDetail setString:NSLocalizedString(@"Headers:\n", nil)];
        while ((headerField = [enumerator nextObject]) != nil)
        {
            [headerDetail appendFormat:@"\t%@: %@\n", headerField, [[httpResponse allHeaderFields] valueForKey:headerField]];
        }
        
      //  ACNLog(ACN_DEBUG, @"Response status code:%d\n", [httpResponse statusCode]);
        //NSLog(@"%@", headerDetail);
        //self.responseData = [self.responseData stringByAppendingFormat:@"%@",headerDetail];
        [headerDetail release];
        
        if (statusCode >= 300 && statusCode <= 399)
        {
            self.redirectLocation = [responseHeaders valueForKey:@"Location"];
            //ACNLog(ACN_DEBUG, @"redirection location:%@",redirectLocation);
        }
        
        [responseHeaders release];
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.isDidReceived = YES;
	//ACNLog(ACN_DEBUG, @"http connection error from didFailWithError:%@", error);
    
	int errCode = [error code];
	if (errCode == NSURLErrorCannotFindHost || errCode == NSURLErrorCannotConnectToHost ||
        errCode == NSURLErrorNetworkConnectionLost || errCode == NSURLErrorDNSLookupFailed)
	{
        /*
         NSURLErrorCannotFindHost = -1003,
         NSURLErrorCannotConnectToHost = -1004,
         NSURLErrorNetworkConnectionLost = -1005,
         NSURLErrorDNSLookupFailed = -1006,
         */
		statusCode = ERR_INTERNET_ERROR;
	}
	else if (errCode == NSURLErrorBadURL || errCode == NSURLErrorUnsupportedURL)
	{
        /*
         NSURLErrorBadURL = -1000,
         NSURLErrorUnsupportedURL = -1002,
         */
		statusCode = ERR_INVALID_URL;
	}
	else if (errCode == NSURLErrorTimedOut)
	{
        /*
         NSURLErrorTimedOut = -1001,
         */
		statusCode = ERR_HTTP_TIMEOUT;
	}
    else if (errCode == NSURLErrorServerCertificateHasBadDate ||
             errCode == NSURLErrorServerCertificateNotYetValid)
    {
        /*
         NSURLErrorServerCertificateHasBadDate = -1201,
         NSURLErrorServerCertificateNotYetValid = -1204,
         */
        statusCode = ERR_SSL_CERTIFICATE_EXPIRED;
        self.sslErrMsg = [error description];
    }
    else if (errCode == NSURLErrorServerCertificateHasUnknownRoot ||
             errCode == NSURLErrorServerCertificateUntrusted)
    {
        /*
         NSURLErrorServerCertificateUntrusted = -1202,
         NSURLErrorServerCertificateHasUnknownRoot = -1203,
         */
        statusCode = ERR_SSL_CERTIFICATE_INVALID;
        self.sslErrMsg = [error description];
    }
    self.errorMsg = [error description];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    //ACNLog(ACN_DEBUG, @"can authenticate with protection space, shouldAllowSelfSignedCert = %d", self.shouldAllowSelfSignedCert);
    
	if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust]) {
		return shouldAllowSelfSignedCert;
	}
    
	// If no other authentication is required, return NO for everything else
	// Otherwise maybe YES for NSURLAuthenticationMethodDefault and etc.
	return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		//if ([trustedHosts containsObject:challenge.protectionSpace.host])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	self.isDidReceived = YES;
}
@end

