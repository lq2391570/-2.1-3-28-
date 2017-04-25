//
//  ServiceAlertViewController.m
//  SMProject
//
//  Created by arvin yan on 11/6/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "ServiceAlertViewController.h"
#import "XMLmanage.h"

@interface ServiceAlertViewController ()

@end

@implementation ServiceAlertViewController

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize key;

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
    [self getDescription];
    // Do any additional setup after loading the view from its nib.
}

- (void)getDescription
{
    self.summary.text = [[XMLmanage shardSingleton] getBodyDescription:self.key withColor:@"1"];
    

    //self.summary.text = [[XMLmanage shardSingleton] getBodyDescription:self.key withColor:@"1"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)saveSelectedColor:(NSString *)Key WithValue:(NSString *)Value
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:Value forKey:Key];
    [prefs synchronize];
}

- (void)noticeUpdateView
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"updateServiceView"
     object:self];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)btn1Clicked
{
    [self saveSelectedColor:self.key WithValue:@"pink"];
    [self noticeUpdateView];
}

- (IBAction)btn2Clicked
{
    [self saveSelectedColor:self.key WithValue:@"red"];
    [self noticeUpdateView];

}

- (IBAction)btn3Clicked
{
    [self saveSelectedColor:self.key WithValue:@"anred"];
    [self noticeUpdateView];

}

- (IBAction)btn4Clicked
{
    [self saveSelectedColor:self.key WithValue:@"white"];
    [self noticeUpdateView];


}
- (IBAction)btn5Clicked
{
    [self saveSelectedColor:self.key WithValue:@"gray"];
    [self noticeUpdateView];


}
- (IBAction)btn6Clicked
{
    [self saveSelectedColor:self.key WithValue:@"purple"];
    [self noticeUpdateView];


}
- (IBAction)btn7Clicked
{
    [self saveSelectedColor:self.key WithValue:@"black"];
    [self noticeUpdateView];

}

- (IBAction)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}
@end
