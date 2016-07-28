//
//  HPServer.h
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPConnection.h"

@interface HPServer : HPConnection

@property(nonatomic,strong)NSString * host;
@property(nonatomic,assign)NSInteger port;
-(id)initWithHost:(NSString *)host andPort:(NSInteger)port andQueue:(dispatch_queue_t)queue;
-(BOOL)connect;
@end
