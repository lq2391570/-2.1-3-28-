//
//  SMPaymentController.h
//  SMProject
//
//  Created by arvin yan on 8/3/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMPaymentController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic,retain) IBOutlet UITableView * payTableView;
@property (nonatomic,retain) IBOutlet UIButton * cancelBtn;
@property (nonatomic,retain) IBOutlet UIButton * paymentBtn;
@property (nonatomic,retain) NSMutableArray * orderArray;
@property (nonatomic,retain) IBOutlet UIButton * salersBtn1;
@property (nonatomic,retain) IBOutlet UIButton * salersBtn2;
@property (nonatomic,retain) IBOutlet UIButton * salersBtn3;
@property (nonatomic,retain) IBOutlet UITextField * txt1;
@property (nonatomic,retain) IBOutlet UITextField * txt2;
@property (nonatomic,retain) IBOutlet UITextField * txt3;
@property (nonatomic,retain) IBOutlet UIButton * verifyBtn;
@property (nonatomic,retain) IBOutlet UITextField * despositTxt;
@property (nonatomic,retain) IBOutlet UITextField * bankTxt;
@property (nonatomic,retain) IBOutlet UITextField * cashTxt;
@property (nonatomic,retain) IBOutlet UITextField * businessCardTxt;
@property (nonatomic,retain) IBOutlet UITextField * busindessTxt;
@property (nonatomic,retain) IBOutlet UITextField * othersTxt;
@property (nonatomic,retain) IBOutlet UILabel * totalLabel;
@property (nonatomic, retain) NSString * itemType;
@property (nonatomic, retain) IBOutlet UILabel * tyNumber;
@property (nonatomic, retain) IBOutlet UITextField * tyTxtNumber;

@property (nonatomic, retain) IBOutlet UILabel * ldxNumber;
@property (nonatomic, retain) IBOutlet UITextField * ldxTxtNumber;

- (IBAction)salersBtnClicked:(id)sender;
- (IBAction)verifyBtnClicked:(id)sender;
- (IBAction)textFieldDidChange:(id)sender;
- (IBAction)textField3DidChange:(id)sender;

@end
