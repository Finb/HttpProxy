//
//  ViewController.m
//  HttpProxy
//
//  Created by huangfeng on 16/7/26.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import "HPParser.h"
@interface ViewController () <GCDAsyncSocketDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HPParser * p = [[HPParser alloc] initWithType:0];
    NSString * str = @"GET www.baidu.com HTTP/1.1\r\n\r\nHost: nsclick.baidu.com\r\nConnection: keep-alive\r\nCache-Control: max-age=0\r\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/52.0.2743.82 Safari/537.36\r\nAccept: */*\r\n\r\n";
    
//        NSString * str1 = @"GET www.baidu.com HTT";
//        NSString * str2 = @"P/1.1\r\nHost: nsclick.baidu.com\r\nConnection: keep-alive\r\nCache-Control: max-age=0\r\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac ";
//        NSString * str3 = @"OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/52.0.2743.82 Safari/537.36\r\nAccept: */*\r\n\r\n";
//    [p parse:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
//    [p parse:[str2 dataUsingEncoding:NSUTF8StringEncoding]];
//    [p parse:[str3 dataUsingEncoding:NSUTF8StringEncoding]];
    
    [p parse:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
}


@end
