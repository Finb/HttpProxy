//
//  HPClient.m
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPClient.h"

@implementation HPClient
- (instancetype)initWithSocket:(GCDAsyncSocket *)socket
{
    self = [super init];
    if (self) {
        self.socket = socket;
        self.socket.delegate = self;
        self.queue = socket.delegateQueue;
    }
    return self;
}
@end
