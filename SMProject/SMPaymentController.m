//
//  SMPaymentController.m
//  SMProject
//
//  Created by arvin yan on 8/3/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "SMPaymentController.h"
#import "TitleCell.h"
#import "CustomCell.h"
#import "ProjectManage.h"
#import "XMLmanage.h"
#import "SGInfoAlert.h"
#import "SMDepositController.h"
#import "ASIHTTPRequest.h"
#import "SGInfoAlert.h"
#import "ASIFormDataRequest.h"

ProjectManage * manage;
NSMutableDictionary * dict;
int btnIndex = 0;
float totals;
float accountTotal;
NSString * txt1;
@interface SMPaymentController ()

@property (nonatomic,retain) NSMutableArray * salersArray;

@end

@implementation SMPaymentController
@synthesize cancelBtn = cancelBtn_;
@synthesize paymentBtn = paymentBtn_;
@synthesize payTableView = payTableView_;
@synthesize orderArray = orderArray_;
@synthesize salersArray = salersArray_;
@synthesize salersBtn1 = salersBtn1_;
@synthesize salersBtn2 = salersBtn2_;
@synthesize salersBtn3 = salersBtn3_;
@synthesize txt1 = txt1_;
@synthesize txt2 = txt2_;
@synthesize txt3 = txt3_;
@synthesize verifyBtn = verifyBtn_;
@synthesize despositTxt = despositTxt_;
@synthesize bankTxt = bankTxt_;
@synthesize cashTxt = cashTxt_;
@synthesize businessCardTxt = businessCardTxt_;
@synthesize busindessTxt = busindessTxt_;
@synthesize othersTxt = othersTxt_;
@synthesize  totalLabel = totalLabel_;
@synthesize itemType = itemType_;
@synthesize tyNumber =  tyNumber_;
@synthesize ldxNumber =  ldxNumber_;
@synthesize tyTxtNumber = tyTxtNumber_;
@synthesize ldxTxtNumber = ldxTxtNumber_;
NSString * expoNumber;
NSString * ldxNumber;

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
    self.title = @"付款";
   self.salersArray = [NSMutableArray arrayWithCapacity:3];
    manage = [ProjectManage shardSingleton];
    [self getOrder];
    [self getSalers];
    [self clearFee];
    self.salersBtn1.titleLabel.text = [self.salersArray objectAtIndex:0];
    self.salersBtn2.titleLabel.text = [self.salersArray objectAtIndex:1];
    self.salersBtn3.titleLabel.text = [self.salersArray objectAtIndex:2];
    txt1 = @"100";
    self.txt2.text = @"0";
    self.txt3.text = @"0";
    [super viewDidLoad];
     [self totalFee];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)textFieldDidChange:(id)sender
{
    if ([self.txt2.text floatValue] == 100 || [self.txt2.text floatValue] > 100)
    {
        [SGInfoAlert showInfo:@"销售人员2的提成比例应小于100%！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return;

    }
    
    if ([self.txt2.text floatValue] >0) {
        float sum = 100 - [self.txt2.text floatValue];
        txt1 = [NSString stringWithFormat:@"%0.2f",sum];
        NSLog(@"the txt2 is %@",txt1);
    }
}

- (IBAction)textField3DidChange:(id)sender
{
    float sum = [self.txt2.text floatValue] + [self.txt3.text floatValue];
    
    if ((sum - 100) == 0 || sum - 100 > 0)
    {
        [SGInfoAlert showInfo:@"销售人员2和销售人员3的提成比例应小于100%！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return;
        
    }
    
    if ([self.txt2.text floatValue] > 0 && [self.txt3.text floatValue] >0)
    {
        float sum = 100 - [self.txt2.text floatValue] - [self.txt3.text floatValue];
    
        txt1 = [NSString stringWithFormat:@"%0.2f",sum];
        NSLog(@"the txt3 is %@",txt1);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    totals = 0;
    expoNumber = [[NSString alloc] init];
    ldxNumber = [[NSString alloc] init];

    if ([self.itemType isEqualToString:@"7"]) {
        [self.tyNumber setHidden:YES];
        [self.tyTxtNumber setHidden:YES];
        [self.ldxTxtNumber setHidden:YES];
        [self.ldxNumber setHidden:YES];
    }
    else
    {
        [self.tyNumber setHidden:NO];
        [self.tyTxtNumber setHidden:NO];
        [self.ldxTxtNumber setHidden:NO];
        [self.ldxNumber setHidden:NO];
        
    }
    [self getExpo];
    [self getLdx];
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * des = [defaults stringForKey:@"desposit"];
    self.despositTxt.text = des;
    accountTotal = [[defaults stringForKey:@"fee"] floatValue];
    
   
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getOrder
{
    self.orderArray = [NSMutableArray arrayWithArray:[manage getOrderRecordWithType:self.itemType]];
    NSLog(@"the order array ocunt is %d",self.orderArray.count);
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.orderArray count] +1;
}


#pragma mark 刷新总价
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
        order = [self.orderArray objectAtIndex:0];
        
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
    order = [self.orderArray objectAtIndex:(indexPath.row -1)];
    UITextField * countText = (UITextField *)custom.textfiled;
    countText.tag = indexPath.row - 1;
    
    custom.lable1.text = order.name;
    
    custom.textfiled.text = order.counts;
    custom.textfiled.enabled = false;
    custom.lable3.text = order.price;
    custom.lable4.text = order.rate;
    float total = [custom.lable3.text floatValue] * [custom.textfiled.text intValue] * [custom.lable4.text floatValue] ;
    custom.total.text = [[NSNumber numberWithFloat:total] stringValue];
    custom.selectionStyle = UITableViewCellSelectionStyleNone;
    order.money = custom.total.text;
    
    
    
    UIButton * batBtn = (UIButton *)custom.batch;
    batBtn.tag = indexPath.row - 1;
    NSLog(@"the tag is %d",batBtn.tag);
    if ([order.type isEqualToString: @"6"]) {
        
        [batBtn setTitle:order.skpmount forState:UIControlStateNormal];
        return custom;
    }
    
    OrderInfo * orders = [self.orderArray objectAtIndex:indexPath.row - 1];
    NSRange range = [orders.produce rangeOfString:@";"];
    if (range.location == NSNotFound){
        
        [batBtn setTitle:order.produce forState:UIControlStateNormal];
    }
    else
    {
        NSArray * array = [orders.produce componentsSeparatedByString:@";"];
        if ([array count] > 1) {
            [batBtn setTitle:[array objectAtIndex:0]forState:UIControlStateNormal];
        }
    }

    return custom;
}

- (void)totalFee
{
    float fee;
    for (int i = 0; i < [self.orderArray count]; i++) {
        OrderInfo * order = [[OrderInfo alloc] init];
        order = [self.orderArray objectAtIndex:i];
        float total = [order.price floatValue] * [order.counts intValue] * [order.rate floatValue];
        fee += total;
    }
    NSLog(@"===%f",fee);
    self.totalLabel.text = [NSString stringWithFormat:@"%0.2f",fee] ;
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];

    [defaults setObject:self.totalLabel.text forKey:@"total"];
    
    [defaults synchronize];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return NO;
    }else{
        return YES;
    }

}

#pragma mark 修改
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [manage deleteOrderRecordWithName:[[self.orderArray objectAtIndex:indexPath.row -1] name]];
        [self.orderArray removeObjectAtIndex:indexPath.row -1];
        //修改
        [self totalFee];
        [self.payTableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    
        
        
        if ([self.orderArray count] == 0) {
            self.paymentBtn.enabled = false;
        }
        else
        {
            self.paymentBtn.enabled = true;
        }
    }
}

- (IBAction)cancelBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)paymentBtnClicked:(id)sender
{
  
    
    
}

- (void)getSalers
{
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * name = [defaults stringForKey:@"name"];
    //NSString * name = @"B01001";
    NSString * username  = @"sanmoon";
    NSString * userpwd = @"sm147369";
    
    //    NSString * name = [defaults stringForKey:@"name"];
    //    NSString * username = [defaults stringForKey:@"username"];
    //    NSString * userpwd = [defaults stringForKey:@"userpwd"];
    NSArray * array = [[XMLmanage shardSingleton] getSalers:name withUsername:username withPwd:userpwd];
    dict = [NSMutableDictionary dictionaryWithCapacity:3];
    for (Information * info in array) {
        [dict setObject:info.ID forKey:info.name];
        NSLog(@"the id is %@ name is %@",info.ID,info.name);
        [self.salersArray addObject:info.name];
    }
}

- (void)initSalers
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择销售人员"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    for (int i = 0; i < [self.salersArray count];i ++) {
        [actionSheet addButtonWithTitle:[self.salersArray objectAtIndex:i]];
    }
    
    [actionSheet showInView:self.view];
}

- (IBAction)salersBtnClicked:(id)sender
{
    btnIndex = 0;
    [self initSalers];
}

- (IBAction)salersBtn2Clicked:(id)sender
{
    btnIndex = 1;
    [self initSalers];
}

- (IBAction)salersBtn3Clicked:(id)sender
{
    btnIndex = 2;
    [self initSalers];

}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSLog(@"the button index is %d",buttonIndex);
    if (buttonIndex == -1) {
        return;
    }
    
    NSString * title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (btnIndex == 0) {
        [self.salersBtn1 setTitle:title forState:UIControlStateNormal];
        [self.salersBtn1 setTitle:title forState:UIControlStateHighlighted];
    }
    else if (btnIndex == 1) {
        [self.salersBtn2 setTitle:title forState:UIControlStateNormal];
        [self.salersBtn2 setTitle:title forState:UIControlStateHighlighted];
    }
    else if (btnIndex == 2)
    {
        [self.salersBtn3 setTitle:title forState:UIControlStateNormal];
        [self.salersBtn3 setTitle:title forState:UIControlStateHighlighted];
    }

}

- (NSString *)getUID
{
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * UID = [defaults stringForKey:@"UID"];
    return UID;
}

- (IBAction)verifyBtnClicked:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"账户查询" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [alert setTag:2];
    [alert show];

}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alert.tag == 2) {
        NSString * pwd = [[alert textFieldAtIndex:0] text];
        NSString * uid = [self getUID];
        NSString *str = [[XMLmanage shardSingleton] CheckUserInfonWithCid:uid withPassWord:pwd];
        if ([str isEqualToString:@"T"]) {
            SMDepositController * pay = [[SMDepositController alloc] init];
            [self.navigationController pushViewController:pay animated:YES];
        }
        else
        {
            if (pwd && pwd.length > 0) {
                [SGInfoAlert showInfo:@"密码错误请重新输入！"
                              bgColor:[[UIColor blackColor] CGColor]
                               inView:self.view
                             vertical:0.4];
            }
            
        }
    }
    else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (NSString *)getSystemDate
{
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:currentDate];
}


-(void)clearFee
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"0" forKey:@"desposit"];
    [prefs setObject:@"0" forKey:@"fee"];

    [prefs synchronize];

}

- (IBAction)payClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    btn.userInteractionEnabled=NO;
    
   // [self getExpo];
    if ([self.salersBtn1.titleLabel.text isEqualToString:@"请选择"]) {
        [SGInfoAlert showInfo:@"请选择销售人员1！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        btn.userInteractionEnabled=YES;

        return;
    }
    
    
    int iValue;
    
    
    if (self.txt2.text.length == 0 && [[NSScanner scannerWithString:self.txt2.text] scanInt:&iValue]) {
        [SGInfoAlert showInfo:@"提成比例请输入整数！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
           btn.userInteractionEnabled=YES;
        return ;
    }
    if (self.txt3.text.length == 0 && [[NSScanner scannerWithString:self.txt3.text] scanInt:&iValue]) {
        [SGInfoAlert showInfo:@"提成比例请输入整数！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
           btn.userInteractionEnabled=YES;
        return ;
    }
    
    float totalMoney = [self.despositTxt.text floatValue] + [self.bankTxt.text floatValue] + [self.cashTxt.text floatValue] + [self.busindessTxt.text floatValue] + [self.businessCardTxt.text floatValue] + [self.othersTxt.text floatValue];
    NSLog(@"the total money is %f",totalMoney);
    
   
    if (totalMoney != [self.totalLabel.text floatValue]) {
        [SGInfoAlert showInfo:@"实付款与应付款不符！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
           btn.userInteractionEnabled=YES;
        return ;
    }
    
   // NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    //float fee = [[defaults stringForKey:@"fee"] floatValue];

//    if ([self.despositTxt.text floatValue] < accountTotal) {
//        [SGInfoAlert showInfo:@"押金优先使用账户余额，请使用账户余额！"
//                      bgColor:[[UIColor blackColor] CGColor]
//                       inView:self.view
//                     vertical:0.4];
//        return ;
//
//    }
    
//    if ([self.despositTxt.text isEqualToString:self.totalLabel.text] == NO) {
//        [SGInfoAlert showInfo:@"押金优先使用账户余额，请使用账户余额！"
//                              bgColor:[[UIColor blackColor] CGColor]
//                                inView:self.view
//                            vertical:0.4];
//        return ;
//    }
    
//    if ([totalNumber compare:feeNumber] != NSOrderedSame) {
//        [SGInfoAlert showInfo:@"押金优先使用账户余额，请使用账户余额！"
//                      bgColor:[[UIColor blackColor] CGColor]
//                       inView:self.view
//                     vertical:0.4];
//        return ;
//    }
    
    float txt2 = [self.txt2.text floatValue];
    float txt3 = [self.txt3.text floatValue];
    float sum = [txt1 floatValue] + txt2 + txt3;
    if (sum != 100) {
        [SGInfoAlert showInfo:@"提成比例错误，请重新输入！"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
           btn.userInteractionEnabled=YES;
        return;
    }
    
//    [SGInfoAlert showInfo:@"支付成功！"
//                  bgColor:[[UIColor blackColor] CGColor]
//                   inView:self.view
//                 vertical:0.4];
    
    PayInfo * pay = [[PayInfo alloc]init];

    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * usid = [defaults stringForKey:@"name"];
    NSString * umid = [defaults stringForKey:@"username"];
    NSString * cid = [defaults stringForKey:@"UID"];
    
    
    NSString * seid = [dict objectForKey:self.salersBtn1.titleLabel.text];
    NSLog(@"the seid  is %@",seid);
    
    NSString * seid2 = @"0";
    NSString * semoney2 = @"0";
    if (![self.salersBtn2.titleLabel.text isEqualToString:@"请选择"]) {
        seid2 = [dict objectForKey:self.salersBtn2.titleLabel.text];
        semoney2 = self.txt2.text;

    }
    NSLog(@"the seid 2 is %@",seid2);
    
    NSString * seid3 = @"0";
    NSString * semoney3  = @"0";
    if (![self.salersBtn3.titleLabel.text isEqualToString:@"请选择"]) {
        seid3 = [dict objectForKey:self.salersBtn3.titleLabel.text];
        semoney3 = self.txt3.text;
    }
    NSLog(@"the seid 3 is %@",seid3);
//    NSString * semoney2 = self.txt2.text;
//    NSString * semoney3 = self.txt3.text;
    NSString * ldx = self.ldxTxtNumber.text;
    NSString * ty = self.tyTxtNumber.text;

    NSString * zje = self.totalLabel.text;
    NSString * yfkje;
    if (self.despositTxt.text.length == 0) {
        yfkje = @"0";
    }
    else
    {
        NSLog(@"the desposti tet is %@",self.despositTxt.text);
        yfkje = self.despositTxt.text;
    }
    NSString * ssje;
    if (self.busindessTxt.text.length == 0) {
        ssje = @"0";
    }
    else
    {
        ssje = self.busindessTxt.text;

    }
    NSString * stkje;
    if (self.businessCardTxt.text.length == 0) {
        stkje = @"0";
    }
    else
    {
        stkje = self.businessCardTxt.text;
    }
    
    NSString * qtje;
    if (self.othersTxt.text.length == 0) {
        qtje = @"0";
    }
    else
    {
        qtje = self.othersTxt.text;
    }
    NSString * xjje;
    if (self.cashTxt.text.length == 0) {
        xjje = @"0";
    }
    else
    {
        xjje = self.cashTxt.text;
    }
    NSString * yhkje;
    if (self.bankTxt.text.length == 0) {
        yhkje = @"0";
    }
    else
    {
        yhkje = self.bankTxt.text;
    }
    NSString * zlje = @"0";
//    NSString * zlje;
//    if (self.bankTxt.text.length == 0) {
//        zlje = 0;
//    }
//    else
//    {
//        yhkje = self.bankTxt.text;
//    }
   // NSString * strJson = @"[{"pid"}]";
  
    NSString * url;
    if ([self.itemType isEqualToString:@"7"]) {
      //  url = @"http://113.140.20.6//getdata/GetData.asmx/SaleProduct?HTTP/1.1";
        url=[NSString stringWithFormat:@"%@GetData.asmx/SaleProduct?HTTP/1.1",RIP];
    }
    else
    {
       url = [NSString stringWithFormat:@"%@GetData.asmx/SaleItem?HTTP/1.1",RIP];
        
    }
    NSMutableArray *jsonArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.orderArray count]; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
         OrderInfo * order = [[OrderInfo alloc] init];
        order = [self.orderArray objectAtIndex:i];
        if ([self.itemType isEqualToString:@"6"]) {
            
            [dict  setObject:order.ID forKey:@"iid"];
            [dict  setObject:order.counts  forKey:@"icount"];
            [dict  setObject:order.money  forKey:@"itotal"];

            [dict  setObject:order.skpmount  forKey:@"xmcount"];
            [dict  setObject:order.rate  forKey:@"irate"];
            [dict  setObject:@"2016-12-28"  forKey:@"bzq"];
            [jsonArray addObject:dict];

        }
        else if ([self.itemType isEqualToString:@"7"])
        {
           
            [dict  setObject:order.ID forKey:@"pid"];
            NSLog(@"the pdate is %@",[dict objectForKey:@"pdate"]);
            NSRange range = [order.produce rangeOfString:@";"];
            if (range.location == NSNotFound){
                
                [dict  setObject:order.produce  forKey:@"pdate"];
            }
            else
            {
                NSArray * array = [order.produce componentsSeparatedByString:@";"];
                if ([array count] > 1) {
                    [dict  setObject:[array objectAtIndex:0] forKey:@"pdate"];
                }
            }
            
            [dict  setObject:order.skpmount  forKey:@"pamount"];
            [dict  setObject:order.counts  forKey:@"pcount"];
            [dict  setObject:order.price  forKey:@"pprice"];
            [dict  setObject:order.rate  forKey:@"prate"];
            [dict  setObject:order.money  forKey:@"ptotal"];
            [dict  setObject:order.name  forKey:@"pname"];
            //[dict setObject:@"7" forKey:@"type"];
            [jsonArray addObject:dict];

        }
       
        

//        info.name = [dic objectForKey:@"iname"];
//        info.price = [dic objectForKey:@"iprice"];
//        info.rate = [dic objectForKey:@"irate"];
//        info.times = [dic objectForKey:@"times"];
//        info.ID = [dic objectForKey:@"iid"];
//        [dict  setObject:order.ID forKey:@"pid"];
//        NSLog(@"the pdate is %@",[dict objectForKey:@"pdate"]);
//        NSRange range = [order.produce rangeOfString:@";"];
//        if (range.location == NSNotFound){
//            
//            [dict  setObject:order.produce  forKey:@"pdate"];
//        }
//        else
//        {
//            NSArray * array = [order.produce componentsSeparatedByString:@";"];
//            if ([array count] > 1) {
//                [dict  setObject:[array objectAtIndex:0] forKey:@"pdate"];
//            }
//      }
//        
//        [dict  setObject:order.skpmount  forKey:@"pamount"];
//        [dict  setObject:order.counts  forKey:@"pcount"];
//        [dict  setObject:order.price  forKey:@"pprice"];
//        [dict  setObject:order.rate  forKey:@"prate"];
//        [dict  setObject:order.money  forKey:@"ptotal"];
//        [dict  setObject:order.name  forKey:@"pname"];
        //[dict setObject:@"7" forKey:@"type"];
    }
    NSError *error = nil;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSLog(@"Successfully serialized the dictionary into data.");
        //NSData转换为String
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);
    }
    
    
    NSString * username  = @"sanmoon";
    NSString * userpass  = @"sm147369";

  

    NSString * path = [NSString stringWithFormat:@"%@",url];
    
    NSURL * postURL = [NSURL URLWithString:path];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:postURL];
    [request setDelegate:self];
	[request setPostValue:usid forKey:@"usid"];
    [request setPostValue:umid forKey:@"umid"];
    [request setPostValue:cid forKey:@"cid"];
    [request setPostValue:seid forKey:@"seid"];
    [request setPostValue:seid2 forKey:@"seid2"];
    [request setPostValue:seid3 forKey:@"seid3"];
    [request setPostValue:semoney2 forKey:@"semoney2"];
    [request setPostValue:semoney3 forKey:@"semoney3"];
    [request setPostValue:zje forKey:@"zje"];
    [request setPostValue:yfkje forKey:@"yfkje"];
    [request setPostValue:ssje forKey:@"ssje"];
    [request setPostValue:stkje forKey:@"stkje"];
    [request setPostValue:qtje forKey:@"qtje"];
    [request setPostValue:xjje forKey:@"xjje"];
    
    [request setPostValue:yhkje forKey:@"yhkje"];
    [request setPostValue:zlje forKey:@"zlje"];
    [request setPostValue:jsonString forKey:@"strJson"];
    if ([self.itemType isEqualToString:@"6"]) {
    [request setPostValue:@"" forKey:@"oldgid"];
    [request setPostValue:@"" forKey:@"expid"];
    }

    [request setPostValue:username forKey:@"username"];
    [request setPostValue:userpass forKey:@"userpass"];
   // [request setDelegate:self];

    //NSString *asciiString = [[NSString alloc] initWithData:request encoding:NSASCIIStringEncoding];
    NSLog(@"the request value is %@",request.postBody);

    
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSLog(@"the response %@",restr);
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:restr options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        
        NSLog(@"this is submit value %@",[rootElement stringValue]);
        
        if ([[rootElement stringValue] isEqualToString:@"success"]) {
            
           // [self clearFee];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            [alter setTag:1];
               btn.userInteractionEnabled=YES;
        }
        else
        {
//            [SGInfoAlert showInfo:@"购买失败，请重试。"
//                          bgColor:[[UIColor blackColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
            [SGInfoAlert showInfo:[rootElement stringValue]
                          bgColor:[[UIColor blackColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            
        }
    }];
    
    [request setFailedBlock:^{
        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
        [SGInfoAlert showInfo:@"购买失败，请重试。"
                      bgColor:[[UIColor blackColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        
           btn.userInteractionEnabled=YES;
    }];
    
    [request startAsynchronous];
    
  

    
  //s  NSString * postStrings =
    
//    NSArray *jsonArray = [[NSArray alloc] initWithObjects:
//                                      @"Anthony's Son 1",
//                                      @"Anthony's Daughter 1",
//                                      @"Anthony's Son 2",
//                                      @"Anthony's Son 3",
//                                      @"Anthony's Daughter 2", nil];
    
//    NSString * s1 = [dict objectForKey:self.salersBtn1.titleLabel.text];
//    NSString * s2 = [dict objectForKey:self.salersBtn2.titleLabel.text];
//    NSString * s3 = [dict objectForKey:self.salersBtn3.titleLabel.text];
//    NSString * s2Commission = self.txt2.text;
//    NSString * s3Commission = self.txt3.text;
//    NSString * pay = [NSString stringWithFormat:@"%d",pay];
//    pay.usid = name;
//    pay.umid = name;
//    pay.cid = name;
//    pay.seid = name;
//    pay.seid2 = name;
//    pay.seid3 = name;
//    pay.semoney2 = name;
//    pay.semoney3 = name;
//    pay.zje = ;
//    pay.yfkje

    

}

 - (void )getExpo
{
    
    NSString * expo;
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * cid = [defaults stringForKey:@"UID"];
    
   // NSString * expUrl = @"http://113.140.20.6/csgetdata/GetData.asmx?op=GetGuestExp";
    NSString * expUrl = [NSString stringWithFormat:@"%@GetData.asmx/GetGuestExp?HTTP/1.1",RIP];
   // NSString * ldxUrl = @"http://113.140.20.6/csgetdata/GetData.asmx?op=GetGuestFrd";
    
    NSURL * postURL = [NSURL URLWithString:expUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:postURL];
	[request setPostValue:cid forKey:@"cid"];
    [request setPostValue:@"sanmoon" forKey:@"username"];
    [request setPostValue:@"sm147369" forKey:@"userpass"];

    
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSLog(@"1111%@",restr);
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:restr options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        expoNumber = [rootElement stringValue];
        self.tyTxtNumber.text = [rootElement stringValue];

        NSLog(@"this is submit value %@",[rootElement stringValue]);
        
    }];
    
    [request setFailedBlock:^{
        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
        
    }];
    
    [request startAsynchronous];
    
}

- (void )getLdx
{
    
    NSString * expo;
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString * cid = [defaults stringForKey:@"UID"];
    
    // NSString * expUrl = @"http://113.140.20.6/csgetdata/GetData.asmx?op=GetGuestExp";
    NSString * expUrl = [NSString stringWithFormat:@"%@GetData.asmx/GetGuestFrd?HTTP/1.1",RIP];
    // NSString * ldxUrl = @"http://113.140.20.6/csgetdata/GetData.asmx?op=GetGuestFrd";
    
    NSURL * postURL = [NSURL URLWithString:expUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:postURL];
	[request setPostValue:cid forKey:@"cid"];
    [request setPostValue:@"sanmoon" forKey:@"username"];
    [request setPostValue:@"sm147369" forKey:@"userpass"];
    
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSLog(@"LDX%@",restr);
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:restr options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        expoNumber = [rootElement stringValue];
        self.ldxTxtNumber.text = [rootElement stringValue];
        NSLog(@"this is submit value %@",[rootElement stringValue]);
        
    }];
    
    [request setFailedBlock:^{
        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
        
    }];
    
    [request startAsynchronous];
    
}
@end
