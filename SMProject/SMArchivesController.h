//
//  SMArchivesController.h
//  SMProject
//
//  Created by arvin yan on 11/16/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPopViewDelegate.h"
#import "SMPopViewController.h"

@interface SMArchivesController : UIViewController<SMPopViewDelegate>

@property ( nonatomic, retain) IBOutlet UITextField * name;
@property ( nonatomic, retain) IBOutlet UITextField * tel;
@property ( nonatomic, retain) IBOutlet UITextField * src;
@property ( nonatomic, retain) IBOutlet UITextField * people;

@property (nonatomic, retain) IBOutlet SMPopViewController * popViewController;
@property (nonatomic, retain) id popoverController;

@property (nonatomic, retain) NSMutableArray * customerArray;
@property (nonatomic, retain) NSMutableArray * peopleArray;

@end
