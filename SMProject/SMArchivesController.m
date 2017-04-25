//
//  SMArchivesController.m
//  SMProject
//
//  Created by arvin yan on 11/16/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMArchivesController.h"
#import "XMLmanage.h"
#import "SGInfoAlert.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"

#define archivesURL [NSString stringWithFormat:@"%@GetData.asmx/SetGuestInfo?HTTP/1.1",RIP]

#define kPopViewWidth       200
#define kPopViewHeight      120
NSArray * argsArray;
NSMutableArray * popArray;
int flag;

@interface SMArchivesController ()
{
    
}
@end

@implementation SMArchivesController

@synthesize name = _name;
@synthesize tel = _tel;
@synthesize src = _src;
@synthesize people = _people;
@synthesize customerArray = _customerArray;
@synthesize peopleArray = _peopleArray;
@synthesize popViewController = popViewController_;
@synthesize popoverController = popoverController_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    buttonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
    NSLog(@"view will appear...");
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)getStoresID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * uName = [prefs objectForKey:@"name"];
    return uName;
}

- (void)getCustomerData
{
    NSMutableArray * array = [[XMLmanage shardSingleton] getCustomerSrc];
    self.customerArray = [NSMutableArray arrayWithArray:array];
    NSLog(@"the cutomer count is %@",[[self.customerArray objectAtIndex:0] tname]);
}

- (void)getPeopleData
{
    NSArray * array = [[XMLmanage shardSingleton] getPeopleWithCID:[self getStoresID]];
    self.peopleArray = [NSMutableArray arrayWithArray:array];
    NSLog(@"the people count is %d",[self.peopleArray count]);
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    argsArray = [[NSArray alloc] init];
    [self getCustomerData];
    [self getPeopleData];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)selectCustomers:(id)sender
{
    flag = 1;
    popArray = [NSMutableArray arrayWithCapacity:2];
    
    for (CustomerSrc * cust in self.customerArray) {
        NSLog(@"the cutomers select  is %@",cust);
        NSLog(@"the cutomers select  is %@,%@",cust.tkey,cust.tname);
        [popArray addObject:cust.tname];
    }
    [self popDomainView];
    
}

- (IBAction)selectPeople:(id)sender
{
    flag = 2;
    popArray = [NSMutableArray arrayWithCapacity:2];
    
    for (CustomerSrc * cust in self.peopleArray) {
        NSLog(@"the people select  is %@",cust);
        NSLog(@"the people select  is %@,%@",cust.tkey,cust.tname);
        [popArray addObject:cust.tname];
    }
    [self popPelopleView];
}

- (IBAction)createDA:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
     btn.userInteractionEnabled=NO;
    
   // [SVProgressHUD showWithStatus:@"查询中，请稍后"];
    if (self.name.text == nil || self.name.text.length == 0) {
        [SGInfoAlert showInfo:@"请输入姓名！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
       btn.userInteractionEnabled=YES;
        return;
        
    }
    if (self.tel.text == nil || self.tel.text.length == 0) {
        [SGInfoAlert showInfo:@"请输入电话！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
     btn.userInteractionEnabled=YES;
        return;
    }
    if (self.src.text == nil || self.src.text.length == 0) {
        
        [SGInfoAlert showInfo:@"请输入新客户来源！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
    btn.userInteractionEnabled=YES;
        return;
    }
    
    if (self.people.text == nil || self.people.text.length == 0) {
        [SGInfoAlert showInfo:@"请输入开发专员！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
     btn.userInteractionEnabled=YES;
        return;
    }
 //     btn.userInteractionEnabled=NO;
    NSError *error = nil;
    
    NSString * name = self.name.text;
    NSString * tels = self.tel.text;
    NSString * xkhlyid;
    NSString * kfazhid;
    
    for (CustomerSrc * cust in self.customerArray) {
        if ([cust.tname isEqualToString:self.src.text]) {
            xkhlyid = cust.tkey;
        }
    }
    
    for (CustomerSrc * cust in self.peopleArray) {
        if ([cust.tname isEqualToString:self.people.text]) {
            kfazhid = cust.tkey;
        }
    }
    
    NSString * username  = @"sanmoon";
    NSString * userpass  = @"sm147369";
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * usid = [defaults stringForKey:@"name"];
    
    
    NSString * path = [NSString stringWithFormat:@"%@",archivesURL];
    
    NSURL * postURL = [NSURL URLWithString:path];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:postURL];
    [request setDelegate:self];
	[request setPostValue:usid forKey:@"usid"];
    [request setPostValue:name  forKey:@"gname"];
    [request setPostValue:tels forKey:@"gtelphone"];
    [request setPostValue:xkhlyid forKey:@"xklyid"];
    [request setPostValue:kfazhid forKey:@"kfzyid"];
    
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:userpass forKey:@"userpass"];
    
    NSLog(@"the request value is %@",request.postBody);
    
    
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSLog(@"the response %@",restr);
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:restr options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        
        NSLog(@"this is submit value %@",[rootElement stringValue]);
        [SVProgressHUD dismiss];

        NSString * msgs = [NSString stringWithFormat:@"顾客号:%@\r姓名:%@\n电话:%@",[rootElement stringValue],name,tels];
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"建档成功" message:msgs delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        btn.userInteractionEnabled=YES;
//        [SGInfoAlert showInfo:@"建立档案成功。"
//                      bgColor:[[UIColor blackColor] CGColor]
//                       inView:self.view
//                     vertical:0.4];
//        [self dismissViewControllerAnimated:YES completion:nil];

        
    }];
    
    [request setFailedBlock:^{
        [SVProgressHUD dismiss];

        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
        [SGInfoAlert showInfo:@"建立档案失败，请重试。"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
         btn.userInteractionEnabled=YES;
    }];
    
    [request startAsynchronous];
    
}

- (void)domainChanged:(NSString *)selectedDomain
{
    NSLog(@"the domain is %@",selectedDomain);
    if (flag == 1) {
        self.src.text = selectedDomain;
    }
    else
    {
        self.people.text = selectedDomain;
        
    }
    if (self.popoverController != nil)
    {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)popDomainView
{
    if (self.popViewController == nil)
    {
        self.popViewController = [[SMPopViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    self.popViewController.array = popArray;
    
    self.popViewController.delegate = self;
    CGRect pickFrame = CGRectMake(150, 90, kPopViewWidth, kPopViewHeight);
    if (self.popoverController == nil)
    {
        Class classPopoverController = NSClassFromString(@"UIPopoverController");
        if (classPopoverController)
        {
            self.popoverController = [[classPopoverController alloc] initWithContentViewController:self.popViewController];
        }
    }
    [self.popoverController presentPopoverFromRect:pickFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


- (void)popPelopleView
{
    if (self.popViewController == nil)
    {
        self.popViewController = [[SMPopViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    
    self.popViewController.array = popArray;
    
    
    self.popViewController.delegate = self;
    CGRect pickFrame = CGRectMake(150, 130, kPopViewWidth, kPopViewHeight);
    if (self.popoverController == nil)
    {
        Class classPopoverController = NSClassFromString(@"UIPopoverController");
        if (classPopoverController)
        {
            self.popoverController = [[classPopoverController alloc] initWithContentViewController:self.popViewController];
        }
    }
    [self.popoverController presentPopoverFromRect:pickFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
