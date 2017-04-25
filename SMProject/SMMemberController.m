//
//  SMMemberController.m
//  SMProject
//
//  Created by arvin yan on 8/3/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMMemberController.h"
#import "SGInfoAlert.h"
#import "XMLmanage.h"
#import "SMPaymentController.h"

@interface SMMemberController ()

@end

@implementation SMMemberController

@synthesize cancelBtn = cancelBtn_;
@synthesize loginBtn = loginBtn_;
@synthesize userNameTextField = userNameTextField_;
@synthesize pwdTextField = pwdTextField_;
@synthesize itemType = itemType_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"会员";
    self.pwdTextField.secureTextEntry = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtnClicked:(id)sender
{
    if (self.userNameTextField.text.length == 0 || self.pwdTextField.text.length == 0) {
        [SGInfoAlert showInfo:@"会员卡号或密码不能为空！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return;
    }
    NSString *str = [[XMLmanage shardSingleton] CheckUserInfonWithCid:self.userNameTextField.text withPassWord:self.pwdTextField.text];
    if ([str isEqualToString:@"T"]) {
        [self saveUID];
        SMPaymentController * pay = [[SMPaymentController alloc] init];
        NSLog(@"the login type is %@",self.itemType);
        pay.itemType = self.itemType;
        [self.navigationController pushViewController:pay animated:YES];
    }
    else
    {
        [SGInfoAlert showInfo:@"用户名或者密码错误请重新输入！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
    }
    
}


- (void)saveUID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:self.userNameTextField.text forKey:@"UID"];
    
    [prefs synchronize];
}

@end
