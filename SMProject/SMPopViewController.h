//
//  SMPopViewController.h
//  SMProject
//
//  Created by arvin yan on 11/16/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPopViewDelegate.h"

@interface SMPopViewController : UITableViewController

@property (nonatomic, retain) NSArray * array;
@property (nonatomic, assign) id <SMPopViewDelegate> delegate;

//@property (nonatomic,retain)NSArray *idArray;


@end
