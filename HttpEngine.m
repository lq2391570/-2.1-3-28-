//
//  HttpEngine.m
//  SMProject
//
//  Created by shiliuhua on 17/3/16.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import "HttpEngine.h"
#import "ProjectList.h"
#import "ASIFormDataRequest.h"
#import "XMLmanage.h"
#import "FirstSerImageBaseClass.h"
#import "SVProgressHUD.h"
#import "SerRecordBaseClass.h"
#import "ProjectListNewBaseClass.h"
#import "ProSerPhotoListBaseClass.h"

@implementation HttpEngine
//得到项目列表
+ (void)getProjectList:(NSString *)cid complete:(void (^) (NSMutableArray *tempArray))complete
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@GetData.asmx/GetGuestBuyItemCid?HTTP/1.1",RIP]]];
    [request setRequestMethod:@"post"];
    [request setTimeOutSeconds:30];
    [request addPostValue:cid forKey:@"cid"];
    [request addPostValue:@"sanmoon" forKey:@"username"];
    [request addPostValue:@"sm147369" forKey:@"userpass"];
    [request setCompletionBlock:^{
     //   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:request.responseString options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        NSLog(@"rootElement = %@",[rootElement stringValue]);
        NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:0];
        for (int i =0; i < jsonArray.count; i++) {
            NSDictionary *dic = [jsonArray objectAtIndex:i];
             ProjectList *listModel = [ProjectList modelObjectWithDictionary:dic];
            [temparray addObject:listModel];
           // NSLog(@"dic = %@",jsonDict);
            NSLog(@"listModel.uname = %@",listModel.uname);
        }
        
      //  NSLog(@"responseString=%@",request.responseString);
        if (complete) {
            complete (temparray);
        }
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startAsynchronous];
    
}
//得到项目列表新
+ (void)getProjectListNew:(NSString *)serNum complete:(void (^) (NSMutableArray *tempArray))complete
{
     [SVProgressHUD show];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@firstserviceproject_findAllMyProjectListToIpad",LocationIp]]];
    [request addPostValue:serNum forKey:@"firstServiceProject.memberCard"];
    [request setRequestMethod:@"post"];
    [request setTimeOutSeconds:30];
    [request setCompletionBlock:^{
        NSLog(@"firstServiceProjectRequest = %@",request.responseString);
        
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:0];
        for (int i =0; i < jsonArray.count; i++) {
            NSDictionary *dic = [jsonArray objectAtIndex:i];
            ProjectListNewBaseClass *listModel = [ProjectListNewBaseClass modelObjectWithDictionary:dic];
            [temparray addObject:listModel];
            // NSLog(@"dic = %@",jsonDict);
            NSLog(@"listModel.iname = %@",listModel.iname);
        }
        
        //  NSLog(@"responseString=%@",request.responseString);
        if (complete) {
            complete (temparray);
        }
        [SVProgressHUD dismiss];
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startAsynchronous];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}



//根据会员号上传首次服务小票
+ (void)uploadSmlTicketOfFirstSer:(NSString *)serNum upImageState:(int)upImageState complete:(void (^) (NSString *str))complete
{
    [SVProgressHUD show];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@firstserviceticket_addFirstTicketsImageToIpad",LocationIp]]];
    [request setPostValue:serNum forKey:@"firstServiceTicket.memberCard"];
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString * paths = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/FirstSerImage%d.jpg",upImageState]];
    NSLog(@"paths = %@",paths);
    
    [request setFile:paths forKey:@"upload"];
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSString *responStr = [dic objectForKey:@"result"];
        
        NSLog(@"%@",restr);
        if (complete) {
            complete (responStr);
        }
        [SVProgressHUD dismiss];
    }];
    
    [request setFailedBlock:^{
        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
    }];
    
    [request startAsynchronous];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
//得到首次服务小票list
+ (void)getFirstSerTicketList:(NSString *)serNum complete:(void (^) (NSMutableArray *tempArray))complete
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@firstserviceticket_findFirstServiceTicketToIpad",LocationIp]]];
    [request addPostValue:serNum forKey:@"firstServiceTicket.memberCard"];
    [request setRequestMethod:@"post"];
    [request setTimeOutSeconds:30];
    [request setCompletionBlock:^{
        NSLog(@"FirstServiceTicketResquest = %@",request.responseString);
        
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:0];
        for (int i =0; i < jsonArray.count; i++) {
            NSDictionary *dic = [jsonArray objectAtIndex:i];
            FirstSerImageBaseClass *listModel = [FirstSerImageBaseClass modelObjectWithDictionary:dic];
            [temparray addObject:listModel];
            // NSLog(@"dic = %@",jsonDict);
            NSLog(@"listModel.uname = %@",listModel.smallImageUrl);
        }
        
        //  NSLog(@"responseString=%@",request.responseString);
        if (complete) {
            complete (temparray);
        }

    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startAsynchronous];
    
}
//得到服务记录list（新）
+ (void)getSerRecordListNew:(NSString *)serNum complete:(void (^) (NSMutableArray *tempArray))complete
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@memberarchive_findServiceRecordsToIpad",LocationIp]]];
    [request addPostValue:serNum forKey:@"memberArchive.memberCard"];
    [request setRequestMethod:@"post"];
    [request setTimeOutSeconds:30];
    [request setCompletionBlock:^{
        NSLog(@"SerRecordList = %@",request.responseString);
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<jsonArray.count; i++) {
            NSDictionary *dic = [jsonArray objectAtIndex:i];
            SerRecordBaseClass *bassClass = [SerRecordBaseClass modelObjectWithDictionary:dic];
            [temparray addObject:bassClass];
            
        }
        if (complete) {
            complete(temparray);
        }
        
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startAsynchronous];
    
}
//上传项目服务前的图片
+ (void)uploadProductSerPhoto:(NSString *)serNum proId:(NSString *)proId proName:(NSString *)proName proStyleName:(NSString *)proStyleName proBuyArea:(NSString *)proBuyArea proTime:(NSString *)proTime setDelegateVC:(UIViewController *)DelegateVC complete:(void (^) (NSString *errorCode,NSString *msg))complete
{
    [SVProgressHUD show];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@firstserviceproject_addFirstServiceProjectImageToIpad",LocationIp]]];
    [request addPostValue:serNum forKey:@"firstServiceProject.memberCard"];
    [request addPostValue:proId forKey:@"firstServiceProject.iid"];
    [request addPostValue:proName forKey:@"firstServiceProject.iname"];
    [request addPostValue:proStyleName forKey:@"firstServiceProject.itname"];
    [request addPostValue:proBuyArea forKey:@"firstServiceProject.uname"];
    [request addPostValue:proTime forKey:@"firstServiceProject.xssj"];
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString * paths = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/ProImage.jpg"]];
    NSLog(@"paths = %@",paths);
    
    [request setFile:paths forKey:@"upload"];
    [request setDelegate:self];
    [request setUploadProgressDelegate:DelegateVC];
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSString *responStr = [dic objectForKey:@"result"];
        NSString *mes = [dic objectForKey:@"message"];
        
        NSLog(@"ProImageRestr=%@",restr);
        if (complete) {
            complete (responStr,mes);
        }
      //  [SVProgressHUD dismiss];
    }];
    
    
    [request setFailedBlock:^{
        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
        [SVProgressHUD showInfoWithStatus:[err.userInfo objectForKey:@"NSLocalizedDescription"]];
    }];
    
    [request startAsynchronous];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}
//获取项目服务前的图片列表
+ (void)getProSerBeforePhotoList:(NSString *)serNum proId:(NSString *)proId complete:(void (^) (NSMutableArray *tempArray))complete
{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@firstserviceproject_findAllFirstServiceProjectToIpad",LocationIp]]];
    [request addPostValue:serNum forKey:@"firstServiceProject.memberCard"];
    [request addPostValue:proId forKey:@"firstServiceProject.iid"];
    [request setRequestMethod:@"post"];
    [request setTimeOutSeconds:30];
    [request setCompletionBlock:^{
        NSLog(@"ProSerBeforeList = %@",request.responseString);
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<jsonArray.count; i++) {
            NSDictionary *dic = [jsonArray objectAtIndex:i];
            ProSerPhotoListBaseClass *bassClass = [ProSerPhotoListBaseClass modelObjectWithDictionary:dic];
            [temparray addObject:bassClass];
            
        }
        if (complete) {
            complete(temparray);
        }
        
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startAsynchronous];
    
    
}


@end
