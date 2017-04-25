//
//  CateViewController.h
//  top100
//
//  Created by Dai Cloud on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"
#import "MBProgressHUD.h"

@interface CateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
    NSArray *_array;
    NSMutableArray *_tempArray;
    NSMutableArray *_tempDataArray;
    NSInteger beforegusNum;
    NSInteger endgusNum;
    
}
@property (strong, nonatomic) NSArray *cates;
@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;
@property (nonatomic, strong) NSString * query;
//客户姓名
@property (nonatomic,strong)NSString *guestName;

@property (strong, nonatomic) NSArray * imagesArray;
@property (strong, nonatomic) NSMutableArray * compareArray;
@property (strong, nonatomic) IBOutlet UILabel * nameLab;
@property (strong, nonatomic) IBOutlet UILabel * cardLab;

@property (strong, nonatomic) IBOutlet UIButton *openBtn;

@property (strong,nonatomic) NSArray *searveArray;
@property (nonatomic,assign) NSInteger indexNum;

//点击左下角弹出的View

@property (strong, nonatomic) IBOutlet UIView *smlPopView;

@property (strong, nonatomic) IBOutlet UIButton *smlTicketBtn1;
@property (strong, nonatomic) IBOutlet UIButton *smlTicketBtn2;
@property (strong, nonatomic) IBOutlet UIButton *smlTicketBtn3;
@property (strong, nonatomic) IBOutlet UILabel *ticketLabel;

//对比image
@property (strong, nonatomic) IBOutlet UIImageView *compareImage1;

@property (strong, nonatomic) IBOutlet UIImageView *compareImage2;

@property (strong, nonatomic) IBOutlet UIButton *deleteBtn1;

@property (strong, nonatomic) IBOutlet UIButton *deleteBtn2;


//将要对比的图片数组
@property (nonatomic,strong)NSMutableArray *selectImageArray;

//服务档案listNew
@property (nonatomic,strong)NSMutableArray *serRecordTempArray;

//首次服务小票数组
@property (nonatomic,strong)NSMutableArray *firstSmlTickArray;

//通知数组
@property (nonatomic,strong)NSMutableArray *notiCompareArray;


@end
