//
//  FaceProductViewController.h
//  SMProject
//
//  Created by DAIjun on 15-1-7.
//  Copyright (c) 2015年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"


@interface FaceProductViewController : UIViewController
{
    
    IBOutlet UIImageView *imageView;
}
@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,assign)int status;
@property (nonatomic, strong) NSMutableArray * detailRecordArray;

@end
