//
//  FirstServerCell.h
//  SMProject
//
//  Created by shiliuhua on 17/3/15.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstServerCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *imageBtn1;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn2;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn3;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn4;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn5;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn6;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel1;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel2;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel3;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel4;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel5;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel6;

@property (strong, nonatomic) IBOutlet UIView *smlBgView;

@property (nonatomic,strong)void (^imageBtnClickBlock)(UIButton *btn);
- (void)setUpBtnAndDateLabel:(NSMutableArray *)tempArray;

@end
