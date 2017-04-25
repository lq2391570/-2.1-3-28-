//
//  SubCateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubCateViewController.h"
#import "SVProgressHUD.h"
#import "UIButton+WebCache.h"
#import "UIButton+btnImageName.h"
#import "UIAlertView+alertViewImageName.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "XMLmanage.h"

#import "ProSerPhotoListBaseClass.h"

#import "JCAlertView.h"

#import "FirstPopView.h"
#import "HttpEngine.h"


#define COLUMN 4

@interface SubCateViewController ()

@end

@implementation SubCateViewController

@synthesize subCates=_subCates;
@synthesize cateVC=_cateVC;


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    
//    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
//    
//    // init cates show
//    int total = self.subCates.count;
//#define ROWHEIHT 100
//    int rows = (total / COLUMN) + ((total % COLUMN) > 0 ? 1 : 0);
//    
//    for (int i=0; i<total; i++) {
//        int row = i / COLUMN;
//        int column = i % COLUMN;
//        // NSDictionary *data = [self.subCates objectAtIndex:i];
//        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80*column, ROWHEIHT*row, 80, ROWHEIHT)] ;
//        view.backgroundColor = [UIColor clearColor];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(15, 15, 200, 200);
//        btn.tag = i;
//        [btn addTarget:self.cateVC
//                action:@selector(subCateBtnAction:)
//      forControlEvents:UIControlEventTouchUpInside];
//        ;
//        NSDictionary * item = [self.subCates objectAtIndex:i];
//        
//        
//        NSString * imageName = [item objectForKey:@"archiveImageUrl"];
//        NSString * state = [item objectForKey:@"archiveState"];
//        
//        //NSString * imageName = [self.subCates objectAtIndex:i];
//        NSLog(@"the sub title is %@",imageName);
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.140.102:8080/Sanmoon1.0/%@",imageName]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *img = [[UIImage alloc] initWithData:data];
//        
//        CGSize size = img.size;
//        
//        [btn setBackgroundImage:img forState:UIControlStateNormal];
//        // forState:UIControlStateNormal];
//        
//        [view addSubview:btn];
//        
//        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 80, 14)];
//        lbl.textAlignment = UITextAlignmentCenter;
//        lbl.textColor = [UIColor colorWithRed:204/255.0
//                                        green:204/255.0
//                                         blue:204/255.0
//                                        alpha:1.0];
//        lbl.font = [UIFont systemFontOfSize:12.0f];
//        lbl.backgroundColor = [UIColor clearColor];
//        //lbl.text = [data objectForKey:@"name"];
//        lbl.text = @"444";
//        
//        [view addSubview:lbl];
//        
//        [self.view addSubview:view];
//    }
//    
//    CGRect viewFrame = self.view.frame;
//    viewFrame.size.height = ROWHEIHT * rows + 19;
//    self.view.frame = viewFrame;
//    
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [SVProgressHUD dismiss];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:168/255.0 blue:196/255.0 alpha:1.0];
    // init cates show
//    int total = self.subCates.count;
//#define ROWHEIHT 140
//    int rows = (total / COLUMN) + ((total % COLUMN) > 0 ? 1 : 0);
//    
//    for (int i=0; i<total; i++) {
//        int row = i / COLUMN;
//        int column = i % COLUMN;
//       // NSDictionary *data = [self.subCates objectAtIndex:i];
//        
//        NSDictionary * item = [self.subCates objectAtIndex:i];
//        NSString * imageName = [item objectForKey:@"archiveImageUrl"];
//        int state = [[item objectForKey:@"archiveState"] intValue];
//        //NSString * imageName = [self.subCates objectAtIndex:i];
//        NSLog(@"the sub title is %@",imageName);
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ipad.sanmoon.net/Sanmoon1.0/%@",imageName]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *img = [[UIImage alloc] initWithData:data];
//        
//        CGSize size = img.size;
//        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(80*column, ROWHEIHT*row, 80, ROWHEIHT)] autorelease];
//        view.backgroundColor = [UIColor clearColor];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(15, 15, 50, 50);
//        btn.tag = i;
//        [btn addTarget:self.cateVC
//                action:@selector(subCateBtnAction:)
//      forControlEvents:UIControlEventTouchUpInside];
//        
//        [btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
//
//        [view addSubview:btn];
//        
//        UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 65, 80, 14)] autorelease];
//        lbl.textAlignment = UITextAlignmentCenter;
//        lbl.textColor = [UIColor blackColor];
//        lbl.font = [UIFont systemFontOfSize:12.0f];
//        lbl.backgroundColor = [UIColor clearColor];
//        //lbl.text = [data objectForKey:@"name"];
//       
//        if (state == 1) {
//            
//            lbl.text = @"服务前";
//            
//        }
//        else
//        {
//            lbl.text = @"服务后";
//        }
//        
//        [view addSubview:lbl];
//        
//        [self.view addSubview:view];
//    }
//    
//    CGRect viewFrame = self.view.frame;
//    viewFrame.size.height = ROWHEIHT * rows + 19;
//    self.view.frame = viewFrame;
    _user=[NSUserDefaults standardUserDefaults];
    [self createNewView];
    self.view.frame=CGRectMake(0, 0, 1024, 180);
    
    
    _selectArray=[NSMutableArray arrayWithCapacity:2];
   
    
   // self.compareArray = [NSMutableArray arrayWithCapacity:2];
//    [_user removeObjectForKey:@"selectImage1"];
//    [_user removeObjectForKey:@"selectImage2"];
    
    
}
//新View
- (void)createNewView
{
    
    for (int i=0; i<self.subCates.count; i++) {
        ImageModelBaseClass *bassClass=self.subCates[i];
        if (bassClass.archiveState==1) {
            self.beforeBassClass=bassClass;
        }else if (bassClass.archiveState==2){
            self.afterBassClass=bassClass;
        }else if (bassClass.archiveState==3){
            self.receiptBassClass=bassClass;
        }
    }
    
    UIView *beforeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 90)];
    [beforeView setBackgroundColor:[UIColor clearColor]];
    beforeView.tag=666;
    [self.view addSubview:beforeView];
    
    UILabel *beforeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 50, 30)];
    beforeLabel.text=@"服务前";
    beforeLabel.font=[UIFont systemFontOfSize:14];
    [beforeView addSubview:beforeLabel];
    //小票
    UILabel *receiptLabel=[[UILabel alloc] initWithFrame:CGRectMake(1024-140, 60, 50, 30)];
    receiptLabel.text=@"小票";
    receiptLabel.font=[UIFont systemFontOfSize:14];
    [beforeView addSubview:receiptLabel];
    
    //首次服务前（按钮）
    UIButton *firstSerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstSerBtn.frame = CGRectMake(1024 - 170, 20, 90,40 );
    firstSerBtn.backgroundColor = [UIColor colorWithRed:232/255.0 green:92/255.0 blue:141/255.0 alpha:1];
    [firstSerBtn setTitle:@"首次服务前" forState:UIControlStateNormal];
    [firstSerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [firstSerBtn addTarget:self action:@selector(firstSerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    firstSerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [beforeView addSubview:firstSerBtn];
    
    
    UIButton *receiptBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [receiptBtn setBackgroundColor:[UIColor clearColor]];
    [receiptBtn setFrame:CGRectMake(1024-160, 95, 70, 70)];
    receiptBtn.tag=9999;
    [receiptBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,self.receiptBassClass.archiveSmallImageUrl]] forState:UIControlStateNormal];
  //  [receiptBtn addTarget:self action:@selector(receiptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  //小票点击进入对比框
    [receiptBtn addTarget:self action:@selector(receiptBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    receiptBtn.imageName=[NSString stringWithFormat:@"%@%@",LocationIp,self.receiptBassClass.archiveSmallImageUrl];
    receiptBtn.bigImageName=[NSString stringWithFormat:@"%@%@",LocationIp,self.receiptBassClass.archiveImageUrl];
    
    //标记
    UIImageView *selecttImageView=[[UIImageView alloc] initWithFrame:CGRectMake(35, 35, 35, 35)];
    [selecttImageView setImage:[UIImage imageNamed:@"CTAssetsPickerChecked@3x.png"]];
    if ([[_user objectForKey:@"selectImage1"] isKindOfClass:[NSArray class]]||[[_user objectForKey:@"selectImage2"] isKindOfClass:[NSArray class]]) {
        if ([[_user objectForKey:@"selectImage1"][1] isEqualToString:receiptBtn.imageName]||[[_user objectForKey:@"selectImage2"][1] isEqualToString:receiptBtn.imageName]) {
            selecttImageView.hidden=NO;
        }else{
            selecttImageView.hidden=YES;
        }
    }else{
        selecttImageView.hidden=YES;
    }
    selecttImageView.tag=999;
    [receiptBtn addSubview:selecttImageView];

    
    
    
    
    NSArray *beforeArray=[self.beforeBassClass.archiveSmallImageUrl componentsSeparatedByString:@","];
    NSArray *beforeBigImageArray=[self.beforeBassClass.archiveImageUrl componentsSeparatedByString:@","];
    
    NSArray *afterArray=[self.afterBassClass.archiveSmallImageUrl componentsSeparatedByString:@","];
    NSArray *afterBigImageArray=[self.afterBassClass.archiveImageUrl componentsSeparatedByString:@","];
    NSLog(@"beforeArray=%@",beforeArray);
    
    
    for (int i=0; i<beforeArray.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(70+80*i, 10, 70, 70)];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag=100+i;
        NSLog(@"xiaotu=%@",beforeArray[i]);
        btn.imageName=[NSString stringWithFormat:@"%@%@",LocationIp,beforeArray[i]];
        btn.bigImageName=[NSString stringWithFormat:@"%@%@",LocationIp,beforeBigImageArray[i]];
        btn.gsNumber= btn.gsNumber=[NSString stringWithFormat:@"%0.f",self.beforeBassClass.internalBaseClassIdentifier];
        btn.relativitybigImageName=beforeBigImageArray[i];
     //   [btn addTarget:self action:@selector(beforeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //服务前点击进入备选框
        [btn addTarget:self action:@selector(beforeBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,beforeArray[i]]] forState:UIControlStateNormal];
        if (![beforeArray[i] isEqualToString:@""]) {
             [beforeView addSubview:btn];
        }
       
        UILongPressGestureRecognizer *recognizer=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(beforeLongRecongnizer:)];
        [btn addGestureRecognizer:recognizer];
        //标记
        UIImageView *selecttImageView=[[UIImageView alloc] initWithFrame:CGRectMake(35, 35, 35, 35)];
        [selecttImageView setImage:[UIImage imageNamed:@"CTAssetsPickerChecked@3x.png"]];
        if ([[_user objectForKey:@"selectImage1"] isKindOfClass:[NSArray class]]||[[_user objectForKey:@"selectImage2"] isKindOfClass:[NSArray class]]) {
        if ([[_user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]||[[_user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
            selecttImageView.hidden=NO;
        }else{
             selecttImageView.hidden=YES;
        }
        }else{
            selecttImageView.hidden=YES;
        }
        selecttImageView.tag=200+i;
        [btn addSubview:selecttImageView];
    
    }
    
    UIView *afterView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, 1024, 90)];
    [afterView setBackgroundColor:[UIColor clearColor]];
    afterView.tag=777;
    [self.view addSubview:afterView];
    
    UILabel *afterLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 50, 30)];
    afterLabel.text=@"服务后";
    afterLabel.font=[UIFont systemFontOfSize:14];
    [afterView addSubview:afterLabel];
    
    
    for (int i=0; i<afterArray.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(70+80*i, 15, 70, 70)];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag=1000+i;
        btn.imageName=[NSString stringWithFormat:@"%@%@",LocationIp,afterArray[i]];
        btn.bigImageName=[NSString stringWithFormat:@"%@%@",LocationIp,afterBigImageArray[i]];
         btn.gsNumber=[NSString stringWithFormat:@"%0.f",self.afterBassClass.internalBaseClassIdentifier];
        btn.relativitybigImageName=afterBigImageArray[i];
      //  [btn addTarget:self action:@selector(afterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
       //服务后点击进入备选框
        [btn addTarget:self action:@selector(afterBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,afterArray[i]]] forState:UIControlStateNormal];
        if (![afterArray[i] isEqualToString:@""]) {
             [afterView addSubview:btn];
        }
        
        UILongPressGestureRecognizer *recognizer=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(afterLongRecongnizer:)];
        
        [btn addGestureRecognizer:recognizer];
        //标记
        UIImageView *selecttImageView=[[UIImageView alloc] initWithFrame:CGRectMake(35, 35, 35, 35)];
        [selecttImageView setImage:[UIImage imageNamed:@"CTAssetsPickerChecked@3x.png"]];
        
        
        if ([[_user objectForKey:@"selectImage1"] isKindOfClass:[NSArray class]]||[[_user objectForKey:@"selectImage2"] isKindOfClass:[NSArray class]]) {
        
        if ([[_user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]||[[_user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
            selecttImageView.hidden=NO;
        }else{
            selecttImageView.hidden=YES;
        }
        }else{
            selecttImageView.hidden=YES;
        }
        selecttImageView.tag=2000+i;
        [btn addSubview:selecttImageView];
        
      }
    [self.view addSubview:receiptBtn];
    
}
//小票点击进入备选框
- (void)receiptBtnClick2:(UIButton *)btn
{
    NSLog(@"点击小票");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否将此图片加入对比" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CompareModel *model = [[CompareModel alloc] init];
        model.imageName = btn.imageName;
        model.bigImageName = btn.bigImageName;
        model.imageType = @"小票";
        if (self.compareArray.count == 2) {
            [SVProgressHUD showInfoWithStatus:@"已选择了2张图片"];
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
//项目6张图片点击
- (void)projectImageList:(ProSerPhotoListBaseClass *)bassClass
{
    
    [self.customAlert dismissWithCompletion:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否将此图片加入对比" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CompareModel *model = [[CompareModel alloc] init];
        
        model.imageName = [NSString stringWithFormat:@"%@%@",LocationIp,bassClass.smallImageUrl];
        model.bigImageName = [NSString stringWithFormat:@"%@%@",LocationIp,bassClass.bigImageUrl];
        model.imageType = @"项目图片";
        if (self.compareArray.count == 2) {
            [SVProgressHUD showInfoWithStatus:@"已选择了2张图片"];
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

//服务前点击进入备选框
- (void)beforeBtnClick2:(UIButton *)btn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否将此图片加入对比" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CompareModel *model = [[CompareModel alloc] init];
        model.imageName = btn.imageName;
        model.bigImageName = btn.bigImageName;
        model.imageType = @"服务前";
        if (self.compareArray.count == 2) {
            [SVProgressHUD showInfoWithStatus:@"已选择了2张图片"];
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
//服务后点击进入备选框
- (void)afterBtnClick2:(UIButton *)btn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否将此图片加入对比" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CompareModel *model = [[CompareModel alloc] init];
        model.imageName = btn.imageName;
        model.bigImageName = btn.bigImageName;
        model.imageType = @"服务后";
        if (self.compareArray.count == 2) {
            [SVProgressHUD showInfoWithStatus:@"已选择了2张图片"];
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

- (void)firstSerBtnClick
{
    
    
    FirstPopView *customView = [[FirstPopView alloc] init];
    customView.imageBtClickBlock = ^(UIButton *btn){
        NSLog(@"点击了第%d个btn",btn.tag-11);
        ProSerPhotoListBaseClass *bassClass = self.popImageListArray[btn.tag-11];
        [self projectImageList:bassClass];
        
    };
    [HttpEngine getProSerBeforePhotoList:self.cid proId:self.iid complete:^(NSMutableArray *tempArray) {
        NSLog(@"ProPhotoListArray = %@",tempArray);
        self.popImageListArray = tempArray;
        [customView imageBtnAppearArray:self.popImageListArray];
    }];
   self.customAlert = [[JCAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:YES];
    [self.customAlert show];
    
}
- (void)beforeLongRecongnizer:(UILongPressGestureRecognizer *)recognizer
{
    
    if(recognizer.state == UIGestureRecognizerStateBegan) {
         NSLog(@"长按了before 第%ld个Btn",recognizer.view.tag-100);
        UIButton *btn=(UIButton *)recognizer.view;
        NSLog(@"btn.gsNumber=%@,btn.relativitybigImageName=%@",btn.gsNumber,btn.relativitybigImageName);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定删除此图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.gsNumber=btn.gsNumber;
        alert.bigImageName=btn.relativitybigImageName;
        alert.tag=100;
        [alert show];
     //   [self deleteImage:btn.gsNumber imageName:btn.relativitybigImageName];
        
    }
    
}
- (void)afterLongRecongnizer:(UILongPressGestureRecognizer *)recognizer
{
   // NSLog(@"长按了after 第%ld个Btn",btn.tag-1000);
      if(recognizer.state == UIGestureRecognizerStateBegan) {
           NSLog(@"长按了after 第%ld个Btn",recognizer.view.tag-1000);
          UIButton *btn=(UIButton *)recognizer.view;
       //   [self deleteImage:btn.gsNumber imageName:btn.relativitybigImageName];
          UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定删除此图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
          alert.gsNumber=btn.gsNumber;
          alert.bigImageName=btn.relativitybigImageName;
          alert.tag=100;
          [alert show];
      }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            [self deleteImage:alertView.gsNumber imageName:alertView.bigImageName];
        }
    }
}


- (void)receiptBtnClick:(UIButton *)btn
{
    NSLog(@"点击小票");
    UIImageView *imageView=(UIImageView *)[btn viewWithTag:999];
     NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if (([user objectForKey:@"selectImage1"] ==nil||[[[user objectForKey:@"selectImage1"] objectAtIndex:1] isEqualToString:@""])) {
        
         if ([user objectForKey:@"selectImage2"]!=nil&&![[user objectForKey:@"selectImage2"][1] isEqualToString:@""]) {
             
             if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
                 [user removeObjectForKey:@"selectImage2"];
                 self.beforeSelectImage2.hidden=NO;
                 self.beforeSelectImage2=imageView;
                 self.beforeSelectImage2.hidden=YES;
                 // imageView.hidden=YES;
                 
             }else if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]){
                 [user removeObjectForKey:@"selectImage1"];
                 self.beforeSelectImage.hidden=NO;
                 self.beforeSelectImage=imageView;
                 self.beforeSelectImage.hidden=YES;
                 //  imageView.hidden=YES;
             }else{
                 NSArray *array=@[@"2",btn.imageName,btn.bigImageName];
                 [user setObject:array forKey:@"selectImage1"];
                 self.beforeSelectImage.hidden=YES;
                 self.beforeSelectImage=imageView;
                 self.beforeSelectImage.hidden=NO;
             }

         }else{
        
        
        if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage1"];
            imageView.hidden=YES;
        }else{
            NSArray *array=@[@"2",btn.imageName,btn.bigImageName];
            [user setObject:array forKey:@"selectImage1"];
            self.beforeSelectImage.hidden=YES;
            self.beforeSelectImage=imageView;
            self.beforeSelectImage.hidden=NO;
            
        }
         }
    }else if ([user objectForKey:@"selectImage2"]==nil||[[user objectForKey:@"selectImage2"][1] isEqualToString:@""]){
        if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage2"];
            imageView.hidden=YES;
        }else if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]){
            [user removeObjectForKey:@"selectImage1"];
            imageView.hidden=YES;
        }
        else{
            NSArray *array=@[@"2",btn.imageName,btn.bigImageName];
            [user setObject:array forKey:@"selectImage2"];
            self.beforeSelectImage2.hidden=YES;
            self.beforeSelectImage2=imageView;
            self.beforeSelectImage2.hidden=NO;
            
        }
    }else{
        if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage1"];
            imageView.hidden=YES;
        }else if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]){
            [user removeObjectForKey:@"selectImage2"];
            imageView.hidden=YES;
        }else{
            [SVProgressHUD showInfoWithStatus:@"已经选了两张图了"];
        }
        
    }

    
}

- (void)beforeBtnClick:(UIButton *)btn
{
    NSLog(@"点击了before 第%ld个Btn",btn.tag-100);
    UIImageView *imageView=(UIImageView *)[btn viewWithTag:btn.tag+100];

    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    //第一步：判断selectImage1有没有图片
    //第二步：判断selectImage2有没有图片
    //第三步：都有图片则第二张移至第一张，第二张替换
    if (([user objectForKey:@"selectImage1"] ==nil||[[[user objectForKey:@"selectImage1"] objectAtIndex:1] isEqualToString:@""])) {
        if ([user objectForKey:@"selectImage2"]!=nil&&![[user objectForKey:@"selectImage2"][1] isEqualToString:@""]) {
            if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
                [user removeObjectForKey:@"selectImage2"];
                self.beforeSelectImage2.hidden=NO;
                self.beforeSelectImage2=imageView;
                self.beforeSelectImage2.hidden=YES;
                // imageView.hidden=YES;
                
            }else if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]){
                [user removeObjectForKey:@"selectImage1"];
                self.beforeSelectImage.hidden=NO;
                self.beforeSelectImage=imageView;
                self.beforeSelectImage.hidden=YES;
                //  imageView.hidden=YES;
            }else{
                NSArray *array=@[@"0",btn.imageName,btn.bigImageName];
                [user setObject:array forKey:@"selectImage1"];
                self.beforeSelectImage.hidden=YES;
                self.beforeSelectImage=imageView;
                self.beforeSelectImage.hidden=NO;
            }

        }else{
        
        
        if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage1"];
            self.beforeSelectImage.hidden=NO;
            self.beforeSelectImage=imageView;
            self.beforeSelectImage.hidden=YES;
          //  imageView.hidden=YES;
        }else{
            NSArray *array=@[@"0",btn.imageName,btn.bigImageName];
            [user setObject:array forKey:@"selectImage1"];
            self.beforeSelectImage.hidden=YES;
            self.beforeSelectImage=imageView;
            self.beforeSelectImage.hidden=NO;
        }
     }
    }else if ([user objectForKey:@"selectImage2"]==nil||[[user objectForKey:@"selectImage2"][1] isEqualToString:@""]){
        if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage2"];
            self.beforeSelectImage2.hidden=NO;
            self.beforeSelectImage2=imageView;
            self.beforeSelectImage2.hidden=YES;
           // imageView.hidden=YES;
            
        }else if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]){
            [user removeObjectForKey:@"selectImage1"];
            self.beforeSelectImage.hidden=NO;
            self.beforeSelectImage=imageView;
            self.beforeSelectImage.hidden=YES;
          //  imageView.hidden=YES;
        }
        else{
            NSArray *array=@[@"0",btn.imageName,btn.bigImageName];
            [user setObject:array forKey:@"selectImage2"];
            self.beforeSelectImage2.hidden=YES;
            self.beforeSelectImage2=imageView;
            self.beforeSelectImage2.hidden=NO;
        }
    }else{
        if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]) {
             [user removeObjectForKey:@"selectImage1"];
            self.beforeSelectImage.hidden=NO;
            self.beforeSelectImage=imageView;
            self.beforeSelectImage.hidden=YES;
          //  imageView.hidden=YES;
        }else if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]){
            [user removeObjectForKey:@"selectImage2"];
            self.beforeSelectImage2.hidden=NO;
            self.beforeSelectImage2=imageView;
            self.beforeSelectImage2.hidden=YES;
        //    imageView.hidden=YES;
        }else{
             [SVProgressHUD showInfoWithStatus:@"已经选了两张图了"];
        }
        
    }
    
}

- (void)afterBtnClick:(UIButton *)btn
{
    NSLog(@"点击了after 第%ldge Btn",btn.tag-1000);
    UIImageView *imageView=(UIImageView *)[btn viewWithTag:btn.tag+1000];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if (([user objectForKey:@"selectImage1"]==nil||[[user objectForKey:@"selectImage1"][1] isEqualToString:@""])) {
        
        if ([user objectForKey:@"selectImage2"]!=nil&&![[user objectForKey:@"selectImage2"][1] isEqualToString:@""]) {
            if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
                [user removeObjectForKey:@"selectImage2"];
                self.beforeSelectImage2.hidden=NO;
                self.beforeSelectImage2=imageView;
                self.beforeSelectImage2.hidden=YES;
                // imageView.hidden=YES;
                
            }else if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]){
                [user removeObjectForKey:@"selectImage1"];
                self.beforeSelectImage.hidden=NO;
                self.beforeSelectImage=imageView;
                self.beforeSelectImage.hidden=YES;
                //  imageView.hidden=YES;
            }else{
                NSArray *array=@[@"1",btn.imageName,btn.bigImageName];
                [user setObject:array forKey:@"selectImage1"];
                self.beforeSelectImage.hidden=YES;
                self.beforeSelectImage=imageView;
                self.beforeSelectImage.hidden=NO;
            }

        }else{
        
        
        if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage1"];
            imageView.hidden=YES;
        }else{
            NSArray *array=@[@"1",btn.imageName,btn.bigImageName];
            [user setObject:array forKey:@"selectImage1"];
            self.beforeSelectImage.hidden=YES;
            self.beforeSelectImage=imageView;
            self.beforeSelectImage.hidden=NO;
        }
      }
    }else if ([user objectForKey:@"selectImage2"]==nil||[[user objectForKey:@"selectImage2"][1] isEqualToString:@""]){
        if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage2"];
            imageView.hidden=YES;
        }else if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]){
            [user removeObjectForKey:@"selectImage1"];
            imageView.hidden=YES;
        }
        else{
            NSArray *array=@[@"1",btn.imageName,btn.bigImageName];
            [user setObject:array forKey:@"selectImage2"];
            self.beforeSelectImage2.hidden=YES;
            self.beforeSelectImage2=imageView;
            self.beforeSelectImage2.hidden=NO;
        }
    }else{
        if ([[user objectForKey:@"selectImage1"][1] isEqualToString:btn.imageName]) {
            [user removeObjectForKey:@"selectImage1"];
            imageView.hidden=YES;
        }else if ([[user objectForKey:@"selectImage2"][1] isEqualToString:btn.imageName]){
            [user removeObjectForKey:@"selectImage2"];
            imageView.hidden=YES;
        }else{
            [SVProgressHUD showInfoWithStatus:@"已经选了两张图了"];
        }

    }

}
//删除图片
- (void)deleteImage:(NSString *)gsNum imageName:(NSString *)imageName
{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@memberarchive_deleteMemberArchiveToIpad",LocationIp]]];
    [request setRequestMethod:@"post"];
    [request setPostValue:gsNum forKey:@"memberArchive.id"];
    [request setPostValue:imageName forKey:@"replaceUrl"];
    [request setCompletionBlock:^{
        id jsonDic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"jsonDic=%@",jsonDic);
        
        if ([jsonDic objectForKey:@"message"]==nil) {
            [XMLmanage xiaotu:^(NSMutableArray *array) {
               self.subCates=array;
               
                          UIView *view1=(UIView *)[self.view viewWithTag:666];
                          [view1 removeFromSuperview];
                          UIView *view2=(UIView *)[self.view viewWithTag:777];
                          [view2 removeFromSuperview];
        [self createNewView];
           } gusNum:self.serNumber];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadSucceed" object:nil];
            
        }else{
            [SVProgressHUD showInfoWithStatus:[jsonDic objectForKey:@"message"]];
        }
        
    
    }];
    [request startAsynchronous];
    
}


@end
