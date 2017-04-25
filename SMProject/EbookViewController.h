//
//  E-bookViewController.h
//  shengmeng
//
//  Created by 石榴花科技 on 14-4-1.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "CustomCell.h"
#import "TitleCell.h"
#import "SecondCustomTitleCell.h"
#import "SecondCustomCell.h"
#define TOUCH_SCREEN_NOTIFICATION @"TOUCH_SCREEN_NOTIFICATION"

@interface EbookViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate,UITableViewDelegate,UITableViewDataSource>

{
     NSMutableArray *_selections;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray * detailImageArray;

@end
