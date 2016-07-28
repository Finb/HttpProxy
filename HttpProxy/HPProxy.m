//
//  HPProxy.m
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPProxy.h"

@interface HPProxy ()<HPConnectionDelegate>

@end
@implementation HPProxy
-(id)initWithClient:(HPClient*)client{
    self = [super init];
    if(self){
        self.client = client;
        self.client.delegate = self;
        self.requestParser = [[HPParser alloc] initWithType:HTTPParserTypeRequset];
        self.responseParser = [[HPParser alloc] initWithType:HTTPParserTypeResponse];
        [self.client read];
    }
    return self;
}

-(void)connection:(HPConnection *)connection didReadData:(NSData *)data{
    NSLog(@"%@",connection);
    if(connection == self.client){
        [self progressRequest:data];
    }
    else if(connection == self.server){
        [self progressResponse:data];
    }
    [connection read];
}
-(void)progressRequest:(NSData *)data{
    if(self.server && !self.server.socket.isDisconnected){
        [self.server write:data];
        [self.server read];
        return;
    }
    
    [self.requestParser parse:data];
    
    if(self.requestParser.state >= HttpParserStateHeaders_complete){
        NSString * host;
        NSInteger port;
        if([[self.requestParser.method lowercaseString] isEqualToString:@"connect"]){
            NSString * url = self.requestParser.url.absoluteString;
            NSArray * arr = [url componentsSeparatedByString:@":"];
            host = arr[0];
            port = [arr[1] integerValue];
        }
        else{
            host = self.requestParser.url.host;
            port = ([self.requestParser.url.port integerValue] > 0 ? [self.requestParser.url.port integerValue] : 80 );
        }
        self.server = [[HPServer alloc] initWithHost:host andPort:port andQueue:self.client.queue];
        self.server.delegate = self;
        if([self.server connect]){
            if([[self.requestParser.method lowercaseString] isEqualToString:@"connect"]){
                NSString * pkt = @"HTTP/1.1 200 Connection established\r\n\r\n";
                [self.client write:[pkt dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else{
                [self.server write:data];
            }
        }
        else{
            //关闭客户端
        }
    }
}
-(void)progressResponse:(NSData *)data{
    [self.client write:data];
}
-(void)connectionDidDisconnect:(HPConnection *)connection withError:(NSError *)err{
    
}
@end
