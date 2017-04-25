//
//  SMDepositController.m
//  SMProject
//
//  Created by arvin yan on 8/11/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMDepositController.h"
#import "XMLmanage.h"
#import "SGInfoAlert.h"

@interface SMDepositController ()

@end

@implementation SMDepositController
@synthesize depositTxt = depositTxt_;
@synthesize usingTxt = usingTxt_;

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
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * UID = [defaults stringForKey:@"UID"];
    NSString *str = [[XMLmanage shardSingleton] getAdvance:UID withUsername:@"sanmoon" withPwd:@"sm147369"];
    self.depositTxt.text = str;
        
    NSString * total = [defaults objectForKey:@"total"];
    if ([total floatValue] > [str floatValue]) {
        self.usingTxt.text = str;
    }
    else
    {
         self.usingTxt.text = total;
    }
    //        SMDepositController * pay = [[SMDepositController alloc] init];
    //        [self.navigationController pushViewController:pay animated:YES];
    
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
    [self.navigationController popViewControllerAnimated:YES];

    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)verifyBtnClicked:(id)sender
{
    float des = [self.depositTxt.text floatValue];
    float desposit = [self.usingTxt.text floatValue];
    
    if ([self.usingTxt.text floatValue] > des) {
        [SGInfoAlert showInfo:@"使用金额不能超过押金余额！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
    }
    else
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        [prefs setObject:[NSString stringWithFormat:@"%0.2f",des] forKey:@"fee"];
        [prefs setObject:[NSString stringWithFormat:@"%0.2f",desposit] forKey:@"desposit"];

        [prefs synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
