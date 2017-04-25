//
//  SMOrderControllerViewController.h
//  SMProject
//
//  Created by arvin yan on 8/2/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMOrderControllerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    float total;
    int goodsCount;
}
@property (nonatomic,retain) IBOutlet UITableView * orderTableView;
@property (nonatomic,retain) IBOutlet NSMutableArray * orderArray;
@property (nonatomic,retain) IBOutlet UILabel * maxTotal;
@property (nonatomic, retain) NSString * itemType;

@end
