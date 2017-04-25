//
//  FirstPopView.m
//  SMProject
//
//  Created by shiliuhua on 17/3/21.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import "FirstPopView.h"
#import "ProSerPhotoListBaseClass.h"
#import "UIButton+WebCache.h"
@implementation FirstPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}
- (id)init
{
    self = [super init];
    FirstPopView *view = [[[NSBundle mainBundle] loadNibNamed:@"FirstPopView2" owner:self options:nil] lastObject];
    return view;
    
}
- (void)imageBtnAppearArray:(NSMutableArray *)tempArray
{
    for (int i =0; i<tempArray.count; i++) {
        ProSerPhotoListBaseClass *bassClass = tempArray[i];
        
        UIButton *btn = [self viewWithTag:11+i];
        btn.hidden = NO;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationIp,bassClass.smallImageUrl]] forState:UIControlStateNormal placeholderImage:nil];
        [btn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
- (void)imageBtnClick:(UIButton *)btn
{
    if (self.imageBtClickBlock) {
        self.imageBtClickBlock(btn);
    }
    
}

@end
