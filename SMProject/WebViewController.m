//
//  WebViewController.m
//  CocoaService
//
//  Created by 石榴花科技 on 14-3-14.
//  Copyright (c) 2014年 shiliuhua. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize  url,mainWebView;
@synthesize backButton,forwardButton,refreshButton,stopButton,HideBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.HideBack = YES;
    }
    return self;
}
- (UIBarButtonItem *)backButton
{
    if (!backButton) {
        backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back12.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        backButton.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		backButton.width = 18.0f;
    }
    return backButton;
}
- (UIBarButtonItem *)forwardButton
{
    if (!forwardButton) {
        forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward12.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        forwardButton.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		forwardButton.width = 18.0f;
    }
    return forwardButton;
}
- (UIBarButtonItem *)refreshButton
{
    if (!refreshButton) {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];

    }
    return refreshButton;
}

- (UIBarButtonItem *)stopButton
{
    if (!stopButton) {
        stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
    }
    return stopButton;
}

#pragma mark - Initialization

- (id)initWithAddress:(NSString *)urlString
{
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL *)URL
{
    if (self = [super init]) {
        self.url = URL;
       self.HideBack = YES;
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
    //设置半透明
    navigationBar.translucent = NO;
    //设置背景颜色
//    navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:186.0/255 blue:204.0/255 alpha:0.6];
    //初始化一个item，用来设置标题文本
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:self.title];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
    bg.image = [UIImage imageNamed:@"bar"];
    [navigationBar addSubview:bg];

//    [navigationBar sendSubviewToBack:bg];
    
    
    NSLog(@"%@",self.title);
    [navigationBar pushNavigationItem:item animated:YES];
    //设置文本视图
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//    label.font = [UIFont systemFontOfSize:38];
//    label.text = @"导航栏视图";
//    item.titleView = label;
    
    //添加返回按钮
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonClick)];
    [leftButtonItem setTintColor:[UIColor whiteColor]];
    
    if (self.HideBack == NO) {
        
        item.leftBarButtonItem = leftButtonItem;
    }

    
    
    [self.view addSubview:navigationBar];
    mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64,1024,768-64)];
    mainWebView.delegate = self;
    mainWebView.scalesPageToFit = YES;
    [mainWebView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    
    [self updateToolbarItems];
    [self.view addSubview:mainWebView];

   

}
- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - View lifecycle

#pragma mark - Toolbar
- (void)updateToolbarItems
{
    self.backButton.enabled = self.mainWebView.canGoBack;
    self.forwardButton.enabled = self.mainWebView.canGoForward;
    UIBarButtonItem *refreshStopButton = self.mainWebView.isLoading ? self.stopButton:self.refreshButton;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 250.0f;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *itmes;
    itmes = [NSArray arrayWithObjects:fixedSpace,
refreshStopButton,flexibleSpace,self.backButton,flexibleSpace,self.forwardButton,fixedSpace, nil];
    
    UIToolbar *toolbar =  [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 720.0f, 1024.0f, 50.0f)];
    toolbar.backgroundColor = [UIColor redColor];
//    toolbar.tintColor = [UIColor redColor];
//    toolbar.alpha = 0.5f;
    //toolbar.translucent = NO;
    toolbar.items = itmes;
//    [self.view addSubview:toolbar];
}
#pragma mark -
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self updateToolbarItems];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateToolbarItems];
}

#pragma mark - Target actions

- (void)goBackClicked:(UIButton *)sender {
    [mainWebView goBack];
}

- (void)goForwardClicked:(UIButton *)sender {
    [mainWebView goForward];
}

- (void)reloadClicked:(UIButton *)sender {
    [mainWebView reload];
}

- (void)stopClicked:(UIButton *)sender {
    [mainWebView stopLoading];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self updateToolbarItems];
}


@end
