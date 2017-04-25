//
//  ProjectListVC.h
//  SMProject
//
//  Created by shiliuhua on 17/3/13.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectListVC : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *cardNumlabel;

@property (strong, nonatomic) IBOutlet UIView *titleView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *returnBtn;
//会员卡号
@property (nonatomic,strong) NSString *cid;
//会员姓名
@property (nonatomic,strong) NSString *uname;
//cell是否打开的indexPath
@property (nonatomic,assign) NSInteger currentSelectSection;

//cell是否打开的bool数组
@property (nonatomic,strong)NSMutableArray *isOpenArray;

@property (nonatomic,strong)NSMutableArray *tempArray;
@property (nonatomic, strong) UIPopoverController *popOver;
//一个全局的数字
@property (nonatomic,assign)NSInteger selectUploadBtnNum;

//创建一个二维数组（第一维：列表数组；第二维：图片数组）
@property (nonatomic,strong)NSMutableArray *twoDimensionArray;



@end
