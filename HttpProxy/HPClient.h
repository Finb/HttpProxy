//
//  HPClient.h
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPConnection.h"

@interface HPClient : HPConnection
- (instancetype)initWithSocket:(GCDAsyncSocket *)socket;
@end
