//
//  UploadViewController.m
//  SMProject
//
//  Created by arvin yan on 10/29/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "UploadViewController.h"
#import "RadioButton.h"
#import "ASIFormDataRequest.h"
#import "SGInfoAlert.h"
#import "SVProgressHUD.h"

#define uploadPath [NSString stringWithFormat:@"%@memberarchive_addMemberArchiveImageToIpad",LocationIp]
NSString * serviceFlag;

@interface UploadViewController ()
{
    
}
@end

@implementation UploadViewController
@synthesize takePhoto;
@synthesize photo;
@synthesize upload;
@synthesize cardNo;
@synthesize cid;

- (void)viewDidLoad
{
    [self createRadioBtn];
    self.title= @"照片上传";

    [super viewDidLoad];
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)takePhotoClicked:(id)sender
{
    [self openMenu];
}

- (IBAction)backClicked:(id)sender
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
	if(sender.selected) {
       // serviceTxt = sender.titleLabel.text;
        if ([sender.titleLabel.text isEqualToString:@"服务前"]) {
            serviceFlag = @"1";
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"shopImage.jpg"];
            [manager removeItemAtPath:fullPathToFile error:nil];
          //  [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
            [self.imageTakePhoto setImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"]];
            
        }
        else if([sender.titleLabel.text isEqualToString:@"服务后"])
        {
            serviceFlag = @"2";
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"shopImage.jpg"];
            [manager removeItemAtPath:fullPathToFile error:nil];
          //  [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
            [self.imageTakePhoto setImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"]];
        }else if ([sender.titleLabel.text isEqualToString:@"小票"]){
            serviceFlag=@"3";
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *documentsDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"shopImage.jpg"];
            [manager removeItemAtPath:fullPathToFile error:nil];
            [self.imageTakePhoto setImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"]];
            
        }
		NSLog(@"Selected color: %@", sender.titleLabel.text);
	}
}
- (void)createRadioBtn
{
    NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:2];
	//CGRect btnRect = CGRectMake(195, 355, 90, 30);
    CGRect btnRect = CGRectMake(150, 405, 25, 25);
	for (NSString* optionTitle in @[@"服务前", @"服务后",@"小票"]) {
		RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
		[btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
		btnRect.origin.x += 100;
		[btn setTitle:optionTitle forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
		[btn setImage:[UIImage imageNamed:@"圣梦_服务前服务后_52.png"] forState:UIControlStateNormal];
		[btn setImage:[UIImage imageNamed:@"圣梦_服务前服务后_54.png"] forState:UIControlStateSelected];
		btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	  //	btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
      //   btn.titleEdgeInsets=UIEdgeInsetsMake(0, -34, 0, 0);
        
		[self.view addSubview:btn];
		[buttons addObject:btn];
	}
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(140, 440, 100, 15)];
    label.text=@"服务前";
    label.textColor=[UIColor darkGrayColor];
    [self.view addSubview:label];
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(240, 440, 100, 15)];
    label2.text=@"服务后";
    label2.textColor=[UIColor darkGrayColor];
    [self.view addSubview:label2];
    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(345, 440, 100, 15)];
    label3.text=@"小票";
    label3.textColor=[UIColor darkGrayColor];
    [self.view addSubview:label3];
    
    
    
	[buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
    serviceFlag = @"1";
	[buttons[0] setSelected:YES]; // Making the first button initially selected
   // serviceTxt = @"便利店";
    
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
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
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
    [self saveImage:image WithName:@"shopImage.jpg"];
   // [self.takePhoto setBackgroundImage:zipImage forState:UIControlStateNormal];
   // [self.takePhoto setImage:image forState:UIControlStateNormal];
    [self.imageTakePhoto setImage:image];
}

- (IBAction)submitAuth:(id)sender
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
  
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"shopImage.jpg"];
        NSUserDefaults *imageArrayUser=[NSUserDefaults standardUserDefaults];
    _imageArray=[imageArrayUser objectForKey:@"imageArray"];
    
    if(![fileManager fileExistsAtPath:fullPathToFile]) //如果不存在
    {
        [SVProgressHUD showInfoWithStatus:@"请选择图片"];
        return;
    }else{
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认后已有的图片将会覆盖" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        alert.tag=1;
//        [alert show];
        [self uploadImage:sender];
        UIButton *button=(UIButton *)sender;
        button.userInteractionEnabled=NO;
    }
    
    
   

//    if (self.imageArray.count>0) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认后已有的图片将会覆盖" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        alert.tag=1;
//        [alert show];
//        
//        if(![fileManager fileExistsAtPath:fullPathToFile]) //如果不存在
//        {
//            NSString * path = uploadPath;
//            NSURL * url = [NSURL URLWithString:path];
//            
//            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//            [request setPostValue:self.cardNo forKey:@"memberArchive.archiveNumber"];
//            [request setPostValue:self.cid forKey:@"memberArchive.memberCard"];
//            
//            [request setPostValue:serviceFlag forKey:@"memberArchive.archiveState"];
//            
//            
//            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//            NSString * paths = [documentsDirectory stringByAppendingString:@"/shopImage.jpg"];
//            [request setFile:paths forKey:@"upload"];
//            
//            [request setDelegate:self];
//#pragma mark 修改
//            [request setCompletionBlock:^{
//                NSString* restr = [request responseString];
//                NSLog(@"%@",restr);
//                [SGInfoAlert showInfo:@"上传成功！"
//                              bgColor:[[UIColor blackColor] CGColor]
//                               inView:self.view
//                             vertical:0.4];
//                
//                //        NSFileManager *manager=[NSFileManager defaultManager];
//                //        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//                //        [manager removeItemAtPath:documentsDirectory error:nil];
//                //        [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
//                
//            }];
//            
//            [request setFailedBlock:^{
//                NSError* err = [request error];
//                [SGInfoAlert showInfo:@"上传失败！"
//                              bgColor:[[UIColor blackColor] CGColor]
//                               inView:self.view
//                             vertical:0.4];
//                NSLog(@"err = %@",err.userInfo);
//            }];
//            
//            [request startAsynchronous];
//
//        }else{
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认后已有的图片将会覆盖" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            alert.tag=1;
//            [alert show];
//
//        }
//        }else{
//
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认后已有的图片将会覆盖" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            alert.tag=1;
//            [alert show];
//
//        NSString * path = uploadPath;
//        NSURL * url = [NSURL URLWithString:path];
//        
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//        [request setPostValue:self.cardNo forKey:@"memberArchive.archiveNumber"];
//        [request setPostValue:self.cid forKey:@"memberArchive.memberCard"];
//        [request setPostValue:serviceFlag forKey:@"memberArchive.archiveState"];
//        
//        
//        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString * paths = [documentsDirectory stringByAppendingString:@"/shopImage.jpg"];
//        [request setFile:paths forKey:@"upload"];
//        
//        [request setDelegate:self];
//#pragma mark 修改
//        [request setCompletionBlock:^{
//            NSString* restr = [request responseString];
//            NSLog(@"%@",restr);
//            [SGInfoAlert showInfo:@"上传成功！"
//                          bgColor:[[UIColor blackColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
//            
//            //        NSFileManager *manager=[NSFileManager defaultManager];
//            //        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//            //        [manager removeItemAtPath:documentsDirectory error:nil];
//            //        [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
//            
//        }];
//        
//        [request setFailedBlock:^{
//            NSError* err = [request error];
//            [SGInfoAlert showInfo:@"上传失败！"
//                          bgColor:[[UIColor blackColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
//            NSLog(@"err = %@",err.userInfo);
//        }];
//        
//        [request startAsynchronous];
//
//        
//    }
//    
//    
    
//    
//    NSString * path = uploadPath;
//    NSURL * url = [NSURL URLWithString:path];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:self.cardNo forKey:@"memberArchive.archiveNumber"];
//    [request setPostValue:self.cid forKey:@"memberArchive.memberCard"];
//    
//    [request setPostValue:serviceFlag forKey:@"memberArchive.archiveState"];
//    
//    
//    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString * paths = [documentsDirectory stringByAppendingString:@"/shopImage.jpg"];
//    [request setFile:paths forKey:@"upload"];
//    
//    [request setDelegate:self];
//#pragma mark 修改
//    [request setCompletionBlock:^{
//        NSString* restr = [request responseString];
//        NSLog(@"%@",restr);
//        [SGInfoAlert showInfo:@"上传成功！"
//                      bgColor:[[UIColor blackColor] CGColor]
//                       inView:self.view
//                     vertical:0.4];
//        
////        NSFileManager *manager=[NSFileManager defaultManager];
////        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
////        [manager removeItemAtPath:documentsDirectory error:nil];
////        [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
//
//    }];
//    
//    [request setFailedBlock:^{
//        NSError* err = [request error];
//        [SGInfoAlert showInfo:@"上传失败！"
//                      bgColor:[[UIColor blackColor] CGColor]
//                       inView:self.view
//                     vertical:0.4];
//        NSLog(@"err = %@",err.userInfo);
//    }];
//    
//    [request startAsynchronous];
//    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [SVProgressHUD show];
    [self performSelector:@selector(SVDidmiss) withObject:nil afterDelay:6];
    if (alertView.tag==1) {
        if (buttonIndex==0) {
           
        //    NSString * path = uploadPath;
            NSString *path=[NSString stringWithFormat:@"%@memberarchive_addMemberArchiveImageToIpad",LocationIp];
            NSURL * url = [NSURL URLWithString:path];
            
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request setPostValue:self.cardNo forKey:@"memberArchive.archiveNumber"];
            [request setPostValue:self.cid forKey:@"memberArchive.memberCard"];
            
            [request setPostValue:serviceFlag forKey:@"memberArchive.archiveState"];
            [request setPostValue:self.serverDate forKey:@"memberArchive.archiveServiceTime"];
            
            
            [request setUploadProgressDelegate:self];
            
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
            NSString * paths = [documentsDirectory stringByAppendingString:@"/shopImage.jpg"];
            [request setFile:paths forKey:@"upload"];
            NSLog(@"--%@",paths);
            [request setDelegate:self];
#pragma mark 修改
            
            [request setCompletionBlock:^{
                NSString* restr = [request responseString];
                NSLog(@"==--%@",restr);
//                [SGInfoAlert showInfo:@"上传成功！"
//                              bgColor:[[UIColor blackColor] CGColor]
//                               inView:self.view
//                             vertical:0.4];
                id dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"jsonDic=%@",dic);
                
                
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                //        NSFileManager *manager=[NSFileManager defaultManager];
                //        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                //        [manager removeItemAtPath:documentsDirectory error:nil];
                //        [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
                
            }];
            
            [request setFailedBlock:^{
                NSError* err = [request error];
                
//                [SGInfoAlert showInfo:@"上传失败！"
//                              bgColor:[[UIColor blackColor] CGColor]
//                               inView:self.view
//                             vertical:0.4];
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
                NSLog(@"err = %@",err.userInfo);
            }];
            
            [request startAsynchronous];

        }else{
            return;
        }
    }

}
- (void)setProgress:(float)newProgress
{
    [SVProgressHUD showProgress:newProgress];
    
}
- (void)uploadImage:(UIButton *)button
{
   
    
    
  //  [SVProgressHUD show];
    [self performSelector:@selector(SVDidmiss) withObject:nil afterDelay:6];
    
            //    NSString * path = uploadPath;
            NSString *path=[NSString stringWithFormat:@"%@memberarchive_addMemberArchiveImageToIpad",LocationIp];
            NSURL * url = [NSURL URLWithString:path];
            
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request setPostValue:self.cardNo forKey:@"memberArchive.archiveNumber"];
            [request setPostValue:self.cid forKey:@"memberArchive.memberCard"];
            
            [request setPostValue:serviceFlag forKey:@"memberArchive.archiveState"];
    NSLog(@"self.serverDate=%@",self.serverDate);
           [request setPostValue:self.serverDate forKey:@"memberArchive.archiveServiceTime"];
    
            [request setUploadProgressDelegate:self];
            NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
            NSString * paths = [documentsDirectory stringByAppendingString:@"/shopImage.jpg"];
            [request setFile:paths forKey:@"upload"];
            NSLog(@"--%@",paths);
            [request setDelegate:self];
#pragma mark 修改
            
            [request setCompletionBlock:^{
                NSString* restr = [request responseString];
                button.userInteractionEnabled=YES;
                NSLog(@"==--%@",restr);
                //                [SGInfoAlert showInfo:@"上传成功！"
                //                              bgColor:[[UIColor blackColor] CGColor]
                //                               inView:self.view
                //                             vertical:0.4];
                id dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"jsonDic=%@",dic);
                if ([[dic objectForKey:@"result"] integerValue]==1) {
                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                    //成功后发通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadSucceed" object:nil];
                    
                    
                    button.userInteractionEnabled=YES;
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    
                    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
                    NSString* documentsDirectory = [paths objectAtIndex:0];
                    // Now we get the full path to the file
                    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"shopImage.jpg"];
                    if(![fileManager fileExistsAtPath:fullPathToFile]) //如果不存在
                    {
                       // return;
                    }else{
                        //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认后已有的图片将会覆盖" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                        //        alert.tag=1;
                        //        [alert show];
                        [fileManager removeItemAtPath:fullPathToFile error:nil];
                    }
              [self.imageTakePhoto setImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"]];
                    
                }else{
                    [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"message"]];
                }
                
                
              //  [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                //        NSFileManager *manager=[NSFileManager defaultManager];
                //        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                //        [manager removeItemAtPath:documentsDirectory error:nil];
                //        [self.takePhoto setBackgroundImage:[UIImage imageNamed:@"圣梦_上传头像_03_03.jpg"] forState:UIControlStateNormal];
                
            }];
            
            [request setFailedBlock:^{
                NSError* err = [request error];
                
                //                [SGInfoAlert showInfo:@"上传失败！"
                //                              bgColor:[[UIColor blackColor] CGColor]
                //                               inView:self.view
                //                             vertical:0.4];
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
                 button.userInteractionEnabled=YES;
                NSLog(@"err = %@",err.userInfo);
            }];
            
            [request startAsynchronous];
            
    
}
- (void)SVDidmiss
{
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [popover presentPopoverFromRect:self.takePhoto.bounds inView:self.takePhoto permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popOver = popover;
        }];
        
    }
    else{
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        [popover presentPopoverFromRect:self.takePhoto.bounds inView:self.takePhoto permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.popOver = popover;
    }

    // [self presentModalViewController:picker animated:YES];
   //  [self presentViewController:picker animated:YES completion:nil];
    
}

//拍照
-(void)takePhotos{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                  [self presentViewController:picker animated:YES completion:nil];
             }];
        }else{
             [self presentViewController:picker animated:YES completion:nil];
        }
        
    }else {
        NSLog(@"该设备无摄像头");
    }
}

@end
