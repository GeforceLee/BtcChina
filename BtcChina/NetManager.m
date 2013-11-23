//
//  NetManager.m
//  BtcChina
//
//  Created by xiaochuan on 13-11-23.
//  Copyright (c) 2013年 xiaochuan. All rights reserved.
//

#import "NetManager.h"

#import "CocoaSecurity.h"
#define ACCESS_KEY @"282c9a10-0a3e-4024-9648-d1c262afe576"
#define SECRET_KEY @"b290b2f4-97dd-4d89-aa97-f5187cee1f40"

@implementation NetManager


+ (NetManager *)sharedNetManager{
    static NetManager *netManager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netManager = [[NetManager alloc] init];
    });
    return netManager;
}


+ (NSString *)getSignature:(NSString *)data andKey:(NSString *)key{
    CocoaSecurityResult *d = [CocoaSecurity hmacSha1:data hmacKey:key];
    
//    NSString *sing  =[[NSString alloc] initWithData:d.data encoding:NSUTF8StringEncoding] ;
//    NSString *to = [NSString stringWithFormat:@"%@:%@",ACCESS_KEY,sing];
//    CocoaSecurityEncoder *encoder = [CocoaSecurityEncoder new];
    return d.hex;
    
//    return     [encoder base64:[to dataUsingEncoding:NSUTF8StringEncoding]];
}

- (id)init{
    
    if (self = [super init]) {
        _client = [AFHTTPRequestOperationManager manager];
    }
    return self;
    
}

- (void)test{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] *1000;
    long long l = time*1000;
    NSMutableString *string = [NSMutableString stringWithFormat:@"tonce=%lld&accesskey=%@&requestmethod=post&id=1&method=getMarketDepth2&params=",l,ACCESS_KEY];
    
    NSString *sig = [NetManager getSignature:string andKey:SECRET_KEY];

    
//    [_client.requestSerializer setAuthorizationHeaderFieldWithUsername:ACCESS_KEY password:sig];
    
    
    
    
    [_client.requestSerializer setValue:[NSString stringWithFormat:@"%lld",l] forHTTPHeaderField:@"Json-Rpc-Tonce"];
//    _client.responseSerializer.acceptableContentTypes 
    NSString *url = [NSString stringWithFormat:@"https://%@:%@@api.btcchina.com/api_trade_v1.php",ACCESS_KEY,sig];
    
    //    NSString *url = [NSString stringWithFormat:@"https://api.btcchina.com/api_trade_v1.php"];
    
    NSDictionary *dic =@{@"method":@"getMarketDepth2",@"params":@[],@"id":@1};

    _client.shouldUseCredentialStorage = YES;
    
    
    
    [_client POST:url parameters:dic success:^( AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
