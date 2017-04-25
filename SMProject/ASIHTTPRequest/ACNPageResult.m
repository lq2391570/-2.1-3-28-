
#import "ACNPageResult.h"
//#import "ACNLog.h"


@implementation ACNPageResult

@synthesize responseData;
@synthesize statusCode;
@synthesize location;
@synthesize sslErrMsg;
@synthesize originatingServer;
@synthesize internetStatus;
@synthesize errorMsg;

- (ACNPageResult*) initWithResponseData:(NSString *) responseStr {
	if (self = [super init]) {
		self.responseData = responseStr;
		self.statusCode = 0;
        self.errorMsg = @"";
	}
	return self;
}

- (ACNPageResult*) init{
	if (self = [super init]) {
		self.statusCode = 0;
        self.errorMsg = @"";
	}
	return self;
}

-(void) dealloc {
	[self.location release];
	[self.responseData release];
    [self.sslErrMsg release];
    [self.originatingServer release];
    [self.errorMsg release];
	[super dealloc];
}

- (NSString *)getRawData {

	NSString * formattedResponseData = [NSString stringWithFormat:@"%@",@""];
	//ACNLog(ACN_DEBUG, self.responseData);
	
	if([self.responseData length] == 0) {
		return formattedResponseData;
	}
	
	formattedResponseData = [NSString stringWithFormat:@"%@", self.responseData];
	
	return formattedResponseData;
}

- (BOOL)isPageResultValid
{
    //(!responseData || [responseData length] == 0) && (!location || [location length] == 0);
    return (responseData && [responseData length] != 0) || (location && [location length] != 0);
}

- (BOOL)responseHasKeyword:(NSString *)keyword
{
	NSRange range = [responseData rangeOfString:keyword options:NSCaseInsensitiveSearch];
    return (range.location != NSNotFound);
}

@end
