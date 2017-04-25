//
//  CustomerController.h
//  SMProject
//
//  Created by arvin yan on 10/29/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myTextDelegate
-(void)changeText;

@end

@interface CustomerController : UIViewController<UITableViewDataSource,UITableViewDelegate>


//卡状态
@property (nonatomic,strong)NSString *cardState;

@property (nonatomic,retain) IBOutlet UITableView * customerTableView;
@property (nonatomic,retain) NSArray * array;
@property (nonatomic,assign)id<myTextDelegate>delegate;
@end
