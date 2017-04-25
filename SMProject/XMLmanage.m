//
//  XMLmanage.m
//  SMProject
//
//  Created by 石榴花科技 on 14-7-9.
//  Copyright (c) 2014年 石榴花科技. All rights reserved.
//

#import "XMLmanage.h"
#import "SVProgressHUD.h"
#import "ASIHTTPRequest.h"
@implementation CustomerSrc

@synthesize tname = _tname;
@synthesize tkey = _tkey;

- (CustomerSrc *)init
{
    self = [super init];
    return self;
}

@end

@implementation Information

@synthesize name = _name;
@synthesize price = _price;
@synthesize rate = _rate;
@synthesize ID = _ID;
@synthesize produceDate = _produceDate;
@synthesize times = _times;
@synthesize skpmount = skpmount_;

- (Information *)init
{
    self = [super init];
    return self;
}

@end

@implementation ServicePhotoInfo

@synthesize archiveImageUrl = archiveImageUrl_;
@synthesize archiveState = archiveState_;

- (ServicePhotoInfo *)init
{
    self = [super init];
    return self;
}

@end

@implementation CustomersQuery

@synthesize cardstate = cardstate_;
@synthesize cid = cid_;
@synthesize gsname = gsname_;
@synthesize usid = usid_;

- (CustomersQuery *)init
{
    self = [super init];
    return self;
}

@end

@implementation CustomersInfo

@synthesize gid = gid_;
@synthesize dabh = dabh_;
@synthesize jdsj = jdsj_;
@synthesize gname = gname_;
@synthesize gfancy = gfancy_;
@synthesize lasttime = lasttime_;
@synthesize sfgm = sfgm_;
@synthesize grequest = grequest_;

- (CustomersInfo *)init
{
    self = [super init];
    return self;
}

@end

@implementation ServiceInfo

@synthesize fwsj = fwsj_;
@synthesize gsnumber = gsnumber_;
@synthesize iname = iname_;
@synthesize sename = sename_;
@synthesize cardNo;
@synthesize cardState;

- (ServiceInfo *)init
{
    self = [super init];
    return self;
}

@end

@implementation PayInfo

@synthesize usid = usid_;
@synthesize umid = umid_;
@synthesize cid = cid_;
@synthesize seid = seid_;
@synthesize seid2 = seid2_;
@synthesize seid3 = seid3_;
@synthesize semoney2 = semoney2_;
@synthesize semoney3 = semoney3_;
@synthesize zje = zje_;
@synthesize yfkje = yfkje_;
@synthesize ssje = ssje_;
@synthesize stkje = stkje_;
@synthesize qtje = qtje_;
@synthesize xjje = xjje_;
@synthesize yhkje = yhkje_;
@synthesize zlje = zlje_;

- (PayInfo *)init
{
    self = [super init];
    return self;
}

@end

@implementation XMLmanage

+ (id)shardSingleton
{
    static dispatch_once_t pred;
    static Information *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return  instance;
}

- (Information *)analysisXMLWithID:(NSString *)ID withUSID:(NSString *)usid withtype:(int)type
{
    NSURL *url;
    NSLog(@"type is %d",type);
//type==0
    if (type==0) {
        url = [NSURL URLWithString:GETITEMTPROMOTION];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        [request setHTTPMethod:@"POST"];
        NSString *requestdata = [NSString stringWithFormat:@"iid=%@&usid=%@&username=sanmoon&userpass=sm147369",ID,usid];
        NSLog(@"requestdata is %@",requestdata);
        
        NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"jsondict is %@",jsonDict);
        Information *info = [[Information alloc] init];
        for (NSDictionary *dic in jsonDict) {
            info.name = [dic objectForKey:@"iname"];
            info.price = [dic objectForKey:@"iprice"];
            info.rate = [dic objectForKey:@"irate"];
            info.times = [dic objectForKey:@"times"];
            info.ID = [dic objectForKey:@"iid"];
        }
        
        return info;
        
    }

    
    
    if (type==2) {
        url = [NSURL URLWithString:GETITEMTPROMOTION];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        [request setHTTPMethod:@"POST"];
        NSString *requestdata = [NSString stringWithFormat:@"iid=%@&usid=%@&username=sanmoon&userpass=sm147369",ID,usid];
        NSLog(@"requestdata is %@",requestdata);
        
        NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"jsondict is %@",jsonDict);
        Information *info = [[Information alloc] init];
        for (NSDictionary *dic in jsonDict) {
            info.name = [dic objectForKey:@"iname"];
            info.price = [dic objectForKey:@"iprice"];
            info.rate = [dic objectForKey:@"irate"];
            info.times = [dic objectForKey:@"times"];
            info.ID = [dic objectForKey:@"iid"];
        }
        
        return info;

    }
    
    
    //解析项目的数据
    if (type == 6) {
        url = [NSURL URLWithString:GETITEMTPROMOTION];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        [request setHTTPMethod:@"POST"];
        NSString *requestdata = [NSString stringWithFormat:@"iid=%@&usid=%@&username=sanmoon&userpass=sm147369",ID,usid];
        NSLog(@"requestdata is %@",requestdata);

        NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"jsondict is %@",jsonDict);
        Information *info = [[Information alloc] init];
        for (NSDictionary *dic in jsonDict) {
            info.name = [dic objectForKey:@"iname"];
            info.price = [dic objectForKey:@"iprice"];
            info.rate = [dic objectForKey:@"irate"];
            info.times = [dic objectForKey:@"times"];
            info.ID = [dic objectForKey:@"iid"];
        }
        
        return info;
     //解析产品的数据
    }else if (type == 7)
    {
        url = [NSURL URLWithString:GETPRODUCTROMOTION];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        [request setHTTPMethod:@"POST"];
        NSString *requestdata = [NSString stringWithFormat:@"pid=%@&usid=%@&username=sanmoon&userpass=sm147369",ID,usid];
        NSLog(@"requestdata is %@",requestdata);

        NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"jsondata is %@",requestdata);

        NSError *error = nil;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"jsondict is %@",jsonDict);
        NSString * produceDate;
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
        Information *info = [[Information alloc] init];

        for (NSDictionary *dic in jsonDict) {
            info.name = [dic objectForKey:@"pname"];
            info.price = [dic objectForKey:@"pprice"];
            info.rate = [dic objectForKey:@"prate"];
            [array addObject:[dic objectForKey:@"producedate"]];
            NSLog(@"producedate is %@",[dic objectForKey:@"producedate"]);
            //[array addObject:[dic objectForKey:@"producedate"]];
            info.ID = [dic objectForKey:@"pid"];
            info.skpmount = [dic objectForKey:@"skamount"];
            //NSLog(@"the pamount is %@",);

        }
        info.produceDate = [NSArray arrayWithArray:array];
        return info;
        
    }else
    {
        return nil;
    }

}

- (NSString *)CheckUserInfonWithCid:(NSString *)cid withPassWord:(NSString *)Password
{
    NSURL *url = [NSURL URLWithString:GETUSERINFON];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"cid=%@&pass=%@&username=sanmoon&userpass=sm147369",cid,Password];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];

    NSLog(@"this is login value %@",[rootElement stringValue]);
    return [rootElement stringValue];
}

- (NSArray *)getSalers:(NSString *)no withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:EMPURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"usid=%@&username=%@&userpass=%@",no,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"jsondict is %@",jsonDict);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    for (NSDictionary *dic in jsonDict) {
        Information *info = [[Information alloc] init];

        info.name = [dic objectForKey:@"sename"];
        info.ID = [dic objectForKey:@"seid"];
        [array addObject:info];

    }
    return array;
}


- (NSMutableArray *)getCustomerSrc
{
    NSURL *url = [NSURL URLWithString:QueryCustomerSrc];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"username=sanmoon&userpass=sm147369"];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"jsondict is %@",jsonDict);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    for (NSDictionary *dic in jsonDict) {
        CustomerSrc *info = [[CustomerSrc alloc] init];
        
        info.tname = [dic objectForKey:@"lyname"];
        NSLog(@"the test name is %@",info.tname);
        info.tkey = [dic objectForKey:@"lyid"];
        [array addObject:info];
        
    }
    return array;
}


- (NSMutableArray *)getPeopleWithCID:(NSString *)cid
{
    NSURL *url = [NSURL URLWithString:QueryPeople];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"usid=%@&username=sanmoon&userpass=sm147369",cid];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"jsondict is %@",jsonDict);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    for (NSDictionary *dic in jsonDict) {
        CustomerSrc *info = [[CustomerSrc alloc] init];
        
        info.tname = [dic objectForKey:@"sename"];
        info.tkey = [dic objectForKey:@"seid"];
        [array addObject:info];
        
    }
    return array;
}

- (NSString *)getAdvance:(NSString *)no withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:ADVURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"cid=%@&username=%@&userpass=%@",no,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"this is login value %@",[rootElement stringValue]);
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSString * deposit;
    NSLog(@"jsondict is %@",jsonDict);
    for (NSDictionary *dic in jsonDict) {
       deposit = [dic objectForKey:@"advmoney"];
    }

    return deposit;
}

- (NSString *)submitPayment:(NSString *)pay
{
    NSURL *url = [NSURL URLWithString:SaleURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"%@",pay];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"this is login value %@",[rootElement stringValue]);
    return [rootElement stringValue];
}

- (NSArray *)getGuestInfo:(NSString *)no withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:QueryID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"cid=%@&username=%@&userpass=%@",no,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"this is login value %@",[rootElement stringValue]);
    

    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSString * deposit;

    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
   
    
    for (NSDictionary *dic in jsonDict) {
        CustomersQuery *info = [[CustomersQuery alloc] init];
        
        info.cardstate = [dic objectForKey:@"cardstate"];
        info.cid = [dic objectForKey:@"cid"];
        info.gsname= [dic objectForKey:@"gname"];
        info.usid = [dic objectForKey:@"usid"];
                    [array addObject:info];
        
        
       
        
    }
    
    return array;
    
}

- (NSMutableArray *)getGuestInfoWithName:(NSString *)name withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:QueryName];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"gname=%@&username=%@&userpass=%@",name,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"===%@",jsonDict);
    NSString * deposit;
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
    NSString *usid=[users objectForKey:@"name"];
    for (NSDictionary *dic in jsonDict) {
        CustomersQuery *info = [[CustomersQuery alloc] init];
        
        info.cardstate = [dic objectForKey:@"cardstate"];
        info.cid = [dic objectForKey:@"cid"];
        info.gsname= [dic objectForKey:@"gname"];
        info.usid = [dic objectForKey:@"usid"];
        if ([info.usid isEqualToString:usid]) {
             [array addObject:info];
        }
       

    }
    return array;
}
//精确查询接口
- (NSMutableArray *)getGuestInfoWithName2:(NSString *)name withUsername:(NSString *)username withPwd:(NSString *)pwd cardNum:(NSString *)cardNum
{
    NSURL *url = [NSURL URLWithString:QueryName];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"gname=%@&username=%@&userpass=%@",name,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"===%@",jsonDict);
    NSString * deposit;
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
    NSString *usid=[users objectForKey:@"name"];
    for (NSDictionary *dic in jsonDict) {
        CustomersQuery *info = [[CustomersQuery alloc] init];
        
        info.cardstate = [dic objectForKey:@"cardstate"];
        info.cid = [dic objectForKey:@"cid"];
        info.gsname= [dic objectForKey:@"gname"];
        info.usid = [dic objectForKey:@"usid"];
        
        if ([info.cid isEqualToString:cardNum]) {
            [array addObject:info];
        }
        
        
    }
    return array;
}

- (NSArray *)getGSNumber:(NSString *)no withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:QueryNumber];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"cid=%@&username=%@&userpass=%@",no,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"this is login value %@",[rootElement stringValue]);
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"jsondict is %@",jsonDict);
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    for (NSDictionary *dic in jsonDict) {
        CustomersInfo *info = [[CustomersInfo alloc] init];
        
        info.gid = [dic objectForKey:@"gid"];
        info.dabh = [dic objectForKey:@"dnbh"];
        info.jdsj = [dic objectForKey:@"jdsj"];
        info.gname = [dic objectForKey:@"gname"];
        info.gfancy = [dic objectForKey:@"gfancy"];
        info.lasttime = [dic objectForKey:@"lasttime"];
        info.sfgm = [dic objectForKey:@"sfgm"];
        info.grequest = [dic objectForKey:@"grequest"];
        [array addObject:info];
        
    }
    return array;
}

- (NSArray *)getService:(NSString *)no withUsername:(NSString *)username withPwd:(NSString *)pwd
{
    NSURL *url = [NSURL URLWithString:QueryService];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [request setHTTPMethod:@"POST"];
    NSString *requestdata = [NSString stringWithFormat:@"cid=%@&username=%@&userpass=%@",no,username,pwd];
    NSData *data = [requestdata dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is %@",data);
    [request setHTTPBody:data];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:received options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"this is login value %@",[rootElement stringValue]);
    
    NSData * jsondata = [[rootElement stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsondata is %@",requestdata);
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"jsondict is %@",jsonDict);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
#pragma mark 修改
    for (NSDictionary *dic in jsonDict) {
        ServiceInfo *info = [[ServiceInfo alloc] init];
        
        info.fwsj = [dic objectForKey:@"fwsj"];
        
        info.gsnumber = [dic objectForKey:@"gsnumber"];
        NSLog(@"query number is %@",info.gsnumber);
        
    
        info.iname = [dic objectForKey:@"iname"];
        NSLog(@"%@==--",info.iname);
        info.sename = [dic objectForKey:@"sename"];
        info.uname = [dic objectForKey:@"uname"];
        info.cardNo = [dic objectForKey:@"memberCard"];
        info.cardState = [dic objectForKey:@"archiveState"];
//        if ([info.fwsj rangeOfString:@"2011"].location!=NSNotFound||[info.fwsj rangeOfString:@"2012"].location!=NSNotFound||[info.fwsj rangeOfString:@"2010"].location!=NSNotFound||[info.fwsj rangeOfString:@"2009"].location!=NSNotFound||[info.fwsj rangeOfString:@"2008"].location!=NSNotFound||[info.fwsj rangeOfString:@"2007"].location!=NSNotFound) {
//            
//        }else{
            [array addObject:info];
//        }
        
    }
    return array;
}




- (NSArray *)getServiceImage:(NSString *)serviceID {
    
   // [SVProgressHUD showWithStatus:@"请稍等"];
//    NSLog(@"the srvice id is %@",serviceID);
    NSString *url = [NSString stringWithFormat:@"%@%@%@",QueryServiceImage,@"memberArchive.archiveNumber=",serviceID];
//    NSThread *myThread=[[NSThread alloc] initWithTarget:self selector:@selector(newThread:) object:url];
//    [myThread start];
   // NSArray *array=[self onMainThread:array];
    NSArray * array = [self jsonParseWithURL:url];
 //   NSArray *array=[self onMainThread:array2];
 //   NSArray *array=[self onMainThread:nil];
//    NSMutableArray * noticeArray = [NSMutableArray arrayWithCapacity:10];
//    for(NSDictionary * item in array) {
//         NSLog(@"Item: %@", item);
//
//        [noticeArray addObject:[item objectForKey:@"archiveImageUrl"]];
//        [noticeArray addObject:[item objectForKey:@"archiveState"]];
//
//    }
  //  NSArray *array=[_tempArray objectAtIndex:0];
  //  NSLog(@"%d-=-=",array.count);
    return array;
}
//- (void)newThread:(NSString *)url
//{
//    NSArray *array=[self jsonParseWithURL:url];
//   // NSArray *array2=[self jsonParseWithURL:url];
//       NSLog(@"==-=%@",url);
//    [self performSelectorOnMainThread:@selector(onMainThread:) withObject:array waitUntilDone:NO];
//    
//}
//- (void)onMainThread:(NSArray *)array
//{
//    NSArray *array1=array;
//    
//   _tempArray=[[NSMutableArray alloc] initWithCapacity:0];
//    [_tempArray addObject:array1];
//   
//    
//}
#pragma mark 修改
- (NSString *)getUserImage:(NSString *)ID {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",QueryUserImage,@"memberInfo.memberCard=",ID];
    
    NSDictionary * item = [self jsonsParseWithURL:url];
    NSString * imageName;
//    int result = (int)[item objectForKey:@"result"];
//    NSLog(@"the result is %d",result);
//    if (result) {
       imageName = [item objectForKey:@"headPortraits"];
//    }
//    else
//    {
//       imageName = @"";
//    }
    return imageName;
}

- (NSString *)getBodyDescription:(NSString *)ID{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",QueryBodyDescription,@"bodyCare.bodyCareIndex=",ID];
    
    NSDictionary * dict = [self jsonsParseWithURL:url];
    NSString * description;
    if (dict) {
        description = [dict objectForKey:@"desp"];
    }
    else
    {
        description = @"";
    }
    return description;
}

- (NSString *)getBodyDescription:(NSString *)ID withColor:(NSString *)color {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@",QueryBodyDescription,@"bodyCare.markColor=",color,@"&",@"bodyCare.bodyCareIndex=",ID];
    
   NSDictionary * dict = [self jsonsParseWithURL:url];
    NSString * description;
    if (dict) {
        description = [dict objectForKey:@"desp"];
    }
    else
    {
        description = @"";
    }
    return description;
}

- (NSDictionary *)getBodySummary:(NSString *)ID withColor:(NSString *)color {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@",QueryBodyDescription,@"bodyCare.markColor=",color,@"&",@"bodyCare.bodyCareIndex=",ID];
    
    NSDictionary * dict = [self jsonsParseWithURL:url];
  
    return dict;
}

- (NSArray *)jsonParseWithURL:(NSString *)imageUrl
{
  //  [SVProgressHUD show];
    NSError * error = nil;
    
    NSLog(@"the url is %@",imageUrl);
    //初始化 url
    NSURL* url = [NSURL URLWithString:imageUrl];
    //将文件内容读取到字符串中，
    NSString * jsonString = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"the json string is %@ error is %@",jsonString,error.localizedDescription);
    //将字符串写到缓冲区。
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
    NSLog(@"the relpace json string is %@ error is %@",jsonString,error.localizedDescription);
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSLog(@" the id %@",jsonDict);
    
    if (!jsonDict || error) {
        NSLog(@"JSON parse failed!");
    }
    return jsonDict;
    
}
//xiaotu
+ (void)xiaotu:(void (^)(NSMutableArray *array))complete gusNum:(NSString *)gusNum
{
//    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",QueryServiceImage,@"memberArchive.archiveNumber=",gusNum]]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@memberarchive_findMemberArchiveForNumberToIpad?%@%@",LocationIp,@"memberArchive.archiveNumber=",gusNum]]];
    
    
    [request setCompletionBlock:^{
        NSArray *dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic= %@",dic);
         NSMutableArray *tempArray=[[NSMutableArray alloc] initWithCapacity:0];
        NSLog(@"json=%@",request.responseString);
       
            for (int i=0; i<dic.count; i++) {
                 ImageModelBaseClass *bassClass=[ImageModelBaseClass modelObjectWithDictionary:dic[i]];
                
                [tempArray addObject:bassClass];
            }
        
        
        NSLog(@"tempArray=%@",tempArray);
        
       
      //  NSLog(@"bassClass=%@",bassClass);
        
        
       
        
        if (complete) {
            complete(tempArray);
        }
        
    }];
    [request startAsynchronous];
}



- (NSDictionary *)jsonsParseWithURL:(NSString *)imageUrl
{
    NSError * error = nil;
    
    NSLog(@"the url is %@",imageUrl);
    //初始化 url
    NSURL* url = [NSURL URLWithString:imageUrl];
    //将文件内容读取到字符串中，
    NSString * jsonString = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"the json string is %@ error is %@",jsonString,error.localizedDescription);
    //将字符串写到缓冲区。
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
    NSLog(@"the relpace json string is %@ error is %@",jsonString,error.localizedDescription);
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSLog(@" the id %@",jsonDict);
    
    if (!jsonDict || error) {
        NSLog(@"JSON parse failed!");
    }
    return jsonDict;
    
}
@end
