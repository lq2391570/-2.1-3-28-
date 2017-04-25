//
//  ProjectListVC.m
//  SMProject
//
//  Created by shiliuhua on 17/3/13.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import "ProjectListVC.h"
#import "ProjectListCell.h"
#import "FirstServerCell.h"
#import "HttpEngine.h"
#import "ProjectList.h"
#import "ProjectListNewBaseClass.h"
#import "SVProgressHUD.h"
#import "JCAlertView.h"
#import "ImagePopView.h"
#import "ProSerPhotoListBaseClass.h"


@interface ProjectListVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProjectListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectListCell" bundle:nil] forCellReuseIdentifier:@"ProjectListCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstServerCell" bundle:nil] forCellReuseIdentifier:@"FirstServerCell"];
    [self.returnBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.isOpenArray = [NSMutableArray arrayWithCapacity:0];
   // [self getProjectList:self.cid];
    self.nameLabel.text = [NSString stringWithFormat:@"会员姓名:%@",self.uname];
    self.cardNumlabel.text = [NSString stringWithFormat:@"会员卡号:%@",self.cid];
    [self getProjectListNew:self.cid];
    //初始化二维数组
    self.twoDimensionArray = [NSMutableArray arrayWithCapacity:0];
    
}
//得到项目列表
- (void)getProjectList:(NSString *)cid
{
    [HttpEngine getProjectList:cid complete:^(NSMutableArray *tempArray) {
        self.tempArray = tempArray;
        for (int i = 0; i < self.tempArray.count; i++)
        {
            BOOL isOpen = NO;
            NSNumber *num = [NSNumber numberWithBool:isOpen];
            [self.isOpenArray addObject:num];
        }
        [self.tableView reloadData];
    }];
    
}
//得到项目列表新
- (void)getProjectListNew:(NSString *)cid
{
    [HttpEngine getProjectListNew:cid complete:^(NSMutableArray *tempArray) {
        self.tempArray = tempArray;
        for (int i = 0; i < self.tempArray.count; i++)
        {
            BOOL isOpen = NO;
            NSNumber *num = [NSNumber numberWithBool:isOpen];
            [self.isOpenArray addObject:num];
            //每一个循环创建一个数组
            NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
            [self.twoDimensionArray addObject:imageArray];
        }
        
        [self.tableView reloadData];
    }];
}
- (void)returnBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tempArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%d行",indexPath.row);
    self.currentSelectSection = indexPath.section;
        NSNumber *num = [self.isOpenArray objectAtIndex:self.currentSelectSection];
        BOOL isOpen = [num boolValue];
        isOpen = !isOpen;
        NSNumber *alNum = [NSNumber numberWithBool:isOpen];
     ProjectListNewBaseClass *listModel = [self.tempArray objectAtIndex:indexPath.section];
    
    if (isOpen == YES) {
    [self getProPhotoList:listModel.iid section:indexPath.section];
    }
    [self.isOpenArray replaceObjectAtIndex:self.currentSelectSection withObject:alNum];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:self.currentSelectSection];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    

}
//得到某一条项目的图片列表
- (void)getProPhotoList:(NSString *)proId section:(NSInteger)section
{
    [HttpEngine getProSerBeforePhotoList:self.cid proId:proId complete:^(NSMutableArray *tempArray) {
        NSLog(@"ProPhotoListArray = %@",tempArray);
       
        NSMutableArray *imageArray = [self.twoDimensionArray objectAtIndex:section];
        [imageArray removeAllObjects];
        [imageArray addObjectsFromArray:tempArray];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:self.currentSelectSection];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }else{
        return 200;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.isOpenArray objectAtIndex:section] boolValue] == YES)
    {
        return 2;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectListNewBaseClass *listModel = [self.tempArray objectAtIndex:indexPath.section];
    if (indexPath.row == 1) {
        FirstServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstServerCell"];
        
        NSMutableArray *imageArray = [self.twoDimensionArray objectAtIndex:indexPath.section];
        [cell setUpBtnAndDateLabel:imageArray];
        cell.imageBtnClickBlock = ^(UIButton *btn){
             NSLog(@"第%d个btn点击",btn.tag-21);
            ProSerPhotoListBaseClass *bassClass = imageArray[btn.tag - 21];
            [self createJCAlertView:bassClass];
        };
        return cell;
    }else{
        ProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectListCell"];
        cell.projectNameLabel.text = listModel.iname;
        cell.projectStyleLabel.text = listModel.itname;
        cell.projectAreaLabel.text = listModel.uname;
        if (listModel.count > 0 ) {
            cell.isHavePhotoLabel.text = @"有";
        }else{
            cell.isHavePhotoLabel.text = @"无";
        }
        cell.uploadPhotoBtn.tag = indexPath.section ;
        [cell.uploadPhotoBtn addTarget:self action:@selector(uploadPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}
//创建jc弹出框
- (void)createJCAlertView:(ProSerPhotoListBaseClass *)bassClass
{
   
    ImagePopView *customView = [[ImagePopView alloc] initWithImageName:[NSString stringWithFormat:@"%@%@",LocationIp,bassClass.bigImageUrl]];
    [customView getBgImage:[NSString stringWithFormat:@"%@%@",LocationIp,bassClass.bigImageUrl]];
    NSLog(@"imagename = %@%@",LocationIp,bassClass.bigImageUrl);
    JCAlertView *customAlert = [[JCAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:YES];
    [customAlert show];
}


- (void)uploadPhotoBtnClick:(UIButton *)btn
{
    self.selectUploadBtnNum = btn.tag;
    [self openMenu];
    
    
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
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self takePhotos];
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
    
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
            CGRect rect = CGRectMake(960, 120, 100, 100);
            [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popOver = popover;
           //  [self presentViewController:picker animated:YES completion:nil];
        }];
        
    }
    else{
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        CGRect rect = CGRectMake(960, 120, 100, 100);
        [popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.popOver = popover;
       //  [self presentViewController:picker animated:YES completion:nil];
    }
    
    // [self presentModalViewController:picker animated:YES];
    //  [self presentViewController:picker animated:YES completion:nil];
    
}
-(void)takePhotos{
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
    [self saveImage:image WithName:@"ProImage.jpg"];
    
     ProjectListNewBaseClass *listModel = [self.tempArray objectAtIndex:self.selectUploadBtnNum];
    
    NSString *timeStr = [listModel.xssj stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
     NSLog(@"self.cid = %@,listModel.iid=%@,listModel.iname=%@,listModel.itname=%@,listModel.uname=%@,listModel.xssj=%@",self.cid,listModel.iid,listModel.iname,listModel.itname,listModel.uname,timeStr);
    
    [HttpEngine uploadProductSerPhoto:self.cid proId:listModel.iid proName:listModel.iname proStyleName:listModel.itname proBuyArea:listModel.uname proTime:timeStr setDelegateVC:self complete:^(NSString *errorCode,NSString *msg) {
        if ([errorCode boolValue] == true) {
             [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
            [self getProjectListNew:self.cid];
             [self getProPhotoList:listModel.iid section:self.currentSelectSection];
        }else{
            [SVProgressHUD showInfoWithStatus:msg];
        }
        
    }];
    
}

- (void)setProgress:(float)newProgress
{
    [SVProgressHUD showProgress:newProgress status:@"下载中"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
