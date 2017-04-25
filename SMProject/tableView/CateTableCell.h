//
//  CateTableCell.h
//  top100
//
//  Created by Dai Cloud on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateTableCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *title, *subTtile;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *addLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *uploadBtn;

@end
