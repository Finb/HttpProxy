//
//  HPParser.h
//  HttpProxy
//
//  Created by huangfeng on 16/7/28.
//  Copyright © 2016年 Fin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HTTPParserType) {
    HTTPParserTypeRequset,
    HTTPParserTypeResponse,
};

typedef NS_ENUM(NSInteger,HTTPParserState) {
    HttpParserStateInitialized = 0 ,
    HttpParserStateLine_rcvd ,
    HttpParserStateRcving_headers ,
    HttpParserStateHeaders_complete ,
    HttpParserStateRcving_body ,
    HttpParserStateComplete ,
};



@interface HPParser : NSObject
@property(nonatomic,assign)HTTPParserType type;
@property(nonatomic,assign)HTTPParserState state;
@property(nonatomic,strong)NSMutableData * raw;
@property(nonatomic,strong)NSMutableData * buffer;

@property(nonatomic,strong)NSMutableDictionary * headers;
@property(nonatomic,strong)NSString * body;

@property(nonatomic,strong)NSString * method;
@property(nonatomic,strong)NSURL * url;
@property(nonatomic,strong)NSString * code;
@property(nonatomic,strong)NSString * reason;
@property(nonatomic,strong)NSString * version;

@property(nonatomic,assign)BOOL chunker;

-(id)initWithType:(HTTPParserType)type;

-(void)parse:(NSData *)data;
@end
