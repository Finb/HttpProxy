//
//  HPParser.m
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import "HPParser.h"
const char CR = '\r';
const char LF = '\n';
const char COLON = ':';
const char SP = ' ';

char CRLF[2] = {CR,LF};

@implementation HPParser
-(id)initWithType:(HTTPParserType)type{
    self = [super init];
    if(self){
        self.type = type;
        self.raw = [NSMutableData data];
        self.buffer = [NSMutableData data];
        self.headers = [NSMutableDictionary new];
    }
    return self;
}
-(void)parse:(NSData *)data{
//    [self.raw appendData:data];
    [self.buffer appendData:data];

    //会读buffer中，能识别的部分，不能识别的留待下一次
    while ([self process:self.buffer]) {
        
    }
}

-(BOOL)process:(NSMutableData *)data{
    NSData * line;
    [self split:&data andLine:&line];
    if (line == nil){
        return NO;
    }
    if(self.state < HttpParserStateLine_rcvd){
        [self processLine:line];
    }
    else if(self.state < HttpParserStateHeaders_complete){
        [self processHeader:line];
    }
    
    return data.length > 0;
}

-(void)processLine:(NSData *)line{
    NSString * lineStr = [[NSString alloc] initWithData:line encoding:NSUTF8StringEncoding];
    NSArray * array = [lineStr componentsSeparatedByString:@" "];
    if(array.count >= 3){
        if(self.type == HTTPParserTypeRequset){
            self.method = array[0];
            self.url = [NSURL URLWithString:array[1]];
            self.version = array[2];
        }
        else{
            self.version = array[0];
            self.code = array[1];
            NSMutableArray * arr = [[NSMutableArray alloc] initWithArray:array];
            [arr removeObjectAtIndex:0];
            [arr removeObjectAtIndex:0];
            self.reason = [arr componentsJoinedByString:@" "];
        }
    }
    self.state = HttpParserStateLine_rcvd;
}
-(void)processHeader:(NSData *)header{
    //读取到了Headers下的空行，则header读取完毕
    if (header.length <=0){
        if(self.state == HttpParserStateRcving_headers){
            self.state = HttpParserStateHeaders_complete;
        }
        else if(self.state == HttpParserStateLine_rcvd){
            self.state = HttpParserStateRcving_headers;
        }
        return;
    }

    self.state = HttpParserStateRcving_headers;
    NSString * headerStr = [[NSString alloc] initWithData:header encoding:NSUTF8StringEncoding];
    NSArray * parts = [headerStr componentsSeparatedByString:@":"];
    [self.headers setObject:parts[1] forKey:parts[0]];
}

-(void)split:(NSMutableData **)data andLine:(NSData **)line{
    NSData * d = *data;
    //找 \r\n
    int pos = find(d, CRLF, 2);
    if(pos >= 0){
        //取出这一行数据
        *line = [NSData dataWithBytes:d.bytes length:pos];
        //删除上面的line
        [*data replaceBytesInRange:NSMakeRange(0, pos + 2) withBytes:NULL length:0];
    }
}

int find(NSData * data,char * sub, int len){
    char * bytes = (char *)data.bytes;
    
    for (int i = 0; i<data.length; i++) {
        int j = 0;
        for (; j < len; j++) {
            if( bytes[i+j] != sub[j]){
                break;
            }
        }
        if (j == len){
            return i;
        }
    }
    
    return -1;
}
@end
