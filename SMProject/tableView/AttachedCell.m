//
//  AttachedCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "AttachedCell.h"
#import "UIButton+Create.h"

@implementation AttachedCell
@synthesize sbBtn;
@synthesize shBtn;
@synthesize sbImg;
@synthesize shImg;
@synthesize ubBtn;
@synthesize uhBtn;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (IBAction)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            NSLog(@">>>>>>>>>>B1");
        }
            break;
        case 2:
        {
            NSLog(@">>>>>>>>>>B2");
        }
            break;
        case 3:
        {
            NSLog(@">>>>>>>>>>B3");
        }
            break;
        case 4:
        {
            NSLog(@">>>>>>>>>>B4");
        }
            break;
        case 5:
        {
            NSLog(@">>>>>>>>>>B5");
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
