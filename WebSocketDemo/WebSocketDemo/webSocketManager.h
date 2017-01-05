//
//  webSocketManager.h
//  wesocketDemo
//
//  Created by 花花一世界 on 17/1/4.
//  Copyright © 2017年 花花一世界. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>
//设置代理,用于接受websocket传来的消息时,在外部进行处理
@protocol getMessageDelegate <NSObject>
- (void)getMessageFromSocket:(NSDictionary *)message;
@end

@interface webSocketManager : NSObject<SRWebSocketDelegate>//签Socket协议
@property (assign, nonatomic) id<getMessageDelegate>delegate;
@property (nonatomic,strong) SRWebSocket *webSocket;

//外部调用传入链接URL
- (void)WithIP:(NSString *)URLIP;
//外部控制打开webSocket(拿到接口传给的URL之后)
- (void)openSocket;
//外部调用控制关闭webSocket
- (void)closeSocket;
//ping pong 心跳链接
- (void)SendPangMessage;
//外部聊天发送消息
- (void)sendTalkMessage:(NSString *)message;
@end
