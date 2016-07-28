//
//  HPConnection.m
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPConnection.h"
@interface HPConnection()
@end

@implementation HPConnection
-(NSUInteger)timeout{
    if(_timeout <=0){
        return 15;
    }
    return _timeout;
}
-(BOOL)isConnected{
    return self.socket.isConnected;
}
-(void)write:(NSData *)data{
    [self.socket writeData:data withTimeout:self.timeout tag:0];
    [self read];
}

-(void)read{
    [self.socket readDataWithTimeout:self.timeout tag:0];
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    if(self.delegate != nil){
        [self.delegate connection:self didReadData:data];
    }
}
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    if(self.delegate != nil){
        [self.delegate connectionDidDisconnect:self withError:err];
    }
}

@end
