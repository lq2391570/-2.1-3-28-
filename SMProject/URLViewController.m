//
//  URLViewController.m
//  SMProject
//
//  Created by DAIjun on 14-12-29.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "URLViewController.h"

@interface URLViewController ()

@end

@implementation URLViewController

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
    // Do any additional setup after loading the view from its nib.
    UIWebView *web=[[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *path = ReLocation;
  //  NSString *path=@"https://sm.shiliuflower.com/data/Sanmoon.plist";
            NSURL *url = [NSURL URLWithString:path];
        [web loadRequest:[NSURLRequest requestWithURL:url]];
    web.delegate=self;
   
    [self.view addSubview:web];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 100 , 50)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
   // [btn setBackgroundImage:[UIImage imageNamed:@"btn-backx_11.png"] forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
- (void)returnBtnClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"update version testing" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        NSLog(@"点击了链接");

        [self exitApplication];
        
    }
    return YES;
}
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    self.view.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
