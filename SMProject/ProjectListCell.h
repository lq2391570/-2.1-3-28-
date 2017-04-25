//
//  ProjectListCell.h
//  SMProject
//
//  Created by shiliuhua on 17/3/15.
//  Copyright © 2017年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *projectNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *projectStyleLabel;

@property (strong, nonatomic) IBOutlet UILabel *projectAreaLabel;

@property (strong, nonatomic) IBOutlet UILabel *isHavePhotoLabel;

@property (strong, nonatomic) IBOutlet UIButton *uploadPhotoBtn;

@end
