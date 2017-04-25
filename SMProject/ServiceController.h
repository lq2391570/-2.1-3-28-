//
//  ServiceController.h
//  SMProject
//
//  Created by arvin yan on 10/28/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger endSection;
    NSInteger didSection;
    BOOL ifOpen;
}
@property (nonatomic,strong) IBOutlet UILabel * name;
@property (nonatomic,strong) IBOutlet UILabel * cid;

@property (nonatomic, strong) IBOutlet UITableView * mainTable;
@property (nonatomic,retain) NSMutableArray * array;


@property (nonatomic, strong) NSString * query;

@property (nonatomic,strong)  UIButton * bsbtn;
@property (nonatomic,strong)  UIButton * shbtn;

@property (nonatomic,strong) IBOutlet  UIImageView * sbImage;
@property (nonatomic,strong) IBOutlet UIImageView * shImage;

@end
