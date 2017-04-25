//
//  ApproveViewController.m
//  SMProject
//
//  Created by 石榴花科技 on 14-4-14.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "ApproveViewController.h"
#import "OpenUDID.h"
#import "JSON.h"

@interface ApproveViewController ()

@end

@implementation ApproveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.navigationController.navigationBarHidden = YES;
    
    [self creatsendButtonandTextField];
    [self KeyBoardnNotification];
    
    
}

- (void)creatsendButtonandTextField
{
    self.StorecodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.StorecodeTextField.center = CGPointMake(self.view.center.x, 300);
    self.StorecodeTextField.returnKeyType = UIReturnKeyNext;
    self.StorecodeTextField.delegate = self;
    self.StorecodeTextField.placeholder = @"门店编号";
    self.StorecodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.StorecodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.StorecodeTextField.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.StorecodeTextField];
    
    self.EquipmentnameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.EquipmentnameTextField.center = CGPointMake(self.view.center.x, 380);
    self.EquipmentnameTextField.delegate = self;
    self.EquipmentnameTextField.placeholder = @"设备名";
    self.EquipmentnameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.EquipmentnameTextField.secureTextEntry = YES;
    self.EquipmentnameTextField.returnKeyType = UIReturnKeyGo;
    self.EquipmentnameTextField.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.EquipmentnameTextField];

    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(0, 0, 100, 40);
    self.sendButton.center = CGPointMake(self.view.center.x, 460);
    [self.sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.sendButton];
    
    self.openUDIDI = [[NSString alloc] init];
    self.openUDIDI = [OpenUDID value];
    NSLog(@"%@===",self.openUDIDI);
}

- (void)sendButtonClick
{
    NSString *name = self.StorecodeTextField.text;
    NSString *passWord = self.EquipmentnameTextField.text;
    
    if ([name isEqualToString:@""] || [passWord isEqualToString:@""]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"门店编号和设备名不能为空" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alter show];
    }
    
    if (![name isEqualToString:@""] && ![passWord isEqualToString:@""]) {
        //        [self.delegate changeRootViewController];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",name,passWord]];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!stringData || [stringData isEqualToString:@""]) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"门店编号或密码错误了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alter show];
        }
        if (![stringData isEqualToString:@""]) {
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            
            NSLog(@"%@",parser);
            
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [UIView commitAnimations];
    
    [self.StorecodeTextField resignFirstResponder];
    [self.EquipmentnameTextField resignFirstResponder];

}

#pragma mark - 检测键盘的通知

- (void)KeyBoardnNotification
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [UIView commitAnimations];
}

#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"%f  %f",self.view.frame.size.width,self.view.frame.size.height);
    NSLog(@"%f  %f",self.view.frame.origin.x,self.view.frame.origin.y);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    self.view.frame = CGRectMake(0, -200, 1024, 768);
    [UIView commitAnimations];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.StorecodeTextField == textField) {
        [self.EquipmentnameTextField becomeFirstResponder];
    }
    else if (self.EquipmentnameTextField == textField) {
        [self sendButtonClick];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString *)string
{
    if ( range.location >= 6) {
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
