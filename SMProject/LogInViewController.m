//
//  LogInViewController.m
//  SMProject
//
//  Created by 石榴花科技 on 14-4-8.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "LogInViewController.h"
#import "JSON.h"
#import "OpenUDID.h"
#import "ProgressHUD.h"
#import "Reachability.h"
#import "UIDevice+FCUUID.h"
#import "FCUUID.h"


#define kWSPath LocationIp
@interface LogInViewController ()
{
    UIImageView *bgimageView;
}

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:NO];
    self.isdimiss=YES;
    [SVProgressHUD dismiss];
}

-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不通畅，请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return isExistenceNetwork;
}

- (void)viewDidLoad
{
    
//    self.view.backgroundColor = [UIColor blueColor];
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    
    NSLog(@"window.frame=%f",window.frame.origin.x);
    NSLog(@"self.frame.x=%f",self.view.frame.origin.x);
    
  //  bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(155, 0, 1024, 768)];
   
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0){
         bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    }else{
         bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(155, 0, 1024, 768)];
    }
    
    
    
    bgimageView.image = [UIImage imageNamed:@"smbg模糊原图 2"];
   // bgimageView.contentMode=UIViewContentModeScaleToFill;
    [self.view addSubview:bgimageView];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self creatLoginButtonandTextField];
 //   [self KeyBoardnNotification];
    
    NSLog(@"***************%@",[OpenUDID value]);
//    [[UIDevice currentDevice] uniqueDeviceIdentifier ]
    
    NSLog(@"%@",[[UIDevice currentDevice] identifierForVendor]);
 //   [self slideFrame:NO];
    //[self firstViewFrame:NO];
    self.view.backgroundColor=[UIColor colorWithRed:198/255.0 green:178/255.0 blue:164/255.0 alpha:1];
    
}
#pragma mark - 创建登陆界面上的东西

- (void)creatLoginButtonandTextField
{
    
    UIImageView *logView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    logView.image = [UIImage imageNamed:@"logo原色发光"];
    logView.center = CGPointMake(self.view.center.x+155, 300-50);
    [self.view addSubview:logView];
    
    self.nameTextfield                 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.nameTextfield.center          = CGPointMake(self.view.center.x+155, 300);
    self.nameTextfield.returnKeyType   = UIReturnKeyNext;
    self.nameTextfield.delegate        = self;
    self.nameTextfield.placeholder     = @"连锁机构代码";
    self.nameTextfield.keyboardType    = UIKeyboardTypeNumberPad;
    self.nameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTextfield.backgroundColor = [UIColor whiteColor];
    self.nameTextfield.delegate=self;
//    [self.nameTextfield addTarget:self action:@selector(slideFrameUp) forControlEvents:UIControlEventEditingDidBegin];
//    [self.nameTextfield addTarget:self action:@selector(slideFrameDown) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.view addSubview:self.nameTextfield];
    
    self.UserNameTextField                 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.UserNameTextField.center          = CGPointMake(self.view.center.x+155, 360);
    self.UserNameTextField.returnKeyType   = UIReturnKeyNext;
    self.UserNameTextField.delegate        = self;
    self.UserNameTextField.placeholder     = @"管理人员代码";
    self.UserNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.UserNameTextField.backgroundColor = [UIColor whiteColor];
    self.UserNameTextField.delegate=self;
    self.UserNameTextField.keyboardType    = UIKeyboardTypeNumberPad;
//    [self.UserNameTextField addTarget:self action:@selector(slideFrameUp) forControlEvents:UIControlEventEditingDidBegin];
//    [self.UserNameTextField addTarget:self action:@selector(slideFrameDown) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.view addSubview:self.UserNameTextField];
    
    
    self.password                 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.password.center          = CGPointMake(self.view.center.x+155, 420);
    self.password.delegate        = self;
    self.password.placeholder     = @"登录口令";
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.secureTextEntry = YES;
    self.password.returnKeyType   = UIReturnKeyGo;
    self.password.backgroundColor = [UIColor whiteColor];
    self.password.keyboardType    = UIKeyboardTypeNumberPad;
//    [self.password addTarget:self action:@selector(slideFrameUp) forControlEvents:UIControlEventEditingDidBegin];
//    [self.password addTarget:self action:@selector(slideFrameDown) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.view addSubview:self.password];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(0, 0, 320, 40);
    self.loginButton.center = CGPointMake(self.view.center.x+155, 480);
    [self.loginButton setImage:[UIImage imageNamed:@"登录_点击前.jpg"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(logInbuttonClick) forControlEvents:UIControlEventTouchUpInside];
//    self.loginButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.loginButton];
    
    self.resgistButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.resgistButton.frame=CGRectMake(0, 0, 320, 40);
    self.resgistButton.center=CGPointMake(self.view.center.x+155, 530);
    [self.resgistButton addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.resgistButton setImage:[UIImage imageNamed:@"注册_点击前.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.resgistButton];
    //获取id
    self.ipadUDID = [[NSString alloc] init];
    
    self.ipadUDID = [OpenUDID value];
//    self.ipadUDID=[[NSString alloc] init];
//    self.ipadUDID=[FCUUID uuidForDevice];
  
    NSLog(@"self.ipadUDID=%@",self.ipadUDID);
    
    NSUserDefaults *usetIpadUdid=[NSUserDefaults standardUserDefaults];
    [usetIpadUdid setObject:self.ipadUDID forKey:@"ipadUDID"];
//    NSLog(@"%f  %f",self.view.frame.size.width,self.view.frame.size.height);
//    NSLog(@"%f  %f",self.view.frame.origin.x,self.view.frame.origin.y);
    self.ipadVersionLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+120, self.view.frame.size.height-30, 200, 20)];
        if ([kWSPath isEqualToString:LocationIp]) {
//            NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
//           
//            NSString *version=[users objectForKey:@"appVersion"];
            if ([LocationIp rangeOfString:@"Cs"].location!=NSNotFound) {
                self.ipadVersionLabel.text=[NSString stringWithFormat:@"测试版%@v",[self getVersion]];
            }else{
                self.ipadVersionLabel.text=[NSString stringWithFormat:@"正式版%@v",[self getVersion]];
            }
            
        };
    [self.view addSubview:self.ipadVersionLabel];
    
   //版本号
//    if ([kWSPath isEqualToString:@"http://ipad.sanmoon.net/Sanmoon1.0/"]) {
//        NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
//        NSString *version=[users objectForKey:@"appVersion"];
//        self.ipadVersionNameLabel.text=[NSString stringWithFormat:@"正式版%@v",version];
//    };
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0){
         logView.center = CGPointMake(self.view.center.x, 300-50);
        self.ipadVersionLabel.frame=CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height-30, 200, 20);
        self.nameTextfield.center          = CGPointMake(self.view.center.x, 300);
        self.UserNameTextField.center          = CGPointMake(self.view.center.x, 360);
        self.password.center          = CGPointMake(self.view.center.x, 420);
        self.loginButton.center = CGPointMake(self.view.center.x, 480);
        self.resgistButton.center=CGPointMake(self.view.center.x, 530);
        
    }
   
    
}
- (NSString *)getVersion
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* version = [infoDict objectForKey:@"CFBundleVersion"];
  //  self.myVersion=version;
    return version;
}


- (void)registBtnClick
{
    [self.nameTextfield resignFirstResponder];
    [self.password resignFirstResponder];
    [self.UserNameTextField resignFirstResponder];
    
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"注册" message:@"请输入内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.alertViewStyle= UIAlertViewStyleLoginAndPasswordInput;
   [alertView textFieldAtIndex:0].placeholder=@"设备名称";
   [alertView textFieldAtIndex:1].placeholder=@"连锁机构代码";
    [alertView textFieldAtIndex:1].secureTextEntry=NO;
    [alertView textFieldAtIndex:0].keyboardType=UIKeyboardTypeDefault;
    [alertView textFieldAtIndex:1].keyboardType=UIKeyboardTypeDefault;
    self.ipadUDID = [[NSString alloc] init];
    self.ipadUDID = [OpenUDID value];
    NSLog(@"%@===",self.ipadUDID);
    alertView.delegate=self;
    alertView.tag=1;
        [alertView show];
    
    
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
////    if (buttonIndex==0) {
////        <#statements#>
////    }
//    
//}


- (void)saveStoresID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSLog(@"the name is %@",self.nameTextfield.text);
    [prefs setObject:self.nameTextfield.text forKey:@"name"];
    [prefs setObject:self.UserNameTextField.text forKey:@"username"];
    [prefs setObject:self.password.text forKey:@"userpwd"];
    [prefs synchronize];
}
- (void)timeOut
{
    if (self.isdimiss==YES) {
        [SVProgressHUD dismiss];
    }else{
        [SVProgressHUD showErrorWithStatus:@"登陆超时"];
    }
    
}
- (void)logInbuttonClick
{
  
    [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeClear];
    [self performSelector:@selector(timeOut) withObject:nil afterDelay:15];
    NSString *name     = self.nameTextfield.text;
    NSString *passWord = self.password.text;
    NSString *user     = self.UserNameTextField.text;
    
    if ([name isEqualToString:@""] || [passWord isEqualToString:@""] || [user isEqualToString:@""]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"门店编号用户名和密码不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alter show];
         [SVProgressHUD dismiss];
    }
//    if (![name isEqualToString:@""] && ![passWord isEqualToString:@""]) {
//        [self.delegate changeRootViewController];
//        [self saveStoresID];
//        [ProgressHUD showSuccess:@"登陆成功！"];
//    }
//    [self.delegate changeRootViewController];
//               [self saveStoresID];
//            [ProgressHUD showSuccess:@"登陆成功！"];
    [self getStoreNum:^(NSArray *array) {
        NSDictionary *dic=[array objectAtIndex:0];
        NSDictionary *dict2=[dic objectForKey:@"data"];
        
       self.shopCode=[dict2 objectForKey:@"shopCode"];
         self.ipadStatus=[dic objectForKey:@"status"];
        self.myIpadName=[dict2 objectForKey:@"name"];
        NSLog(@"name=%@,self.shopCode=%@",name,self.shopCode);
    self.data_updata=[dict2 objectForKey:@"data_update"];

    
#pragma mark 修改
        //self.ipadStatus = [NSNumber numberWithInt:2];
    if ([self.ipadStatus isEqualToNumber:[NSNumber numberWithInteger:2]]) {
        NSLog(@"ipad验证成功！");
        if ([name isEqualToString:self.shopCode] ) {
            NSLog(@"门店验证成功");
            NSLog(@"%@",self.ipadStatus);
            NSLog(@"%@",self.shopCode);
            NSLog(@"%@",[self getGuestInfo:name withUsername:user withPwd:passWord]);
            if ([[self getGuestInfo:name withUsername:user withPwd:passWord] isEqualToString:@"T"]) {
                [self.delegate changeRootViewController];
                [self saveStoresID];
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                });
                
               
               
            }else{
                [SVProgressHUD showInfoWithStatus:@"用户名或密码错误！"];
              //  [SVProgressHUD dismiss];
            }

        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备未在此门店下注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [SVProgressHUD dismiss];
            
        }

            
       
    }else if([self.ipadStatus isEqualToNumber:[NSNumber numberWithInteger:-1]]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备未激活" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
         [SVProgressHUD dismiss];
        
    }else if ([self.ipadStatus isEqualToNumber:[NSNumber numberWithInteger:0]]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
         [SVProgressHUD dismiss];
    }else if ([self.ipadStatus isEqualToNumber:[NSNumber numberWithInteger:1]]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备未审核" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
         [SVProgressHUD dismiss];
    }else if ([self.ipadStatus isEqualToNumber:[NSNumber numberWithInteger:3]]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备审核未通过" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
         [SVProgressHUD dismiss];
    }
    
      }];
    if ([self isConnectionAvailable]==NO) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [SVProgressHUD dismiss];
    }

//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.view.frame = CGRectMake(0, 0, 1024, 768);
//    [UIView commitAnimations];

    [self.nameTextfield resignFirstResponder];
    [self.password resignFirstResponder];
    [self.UserNameTextField resignFirstResponder];
   // [self performSelector:@selector(netWorkUse) withObject:self afterDelay:10];
  
}
- (void)netWorkUse
{
   //  [ProgressHUD showSuccess:@"登陆失败！"];
   // [SVProgressHUD dismiss];
}
- (NSString *)getGuestInfo:(NSString *)no withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@GetData.asmx/GetMembert",RIP]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"usid=%@&umid=%@&pw=%@&username=sanmoon&userpass=sm147369",no,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"this is login value %@",[rootElement stringValue]);
    NSString *str=[rootElement stringValue];
    
    NSLog(@"%@",rootElement);
    
    
    
//    
//    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"jsondata is %@",requestdata);
//    
//    NSError *error = nil;
//    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
//    NSString * deposit;
//    
//    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
//    
//    NSString *str=[jsondata base64Encoding];
////    for (NSDictionary *dic in jsonDict) {
////        CustomersQuery *info = [[CustomersQuery alloc] init];
////        
////        info.cardstate = [dic objectForKey:@"cardstate"];
////        info.cid = [dic objectForKey:@"cid"];
////        info.gsname= [dic objectForKey:@"gname"];
////        info.usid = [dic objectForKey:@"usid"];
////        
////        [array addObject:info];
//        
////    }
    
    return str;
    
}
- (void)getStoreNum:(void (^) (NSArray *array))complete
{
     ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@checkLoginToIpad",LocationIp]]];
    NSDictionary *dic=[[NSBundle mainBundle] infoDictionary];
    NSString *app_version=[dic objectForKey:@"CFBundleVersion"];
    NSLog(@"%@",app_version);
    NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
    [users setObject:app_version forKey:@"appVersion"];
    [request addPostValue:self.ipadUDID forKey:@"ipad.udid"];
    NSLog(@"app_version=%@",app_version);
    [request addPostValue:app_version forKey:@"ipad.currentVersion"];
    [request setTimeOutSeconds:15];
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:0];
    [request setCompletionBlock:^{
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"=-=%@",dic);
        if ([dic isEqual:[NSNull null]]) {
            [SVProgressHUD showErrorWithStatus:@"服务器异常"];
        }else{
        [tempArray addObject:dic];
        }
//        self.cardStatus=[dic objectForKey:@"status"];
//        NSDictionary *dic2=[dic objectForKey:@"data"];
//        self.shopCode=[dic2 objectForKey:@"shopCode"];
        if (tempArray) {
            complete(tempArray);
        }
       
    }];
    
     [request startAsynchronous];
    
}

#pragma mark - 检测键盘的通知

- (void)KeyBoardnNotification
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.view.frame = CGRectMake(0, -300, 1024, 768);
//    [UIView commitAnimations];


}
- (void)keyboardWillHide:(NSNotification *)notification
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
 //   self.view.frame = CGRectMake(255.5, 0, 1024, 768);
//    [UIView commitAnimations];
    
}

#pragma mark - TextField Delegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//    NSLog(@"%f  %f",self.view.frame.size.width,self.view.frame.size.height);
//    NSLog(@"%f  %f",self.view.frame.origin.x,self.view.frame.origin.y);
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    
//    self.view.frame = CGRectMake(0, -200, 1024, 768);
//    [UIView commitAnimations];
//    
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (self.nameTextfield == textField) {
//        [self.UserNameTextField becomeFirstResponder];
//    }
//    
//    else if (self.UserNameTextField == textField){
//        [self.password becomeFirstResponder];
//    }
//    
//    else if (self.password == textField) {
//        [self logInbuttonClick];
//    }
    [self logInbuttonClick];
    
    return YES;
}

- (IBAction)slideFrameUp
{
//    self.view.transform = CGAffineTransformMake(0,-1,1,0,0,0);
	[self slideFrame:YES];
    
    
}

- (IBAction)slideFrameDown
{
	[self slideFrame:NO];
    
}

- (void)slideFrame:(BOOL) up
{
    int movementDistance = 160;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
    }
    else
    {
        movementDistance = 153;
    }
	const float movementDuration = 0.3f;
	int movement = (up ? -movementDistance : movementDistance);
    //	int movement = (up ? -movementDistance : movementDistance);
#pragma mark 修改
    
    UIDevice *device = [UIDevice currentDevice] ;
    if (device.orientation==UIDeviceOrientationLandscapeLeft){
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, -movement, 0);
        // self.view.frame = CGRectMake(0, -300, 1024, 768);
        [UIView commitAnimations];
        
    }else{
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, movement, 0);
   // self.view.frame = CGRectMake(0, -300, 1024, 768);
        [UIView commitAnimations];
        
        }

    
}
- (void)firstViewFrame:(BOOL)up
{
    int movementDistance = 160;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
    }
    else
    {
        movementDistance = 153;
    }
	const float movementDuration = 0.3f;
	int movement = (up ? -movementDistance : movementDistance);
    //	int movement = (up ? -movementDistance : movementDistance);
#pragma mark 修改
    
    UIDevice *device = [UIDevice currentDevice] ;
    if (device.orientation==UIDeviceOrientationLandscapeLeft){
//        [UIView beginAnimations: @"anim" context: nil];
//        [UIView setAnimationBeginsFromCurrentState: YES];
//        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, -movement, 0);
        // self.view.frame = CGRectMake(0, -300, 1024, 768);
       // [UIView commitAnimations];
        
    }else{
//        [UIView beginAnimations: @"anim" context: nil];
//        [UIView setAnimationBeginsFromCurrentState: YES];
//        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, movement, 0);
        // self.view.frame = CGRectMake(0, -300, 1024, 768);
    //    [UIView commitAnimations];
        
    }
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [self firstViewFrame:YES];
   
}
#pragma mark 修改
- (void)textFieldDidBeginEditing:(UITextField *)textField 
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:0.3f];
//    self.view.frame = CGRectMake(0, -300, 1024, 768);
//    [UIView commitAnimations];
  //  [self slideFrameUp];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationDuration:0.3f];
//    self.view.frame = CGRectMake(0, 0, 1024, 768);
//    [UIView commitAnimations];
  //  [self slideFrameDown];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    NSLog(@"屏幕翻转了");
 //   return (interfaceOrientation == UIInterfaceOrientationLandscapeRight&&interfaceOrientation==UIInterfaceOrientationLandscapeLeft); // 只支持向左横向, YES 表示支持所有方向
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"屏幕翻转了");
    [self.nameTextfield resignFirstResponder];
    [self.password resignFirstResponder];
    [self.UserNameTextField resignFirstResponder];

    
    
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString *)string
//{
////    if ( range.location >= 6) {
////        return NO;
////    }
////    
////    return YES;
//}

#pragma mark  -  alterView Delegate

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.nameTextfield.text = @"";
    self.password.text = @"";
    self.UserNameTextField.text = @"";
    
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            if ([[alertView textFieldAtIndex:0].text isEqualToString:@""]||[[alertView textFieldAtIndex:1].text isEqualToString:@""]) {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"设备名称或门店编号不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
//                UIDevice *device = [UIDevice currentDevice] ;
//                if (device.orientation==UIDeviceOrientationLandscapeLeft){
//                    
//                    self.view.frame = CGRectMake(-155.5, 0, 1024, 768);
//                    
//                    
//                }else{
//                    self.view.frame = CGRectMake(0, 255.5, 1024, 768);
//                    
//                }

                
            }else{
                
            
//            UIDevice *device = [UIDevice currentDevice] ;
//            if (device.orientation==UIDeviceOrientationLandscapeLeft){
//                
//                self.view.frame = CGRectMake(-255.5, 0, 1024, 768);
//                
//                
//            }else{
//                 self.view.frame = CGRectMake(0, 255.5, 1024, 768);
//                
//            }

                if ([self isConnectionAvailable]==NO) {
                  
                    
                }else{
            
          
            self.ipadName = [alertView textFieldAtIndex:0].text;
                self.storeName=[alertView textFieldAtIndex:1].text;
           // [alertView textFieldAtIndex:0].delegate=self;
//                NSString * strUrl = [NSString stringWithFormat:@"http://192.168.0.112:8080/Sanmoon1.0/insertInToIpad?ipad.name=%@&ipad.udid=%@&ipad.shopCode=%@",self.ipadName,self.ipadUDID,self.storeName];
//                NSString * newUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSURL *url=[NSURL URLWithString:newUrl];
//                
//            NSURLRequest *request=[NSURLRequest requestWithURL:url];
//                
//                NSLog(@"=%@",url);
//            NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
//            [connection start];
                    [self registIpad];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已提交审核" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            }
            }
        }else{
//            UIDevice *device = [UIDevice currentDevice] ;
//            if (device.orientation==UIDeviceOrientationLandscapeLeft){
//                
//              //  self.view.frame = CGRectMake(-255.5, 0, 1024, 768);
//                self.view.frame = CGRectMake(-255.5, 0, 1024, 768);
//                
//            }else{
//                self.view.frame = CGRectMake(0, 255.5, 1024, 768);
//                
//            }

        //    [alertView resignFirstResponder];
        }
    }
    
}
- (void)didPresentAlertView:(UIAlertView *)alertView
{
    NSLog(@"调用了代理");
  //  [alertView setFrame:CGRectMake(100, 100, 100, 100)];
//    UIDevice *device = [UIDevice currentDevice] ;
//    if (device.orientation==UIDeviceOrientationLandscapeLeft){
//        
//        [alertView setCenter:CGPointMake(512, 200)];
//        
//        
//    }else{
//        self.view.frame = CGRectMake(0, 255.5, 1024, 768);
//        
//    }
//
}
- (void)registIpad
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@insertInToIpad",LocationIp]]];
    [request addPostValue:self.ipadName forKey:@"ipad.name"];
    [request addPostValue:self.ipadUDID forKey:@"ipad.udid"];
    [request addPostValue:self.storeName forKey:@"ipad.shopCode"];
    [request setTimeOutSeconds:20];
    [request setRequestMethod:@"post"];
    [request startAsynchronous];
    
    
}

- (NSString *)isCanLoginToIpad
{
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@isCanLoginToIpad?ipad.udid=%@",LocationIp,self.ipadUDID]]];
   // NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"=%@",str);
    NSLog(@"%@",self.ipadUDID);
    return str;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
