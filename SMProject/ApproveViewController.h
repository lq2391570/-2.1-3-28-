//
//  ApproveViewController.h
//  SMProject
//
//  Created by 石榴花科技 on 14-4-14.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ApproveViewController <NSObject>

- (void)changeRootVC;

@end

@interface ApproveViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *StorecodeTextField;
@property (nonatomic, strong) UITextField *EquipmentnameTextField;
@property (nonatomic, strong) NSString *openUDIDI;
@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) id <ApproveViewController> delegate;

@end
