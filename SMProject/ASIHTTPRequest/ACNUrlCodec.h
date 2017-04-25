//
//  ACNUrlCodec.h
//  roaming
//
//  Created by Eason Yang on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ACNUrlCodec : NSObject {

}

+ (NSString *) urlEncode: (NSString *) url;
+ (NSString *) urlDecode: (NSString *) url;

@end
