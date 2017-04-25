//
//  SMOrderControllerViewController.m
//  SMProject
//
//  Created by arvin yan on 8/2/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMOrderControllerViewController.h"
#import "TitleCell.h"
#import "CustomCell.h"
#import "SMOrderSummaryController.h"
#import "ProjectManage.h"
#import "SGInfoAlert.h"
#import "SVProgressHUD.h"
NSArray * buttonArray;
int totalNumber;
int rowTag;

@implementation SMOrderControllerViewController
@synthesize orderTableView = orderTableView_;
@synthesize orderArray = orderArray_;
@synthesize maxTotal = maxTotal_;
@synthesize itemType = itemType_;

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
    self.title = @"销售订单";
    [self customBackItem];
    
    //[self.view.superview setBounds:CGRectMake(0, 0, 450, 480)];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    orderTableView_.bounces=NO;
}

- (void)customBackItem
{
    UIButton *backButtonItem=[[UIButton alloc] initWithFrame:CGRectMake(15, 6, 155, 32)];
    [backButtonItem setTitle:@"取消全部订单" forState:UIControlStateNormal];
    [backButtonItem setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButtonItem addTarget:self action:@selector(deleteRecords) forControlEvents:UIControlEventTouchUpInside];
    // [backButtonItem setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    // [backButtonItem setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *rightBar =[[UIBarButtonItem alloc] initWithCustomView:backButtonItem];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)deleteRecords
{
    ProjectManage * manage = [ProjectManage shardSingleton];
    [manage deleteRecords];
    NSLog(@"the delete records...");
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.orderArray = [NSMutableArray arrayWithCapacity:3];
    
    [self getOrder];
    [super viewWillAppear:animated];
    [orderTableView_ reloadData];
}
- (void)getOrder
{
    ProjectManage * manage = [ProjectManage shardSingleton];
    NSLog(@"the item type is %@",self.itemType);

    self.orderArray = [NSMutableArray arrayWithArray:[manage getOrderRecordWithType:self.itemType]];
    NSLog(@"the order array count is %d",[self.orderArray count]);
    
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.orderArray count] + 1;
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
        if (self.orderArray.count<1) {
            [SVProgressHUD showInfoWithStatus:@"无商品"];
        }else{
        order = [self.orderArray objectAtIndex:0];
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
    if (self.orderArray.count<1) {
        [SVProgressHUD showInfoWithStatus:@"无商品"];
    }else{
    order = [self.orderArray objectAtIndex:indexPath.row - 1];
    }
    UITextField * countText = (UITextField *)custom.textfiled;
    countText.delegate=self;
    countText.tag = indexPath.row - 1;
    [countText addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    custom.lable1.text = order.name;
    
    custom.textfiled.text = order.counts;
    custom.lable3.text = order.price;
    custom.lable4.text = order.rate;
    
    total = [custom.lable3.text floatValue] * [custom.textfiled.text intValue] * [custom.lable4.text floatValue] ;
    custom.total.text = [[NSNumber numberWithFloat:total] stringValue];
    custom.selectionStyle = UITableViewCellSelectionStyleNone;
    //if ([order.type isEqualToString:@"7"])
    //{

    NSLog(@"--%@==",order.skpmount);                    
    UIButton * batBtn = (UIButton *)custom.batch;
  
    batBtn.tag = indexPath.row - 1;
    NSLog(@"the tag is %d",batBtn.tag);
    if ([order.type isEqualToString: @"6"]) {
        
        [batBtn setTitle:order.skpmount forState:UIControlStateNormal];
        return custom;
    }
    
    [batBtn addTarget:self
               action:@selector(produceClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    OrderInfo * orders = [self.orderArray objectAtIndex:indexPath.row - 1];
   
    
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


- (void)textFieldDidChange:(UITextField *)theTextField
{
    OrderInfo * order = [[OrderInfo alloc] init];
    ProjectManage * mangage = [[ProjectManage alloc] init];
    
    if (theTextField.text == 0) {
        [SGInfoAlert showInfo:@"密码错误请重新输入！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
    }
    
    
    order.counts = theTextField.text;
    int row = theTextField.tag;
    
    order.name = [[self.orderArray objectAtIndex:row] name];
    order.price = [[self.orderArray objectAtIndex:row] price];
    order.rate = [[self.orderArray objectAtIndex:row] rate];
  //  order.batch=[[self.orderArray objectAtIndex:row] batch];
    order.skpmount=[[self.orderArray objectAtIndex:row] skpmount];
    
    float money = [order.counts intValue] * [order.price floatValue] * [order.rate floatValue];
    order.money = [NSString stringWithFormat:@"%0.2f",money];
    NSLog(@"the money is %@",order.money);
    total=[order.money floatValue];
    NSLog(@"%@===",order.skpmount);
    NSInteger skpmount=[order.counts intValue] *[order.skpmount intValue];
    order.skpmount = [NSString stringWithFormat:@"%d",skpmount];
    NSLog(@"the skpmount is %@",order.skpmount);

    [mangage updateOrder:order];
    
    [self.orderArray replaceObjectAtIndex:row withObject:order];
   // float money = [order.counts intValue] * [[[self.orderArray objectAtIndex:row] price] floatValue];
   // order.money = [NSString stringWithFormat:@"%f",money];
//    NSLog(@"the order id is %@,the counts is %@,the money is %@",order.ID,order.counts,order.money);
//    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
//    NSLog(@"the path is %@,the counts is %@,the money is %@",order.ID,order.counts,order.money);
//    
    //    CustomCell * cell = (CustomCell *)[self.orderTableView cellForRowAtIndexPath:path];
    //    NSLog(@"the cell tag is %@",cell);
    //    UIButton *producebtn = (UIButton *)cell.batch;
    //    order.produce = producebtn.titleLabel.text;
    //
    //    // UIButton *producebtn =(UIButton*)[cell.contentView viewWithTag:rowTag];
    //    NSLog(@"the prod button is %@",producebtn.titleLabel.text);
    //  [mangage updateOrderInfo:order];
   // [orderTableView_ reloadData];
    
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
   [orderTableView_ reloadData];
}
- (void)produceClicked:(UIButton *)btn
{
    NSLog(@"click btn");
    buttonArray = [[NSArray alloc] init];
    OrderInfo * order = [[OrderInfo alloc] init];
    rowTag = btn.tag;
    order = [self.orderArray objectAtIndex:rowTag];
    buttonArray = [order.produce componentsSeparatedByString:@";"];
    NSLog(@"the action arrray is %@",buttonArray);
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"批次"
                                  delegate:self
                                  cancelButtonTitle:@"取消" // change is here
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    for (NSString * title in buttonArray)
    {
        [actionSheet addButtonWithTitle:title];
    }
    [actionSheet showInView:self.view];
    
	//[actionSheet showFromRect:self.view.bounds inView:self.view animated:YES];
	//[sheet release];
    //[actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
	if (buttonIndex == actionSheet.cancelButtonIndex) { return; }
    int cellIndex = rowTag +1;
    NSIndexPath *path = [NSIndexPath indexPathForRow:cellIndex inSection:0];
    CustomCell * cell = (CustomCell *)[self.orderTableView cellForRowAtIndexPath:path];
    NSLog(@"the producebtn tag is %d",rowTag);
    UIButton *producebtn = cell.batch;
    
    
    // UIButton *producebtn =(UIButton*)[cell.contentView viewWithTag:rowTag];
    NSLog(@"the prod button is %@",producebtn.titleLabel.text);
    // UIButton *producebtn = (UIButton *)cell;
    NSString * title = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"the title tag is %@",title);
    
    [producebtn setTitle: title forState:UIControlStateNormal];
    ProjectManage * mangage = [[ProjectManage alloc] init];
    OrderInfo * order = [[OrderInfo alloc] init];
    order.produce = title;
    order.name = cell.lable1.text;
    order.counts = cell.textfiled.text;
    NSLog(@"the id is %@",order.ID);
    [mangage updateOrderInfo:order];
    
    //producebtn.titleLabel.text = ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = indexPath.row;
	NSUInteger section = indexPath.section;
}

- (IBAction)purchaseBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)payBtnCliked:(id)sender
{
    ProjectManage * manage = [ProjectManage shardSingleton];
    OrderInfo * order = [[OrderInfo alloc] init];
    if(totalNumber == 0)
    {
        order.counts = @"1";
    }
    //    else
    //    {
    //       order.counts = [NSString stringWithFormat:@"%d",totalNumber];
    //    }
    
    SMOrderSummaryController * orderController = [[SMOrderSummaryController alloc]init];
    orderController.itemType = self.itemType;
    // UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:order  ];
    [self.navigationController pushViewController:orderController animated:YES];
    //settingsController.parentController = self;
    // order.navigationController = self.popUpNavigationController
}
@end


