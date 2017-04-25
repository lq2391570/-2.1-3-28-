//
//  FaceProblemViewController.m
//  SMProject
//
//  Created by DAIjun on 14-12-30.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "FaceProblemViewController.h"
int btnSelect;
@interface FaceProblemViewController ()

@end

@implementation FaceProblemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
//    _tempNameArray=[[NSMutableArray alloc] initWithCapacity:0];
//    FaceViewController *faceView=[[FaceViewController alloc] init];
//    [faceView postId:^(NSArray *array) {
//        for (NSDictionary *dic in array) {
//            NSDictionary *dict2=[dic objectForKey:@"facesInfo"];
//            NSString *question=[dic objectForKey:@"fname"];
//            self.label2.text=question;
//            NSString *name=[dict2 objectForKey:@"name"];
//            [_tempNameArray addObject:name];
//            
//        }
//        
//    }];
//    self.nameArray=[NSMutableArray arrayWithArray:_tempNameArray];

    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.label1.backgroundColor=[UIColor whiteColor];
    self.label2.backgroundColor=[UIColor colorWithRed:236/255.0 green:135/255.0 blue:142/255.0 alpha:1];
    self.label2.text=[self.tempLabelArray objectAtIndex:0];
    
    
    NSLog(@"%@",self.labelArray);
    for (int i=0; i<self.labelArray.count; i++) {
        int hang=i%5;
        int lie=i/5;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(107+160*hang, 138+60*lie, 135, 40)];
        [button setTitle:[self.labelArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"圣梦_面部_49.jpg"] forState:UIControlStateNormal];
        [self.view addSubview:button];
    
    }
    NSLog(@"==%@",self.nameArray);
    for (int i=0; i<self.nameArray.count; i++) {
        FacesInfo *face=[self.nameArray objectAtIndex:i];
        int hang=i%5;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(381+110*hang, 380, 100, 30)];
        [button setTitle:face.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         button.tag=i+1;
       
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"圣梦_面部_49.jpg"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
    }
    
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(431, 410, 15, 15)];
    _imageView.image=[UIImage imageNamed:@"圣梦_面部_44.png"];
    
    [self.view addSubview:_imageView];
    
    
    
    if (!self.nameArray.count) {
        
    }else{
        FacesInfo *face=[self.nameArray objectAtIndex:0];
        self.ressionLabel.text=face.ression;
        self.questionLabel.text=face.qusetion;
        self.adviseLabel.text=face.advise;
        self.imageUrl=face.imageUrl;
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        [user setObject:self.imageUrl forKey:@"imageUrl"];
        [user setObject:face.imageID forKey:@"imageID"];

        [user synchronize];
    }
    
       
    _faceColorView=[[FaceColourViewController alloc] init];
    
}
- (void)buttonClick:(UIButton *)btn
{
    
    
       switch (btn.tag) {
        case 1:{
            FacesInfo *face=[self.nameArray objectAtIndex:0];
            self.ressionLabel.text=face.ression;
            self.questionLabel.text=face.qusetion;
            self.adviseLabel.text=face.advise;
            self.imageUrl=face.imageUrl;
            NSLog(@"the click image id is %@",face.imageID);
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:self.imageUrl forKey:@"imageUrl"];
            [user setObject:face.imageID forKey:@"imageID"];

            [user synchronize];
            _faceColorView.imageUrl=face.imageUrl;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            _imageView.frame=CGRectMake(425, 410, 15, 15);
            [UIView commitAnimations];
        }
            break;
        case 2:{
            FacesInfo *face=[self.nameArray objectAtIndex:1];
            self.ressionLabel.text=face.ression;
            self.questionLabel.text=face.qusetion;
            self.adviseLabel.text=face.advise;
            self.imageUrl=face.imageUrl;
            
            NSLog(@"the click image id is %@",face.imageID);

            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:self.imageUrl forKey:@"imageUrl"];
            [user setObject:face.imageID forKey:@"imageID"];
            [user synchronize];
            _faceColorView.imageUrl=face.imageUrl;

            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            _imageView.frame=CGRectMake(431+105, 410, 15, 15);
            [UIView commitAnimations];
        }
            break;
        case 3:{
            FacesInfo *face=[self.nameArray objectAtIndex:2];
            self.ressionLabel.text=face.ression;
            self.questionLabel.text=face.qusetion;
            self.adviseLabel.text=face.advise;
            self.imageUrl=face.imageUrl;
            NSLog(@"the click image id is %@",face.imageID);

            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:self.imageUrl forKey:@"imageUrl"];
            [user setObject:face.imageID forKey:@"imageID"];
            [user synchronize];
            _faceColorView.imageUrl=face.imageUrl;

            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            _imageView.frame=CGRectMake(431+105+105, 410, 15, 15);
            [UIView commitAnimations];
        }
            break;
        case 4:{
            FacesInfo *face=[self.nameArray objectAtIndex:3];
            self.ressionLabel.text=face.ression;
            self.questionLabel.text=face.qusetion;
            self.adviseLabel.text=face.advise;
            self.imageUrl=face.advise;
            NSLog(@"the click image id is %@",face.imageID);

            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:self.imageUrl forKey:@"imageUrl"];
            [user setObject:face.imageID forKey:@"imageID"];
            [user synchronize];
            _faceColorView.imageUrl=face.imageUrl;

            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            _imageView.frame=CGRectMake(431+105+105+105, 410, 15, 15);
            [UIView commitAnimations];
        }
             break;
        case 5:{
            FacesInfo *face=[self.nameArray objectAtIndex:4];
            self.ressionLabel.text=face.ression;
            self.questionLabel.text=face.qusetion;
            self.adviseLabel.text=face.advise;
            self.imageUrl=face.imageUrl;
            NSLog(@"the click image id is %@",face.imageID);

            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:self.imageUrl forKey:@"imageUrl"];
            [user setObject:face.imageID forKey:@"imageID"];
            [user synchronize];
            _faceColorView.imageUrl=face.imageUrl;

            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            _imageView.frame=CGRectMake(431+105+105+105+105, 410, 15, 15);
            [UIView commitAnimations];
        }
            break;

        default:
            break;
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextbtnClick:(UIButton *)sender
{
    [self.navigationController pushViewController:_faceColorView animated:YES];
}
@end
