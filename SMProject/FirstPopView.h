//
//  FirstPopView.h
//  SMProject
//
//  Created by shiliuhua on 17/3/21.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstPopView : UIView


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *imagebtn1;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn2;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn3;

@property (strong, nonatomic) IBOutlet UIButton *ImageBtn4;

@property (strong, nonatomic) IBOutlet UIButton *ImageBtn5;

@property (strong, nonatomic) IBOutlet UIButton *imageBtn6;
//按钮点击block
@property (nonatomic,strong)void ( ^imageBtClickBlock)(UIButton *btn);
- (void)imageBtnAppearArray:(NSMutableArray *)tempArray;
@end
