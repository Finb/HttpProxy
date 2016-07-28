//
//  HPServer.m
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPServer.h"

@implementation HPServer

-(NSInteger)port{
    if(_port<=0){
        return 80;
    }
    return _port;
}

-(id)initWithHost:(NSString *)host andPort:(NSInteger)port andQueue:(dispatch_queue_t)queue {
    self = [super init];
    if(self){
        self.host = host;
        self.port = port;
        self.queue = queue;
    }
    return self;
}

-(BOOL)connect{
    if(!self.socket){
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:self.queue];
        self.socket.delegate = self;
    }
    NSError * error;
    BOOL ok =  [self.socket connectToHost:self.host onPort:self.port error:&error];
    return ok;
}
@end
