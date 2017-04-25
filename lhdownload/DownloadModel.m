#import "DownloadModel.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SVProgressHUD.h"
#define API_REQUEST     0
#define IMG_REQUEST     1
#define VOICE_REQUEST   2
@interface DownloadModel (Private)

- (void)dataRequestSuccessed:(ASIHTTPRequest *)request;
- (void)dataRequestFailed:(ASIHTTPRequest *)request;
- (void)fileDownloaded:(NSDictionary*)userInfo forType:(NSInteger)fileType url:(NSString*)url;
@end

static NSString *userAgent;
static DownloadModel *shareDownloadModel = nil;
@implementation DownloadModel
@synthesize requestsDict;
+ (void)setUserAgent:(NSString *)newUserAgent {
    if (userAgent == nil) {
        userAgent = [newUserAgent copy];
    } else if (userAgent != newUserAgent) {
        [userAgent release];
        userAgent = [newUserAgent copy];
    }
    
}
+ (DownloadModel*)sharedDownloadModel{
  
    if (!shareDownloadModel){
		shareDownloadModel = [[DownloadModel alloc] init];
#pragma mark 100
        shareDownloadModel.requestsDict = [NSMutableDictionary dictionaryWithCapacity:100];
	}
    
	return shareDownloadModel;
    
}

-(void)setP:(UIProgressView*)p{
    NSLog(@"调用了进度条？");
    
    [networkQueue setDownloadProgressDelegate:p];
}
-(id) init {
    self = [super init];
    if (self) {
        networkQueue = [[ASINetworkQueue alloc] init];
        [networkQueue reset];
       
        [networkQueue setShowAccurateProgress:YES];
        [networkQueue setQueueDidFinishSelector:@selector(testdataRequestSuccessed)];
     //   [networkQueue setDownloadProgressDelegate:self];
        [networkQueue setRequestDidFinishSelector:@selector(dataRequestSuccessed:)];
        [networkQueue setRequestDidFailSelector:@selector(dataRequestFailed:)];
       
        [networkQueue setShouldCancelAllRequestsOnFailure:NO];
        [networkQueue setDelegate:self];
    }
    return self;
}

-(void)setMaxCount:(NSInteger)maxNum{
    [networkQueue setMaxConcurrentOperationCount:maxNum];
     [networkQueue setMaxConcurrentOperationCount:networkQueue.requestsCount];
}
-(int)countOfqueue
{
    return networkQueue.requestsCount;
}

- (void)dealloc {
    [networkQueue cancelAllOperations];
    [networkQueue reset];
    [networkQueue release];
    [super dealloc];
}
-(void)testdataRequestSuccessed
{
    NSLog(@"下载完成");
   // [SVProgressHUD showSuccessWithStatus:@"下载完成" duration:3];
   
  //  [self performSelector:@selector(dismiss:) withObject:nil afterDelay:3];
    
}
- (void)dismiss:(UIProgressView *)progress
{
//    [progress removeFromSuperview];
//    [SVProgressHUD dismiss];
    

}
//-(void)setProgress:(float)m{
//    
//    NSLog(@"hehe");
//    
//}

+(NSString*)CreateCachePath:(NSString*)forder{
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:forder];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    }
    return [path stringByAppendingString:@"/"];
}

#pragma mark MD5加密
+(NSString*)md5:(NSString*)value {
    const char *cStr = [value UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}


+(NSString*)getPath:(NSString*)folder nsurl:(NSString*)nsurl{
    
    NSArray * array = [nsurl componentsSeparatedByString:@"resources/images/"];
    NSString *fileName = [array objectAtIndex:1];
//    
//    NSString *pathExtension = [nsurl pathExtension];
//    NSString *fileName = [self md5:nsurl];//文件更具url练剑 加密出唯一文件名字
//    fileName = [fileName stringByAppendingString:@"."];
//    fileName = [fileName stringByAppendingString:pathExtension];
    NSLog(@"filename:%@",fileName);
    NSString *documentPath = [self CreateCachePath:[NSString stringWithFormat:@"Library/Caches/ephoto/%@",folder]];//设置下载文件夹
    documentPath = [documentPath stringByAppendingString:fileName];
    return documentPath;
}


- (ASIHTTPRequest*)downloadFile:(id)delegate url:(NSString*)fullUrl  folder:(NSString*)folder tag:(int)tag  fileType:(NSInteger)type {
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSString *path = [DownloadModel getPath:folder nsurl:fullUrl];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == YES)
    {
        
        return nil;
    }
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setUserAgent:userAgent];

    [request setUserInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSValue valueWithNonretainedObject:delegate], path, [NSNumber numberWithInt:tag],  nil] forKeys:[NSArray arrayWithObjects:@"delegate", @"path", @"tag",  nil]]];
    [request setTag:type];         //1代表图片访问, 2代表声音访问
    [request setDownloadDestinationPath:path];//自定义临时存储路径
    [request setTimeOutSeconds:30];
    [request setAllowResumeForFileDownloads:YES];//断点续传
    [request setTemporaryFileDownloadPath:[path stringByDeletingPathExtension]];
   // request.delegate=self;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    [networkQueue addOperation:request];
    queueCount=networkQueue.requestsCount;
    if ([networkQueue requestsCount] == 1) {
        [networkQueue go];
    }
    NSMutableDictionary*dict = [[DownloadModel sharedDownloadModel].requestsDict objectForKey:[NSString stringWithFormat:@"%@",url]];
    if (dict) {
        ASIHTTPRequest *terquest = [dict objectForKey:@"request"];
        [terquest clearDelegatesAndCancel];
        terquest= nil;
        NSMutableArray*array = [dict objectForKey:@"delegates"];
        if (!array) {
             array = [NSMutableArray arrayWithCapacity:3];
        }
        [array addObject:delegate];
        [dict setObject:array forKey:@"delegates"];//代理数组
        [dict setObject:request forKey:@"request"];//下载对象
    }else{
        dict = [NSMutableDictionary dictionaryWithCapacity:3];
        [dict setObject:request forKey:@"request"];//下载对象
        NSMutableArray*array = [NSMutableArray arrayWithCapacity:3];
        [array addObject:delegate];
        [dict setObject:array forKey:@"delegates"];//代理数组
    }
    [[DownloadModel sharedDownloadModel].requestsDict setObject:dict forKey:[NSString stringWithFormat:@"%@",url]];
    
    return request;
}

- (void)dataRequestSuccessed:(ASIHTTPRequest *)request {
    if (request.tag == IMG_REQUEST || request.tag == VOICE_REQUEST) { //图片访问
        NSDictionary *dict = request.userInfo;
        NSString*url = [NSString stringWithFormat:@"%@",request.url];
        [self fileDownloaded:dict forType:request.tag url:url];
        [[DownloadModel sharedDownloadModel].requestsDict removeObjectForKey:url];
        return;
    }
    
}

- (void)dataRequestFailed:(ASIHTTPRequest *)request {
    NSString*url = [NSString stringWithFormat:@"%@",request.url];
    [[DownloadModel sharedDownloadModel].requestsDict removeObjectForKey:url];
}

+(void)deleteRequest:(ASIHTTPRequest*)request{
    if(!request){
        return ;
    }
    [request clearDelegatesAndCancel];
    NSString*url = [NSString stringWithFormat:@"%@",request.url];
     NSMutableDictionary*dic = [[DownloadModel sharedDownloadModel].requestsDict objectForKey:url];
    if([[dic objectForKey:@"request"] isEqual:request]){
        [[DownloadModel sharedDownloadModel].requestsDict removeObjectForKey:url];//删除下载队形与代理
    }else{//删除代理
        NSMutableArray*array = [dic objectForKey:@"delegates"];
        id delegate = [request.userInfo objectForKey:@"delegate"];
        int i = 0;
        for (id del in array) {
            if ([del isEqual:delegate]) {
                [array removeObjectAtIndex:i];
                return;
            }
            i++;
        }
    }
    
}

- (void)fileDownloaded:(NSDictionary*)userInfo forType:(NSInteger)fileType url:(NSString*)url{
    SEL sel = nil;
    NSLog(@"下载完成");
    if (fileType == IMG_REQUEST)
        sel = @selector(didImageDownloaded:url:);
    else if (fileType == VOICE_REQUEST)
        sel = @selector(didVoiceDownloaded:url:);
    
    NSString*path = [userInfo objectForKey:@"path"];
    
    NSMutableDictionary*dic = [[DownloadModel sharedDownloadModel].requestsDict objectForKey:url];
    NSMutableArray*array = [dic objectForKey:@"delegates"];
    for (id delegate in array) {
        if ([delegate respondsToSelector:sel]) {
            NSMethodSignature *sig = [delegate methodSignatureForSelector:sel];
            if (sig) {
                NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
                [invo setTarget:delegate];
                [invo setSelector:sel];
                [invo setArgument:&path atIndex:2];
                [invo setArgument:&url atIndex:3];
                [invo invoke];
            }
        }

    }
}



-(BOOL)hdEnsurePath:(NSString*)path{
    if ([path length] == 0)
        return FALSE;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NULL]) {
        NSString* parentPath = [path stringByDeletingLastPathComponent];
        if ([self hdEnsurePath:parentPath]) {
            NSError* error = nil;
            return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        } else {
            return FALSE;
        }
    }
    return TRUE;
}


@end
