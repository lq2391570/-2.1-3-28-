//
//  SMOrderSummaryController.h
//  SMProject
//
//  Created by arvin yan on 8/3/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMOrderSummaryController : UIViewController

@property (nonatomic,retain) IBOutlet UITableView * orderTableView;
@property (nonatomic,retain) NSMutableArray * summaryArray;
@property (nonatomic,retain) IBOutlet UIButton * btnCancel;
@property (nonatomic,retain) IBOutlet UIButton * btnPay;
@property (nonatomic, retain) NSString * itemType;

@end
