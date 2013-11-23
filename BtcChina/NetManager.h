//
//  NetManager.h
//  BtcChina
//
//  Created by xiaochuan on 13-11-23.
//  Copyright (c) 2013年 xiaochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface NetManager : NSObject
{
    AFHTTPRequestOperationManager *_client;
}
+ (NetManager *)sharedNetManager;
+ (NSString *)getSignature:(NSString *)data andKey:(NSString *)key;
- (void)test;
@end
