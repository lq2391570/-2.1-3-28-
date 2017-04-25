//
//  InformationViewController.h
//  SMProject
//
//  Created by 石榴花科技 on 14-4-29.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "XMLmanage.h"
#import "CustomCell.h"
#import "TitleCell.h"
#import "SecondCustomTitleCell.h"
#import "SecondCustomCell.h"
#import "SVProgressHUD.h"
#define TOUCH_SCREEN_NOTIFICATION @"TOUCH_SCREEN_NOTIFICATION"
@interface InformationViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    NSMutableArray *_selections;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray * detailImageArray;

@end
