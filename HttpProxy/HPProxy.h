//
//  HPProxy.h
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPServer.h"
#import "HPClient.h"
#import "HPParser.h"
@interface HPProxy : NSObject

@property(nonatomic,strong)HPClient * client;
@property(nonatomic,strong)HPServer * server;

@property(nonatomic,strong)HPParser * requestParser;
@property(nonatomic,strong)HPParser * responseParser;

-(id)initWithClient:(HPClient*)client;
@end
