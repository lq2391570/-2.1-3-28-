//
//  UISolutionController.m
//  SMProject
//
//  Created by arvin yan on 11/7/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "UISolutionController.h"
#import "XMLmanage.h"

#import "InformationManage.h"
#import "SVProgressHUD.h"
#import "XMLmanage.h"
#import "ProjectManage.h"
#import "SMOrderControllerViewController.h"

@interface UISolutionController ()

@end

@implementation UISolutionController

@synthesize soloution;
@synthesize sDescription;
@synthesize resonse;
@synthesize advance;
@synthesize key;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)getBodyDescription
{
    NSDictionary * dict = [[XMLmanage shardSingleton] getBodySummary:self.key];
    self.soloution.text = [NSString stringWithFormat:@"针对%@号部位皮肤的问题描述ttyy",self.key];
    self.sDescription.text = (NSString *)[dict objectForKey:@"desp"];
    self.resonse.text = [dict objectForKey:@"questionOrRession"];
    self.advance.text = [dict objectForKey:@"advise"];
}

- (void)viewDidLoad
{
    NSLog(@"dddddddddd");
    //[self getBodyDescription];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
