//
//  ServiceController.m
//  SMProject
//
//  Created by arvin yan on 10/28/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "ServiceController.h"
#import "MainCell.h"
#import "AttachedCell.h"
#import "XMLmanage.h"
#import "UploadViewController.h"

#define rootPath LocationIp
#define queryImagePath [NSString stringWithFormat:@"%@memberarchive_findMemberArchiveForNumberToIpad",LocationIp]

@interface ServiceController ()

{
    
}


@end

@implementation ServiceController

@synthesize cid = cid_;
@synthesize name = name_;
@synthesize query = query_;
@synthesize bsbtn = bsbtn_;
@synthesize shbtn = shbtn_;
@synthesize sbImage = sbImage_;
@synthesize shImage = shImage_;
@synthesize mainTable = mainTable_;
@synthesize array = array_;


 - (void)viewWillAppear:(BOOL)animated
{
    NSArray * arrays  = [[XMLmanage shardSingleton] getService:self.query withUsername:@"sanmoon" withPwd:@"sm147369"];
    
 
    self.array = [[NSMutableArray alloc] initWithArray:arrays];
    
 
    
    [super viewWillAppear:animated];
}

- (void)queryServiceImage:(NSString *)ID
{
    NSArray * arrays  = [[XMLmanage shardSingleton] getServiceImage:ID];
    NSLog(@"get service count is %d",[arrays count]);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.array = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    didSection = self.array.count+1;
    [self performSelector:@selector(firstOneClicked) withObject:self afterDelay:0.2f];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)firstOneClicked{
    didSection = 0;
    endSection = 0;
    [self didSelectCellRowFirstDo:YES nextDo:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == didSection) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"AttachedCell";
    
    AttachedCell *cell = (AttachedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"AttachedCell" owner:self options:nil];
        for (id oneObject in nib)
        {
            if ([oneObject isKindOfClass:[AttachedCell class]])
            {
                cell = (AttachedCell *)oneObject;
            }
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == didSection) {
        return 45;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *mView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    [mView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
    [logoView setImage:[UIImage imageNamed:[self.array objectAtIndex:section]]];
    [mView addSubview:logoView];
    
    if (section<self.array.count-1) {
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 109, 320, 1)];
        [lineView setImage:[UIImage imageNamed:@"XX0022"]];
        [mView addSubview:lineView];
    }
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(0, 0, 320, 110)];
    [bt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bt setTag:section];
    [bt.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [bt.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [bt.titleLabel setTextColor:[UIColor blueColor]];
    [bt addTarget:self action:@selector(addCell:) forControlEvents:UIControlEventTouchUpInside];
    [mView addSubview:bt];
    return mView;
}
- (void)addCell:(UIButton *)bt{
    endSection = bt.tag;
    if (didSection==self.array.count+1) {
        ifOpen = NO;
        didSection = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    else{
        if (didSection==endSection) {
            [self didSelectCellRowFirstDo:NO nextDo:NO];
        }
        else{
            [self didSelectCellRowFirstDo:NO nextDo:YES];
        }
    }
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert{
    [self.mainTable beginUpdates];
    NSLog(@"点击cell");
    ifOpen = firstDoInsert;
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:didSection];
    [rowToInsert addObject:indexPath];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:didSection];
    [rowToInsert addObject:indexPath1];
    if (!ifOpen) {
        didSection = self.array.count+1;
        [self.mainTable deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self.mainTable insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.mainTable endUpdates];
    if (nextDoInsert) {
        didSection = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    [self.mainTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}






//
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
//    {
//        
//        static NSString *CellIdentifier = @"MainCell";
//        
//        MainCell *cell = (MainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MainCell" owner:self options:nil];
//            for (id oneObject in nib) {
//                if ([oneObject isKindOfClass:[MainCell class]]) {
//                    cell = (MainCell *)oneObject;
//                }
//            }
//        }
//
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//
//        ServiceInfo * info  = [self.userInfoArray objectAtIndex:indexPath.row];
//        cell.titleLabel.text = info.gsnumber;
//        cell.addLabel.text = info.uname;
//        cell.nameLabel.text = info.sename;
//        cell.dateLabel.text = info.fwsj;
//       [cell.uploadBtn  addTarget:self action:@selector(btnUpload:) forControlEvents:UIControlEventTouchUpInside];
//        cell.uploadBtn.tag = indexPath.row;
//
//        return cell;
//        
//    }else if([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]){
//        
//        static NSString *CellIdentifier = @"AttachedCell";
//        
//        
//        AttachedCell *cell = (AttachedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"AttachedCell" owner:self options:nil];
//            for (id oneObject in nib) {
//                if ([oneObject isKindOfClass:[AttachedCell class]]) {
//                    cell = (AttachedCell *)oneObject;
//                }
//            }
//        }
//      
//        //self.sbImage.frame = CGRectMake(cell.sbImg.frame.origin.x, cell.sbImg.frame.origin.y, 100, 100);
//
//        //cell.sbImg = self.sbImage;
//       // cell.sbImg.image = self.sbImage.image;
//        //[cell addSubview:self.sbImage];
//        [cell.sbBtn  addTarget:self action:@selector(sbClickAction:) forControlEvents:UIControlEventTouchUpInside];
//         [cell.shBtn  addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
//       cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        return cell;
//        
//    }
//    
//    return nil;
//    
//    
//}
//
//- (void)btnUpload:(id)sender
//{
//    UIButton * uploadbtn = (UIButton *)sender;
//    NSLog(@"the tag is %d",uploadbtn.tag);
//    ServiceInfo * customer  = [self.userInfoArray objectAtIndex:uploadbtn.tag];
//   // ServiceInfo * customer = [self.tableArray objectAtIndex:uploadbtn.tag];
//    NSString * gsNumber = customer.gsnumber;
//    NSLog(@"the gsNumber is %@",customer.gsnumber);
//    NSLog(@"the name is %@",customer.sename);
//
//    //NSIndexPath *path = [NSIndexPath indexPathForRow:uploadbtn.tag inSection:0];
//    
//    UploadViewController * order = [[UploadViewController alloc] initWithNibName:@"UploadViewController" bundle:nil];
//    order.cardNo = gsNumber;
//    order.cid = self.query;
//    NSLog(@"the cid quey is %@",self.query);
//    UINavigationController * popUpNavigationController = [[UINavigationController alloc] initWithRootViewController:order];
//    
//    //order.orderArray = singlearray;
//    //settingsController.parentController = self;
//    // order.navigationController = self.popUpNavigationController;
//    popUpNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
//    popUpNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    //popUpNavigationController.navigationBar setTitleTextAttributes:[Aicent_Utility_iPad setTextAttributes];
//    
//    [self.navigationController presentViewController:popUpNavigationController animated:YES completion:nil];
//}
//
//
//
//
//
//- (IBAction)submitErrand:(id)sender
//{
//    
//    ServiceController * service = [[ServiceController alloc] init];
//    service.query = self.query;
//    [self.navigationController pushViewController:service animated:YES];
//}


@end
