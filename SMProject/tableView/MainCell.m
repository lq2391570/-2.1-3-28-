//
//  MainCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell
@synthesize titleLabel;
@synthesize recordLabel;
@synthesize addLabel;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize uploadBtn;


@synthesize typeLabel;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
