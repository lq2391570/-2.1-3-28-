//
//  FaceViewController.m
//  SMProject
//
//  Created by DAIjun on 14-12-25.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "FaceViewController.h"


#define kPopViewWidth       200
#define kPopViewHeight      120


int flag;
int selectNum=0;
int selectEye=0;
int selectForehead=0;
int selectNose=0;
int selectMandible=0;
BOOL selected;
@interface FaceViewController ()

@end

@implementation FaceViewController
@synthesize popViewController = popViewController_;
@synthesize popoverController = popoverController_;
@synthesize tel = _tel;
@synthesize src = _src;
@synthesize name = _name;
@synthesize people = _people;
@synthesize bigArray=_bigArray;
@synthesize idArray=_idArray;
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
    selectNum=0;
    selectNose=0;
    selectEye=0;
    selectForehead=0;
    selectMandible=0;
    
    

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    _faceArray=[[NSMutableArray alloc] initWithCapacity:0];
    _eyeArray=[[NSMutableArray alloc] initWithCapacity:0];
    _headArray=[[NSMutableArray alloc] initWithCapacity:0];
    _noseArray=[[NSMutableArray alloc] initWithCapacity:0];
    _mandibleArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.faceLabel.layer.cornerRadius=5;
    self.faceLabel2.layer.cornerRadius=5;
    self.faceLabel3.layer.cornerRadius=5;
    self.eyeLabel.layer.cornerRadius=5;
    self.eyeLabel2.layer.cornerRadius=5;
    self.eyeLabel3.layer.cornerRadius=5;
    self.foreheadLabel.layer.cornerRadius=5;
    self.foreheadLabel2.layer.cornerRadius=5;
    self.foreheadLabel3.layer.cornerRadius=5;
    self.noseLabel.layer.cornerRadius=5;
    self.noseLabel2.layer.cornerRadius=5;
    self.noseLabel3.layer.cornerRadius=5;
    self.mandibleLabel.layer.cornerRadius=5;
    self.mandibleLabel2.layer.cornerRadius=5;
    self.mandibleLabel3.layer.cornerRadius=5;
    _bigArray=[[NSMutableArray alloc] initWithCapacity:0];
    _idArray=[[NSMutableArray alloc] initWithCapacity:0];
    [self getData];
    
}
- (void)domainChanged:(NSString *)selectedDomain;
{
    
    if (selectNum==3) {
        return;
    }
    
    NSLog(@"the domain is %@",selectedDomain);
    selected=YES;
    if ([selectedDomain isEqualToString:@"没有"]) {
        [self.popoverController dismissPopoverAnimated:YES];
    }else{
    
    if (flag == 3) {
        if (selected==YES) {
        if (selectNum==0) {
        self.faceLabel.text = selectedDomain;
            if (self.faceLabel.text==self.faceLabel2.text||self.faceLabel.text==self.faceLabel3.text) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                self.faceLabel.text=@"";
                self.faceLabel.backgroundColor=[UIColor clearColor];
            }else{
        self.faceLabel.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
            selectNum++;
            selected=NO;
            }
            
        }
        }
        if (selected==YES) {
        if (selectNum==1) {
            self.faceLabel2.text=selectedDomain;
            if (self.faceLabel2.text==self.faceLabel.text||self.faceLabel2.text==self.faceLabel3.text) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                self.faceLabel2.text=@"";
                self.faceLabel2.backgroundColor=[UIColor clearColor];
            }else{
            self.faceLabel2.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
            selectNum++;
            selected=NO;
            }
        }
        }
        if (selected==YES) {
            if (selectNum==2) {
                self.faceLabel3.text=selectedDomain;
                if (self.faceLabel3.text==self.faceLabel.text||self.faceLabel3.text==self.faceLabel2.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.faceLabel3.text=@"";
                    self.faceLabel3.backgroundColor=[UIColor clearColor];
                }else{

                self.faceLabel3.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selected=NO;
                }
            }
        }
    }
    else if(flag==4)
    {
        if (selected==YES) {
            if (selectEye==0) {
                self.eyeLabel.text = selectedDomain;
                if (self.eyeLabel.text==self.eyeLabel2.text||self.eyeLabel.text==self.eyeLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.eyeLabel.text=@"";
                    self.eyeLabel.backgroundColor=[UIColor clearColor];
                }else{
                self.eyeLabel.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectEye++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectEye==1) {
                self.eyeLabel2.text=selectedDomain;
                if (self.eyeLabel2.text==self.eyeLabel.text||self.eyeLabel2.text==self.eyeLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.eyeLabel2.text=@"";
                    self.eyeLabel2.backgroundColor=[UIColor clearColor];
                }else{

                self.eyeLabel2.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectEye++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectEye==2) {
                self.eyeLabel3.text=selectedDomain;
                if (self.eyeLabel3.text==self.eyeLabel2.text||self.eyeLabel3.text==self.eyeLabel.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.eyeLabel3.text=@"";
                    self.eyeLabel3.backgroundColor=[UIColor clearColor];
                }else{

                self.eyeLabel3.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selected=NO;
                }
            }
        }

      
    }else if (flag==5)
    {
        if (selected==YES) {
            if (selectForehead==0) {
                self.foreheadLabel.text = selectedDomain;
                if (self.foreheadLabel.text==self.foreheadLabel2.text||self.foreheadLabel.text==self.foreheadLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.foreheadLabel.text=@"";
                    self.foreheadLabel.backgroundColor=[UIColor clearColor];

                }else{
                self.foreheadLabel.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectForehead++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectForehead==1) {
                self.foreheadLabel2.text=selectedDomain;
                if (self.foreheadLabel2.text==self.foreheadLabel.text||self.foreheadLabel2.text==self.foreheadLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.foreheadLabel2.text=@"";
                    self.foreheadLabel2.backgroundColor=[UIColor clearColor];
                    
                }else{

                self.foreheadLabel2.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectForehead++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectForehead==2) {
                self.foreheadLabel3.text=selectedDomain;
                if (self.foreheadLabel3.text==self.foreheadLabel.text||self.foreheadLabel3.text==self.foreheadLabel2.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.foreheadLabel3.text=@"";
                    self.foreheadLabel3.backgroundColor=[UIColor clearColor];
                    
                }else{

                self.foreheadLabel3.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selected=NO;
                }
            }
        }

    }
    else if (flag==6)
    {
        if (selected==YES) {
            if (selectNose==0) {
                self.noseLabel.text = selectedDomain;
                if (self.noseLabel.text==self.noseLabel2.text||self.noseLabel.text==self.noseLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.noseLabel.text=@"";
                    self.noseLabel.backgroundColor=[UIColor clearColor];
                }else{
                self.noseLabel.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectNose++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectNose==1) {
                self.noseLabel2.text=selectedDomain;
                if (self.noseLabel2.text==self.noseLabel.text||self.noseLabel2.text==self.noseLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.noseLabel2.text=@"";
                    self.noseLabel2.backgroundColor=[UIColor clearColor];
                }else{

                self.noseLabel2.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectNose++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectNose==2) {
                self.noseLabel3.text=selectedDomain;
                if (self.noseLabel3.text==self.noseLabel.text||self.noseLabel3.text==self.noseLabel2.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.noseLabel3.text=@"";
                    self.noseLabel3.backgroundColor=[UIColor clearColor];
                }else{

                self.noseLabel3.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selected=NO;
                }
            }
        }

    }
    else if (flag==7)
    {
        if (selected==YES) {
            if (selectMandible==0) {
                self.mandibleLabel.text = selectedDomain;
                if (self.mandibleLabel.text==self.mandibleLabel2.text||self.mandibleLabel.text==self.mandibleLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.mandibleLabel.text=@"";
                    self.mandibleLabel.backgroundColor=[UIColor clearColor];
                }else{
                self.mandibleLabel.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectMandible++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectMandible==1) {
                self.mandibleLabel2.text=selectedDomain;
              
                if (self.mandibleLabel2.text==self.mandibleLabel.text||self.mandibleLabel2.text==self.mandibleLabel3.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.mandibleLabel2.text=@"";
                    self.mandibleLabel2.backgroundColor=[UIColor clearColor];
                }else{

                self.mandibleLabel2.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selectMandible++;
                selected=NO;
                }
            }
        }
        if (selected==YES) {
            if (selectMandible==2) {
                self.mandibleLabel3.text=selectedDomain;
                if (self.mandibleLabel3.text==self.mandibleLabel.text||self.mandibleLabel3.text==self.mandibleLabel2.text) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"所选项目不能重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    self.mandibleLabel3.text=@"";
                    self.mandibleLabel3.backgroundColor=[UIColor clearColor];
                }else{

                self.mandibleLabel3.backgroundColor=[UIColor colorWithRed:250/255.0 green:179/255.0 blue:218/255.0 alpha:0.8];
                selected=NO;
                }
            }
        }

    }
    
     if (self.popoverController != nil)
    {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}
}
-(void)popDomainView:(int)y array:(NSMutableArray *)popArray
{
   // int i;
    
    if (self.popViewController == nil)
    {
        self.popViewController = [[SMPopViewController alloc] initWithStyle:UITableViewStylePlain];
    }
  //  NSMutableArray * popArray;
 
    self.popViewController.array = popArray;
   
    
    self.popViewController.delegate = self;
    CGRect pickFrame = CGRectMake(250, y, kPopViewWidth, kPopViewHeight);
    if (self.popoverController == nil)
    {
        Class classPopoverController = NSClassFromString(@"UIPopoverController");
        if (classPopoverController)
        {
            self.popoverController = [[classPopoverController alloc] initWithContentViewController:self.popViewController];
        }
    }
    [self.popoverController presentPopoverFromRect:pickFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


- (void)getProblem:(void (^) (NSArray *array))complete
{
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@findAllFacesTypeYmpToIpad",LocationIp]]];
    [request setCompletionBlock:^{
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[dic objectForKey:@"data"];
        if (array) {
            complete(array);
        }
        
    }];
    [request setFailedBlock:^{
       
        NSLog(@"%@",request.error);
        
    }];
    [request startAsynchronous];
  
    
    
}
- (void)getData
{
    
    [self getProblem:^(NSArray *array) {
        self.idArray=[NSMutableArray arrayWithArray:array];
        for (NSDictionary *dic in array) {
             NSDictionary *dic2=[dic objectForKey:@"facesType"];
             NSString *str=[dic2 objectForKey:@"name"];
            // NSString *idStr=[dic objectForKey:@"id"];
            // [_idArray addObject:idStr];
            if ([str isEqualToString:@"面部问题"]) {
                NSString *fName=[dic objectForKey:@"name"];
                
                [_faceArray addObject:fName];
                
                            }
            if ([str isEqualToString:@"眼部问题"]) {
                NSString *fName=[dic objectForKey:@"name"];
                [_eyeArray addObject:fName];
                            }
            if ([str isEqualToString:@"额头问题"]) {
                
                NSString *fName=[dic objectForKey:@"name"];
                [_headArray addObject:fName];
                            }
            if ([str isEqualToString:@"鼻部问题"]) {
                
                NSString *fName=[dic objectForKey:@"name"];
                [_noseArray addObject:fName];
                            }
            if ([str isEqualToString:@"下颌问题"]) {
                
                NSString *fName=[dic objectForKey:@"name"];
                [_mandibleArray addObject:fName];
                
            }
         
        }
        [_bigArray addObject:_faceArray];
        [_bigArray addObject:_eyeArray];
        [_bigArray addObject:_headArray];
        [_bigArray addObject:_noseArray];
        [_bigArray addObject:_mandibleArray];

    }];
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender
{
    if (!_bigArray.count) {
        
        return;
    }

    switch (sender.tag) {
        case 1:
        {
            flag=3;
                    NSMutableArray *array=[NSMutableArray arrayWithArray:[_bigArray objectAtIndex:0]];
            [self popDomainView:60 array:array];
        }
            break;
       case 2:
        {
            flag=4;
        NSMutableArray *array=[NSMutableArray arrayWithArray:[_bigArray objectAtIndex:1]];
            [self popDomainView:140 array:array];
            
        }
            break;
        case 3:
        {
            flag=5;
        NSMutableArray *array=[NSMutableArray arrayWithArray:[_bigArray objectAtIndex:2]];
            [self popDomainView:240 array:array];
        }
            break;
        case 4:
        {
            NSMutableArray *array=[NSMutableArray arrayWithArray:[_bigArray objectAtIndex:3]];
            flag=6;
            [self popDomainView:300 array:array];
        }
            break;
        case 5:
        {
            NSMutableArray *array=[NSMutableArray arrayWithArray:[_bigArray objectAtIndex:4]];
            flag=7;
            [self popDomainView:385 array:array];
        }
            break;

        default:
            break;
    }
    
    
}

- (IBAction)nextBtnClick:(UIButton *)sender
{
    
    
    FaceProblemViewController *faceProblemViewController=[[FaceProblemViewController alloc] init];
    NSArray *array=@[self.faceLabel.text,self.faceLabel2.text,self.faceLabel3.text,self.eyeLabel.text,self.eyeLabel2.text,self.eyeLabel3.text,self.foreheadLabel.text,self.foreheadLabel2.text,self.foreheadLabel3.text,self.noseLabel.text,self.noseLabel2.text,self.noseLabel3.text,self.mandibleLabel.text,self.mandibleLabel2.text,self.mandibleLabel3.text];
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *test in array) {
        if ([test isEqualToString:@""]) {
        }else{
            [tempArray addObject:test];
        }
    }
    _tempIdArray=[[NSMutableArray alloc] initWithCapacity:0];
  //  _tempNameArray=[[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in _idArray) {
            NSString *name=[dic objectForKey:@"name"];
        if ([tempArray containsObject:name]) {
            NSLog(@"--%@",name);
            if (name) {
                NSString *idName=[dic objectForKey:@"id"];
                [_tempIdArray addObject:idName];
        }
        
    }
        
    }
    NSLog(@"==%@",_tempIdArray);
   // NSMutableArray *tempArray2=[[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"===---%@",tempArray);
    faceProblemViewController.labelArray=[NSMutableArray arrayWithArray:tempArray];
    faceProblemViewController.nameArray=[[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"__%@==",faceProblemViewController.nameArray);
   // [self getDataOfName];
    NSMutableArray *tempArray2=[[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *tempArray3=[[NSMutableArray alloc] initWithCapacity:0];
    
    [self postId:^(NSArray *array) {
        if (!array.count) {
            
        }else{
        for (NSDictionary *dic in array) {
            NSString *question=[dic objectForKey:@"name"];
            if (!question) {
                
            }else{
                [tempArray3 addObject:question];
            }
            FacesInfo *face=[[FacesInfo alloc] init];
            NSDictionary *dict2=[dic objectForKey:@"facesInfo"];
            NSLog(@"%@",question);
            NSLog(@"==%@",faceProblemViewController.label2.text);
        //    NSString *name=[dict2 objectForKey:@"name"];
            face.name=[dict2 objectForKey:@"name"];
            face.ression=[dict2 objectForKey:@"ression"];
            face.qusetion=[dict2 objectForKey:@"question"];
            face.advise=[dict2 objectForKey:@"advise"];
            face.imageUrl=[dict2 objectForKey:@"solution"];
            face.imageID=[dict2 objectForKey:@"id"];
            NSLog(@"Get the normal image id is %@",face.imageID);
            
            if (!face.name&&!face.ression&&!face.qusetion&&!face.advise&&!face.imageUrl) {
                
            }else{
                
                [tempArray2 addObject:face];
            }
           
        }
        NSLog(@"--%@",tempArray3);
        faceProblemViewController.tempLabelArray=[NSMutableArray arrayWithArray:tempArray3];
         faceProblemViewController.nameArray=[NSMutableArray arrayWithArray:tempArray2];
             [self.navigationController pushViewController:faceProblemViewController animated:YES];
        }
    }];
    
    
    
   
    
}
- (void)getDataOfName
{
   
}
- (void)postId:(void (^) (NSArray *array))complete
{
 //   NSURL *url=[NSURL URLWithString:@"http://192.168.0.112:8080/Sanmoon1.0/findFacesQuestionAndTypeToIpad"];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@findFacesQuestionAndTypeToIpad",LocationIp]];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    NSMutableString *bigStr=[[NSMutableString alloc] init];
    for (int i=0; i<_tempIdArray.count; i++) {
        NSString *str=[_tempIdArray objectAtIndex:i];
             if (i==0) {
            [bigStr appendString:[NSString stringWithFormat:@"%@",str]];
        }else{
            
        
        [bigStr appendString:[NSString stringWithFormat:@",%@",str]];
        }
    }
    NSLog(@"%@",bigStr);
    [request addPostValue:bigStr forKey:@"facesYmpIds"];
    
  //  NSLog(@"%@",set);
    NSLog(@"++%@",url);
    
    
    [request setTimeOutSeconds:15];
  //  [request setRequestMethod:@"post"];
    [request setCompletionBlock:^{
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[dic objectForKey:@"data"];
        NSString *message=[dic objectForKey:@"message"];
        NSLog(@"%@",message);
        NSLog(@"--%@",dic);
        NSLog(@"==%@",array);
//        if ([message isEqualToString:@"请求数据成功！"]) {
            if (array) {
                complete(array);
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
//
        
       }];
    
    [request setFailedBlock:^{
        NSLog(@"%@",request.error);
    }];
    [request startSynchronous];
    
    
}

- (IBAction)deleteBtnClick:(UIButton *)sender
{
    if (sender.tag==1) {
        if (![self.faceLabel.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=1;
            [alert show];
        }
    }else if (sender.tag==2){
        if (![self.faceLabel2.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=2;
            [alert show];
        }

    }else if (sender.tag==3){
        if (![self.faceLabel3.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=3;
            [alert show];
        }
    }else if (sender.tag==4){
        if (![self.eyeLabel.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=4;
            [alert show];
        }

    }else if (sender.tag==5){
        if (![self.eyeLabel2.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=5;
            [alert show];
        }

    }else if (sender.tag==6){
        if (![self.eyeLabel3.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=6;
            [alert show];
        }
    }else if (sender.tag==7){
        if (![self.foreheadLabel.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=7;
            [alert show];
        }

    }else if (sender.tag==8){
        if (![self.foreheadLabel2.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=8;
            [alert show];
        }

    }else if (sender.tag==9){
        if (![self.foreheadLabel3.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=9;
            [alert show];
        }

    }else if (sender.tag==10){
        if (![self.noseLabel.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=10;
            [alert show];
        }

    }else if (sender.tag==11){
        if (![self.noseLabel2.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=11;
            [alert show];
        }

    }else if (sender.tag==12){
        if (![self.noseLabel3.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=12;
            [alert show];
        }

    }else if (sender.tag==13){
        if (![self.mandibleLabel.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=13;
            [alert show];
        }

    }else if (sender.tag==14){
        if (![self.mandibleLabel2.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=14;
            [alert show];
        }

    }else if (sender.tag==15){
        if (![self.mandibleLabel3.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除此项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag=15;
            [alert show];
        }

    }
    
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1:
            if (buttonIndex==0) {
                self.faceLabel.text = @"";
                self.faceLabel.backgroundColor=[UIColor clearColor];
                selectNum=0;
            }
            break;
        case 2:
            if (buttonIndex==0) {
                self.faceLabel2.text = @"";
                self.faceLabel2.backgroundColor=[UIColor clearColor];
                selectNum=1;
            }
            break;
        case 3:
            if (buttonIndex==0) {
                self.faceLabel3.text = @"";
                self.faceLabel3.backgroundColor=[UIColor clearColor];
                selectNum=2;
            }
            break;
        case 4:
            if (buttonIndex==0) {
                self.eyeLabel.text = @"";
                self.eyeLabel.backgroundColor=[UIColor clearColor];
                selectEye=0;
            }
            break;
        case 5:
            if (buttonIndex==0) {
                self.eyeLabel2.text = @"";
                self.eyeLabel2.backgroundColor=[UIColor clearColor];
                selectEye=1;
            }
            break;
        case 6:
            if (buttonIndex==0) {
                self.eyeLabel3.text = @"";
                self.eyeLabel3.backgroundColor=[UIColor clearColor];
                selectEye=2;
            }
            break;
        case 7:
            if (buttonIndex==0) {
                self.foreheadLabel.text = @"";
                self.foreheadLabel.backgroundColor=[UIColor clearColor];
                selectForehead=0;
            }
            break;
        case 8:
            if (buttonIndex==0) {
                self.foreheadLabel2.text = @"";
                self.foreheadLabel2.backgroundColor=[UIColor clearColor];
                selectForehead=1;
            }
            break;
        case 9:
            if (buttonIndex==0) {
                self.foreheadLabel3.text = @"";
                self.foreheadLabel3.backgroundColor=[UIColor clearColor];
                selectForehead=2;
            }
            break;
        case 10:
            if (buttonIndex==0) {
                self.noseLabel.text = @"";
                self.noseLabel.backgroundColor=[UIColor clearColor];
                selectNose=0;
            }
            break;
        case 11:
            if (buttonIndex==0) {
                self.noseLabel2.text = @"";
                self.noseLabel2.backgroundColor=[UIColor clearColor];
                selectNose=1;
            }
            break;
        case 12:
            if (buttonIndex==0) {
                self.noseLabel3.text = @"";
                self.noseLabel3.backgroundColor=[UIColor clearColor];
                selectNose=2;
            }
            break;
        case 13:
            if (buttonIndex==0) {
                self.mandibleLabel.text = @"";
                self.mandibleLabel.backgroundColor=[UIColor clearColor];
                selectMandible=0;
            }
            break;
        case 14:
            if (buttonIndex==0) {
                self.mandibleLabel2.text = @"";
                self.mandibleLabel2.backgroundColor=[UIColor clearColor];
                selectMandible=1;
            }
            break;
        case 15:
            if (buttonIndex==0) {
                self.mandibleLabel3.text = @"";
                self.mandibleLabel3.backgroundColor=[UIColor clearColor];
                selectMandible=2;
            }
            break;
        default:
            break;
   
    }
    
}
@end
