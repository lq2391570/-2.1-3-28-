//
//  WebViewController.h
//  CocoaService
//
//  Created by 石榴花科技 on 14-3-14.
//  Copyright (c) 2014年 shiliuhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;
@end

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong, readonly) UIBarButtonItem *backButton;
@property (nonatomic, strong, readonly) UIBarButtonItem *forwardButton;
@property (nonatomic, strong, readonly) UIBarButtonItem *refreshButton;
@property (nonatomic, strong, readonly) UIBarButtonItem *stopButton;



@property (nonatomic, strong)UIWebView *mainWebView;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL HideBack;

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

- (void)updateToolbarItems;

- (void)goBackClicked:(UIBarButtonItem *)sender;
- (void)goForwardClicked:(UIBarButtonItem *)sender;
- (void)reloadClicked:(UIBarButtonItem *)sender;
- (void)stopClicked:(UIBarButtonItem *)sender;



@end
