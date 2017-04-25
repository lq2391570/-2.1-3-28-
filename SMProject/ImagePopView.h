//
//  ImagePopView.h
//  SMProject
//
//  Created by shiliuhua on 17/3/23.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePopView : UIView
- (id)initWithImageName:(NSString *)imageUrlStr;
- (void)getBgImage:(NSString *)imageUrlStr;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@end
