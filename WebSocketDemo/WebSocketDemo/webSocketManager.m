//
//  webSocketManager.m
//  wesocketDemo
//
//  Created by 花花一世界 on 17/1/4.
//  Copyright © 2017年 花花一世界. All rights reserved.
//

#import "webSocketManager.h"

@implementation webSocketManager

- (void)WithIP:(NSString *)URLIP{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@", URLIP];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //如需更改链接的头部则需此步
    [request setValue:@"http://xxxxxx" forHTTPHeaderField:@"xxx"];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    _webSocket.delegate = self;
}

- (void)openSocket {
    [_webSocket open];
}

- (void)closeSocket {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

//外部聊天发送消息
- (void)sendTalkMessage:(NSString *)message{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic = [@{ @"content":message} mutableCopy];
    [self sendMessage:dic];
}

//ping pong 心跳链接
- (void)SendPangMessage{
    
}
#pragma mark   /*******  socket必须实现的代理方法 *********/
//打开socket后根据后端要求传入字典字符串
-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"type":@"login"
                                                                 } options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [webSocket send:jsonString];
}


//socket接收到信息后通过代理传给外部使用
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    [self.delegate getMessageFromSocket:dic];
}


-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"WebSocket closed");
    _webSocket = nil;
}


-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
}


-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    _webSocket = nil;
}

//send数据转化成json字符串
- (void)sendMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [_webSocket send:jsonString];
}
@end
