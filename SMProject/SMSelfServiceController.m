//
//  SMSelfServiceController.m
//  SMProject
//
//  Created by arvin yan on 10/17/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMSelfServiceController.h"
#import "ServiceAlertViewController.h"
#import "SGInfoAlert.h"
#import "SMDescriptionController.h"
#import "FaceViewController.h"


int curX;
int curY;
NSString * selectedIndex;

@interface SMSelfServiceController ()

@end

int buffer = 10;
int xCoord=0;
int yCoord=0;
int buttonWidth=35;
int buttonHeight=35;

NSMutableArray * btnArray;

@implementation SMSelfServiceController
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize btn8;
@synthesize btn9;
@synthesize btn10;
@synthesize btn11;
@synthesize btnReset;
@synthesize btnNext;

@synthesize btnB1;
@synthesize btnB2;
@synthesize btnB3;
@synthesize btnB4;
@synthesize btnB5;
@synthesize btnB6;
@synthesize btnB7;
@synthesize btnB8;
@synthesize btnB9;
@synthesize btnB10;
@synthesize btnB11;
@synthesize selectView;

- (void)viewDidLoad
{
    btnArray = [NSMutableArray arrayWithCapacity:2];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDisplay:) name:@"updateServiceView" object:nil];
    [super viewDidLoad];
    
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(0, 0, 100, 100)];
//    [button setTitle:@"进入面部护理" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(pushFace) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)pushFace
{
    FaceViewController *faceView=[[FaceViewController alloc] init];
    [self.navigationController pushViewController:faceView animated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (btnArray.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    for (UIView *view in [self.selectView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    xCoord = 0;
    [self resetBG];
    [btnArray removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveIDWithKey:(NSString *)ID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:btnArray forKey:ID];
    [prefs synchronize];
}

- (void)setColor:(NSString *)colors
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:colors forKey:@"smcolor"];
    [prefs synchronize];
}

- (NSString *)getColorWithID:(NSString *)ID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:ID];
}

- (void)setDisplay:(NSNotification *) notification
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(xCoord, yCoord, buttonWidth, buttonHeight);
    UIButton * btnBG = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([selectedIndex isEqualToString:@"1"]) {
        NSLog(@"click 1.");
        btnBG = self.btnB1;
    }
    else if ([selectedIndex isEqualToString:@"2"]) {
        NSLog(@"click 2.");
        
        btnBG = self.btnB2;
    }
    else if ([selectedIndex isEqualToString:@"3"]) {
        
        btnBG = self.btnB3;
    }
    else if ([selectedIndex isEqualToString:@"4"]) {
        
        btnBG = self.btnB4;
    }
    else if ([selectedIndex isEqualToString:@"5"]) {
        
        btnBG = self.btnB5;
    }
    else if ([selectedIndex isEqualToString:@"6"]) {
        
        btnBG = self.btnB6;
    }
    else if ([selectedIndex isEqualToString:@"7"]) {
        
        btnBG = self.btnB7;
    }
    else if ([selectedIndex isEqualToString:@"8"]) {
        
        btnBG = self.btnB8;
    }
    else if ([selectedIndex isEqualToString:@"9"]) {
        
        btnBG = self.btnB9;
    }
    else if ([selectedIndex isEqualToString:@"10"]) {
        
        btnBG = self.btnB10;
    }
    else {
        
        btnBG = self.btnB11;
    }
    
    if ([[self getColorWithID:selectedIndex] isEqualToString:@"pink"]) {
        NSLog(@"click pink.");
        
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_151.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_151.png"] forState:UIControlStateNormal];
        
    }
    else if ([[self getColorWithID:selectedIndex] isEqualToString:@"black"]) {
        NSLog(@"click black.");
        
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_171.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_171.png"] forState:UIControlStateNormal];
        
    }
    else if ([[self getColorWithID:selectedIndex] isEqualToString:@"anred"]) {
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_051.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_051.png"] forState:UIControlStateNormal];
        
    }
    else if ([[self getColorWithID:selectedIndex] isEqualToString:@"white"]) {
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_071.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_071.png"] forState:UIControlStateNormal];
        
    }
    else if ([[self getColorWithID:selectedIndex] isEqualToString:@"gray"]) {
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_091.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_091.png"] forState:UIControlStateNormal];
        
    }
    else if ([[self getColorWithID:selectedIndex] isEqualToString:@"red"]) {
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_211.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_211.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"圣梦_161.png"] forState:UIControlStateNormal];
        [btnBG setBackgroundImage:[UIImage imageNamed:@"圣梦_161.png"] forState:UIControlStateNormal];
        
    }
    [btn setTitle:selectedIndex forState:UIControlStateNormal];
    [btnBG setTitle:selectedIndex forState:UIControlStateNormal];
    
    if ([[self getColorWithID:selectedIndex] isEqualToString:@"white"]) {
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btnBG setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnBG setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    btn.backgroundColor = [UIColor clearColor];
    btnBG.backgroundColor = [UIColor clearColor];
    btn.tag = [selectedIndex intValue];
    NSLog(@"the click before btn tag is %d", btn.tag);
    [btn addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    xCoord += buttonWidth+buffer;
    [self.selectView addSubview:btn];
    [super viewWillAppear:YES];
}

- (void)sendButtonClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;

    SMDescriptionController * service = [[SMDescriptionController alloc] init];
    //ServiceController * service = [[ServiceController alloc] init];
    NSLog(@"the tag is %d",btn.tag);

    service.key = [NSString stringWithFormat:@"%d",btn.tag];
    NSString * colors = [self getColorWithID:service.key];
    
    
    NSLog(@"the colors is %@",colors);
  
    [self setColor:colors];
    [self.navigationController pushViewController:service animated:YES];
}

- (void)promptWithArray
{
    if ([btnArray containsObject:selectedIndex]) {
        [SGInfoAlert showInfo:@"已选择，请勿重复添加！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        
        return;
    }
    [btnArray addObject:selectedIndex];
    [self saveIDWithKey:@"btns"];
    ServiceAlertViewController * sa = [[ServiceAlertViewController alloc] initWithNibName:@"ServiceAlertViewController" bundle:nil];
    UINavigationController * popUpNavigationController = [[UINavigationController alloc] initWithRootViewController:sa];
    sa.key = selectedIndex;
    popUpNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    popUpNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController presentViewController:popUpNavigationController animated:YES completion:nil];
}

- (IBAction)btn1Clicked:(id)sender
{
    selectedIndex = @"1";
    [self promptWithArray];
}

- (IBAction)btn2Clicked:(id)sender
{
    selectedIndex = @"2";
    [self promptWithArray];
    
}
- (IBAction)btn3Clicked:(id)sender
{
    selectedIndex = @"3";
    [self promptWithArray];
}
- (IBAction)btn4Clicked:(id)sender
{
    selectedIndex = @"4";
    [self promptWithArray];
}

- (IBAction)btn5Clicked:(id)sender
{
    selectedIndex = @"5";
    [self promptWithArray];
}

- (IBAction)btn6Clicked:(id)sender
{
    selectedIndex = @"6";
    [self promptWithArray];
}
- (IBAction)btn7Clicked:(id)sender
{
    selectedIndex = @"7";
    [self promptWithArray];
}
- (IBAction)btn8Clicked:(id)sender
{
    selectedIndex = @"8";
    [self promptWithArray];
}

- (IBAction)btn9Clicked:(id)sender
{
    selectedIndex = @"9";
    [self promptWithArray];
}
- (IBAction)btn10Clicked:(id)sender
{
    selectedIndex = @"10";
    [self promptWithArray];
}

- (IBAction)btn11Clicked:(id)sender
{
    selectedIndex = @"11";
    [self promptWithArray];
}
- (IBAction)btnRestClicked:(id)sender
{
    if (btnArray.count == 0) {
        return;
    }
    
    for (UIView *view in [self.selectView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    xCoord = 0;
    [self resetBG];
    [btnArray removeAllObjects];
    
}

- (void)resetBG
{
    [self.btnB1 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB1 setTitle:@"" forState:UIControlStateNormal];
    
    [self.btnB2 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB2 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB3 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB3 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB4 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB4 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB5 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB5 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB6 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB6 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB7 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB7 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB8 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB8 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB9 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB9 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB10 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB10 setTitle:@"" forState:UIControlStateNormal];

    [self.btnB11 setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnB11 setTitle:@"" forState:UIControlStateNormal];


}

- (IBAction)back:(id)sender
{
    
    for (UIView *view in [self.selectView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    xCoord = 0;
    [self resetBG];
    [btnArray removeAllObjects];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)goToFace:(UIButton *)sender
{
    FaceViewController *faceView=[[FaceViewController alloc] init];
    [self.navigationController pushViewController:faceView animated:YES];
}
@end
