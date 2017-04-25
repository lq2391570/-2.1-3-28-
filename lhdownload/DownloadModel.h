
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "NSObject+SBJson.h"

@class ASIHTTPRequest;
@class ASINetworkQueue;
@class ASIFormDataRequest;
@class JsonData;

@interface DownloadModel : NSObject{
    ASINetworkQueue *networkQueue;
    int queueCount;
}
@property(nonatomic,retain)  NSMutableDictionary* requestsDict;

- (ASIHTTPRequest*)downloadFile:(id)delegate url:(NSString*)fullUrl  folder:(NSString*)folder tag:(int)tag fileType:(NSInteger)type;

+ (void)setUserAgent:(NSString *)newUserAgent;
+ (DownloadModel*)sharedDownloadModel;
+(void)deleteRequest:(ASIHTTPRequest*)request;

+(NSString*)getPath:(NSString*)folder nsurl:(NSString*)nsurl;

-(void)setMaxCount:(NSInteger)maxNum;
-(BOOL)hdEnsurePath:(NSString*)path;
-(void)setP:(UIProgressView*)p;
- (void)dismiss;
-(int)countOfqueue;
- (void)dataRequestSuccessed:(ASIHTTPRequest *)request;
@end

