//
//  HPConnection.h
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@class HPConnection;

@protocol HPConnectionDelegate <NSObject>
@optional
-(void)connection:(HPConnection *)connection didReadData:(NSData *)data;
-(void)connectionDidDisconnect:(HPConnection *)connection withError:(NSError *)err;
@end

@interface HPConnection : NSObject<GCDAsyncSocketDelegate>

@property(nonatomic, assign)BOOL isConnected;
@property(nonatomic, assign)NSUInteger timeout;
@property(nonatomic, strong)GCDAsyncSocket * socket;
@property(nonatomic, strong)dispatch_queue_t queue;

@property(nonatomic,weak)id<HPConnectionDelegate> delegate;

-(void)write:(NSData *)data;
-(void)read;
@end
