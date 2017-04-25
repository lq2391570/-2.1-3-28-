//
//  SMDescriptionController.m
//  SMProject
//
//  Created by arvin yan on 11/7/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMDescriptionController.h"
#import "XMLmanage.h"
#import "SMSolutionController.h"

@interface SMDescriptionController ()

@end

@implementation SMDescriptionController
@synthesize soltion;
@synthesize advince;
@synthesize reason;
@synthesize description;
@synthesize key;
@synthesize color;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)getColor
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   return [prefs objectForKey:@"smcolor"];
}

- (void)getBodyDescription
{
    
    NSString * colors = [self getColor];
    NSLog(@"the selcerd color is %@",colors);
    
    if ([colors isEqualToString: @"pink"]) {
        colors = @"1";
    }
    else if ([colors isEqualToString: @"red"]) {
        colors = @"2";

        
    }
    else if ([colors isEqualToString: @"anred"]) {
        colors = @"3";

        
    } else if ([colors isEqualToString: @"white"]) {
        colors = @"4";

        
    }
    else if ([colors isEqualToString: @"gray"]) {
        colors = @"5";

    }
    else if ([colors isEqualToString: @"purple"]) {
        colors = @"6";

        
    } else if ([colors isEqualToString: @"black"]) {
        colors = @"7";

        
    }else
    {
        colors = @"1";

    }
    
    NSDictionary * dict = [[XMLmanage shardSingleton] getBodySummary:self.key withColor:colors];
    self.soltion.text = [NSString stringWithFormat:@"针对%@号部位皮肤的问题描述",self.key];
    self.description.text = (NSString *)[dict objectForKey:@"desp"];
    self.description.clipsToBounds = YES;
    self.description.layer.cornerRadius = 8.0f;
    self.reason.text = [dict objectForKey:@"questionOrRession"];
    self.reason.clipsToBounds = YES;
    self.reason.layer.cornerRadius = 8.0f;
    self.advince.text = [dict objectForKey:@"advise"];
    self.advince.clipsToBounds = YES;
    self.advince.layer.cornerRadius = 8.0f;
}

- (void)viewDidLoad
{
    [self getBodyDescription];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    buttonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
    NSLog(@"view will appear...");
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender
{
    SMSolutionController * solution = [[SMSolutionController alloc] init];
    solution.key = self.key;
    [self.navigationController pushViewController:solution animated:YES];
}

@end
