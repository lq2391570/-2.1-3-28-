//
//  MemberController.m
//  SMProject
//
//  Created by arvin yan on 10/28/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "MemberController.h"
#import "XMLmanage.h"
#import "ASIFormDataRequest.h"
#import "ServiceController.h"
#import "CateViewController.h"
#import "SVProgressHUD.h"
#import "ProjectListVC.h"
#import "HttpEngine.h"
#import "FirstSerImageBaseClass.h"
#import "UIButton+WebCache.h"
#import "JCAlertView.h"
#import "ImagePopView.h"

#define uploadImage [NSString stringWithFormat:@"%@memberinfo_addMemberInfoImageToIpad",LocationIp]

#define uploadServicesImage [NSString stringWithFormat:@"%@memberarchive_findMemberArchiveForNumberToIpad",LocationIp]

@interface MemberController ()
{
    
    
}
@end

@implementation MemberController

@synthesize query = query_;
@synthesize name = name_;
@synthesize jdTime = jdTime_;
@synthesize zjTime = zjTime_;
@synthesize cardNO = cardNO_;
@synthesize gkNO = gkNO_;
@synthesize imageBtn = imageBtn_;
@synthesize gmsText = gmsText_;
@synthesize ahText = ahText_;
@synthesize remarkText = remarkText_;

@synthesize ahView;
@synthesize gmsView;
@synthesize yqView;

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
   NSArray * array  = [[XMLmanage shardSingleton] getGSNumber:self.query withUsername:@"sanmoon" withPwd:@"sm147369"];
    CustomersInfo * info = [array objectAtIndex:0];
    
    self.ahView.layer.cornerRadius = 8.0f;
    self.gmsView.layer.cornerRadius = 8.0f;
    self.yqView.layer.cornerRadius = 8.0f;

    self.name.text = info.gname;
    self.jdTime.text = info.jdsj;
    self.zjTime.text = info.lasttime;
    self.gkNO.text = info.gid;
    self.cardNO.text = self.query;
    self.ahText.text = info.gfancy;
    self.gmsText.text = info.sfgm;
    self.remarkText.text = info.grequest;
    if ([self.cardState integerValue]==0) {
        self.daNO.text=@"补卡";
    }else if ([self.cardState integerValue]==1){
        self.daNO.text=@"正常";
    }else if ([self.cardState integerValue]==2){
        self.daNO.text=@"未激活";
    }else if ([self.cardState integerValue]==3){
        self.daNO.text=@"已转卡";
    }else if ([self.cardState integerValue]==4){
        self.daNO.text=@"挂失";
    }else if ([self.cardState integerValue]==5){
        self.daNO.text=@"已完成";
    }else if ([self.cardState integerValue]==6){
        self.daNO.text=@"退卡";
    }else if ([self.cardState integerValue]==7){
        self.daNO.text=@"冻结";
    }else if ([self.cardState integerValue]==8){
        self.daNO.text=@"已合卡";
    }else if ([self.cardState integerValue]==9){
        self.daNO.text=@"余零";
    }
    
    NSLog(@"%@==--==",self.query);
    [self getUserPhoto];
    
    [self installSmlTicketsView];
    
    [self getFirstSerList];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)addBtn1Click:(UIButton *)sender {

    if (self.smlTicketArray.count > 0) {
          FirstSerImageBaseClass *firstSerBassClass = self.smlTicketArray[0];
        ImagePopView *customView = [[ImagePopView alloc] initWithImageName:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.bigImageUrl]];
        [customView getBgImage:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.bigImageUrl]];
        JCAlertView *customAlert = [[JCAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:YES];
        [customAlert show];
    }
    
}
- (IBAction)addBtn2Click:(UIButton *)sender {

    if (self.smlTicketArray.count > 1) {
        FirstSerImageBaseClass *firstSerBassClass = self.smlTicketArray[1];
        ImagePopView *customView = [[ImagePopView alloc] initWithImageName:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.bigImageUrl]];
        [customView getBgImage:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.bigImageUrl]];
        JCAlertView *customAlert = [[JCAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:YES];
        [customAlert show];
    }else{
            [self openMenu];
            self.imageStateNum = 1;
        
    }
    
    
}
- (IBAction)addBtn3Click:(UIButton *)sender {

    if (self.smlTicketArray.count > 2) {
        FirstSerImageBaseClass *firstSerBassClass = self.smlTicketArray[2];
        ImagePopView *customView = [[ImagePopView alloc] initWithImageName:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.bigImageUrl]];
        [customView getBgImage:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.bigImageUrl]];
        JCAlertView *customAlert = [[JCAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:YES];
        [customAlert show];
    }else{
            [self openMenu];
            self.imageStateNum = 1;
    }
    
}
- (IBAction)addBtn0Click:(UIButton *)sender {
    [self openMenu];
    self.imageStateNum = 1;
}
//得到首次小票列表
- (void)getFirstSerList
{
    NSLog(@"self.query = %@",self.query);
    [HttpEngine getFirstSerTicketList:self.query complete:^(NSMutableArray *tempArray) {
        self.smlTicketArray = tempArray;
        if (self.smlTicketArray.count == 1) {
            self.addBtn0.hidden =YES;
            self.addBtn1.hidden = NO;
            self.addBtn2.hidden = NO;
            self.leftLabel.hidden = NO;
            self.rightLabel.hidden = NO;
            FirstSerImageBaseClass *firstSerBassClass = self.smlTicketArray[0];
            
            [self.addBtn1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
            
            
            
        }else if (self.smlTicketArray.count == 2){
            self.addBtn0.hidden = YES;
            self.addBtn1.hidden = NO;
            self.addBtn2.hidden = NO;
            self.addBtn3.hidden = NO;
            self.leftLabel.hidden = NO;
            self.rightLabel.hidden = NO;
              FirstSerImageBaseClass *firstSerBassClass1 = self.smlTicketArray[0];
              FirstSerImageBaseClass *firstSerBassClass2 = self.smlTicketArray[1];
            [self.addBtn1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass1.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
            [self.addBtn2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass2.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
        }else if (self.smlTicketArray.count == 3){
            self.addBtn0.hidden = YES;
            self.addBtn1.hidden = NO;
            self.addBtn2.hidden = NO;
            self.addBtn3.hidden = NO;
            self.leftLabel.hidden = NO;
            self.rightLabel.hidden = NO;
            FirstSerImageBaseClass *firstSerBassClass1 = self.smlTicketArray[0];
            FirstSerImageBaseClass *firstSerBassClass2 = self.smlTicketArray[1];
            FirstSerImageBaseClass *firstSerBassClass3 = self.smlTicketArray[2];
            [self.addBtn1 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass1.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
            [self.addBtn2 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass2.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
            [self.addBtn3 sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,firstSerBassClass3.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
        }
        
//        for (int i = 0; i<self.smlTicketArray.count; i++) {
//            FirstSerImageBaseClass *firstSerBassClass = self.smlTicketArray[i];
//            
//        }
    }];
}


- (void)installSmlTicketsView
{
    self.smlTicketView.layer.opacity = 1;
    [self.projectListBtn addTarget:self action:@selector(projectListBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)projectListBtnClick
{
    ProjectListVC *vc = [[ProjectListVC alloc] init];
    vc.cid = self.cardNO.text;
    vc.uname = self.name.text;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getUserPhoto];
}
- (UIImage *)getImageWithURL:(NSString *)imageName
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,imageName]];
    NSLog(@"%@",imageName);
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [[UIImage alloc] initWithData:data];
   // return [UIImage imageWithData:data];
}


- (void)getUserPhoto
{
   NSString * imagePath  = [[XMLmanage shardSingleton] getUserImage:self.query];
    NSLog(@"%@...",self.query);
    NSLog(@"%d,,,",imagePath.length);
    if (imagePath.length == 0 )
    {
    }
    else
    {
        [self.imageBtn setBackgroundImage:[self getImageWithURL:imagePath] forState:UIControlStateNormal];
    NSLog(@"---%@",imagePath);
      //  [self.imageBtn setImage:[self getImageWithURL:imagePath] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)doTask
{
    //[SVProgressHUD showWithStatus:@"查询中，请稍后"];
    CateViewController * service = [[CateViewController alloc] init];
    //ServiceController * service = [[ServiceController alloc] init];
    service.query = self.query;
    service.guestName = self.name.text;
    service.firstSmlTickArray = self.smlTicketArray;
    NSLog(@"the log is quey %@",self.query);
#pragma mark 修改
    
   // [SVProgressHUD dismiss];
    
    [self.navigationController pushViewController:service animated:YES];
}
//- (NSArray *)queryServiceImage:(NSString *)ID
//{
//    NSArray * arrays  = [[XMLmanage shardSingleton] getServiceImage:ID];
//    //    NSLog(@"get service count is %d",[arrays count]);
//    return arrays;
//}
//- (NSArray *)getServiceImage:(NSString *)serviceID {
//    
//    //    NSLog(@"the srvice id is %@",serviceID);
//    NSString *url = [NSString stringWithFormat:@"%@%@%@",QueryServiceImage,@"memberArchive.archiveNumber=",serviceID];
//    
//    NSArray * array = [self jsonParseWithURL:url];
//    //    NSMutableArray * noticeArray = [NSMutableArray arrayWithCapacity:10];
//    //    for(NSDictionary * item in array) {
//    //         NSLog(@"Item: %@", item);
//    //
//    //        [noticeArray addObject:[item objectForKey:@"archiveImageUrl"]];
//    //        [noticeArray addObject:[item objectForKey:@"archiveState"]];
//    //
//    //    }
//    
//    return array;
//}
//- (NSDictionary *)jsonParseWithURL:(NSString *)imageUrl
//{
//    NSError * error = nil;
//    
//    //初始化 url
//    NSURL* url = [NSURL URLWithString:imageUrl];
//    //将文件内容读取到字符串中，
//    NSString * jsonString = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"the json string is %@",jsonString);
//    //将字符串写到缓冲区。
//    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
//    if (!jsonDict || error) {
//        NSLog(@"JSON parse failed!");
//    }
//    return jsonDict;
//    
//}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}

- (IBAction)submitErrand:(id)sender
{
    
    [SVProgressHUD showWithStatus:@"查询中，请稍后"];
	[self doTask];
    [SVProgressHUD dismiss];

    //[HUD showWhileExecuting:@selector(doTask) onTarget:self withObject:nil animated:YES];
  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 0)
    {
        
    }
}

#pragma mark -

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)openMenu
{
    UIActionSheet * myActionSheet = [[UIActionSheet alloc]
                                     initWithTitle:nil
                                     delegate:self
                                     cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
}

- (IBAction)imageBtnClicked:(id)sender
{
    [self openMenu];
    self.imageStateNum = 0;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self LocalPhoto];
            break;
        default:
            break;
    }
}

-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
//    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
//    [popover presentPopoverFromRect:self.imageBtn.bounds inView:self.imageBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    self.popOver = popover;
//    
//    [self presentModalViewController:picker animated:YES];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popover presentPopoverFromRect:self.imageBtn.bounds inView:self.imageBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popOver = popover;
        }];
        
    }
    else{
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        [popover presentPopoverFromRect:self.imageBtn.bounds inView:self.imageBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.popOver = popover;
    }

    
}

-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
      //  [self presentModalViewController:picker animated:YES];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:picker animated:YES completion:nil];
            }];
        }else{
            [self presentViewController:picker animated:YES completion:nil];
        }

        
    }else {
    }
}

- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.8);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   // UIImage * zipImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(440.0, 440.0)];
    if (self.imageStateNum == 0) {
        [self saveImage:image WithName:@"rewardImage.jpg"];
        [self.imageBtn setBackgroundImage:image forState:UIControlStateNormal];
        [self submitAuth];
    }else if (self.imageStateNum == 1){
        [self saveImage:image WithName:@"FirstSerImage1.jpg"];
        
        [HttpEngine uploadSmlTicketOfFirstSer:self.query upImageState:1 complete:^(NSString *str) {
            if ([str boolValue] == true ) {
                [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
                [self getFirstSerList];
            }
        }];
        
    }
    
}

- (void)submitAuth
{
    NSString * path = uploadImage;
    NSURL * url = [NSURL URLWithString:path];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.query forKey:@"memberInfo.memberCard"];
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString * paths = [documentsDirectory stringByAppendingString:@"/rewardImage.jpg"];
    [request setFile:paths forKey:@"upload"];
    
    [request setDelegate:self];
    
    [request setCompletionBlock:^{
        NSString* restr = [request responseString];
        NSLog(@"%@",restr);
        
    }];
    
    [request setFailedBlock:^{
        NSError* err = [request error];
        NSLog(@"err = %@",err.userInfo);
    }];
    
    [request startAsynchronous];
}

- (IBAction)back:(id)sender
{
    [self.delegate changeText2];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
