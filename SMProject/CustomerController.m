//
//  CustomerController.m
//  SMProject
//
//  Created by arvin yan on 10/29/14.
//  Copyright (c) 2014 石榴花科技. All rights reserved.
//

#import "CustomerController.h"
#import "CustomerCell.h"
#import "CustomerTitleCell.h"
#import "XMLmanage.h"
#import "MemberController.h"

@interface CustomerController ()

@end

@implementation CustomerController
@synthesize customerTableView = customerTableView_;
@synthesize array = array_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.array count] + 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"mycell";
    static NSString * ident = @"titlecell";
    
    if (indexPath.row == 0) {
		CustomerTitleCell *cell = (CustomerTitleCell *)[tableView dequeueReusableCellWithIdentifier:ident];
		if (cell == nil) {
			NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CustomerTitleCell" owner:self options:nil];
			for (id oneObject in nib) {
				if ([oneObject isKindOfClass:[CustomerTitleCell class]]) {
					cell = (CustomerTitleCell *)oneObject;
				}
			}
		}
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        return cell;
    }
    

    CustomerCell *custom = (CustomerCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (custom == nil)
    {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CustomerCell" owner:self options:nil];
        for (id oneObject in nib)
        {
            if ([oneObject isKindOfClass:[CustomerCell class]])
            {
                custom = (CustomerCell *)oneObject;
            }
        }
    }
    CustomersQuery * customer = [self.array objectAtIndex:indexPath.row - 1];
    custom.cardLab.text = customer.cid;
    custom.nameLab.text = customer.gsname;
    custom.selectionStyle = UITableViewCellSelectionStyleBlue;
    custom.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //if ([order.type isEqualToString:@"7"])
    //{
    
    return custom;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // int section = indexPath.section;
    if (indexPath.row == 0)
    {
        
    }
    else
    {
        
        CustomersQuery * customer = [self.array objectAtIndex:indexPath.row -1];
        MemberController * member  = [[MemberController alloc] init];
        member.query = customer.cid;
        member.cardState=customer.cardstate;
        if (customer.cid!=nil) {
             [self.navigationController pushViewController:member animated:YES];
        }
       
    }
}

- (IBAction)back:(id)sender
{
    [self.delegate changeText];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
