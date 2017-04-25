//
//  SMOrderSummaryController.m
//  SMProject
//
//  Created by arvin yan on 8/3/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMOrderSummaryController.h"
#import "TitleCell.h"
#import "CustomCell.h"
#import "SMMemberController.h"
#import "ProjectManage.h"
#import "SMPaymentController.h"
#import "SVProgressHUD.h"
ProjectManage * manage;
@interface SMOrderSummaryController ()

@end

@implementation SMOrderSummaryController

@synthesize summaryArray = summaryArray_;
@synthesize orderTableView = orderTableView_;
@synthesize btnCancel = btnCancel_;
@synthesize btnPay = btnPay_;
@synthesize itemType =  itemType_;

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
    self.summaryArray = [NSMutableArray arrayWithCapacity:3];
    self.title = @"购买汇总";
    manage = [ProjectManage shardSingleton];
    [self getOrder];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customBackItem];
    
    
}
- (void)customBackItem
{
    UIButton *backButtonItem=[[UIButton alloc] initWithFrame:CGRectMake(15, 6, 55, 32)];
    [backButtonItem setTitle:@"取消" forState:UIControlStateNormal];
    [backButtonItem setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButtonItem addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    // [backButtonItem setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    // [backButtonItem setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *rightBar =[[UIBarButtonItem alloc] initWithCustomView:backButtonItem];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    
    
}
- (void)popView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getOrder
{
    self.summaryArray = [NSMutableArray arrayWithArray:[manage getOrderRecordWithType:self.itemType]];
    NSLog(@"the summary count is %d",[self.summaryArray count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.summaryArray count] + 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"mycell";
    static NSString * ident = @"titlecell";
    
    OrderInfo * order = [[OrderInfo alloc] init];
    
    if (indexPath.row == 0) {
		TitleCell *cell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:ident];
		if (cell == nil) {
			NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:self options:nil];
			for (id oneObject in nib) {
				if ([oneObject isKindOfClass:[TitleCell class]]) {
					cell = (TitleCell *)oneObject;
				}
			}
		}
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.summaryArray.count==0) {
            [SVProgressHUD showErrorWithStatus:@"无商品"];
        }else{
        order = [self.summaryArray objectAtIndex:0];
        }
        if ([order.type isEqualToString: @"6"]) {
            cell.times.text = @"次数";
        }
        return cell;
    }
    
    CustomCell *custom = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (custom == nil)
    {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        for (id oneObject in nib)
        {
            if ([oneObject isKindOfClass:[CustomCell class]])
            {
                custom = (CustomCell *)oneObject;
            }
        }
    }
    order = [self.summaryArray objectAtIndex:indexPath.row - 1];
    
    UITextField * countText = (UITextField *)custom.textfiled;
    countText.tag = indexPath.row - 1;
    [countText addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    custom.lable1.text = order.name;
    
    custom.textfiled.text = order.counts;
    custom.textfiled.enabled = false;
    custom.textfiled.borderStyle = UITextBorderStyleNone;

    custom.lable3.text = order.price;
    custom.lable4.text = order.rate;
    float total = [custom.lable3.text floatValue] * [custom.textfiled.text intValue] * [custom.lable4.text floatValue] ;
    custom.total.text = [[NSNumber numberWithFloat:total] stringValue];
    custom.selectionStyle = UITableViewCellSelectionStyleNone;
    //if ([order.type isEqualToString:@"7"])
    //{
    
    
    UIButton * batBtn = (UIButton *)custom.batch;
    
    batBtn.tag = indexPath.row - 1;
    NSLog(@"the tag is %d",batBtn.tag);
    if ([order.type isEqualToString: @"6"]) {
        
        [batBtn setTitle:order.skpmount forState:UIControlStateNormal];
        return custom;
    }
    
//    [batBtn addTarget:self
//               action:@selector(produceClicked:)
//     forControlEvents:UIControlEventTouchUpInside];
    OrderInfo * orders = [self.summaryArray objectAtIndex:indexPath.row - 1];
    
    
    NSRange range = [orders.produce rangeOfString:@";"];
    if (range.location == NSNotFound){
        
        [batBtn setTitle:order.produce forState:UIControlStateNormal];
    }
    else
    {
        NSArray * ordArray = [orders.produce componentsSeparatedByString:@";"];
        if ([ordArray count] > 1) {
            [batBtn setTitle:[ordArray objectAtIndex:0]forState:UIControlStateNormal];
        }
    }
    return custom;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return NO;
    }else{
        return YES;
    }

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [manage deleteOrderRecordWithName:[[self.summaryArray objectAtIndex:indexPath.row -1] name]];
        [self.summaryArray removeObjectAtIndex:indexPath.row -1];
        [self.orderTableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([self.summaryArray count] == 0)
        {
            btnPay_.enabled = false;
        }
        else
        {
            btnPay_.enabled = true;
        }
    }
}

- (IBAction)cancelBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)paymentBtnClicked:(id)sender
{
    SMMemberController * member = [[SMMemberController alloc] init];
    member.itemType = self.itemType;
    [self.navigationController pushViewController:member animated:YES];
    
//    SMPaymentController * pay = [[SMPaymentController alloc] init];
//    [self.navigationController pushViewController:pay animated:YES];
}


@end
