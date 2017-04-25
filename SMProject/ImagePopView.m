//
//  ImagePopView.m
//  SMProject
//
//  Created by shiliuhua on 17/3/23.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import "ImagePopView.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
@implementation ImagePopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithImageName:(NSString *)imageUrlStr
{
    self = [super init];
    ImagePopView *view = [[[NSBundle mainBundle] loadNibNamed:@"ImagePopView" owner:self options:nil] lastObject];
//    [SVProgressHUD show];
//    
//    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [SVProgressHUD dismiss];
//        
//    }];
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
   // [self getBgImage:imageUrlStr];
    return view;
}

- (void)getBgImage:(NSString *)imageUrlStr
{
    [SVProgressHUD show];
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [SVProgressHUD dismiss];
    }];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}


@end
