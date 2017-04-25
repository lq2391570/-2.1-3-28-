//
//  DAViewController.m
//  SMProject
//
//  Created by arvin yan on 11/14/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "DAViewController.h"
#import "XMLmanage.h"


#define pickerViewbtnWidth 	30.0
#define pickerViewbtnHeight 18.0
#define kPopViewWidth       200
#define kPopViewHeight      120

int flag;
NSMutableArray * popArray;

@interface DAViewController ()

@property (nonatomic,retain)  IBOutlet UIPickerView * pickerView;
@property (nonatomic,retain)  NSArray * pickerViewData;
@property (nonatomic, retain) UIActionSheet * actionSheet;

@end

@implementation DAViewController
@synthesize name = _name;
@synthesize tel = _tel;
@synthesize src = _src;
@synthesize people = _people;
@synthesize peoples = _peoples;
@synthesize customers1 = customers1_;

@synthesize pickerView = pickerView_;
@synthesize pickerViewData = pickerViewData_;
@synthesize actionSheet = actionSheet_;
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

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)getCustomerData
{
    self.customers1  = [[XMLmanage shardSingleton] getCustomerSrc];
    NSLog(@"the cutomer count is %@",[[self.customers1 objectAtIndex:0] name]);
}

- (void)getPeopleData
{
    self.peoples = [[XMLmanage shardSingleton] getPeopleWithCID:[self getStoresID]];
    NSLog(@"the people count is %d",[self.peoples count]);
    
}

- (void)viewWillAppear:(BOOL)animated
{
//{
//    self.customers = [NSMutableArray arrayWithCapacity:2];
//    self.peoples = [NSMutableArray arrayWithCapacity:2];
    [self getCustomerData];
   // [self getPeopleData];
}

- (void)domainChanged:(NSString *)selectedDomain
{
    NSLog(@"the domain is %@",selectedDomain);
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
    CGRect pickFrame = CGRectMake(150, 0, kPopViewWidth, kPopViewHeight);
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
    CGRect pickFrame = CGRectMake(150, 0, kPopViewWidth, kPopViewHeight);
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

- (void)setCustomerData
{
    NSLog(@"the cutomer count is %@",[[self.customers1 objectAtIndex:0] name]);

}

- (IBAction)btn1:(id)sender
{
    [self setCustomerData];
    flag = 1;

    
    //popArray = [NSMutableArray arrayWithCapacity:2];
   // NSLog(@"the cutomer count opop is %d",[self.customers count]);
    for (int i = 0; i < 5; i++) {
        
        NSLog(@"teh arrya count is %@",[[self.customers1 objectAtIndex:i] key]);
        //[popArray addObject:[[self.customers objectAtIndex:i] name]];

    }
    

   // [self popDomainView];

    //self.pickerViewData = customers;
    //[self addActionSheetToView];

}

- (IBAction)btn2:(id)sender
{
    flag = 2;
    popArray = [NSMutableArray arrayWithCapacity:2];
    for (CustomerSrc * customer in self.peoples) {
        [popArray addObject:customer.tname];
    }
    [self popPelopleView];

}



//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[self.txtUsername resignFirstResponder];
//	[self.txtPassword resignFirstResponder];
//}

- (NSString *)getStoresID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString * uName = [prefs objectForKey:@"name"];
    return uName;
}



- (IBAction)createDA:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
