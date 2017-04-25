//
//  CateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CateViewController.h"
#import "SubCateViewController.h"
#import "CateTableCell.h"
#import "MainCell.h"
#import "XMLmanage.h"
#import "UploadViewController.h"
#import "ComparePotoController.h"
#import "SGInfoAlert.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "HttpEngine.h"
#import "SerRecordBaseClass.h"
#import "FirstSerImageBaseClass.h"
#import "UIButton+WebCache.h"
int selectSection;
int imageFlag;
NSMutableArray * resultArray;
SubCateViewController *subVc;
NSString * fwtimes;

@interface CateViewController () <UIFolderTableViewDelegate>
{
    ServiceInfo *_info;
}
@property (strong, nonatomic) SubCateViewController *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;


@end

@implementation CateViewController

@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;
@synthesize query = query_;
@synthesize imagesArray = imagesArray_;
@synthesize compareArray = compareArray_;
@synthesize nameLab;
@synthesize cardLab;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"selectImage1"];
    [prefs removeObjectForKey:@"selectImage2"];
    [prefs synchronize];
    
   // [self getData];
    
    
    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:10000];
    [imageView removeFromSuperview];
    UIImageView *imageView2=(UIImageView *)[self.view viewWithTag:10000];
    [imageView2 removeFromSuperview];
   
    [self.openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //smlPooView初始化坐标
     [self hiddenSmlPopView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regetData) name:@"uploadSucceed" object:nil];
    
    //注册一个选中图片更改后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectImageNoti:) name:@"selectImageNoti" object:nil];
    
    self.deleteBtn1.hidden = YES;
    self.deleteBtn2.hidden = YES;
     self.tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:168/255.0 blue:196/255.0 alpha:1.0];
      self.cardLab.text = self.query;
     self.nameLab.text = self.guestName;
    [self getDataNew];
    [self installSmlTicket];
    self.compareArray = [NSMutableArray arrayWithCapacity:2];
  //  self.notiCompareArray = [NSMutableArray arrayWithCapacity:2];
}
//根据传进来的数组设置首次服务小票的显示
- (void)installSmlTicket
{
    for (int i = 0; i<self.firstSmlTickArray.count; i++) {
        UIButton *btn = [self.smlPopView viewWithTag:11+i];
        FirstSerImageBaseClass *bassClass = self.firstSmlTickArray[i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,bassClass.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
        [btn addTarget:self action:@selector(firstSmlTicketClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)firstSmlTicketClick:(UIButton *)btn
{
    NSLog(@"点击首次小票");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否将此图片加入对比" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         FirstSerImageBaseClass *bassClass = self.firstSmlTickArray[btn.tag - 11];
        CompareModel *model = [[CompareModel alloc] init];
        model.imageName = [NSString stringWithFormat:@"%@%@",LocationIp,bassClass.smallImageUrl];
        model.bigImageName = [NSString stringWithFormat:@"%@%@",LocationIp,bassClass.bigImageUrl];
        model.imageType = @"首次小票";
        if (self.compareArray.count == 2) {
            [SVProgressHUD showInfoWithStatus:@"已经选择了2张图片"];
            return ;
        }
         [self.compareArray addObject:model];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectImageNoti" object:self.compareArray];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)selectImageNoti:(NSNotification *)noti
{
    NSLog(@"收到选中图片的通知 noti = %@",[noti object]);
    self.compareArray = [noti object];
  //   [self.compareArray addObjectsFromArray:[noti object]];
    //[self.compareArray addObjectsFromArray:[noti object]];
    if (self.compareArray.count == 1) {
        CompareModel *model = self.compareArray[0];
        [self.compareImage1 sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
        self.deleteBtn1.hidden = NO;
        self.deleteBtn2.hidden = YES;
    }else if (self.compareArray.count == 2){
        CompareModel *model = self.compareArray[0];
        [self.compareImage1 sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
        CompareModel *model2 = self.compareArray[1];
        [self.compareImage2 sd_setImageWithURL:[NSURL URLWithString:model2.imageName]];
        self.deleteBtn1.hidden = NO;
        self.deleteBtn2.hidden = NO;
    }
  
    
}
- (IBAction)deleteBtn1Click:(UIButton *)sender {
    
    if (self.compareArray.count == 2) {
        [self.compareArray removeObjectAtIndex:0];
        CompareModel *model = self.compareArray[0];
        [self.compareImage1 sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:nil];
        [self.compareImage2 sd_setImageWithURL:nil placeholderImage:nil];
        self.deleteBtn1.hidden = NO;
        self.deleteBtn2.hidden = YES;
    }else if (self.compareArray.count == 1){
          [self.compareArray removeObjectAtIndex:0];
        [self.compareImage1 sd_setImageWithURL:nil placeholderImage:nil];
        [self.compareImage2 sd_setImageWithURL:nil placeholderImage:nil];
        self.deleteBtn1.hidden = YES;
        self.deleteBtn2.hidden = YES;
    }
}

- (IBAction)deleteBtn2Click:(UIButton *)sender {
    
    if (self.compareArray.count > 1) {
        [self.compareArray removeObjectAtIndex:1];
         CompareModel *model = self.compareArray[0];
        [self.compareImage1 sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:nil];
        [self.compareImage2 sd_setImageWithURL:nil placeholderImage:nil];
        self.deleteBtn1.hidden = NO;
        self.deleteBtn2.hidden = YES;
    }
    
}


//展开按钮点击
- (void)openBtnClick
{
    self.openBtn.selected = !self.openBtn.selected;
    if (self.openBtn.selected == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.openBtn.layer.transform = CATransform3DMakeRotation([self radians:180], 0, 0, 1);
            [self popSmlPopView];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.openBtn.layer.transform = CATransform3DMakeRotation([self radians:0], 0, 0, 1);
            [self hiddenSmlPopView];
        }];
    }
    
}
//pop smlPopView
- (void)popSmlPopView
{
    self.smlPopView.hidden = NO;
    self.smlTicketBtn1.hidden = NO;
    self.smlTicketBtn2.hidden = NO;
    self.smlTicketBtn3.hidden = NO;
    self.ticketLabel.hidden = NO;
    self.smlPopView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.smlPopView.layer.shadowOpacity = 0.3;
    
    
}
//隐藏smlPopView
- (void)hiddenSmlPopView
{
    self.smlPopView.hidden = YES;
    self.smlTicketBtn1.hidden = YES;
    self.smlTicketBtn2.hidden = YES;
    self.smlTicketBtn3.hidden = YES;
    self.ticketLabel.hidden = YES;
    
}
//收缩动画
//- (void)suckAnimation
//{
//    CATransition *animation = [CATransition animation];
//    
//    animation.delegate = self;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.type = @"suckEffect";//这个就是你想要的效果
//    [self hiddenSmlPopView];
//    [self.smlPopView.layer addAnimation:animation forKey:@"animation"];
//}

- (CGFloat)radians:(CGFloat)degress
{
    return (degress *3.14159265) /180.0;
}
- (void)regetData
{
  //  [self getData];
    [self getDataNew];
    [self.tableView reloadData];
    
}

- (void)getDataNew
{
    
    [HttpEngine getSerRecordListNew:self.query complete:^(NSMutableArray *tempArray) {
        self.serRecordTempArray = tempArray;
        NSLog(@" self.serRecordTempArray = %@", self.serRecordTempArray);
        [self.tableView reloadData];
        
    }];
    
    
}

- (void)getData
{
    NSArray * arrays  = [[XMLmanage shardSingleton] getService:self.query withUsername:@"sanmoon" withPwd:@"sm147369"];
    NSMutableArray *mutabArray = [[NSMutableArray alloc] initWithArray:arrays];
    
    // self.cates = [NSMutableArray arrayWithCapacity:1];
    
    //    for (int i = 0; i < [mutabArray count]; i++) {
    //        if (i < 15) {
    //            [self.cates arrayByAddingObject:[mutabArray objectAtIndex:i]];
    //        }
    //    }
    self.cates = [[NSMutableArray alloc] initWithArray:mutabArray];
    
#pragma mark 修改
    // ServiceInfo * service = [self.cates objectAtIndex:0];
    
    NSArray * customers = [[XMLmanage shardSingleton] getGuestInfo:self.query withUsername:@"sanmoon" withPwd:@"sm147369"];
    
    CustomersQuery * customer  = [customers objectAtIndex:0];
    
    self.nameLab.text = customer.gsname;
    
    self.cardLab.text = self.query;
    
   
    
    // ServiceInfo * info  = [self.cates objectAtIndex:_indexNum];
    
    //   self.searveArray = [self queryServiceImage:_info.gsnumber];
    _tempArray=[[NSMutableArray alloc] initWithCapacity:0];
    //    [_tempArray addObject:array];
    _tempDataArray=[NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<self.cates.count; i++) {
        ServiceInfo *info=[self.cates objectAtIndex:i];
        beforegusNum=[info.gsnumber integerValue];
        
    }
    
    imageFlag = 0;
 //   self.compareArray = [NSMutableArray arrayWithCapacity:2];
    
    for (int i=0; i<self.cates.count; i++) {
        ServiceInfo *info=[self.cates objectAtIndex:i];
        NSArray *array=[self queryServiceImage:info.gsnumber];
        [_tempArray addObject:array];
    }

}



- (void)viewWillAppear:(BOOL)animated
{
   
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.serRecordTempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#pragma mark 修改
    
    static NSString *CellIdentifier = @"MainCell";
    
    MainCell * cell = (MainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MainCell" owner:self options:nil];
            
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[MainCell class]]) {
                cell = (MainCell *)oneObject;
            }
            
        }
                
    }
    
   //  ServiceInfo * info  = [self.cates objectAtIndex:indexPath.row];
   
    
//    NSArray *array=[_tempArray objectAtIndex:indexPath.row];
//    
//    NSLog(@"array222=%@",array);
//      NSLog(@"...%d",_indexNum);
//      NSLog(@"???%d",indexPath.row);
//      NSLog(@",,,,%d",array.count);
//    
//    NSMutableString *recordStr=[[NSMutableString alloc] init];
//    
//    for (int i=0; i<array.count; i++) {
//        NSDictionary *dic=[array objectAtIndex:i];
//        
//        if ([[dic objectForKey:@"archiveState"] integerValue]==3) {
//            cell.littleTicketLAbel.text=@"有";
//        }else{
//         //   cell.littleTicketLAbel.text=@"无";
//        }
//    if ([[dic objectForKey:@"archiveState"] integerValue]==1) {
//        [recordStr appendString:[dic objectForKey:@"archiveSmallImageUrl"]];
//        
//    }else if ([[dic objectForKey:@"archiveState"] integerValue]==2) {
//        [recordStr appendString:[dic objectForKey:@"archiveSmallImageUrl"]];
//    }
//        if ([recordStr isEqualToString:@""]) {
//            cell.recordLabel.text=@"无";
//        }else{
//            cell.recordLabel.text=@"有";
//        }
//        
//    }
     SerRecordBaseClass *bassClass = [self.serRecordTempArray objectAtIndex:indexPath.row];
            cell.typeLabel.text=bassClass.iname;
            cell.dateLabel.text=bassClass.fwsj;
            cell.titleLabel.text = bassClass.gsnumber;
            cell.addLabel.text = bassClass.uname;
            cell.nameLabel.text = bassClass.sename;
#pragma mark 修改
            cell.dateLabel.text = bassClass.fwsj;
    if (bassClass.fwzpcount > 0) {
        cell.recordLabel.text = @"有";
    }else{
        cell.recordLabel.text =@"无";
    }
    if (bassClass.fwxpcount > 0) {
        cell.littleTicketLAbel.text = @"有";
    }else{
        cell.littleTicketLAbel.text =@"无";
    }
    
           [cell.uploadBtn  addTarget:self action:@selector(btnUpload:) forControlEvents:UIControlEventTouchUpInside];
            cell.uploadBtn.tag = indexPath.row;
             _indexNum=indexPath.row;

    return cell;
    
#pragma mark 修改
    
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"滑动减速");
//     ServiceInfo * info  = [self.cates objectAtIndex:_indexNum];
//       self.searveArray = [self queryServiceImage:info.gsnumber];
//    
//    
//}
//- (void)onMyThread:(ServiceInfo *)info
//{
//    [self queryServiceImage:info.gsnumber];
//   
////    if (array && [array count] > 0) {
////        cell.recordLabel.text = @"有";
////    }
////    else
////    {
////        cell.recordLabel.text = @"无";
////    }
//
//    
//}
- (void)btnUpload:(id)sender
{
    [SVProgressHUD showWithStatus:@"查询中，请稍后"];

    UIButton * uploadbtn = (UIButton *)sender;
    NSLog(@"the tag is %d",uploadbtn.tag);
  //  ServiceInfo * customer  = [self.cates objectAtIndex:uploadbtn.tag];
    SerRecordBaseClass *bassClass = [self.serRecordTempArray objectAtIndex:uploadbtn.tag];
    
    
    NSString * gsNumber = bassClass.gsnumber;

    UploadViewController * order = [[UploadViewController alloc] initWithNibName:@"UploadViewController" bundle:nil];
    order.cardNo = gsNumber;
    order.cid = self.query;
    order.serverDate=bassClass.fwsj;
    
    
#pragma mark 修改
    order.imageArray=self.imagesArray;
    
    NSLog(@"the cid quey is %@",self.query);
    UINavigationController * popUpNavigationController = [[UINavigationController alloc] initWithRootViewController:order];
    
    //order.orderArray = singlearray;
    //settingsController.parentController = self;
    // order.navigationController = self.popUpNavigationController;
    popUpNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    popUpNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //popUpNavigationController.navigationBar setTitleTextAttributes:[Aicent_Utility_iPad setTextAttributes];
#pragma mark 修改
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    [manager removeItemAtPath:documentsDirectory error:nil];
    
    [self.navigationController presentViewController:popUpNavigationController animated:YES completion:nil];
    [SVProgressHUD dismiss];
}

- (NSArray *)queryServiceImage:(NSString *)ID
{
    NSArray * arrays  = [[XMLmanage shardSingleton] getServiceImage:ID];
//    NSLog(@"get service count is %d",[arrays count]);
    return arrays;
}

- (void)SearchbuttonClick:(NSString *)gsnumber
{
    
    NSLog(@"the cate gsnumber is %@",gsnumber);
    NSLog(@"SSSSS");

}

- (void)doTask:(NSString *)gsnumber
{
  
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"查询中，请稍后";
	
    [HUD showWhileExecuting:@selector(SearchbuttonClick:) onTarget:self withObject:gsnumber animated:YES];
    NSLog(@"QQQQQQQ");

    
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showWithStatus:@"请稍等"];
    NSLog(@"点击");
    subVc = [[SubCateViewController alloc]
                                    initWithNibName:NSStringFromClass([SubCateViewController class])
                                    bundle:nil];
    subVc.compareArray = self.compareArray;
   
   // ServiceInfo * info =  [self.cates objectAtIndex:indexPath.row];
    SerRecordBaseClass *info =[self.serRecordTempArray objectAtIndex:indexPath.row];
    NSArray *listItems = [info.fwsj componentsSeparatedByString:@" "];
    fwtimes = info.fwsj;
    subVc.serNumber=info.gsnumber;
    subVc.iid = info.iid;
    subVc.cid = self.query;
    NSLog(@"the fwsj was selected is %@",fwtimes);
  //    resultArray = [NSMutableArray arrayWithArray:[self queryServiceImage:info.gsnumber]];
   
    [XMLmanage xiaotu:^(NSMutableArray *array) {
        resultArray=[NSMutableArray arrayWithArray:array];
      //  resultArray = [NSMutableArray arrayWithArray:[self queryServiceImage:info.gsnumber]];
         NSLog(@"resultArray=%@",resultArray);
        subVc.subCates = resultArray;
        self.imagesArray = [NSArray arrayWithArray:subVc.subCates];
//        if ( self.imagesArray.count == 0) {
//            [SGInfoAlert showInfo:@"没有服务的照片！"
//                          bgColor:[[UIColor blackColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
//            [SVProgressHUD dismiss];
//            return;
//        }
        selectSection = indexPath.section;
        
        //subVc.subCates = [NSArray arrayWithObjects:@"EEEE",@"ERRR",nil];
        // self.currentCate = cate;
        subVc.cateVC = self;
        // [SVProgressHUD dismiss];
        
        //self.tableView.scrollEnabled = NO;
        UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
        [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view
                                     openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                         // opening actions
                                         NSLog(@"open subClassView=%@",subClassView);
                                         
                                         
                                     }
                                    closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                        // closing actions
                                        NSLog(@"close");
                                    }
                               completionBlock:^{
                                   // completed actions
                                   //self.tableView.scrollEnabled = YES;
                                   NSLog(@"complete");
                               }];

                 [SVProgressHUD dismiss];
    } gusNum:info.gsnumber];
    
    
    //subVc.subCates = [self queryServiceImage:info.gsnumber];
   
}

-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)saveStoresPhoto:(NSString *)KEY withValue:(NSArray *)value
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:value forKey:KEY];
    [prefs synchronize];
}

-(void)subCateBtnAction:(UIButton *)btn
{

    if (self.imagesArray.count == 0) {

        return;
    }
    NSMutableArray * imageInfo = [NSMutableArray arrayWithCapacity:2];
    //ServiceInfo * service = [self.cates objectAtIndex:selectSection];
    NSArray * array = [fwtimes componentsSeparatedByString:@" "];
    NSString * fwsj = [array objectAtIndex:0];
    NSLog(@"the service service.fwsj is %@",fwsj);
    [imageInfo addObject:fwsj];
    
    NSDictionary * item = [self.imagesArray objectAtIndex:btn.tag];
    [imageInfo addObject:[item objectForKey:@"archiveState"]];
    NSLog(@"the service archiveState is %@",[item objectForKey:@"archiveState"]);

    [imageInfo addObject:[item objectForKey:@"archiveImageUrl"]];
    [self saveStoresPhoto:[NSString stringWithFormat:@"%d",imageFlag] withValue:imageInfo];

    imageFlag++;
    //[self.compareArray addObject:name];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 20, 20)];
    imageView.tag=10000;
    imageView.image=[UIImage imageNamed:@"icon_unchecked.png"];
    
    [btn addSubview:imageView];
    
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"照片比对"
                                                         message:@"您已请选中该照片进行比对"
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
    [Notpermitted show];
   
    
}

- (IBAction)comparePhotos:(id)sender
{
//        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    
//    if ([user objectForKey:@"selectImage1"]!=nil&&[user objectForKey:@"selectImage2"]!=nil) {
//        ComparePotoController * order = [[ComparePotoController alloc] initWithNibName:@"ComparePotoController" bundle:nil];
//        // order.cArray = self.compareArray;
//        order.compareImageArray = self.compareArray;
//        [self.navigationController pushViewController:order animated:YES];
//    }else{
//        [SVProgressHUD showInfoWithStatus:@"照片对比需要两张图片"];
//    }
    if (self.compareArray.count == 2) {
                ComparePotoController * order = [[ComparePotoController alloc] initWithNibName:@"ComparePotoController" bundle:nil];
                // order.cArray = self.compareArray;
                order.compareImageArray = self.compareArray;
                [self.navigationController pushViewController:order animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"照片对比需要两张图片"];

    }
    
}

- (IBAction)back:(id)sender
{
   

    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
