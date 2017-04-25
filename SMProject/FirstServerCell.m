//
//  FirstServerCell.m
//  SMProject
//
//  Created by shiliuhua on 17/3/15.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import "FirstServerCell.h"
#import "ProSerPhotoListBaseClass.h"
#import "UIButton+WebCache.h"

@implementation FirstServerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
     
    // Configure the view for the selected state
}


- (void)setUpBtnAndDateLabel:(NSMutableArray *)tempArray
{
    //初始化btn和label
    for (int i =0; i< 6; i++) {
        UIButton *btn = [self.smlBgView viewWithTag:21+i];
        btn.hidden = YES;
        UILabel *label = [self.smlBgView viewWithTag:31+i];
        label.hidden = YES;
    }
    
    for (int i = 0; i < tempArray.count; i++) {
        UIButton *btn = [self.smlBgView viewWithTag:21+i];
        btn.hidden = NO;
        UILabel *dateLabel = [self.smlBgView viewWithTag:31+i];
        dateLabel.hidden = NO;
        ProSerPhotoListBaseClass *bassClass = [tempArray objectAtIndex:i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,bassClass.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
        [btn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        dateLabel.text = bassClass.serviceDateTime;
    }
}
- (void)imageBtnClick:(UIButton *)btn
{
    
    if (self.imageBtnClickBlock) {
        self.imageBtnClickBlock(btn);
    }
}





@end
