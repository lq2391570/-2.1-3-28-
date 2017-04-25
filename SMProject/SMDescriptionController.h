//
//  SMDescriptionController.h
//  SMProject
//
//  Created by arvin yan on 11/7/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMDescriptionController : UIViewController

@property (nonatomic,retain) IBOutlet UILabel * soltion;
@property (nonatomic,retain) IBOutlet UITextView * description;
@property (nonatomic,retain) IBOutlet UITextView * reason;
@property (nonatomic,retain) IBOutlet UITextView * advince;

@property (nonatomic,retain) NSString *key;
@property (nonatomic,retain) NSString *color;

@end
