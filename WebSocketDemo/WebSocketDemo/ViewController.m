//
//  ViewController.m
//  wesocketDemo
//
//  Created by 花花一世界 on 17/1/4.
//  Copyright © 2017年 花花一世界. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewCell.h"
#import "webSocketManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,getMessageDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *talkArr;
@property (nonatomic, strong) webSocketManager *webSocket;
@end

@implementation ViewController
//记得退出页面关闭socket
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_webSocket closeSocket];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableview数据数组
    self.talkArr = [NSMutableArray arrayWithObjects:@"hello world~",@"where are you from?",nil];
    [self getData];
    [self creatTableView];
    self.textField.delegate = self;
    [self.sendButton addTarget:self action:@selector(sendACT) forControlEvents:UIControlEventTouchUpInside];
}

//发送按钮 调用websocket发送方法,推给服务器消息
- (void)sendACT{
    [self. textField resignFirstResponder];
    if (!([_textField.text  isEqual: @""])) {
        [_webSocket sendTalkMessage:_textField.text];
        [self.talkArr addObject:_textField.text];
        [_mainTableView reloadData];
        _textField.text = nil;
    }
}
//获取到服务器数据后创建websocket
- (void)getData{
    //webscoket链接
    _webSocket = [[webSocketManager alloc] init];
    //    [_webSocket WithIP:@"xxxxxxxxxxx"];
    _webSocket.delegate = self;
    [_webSocket openSocket];
}

#pragma mark 一一WebSocket协议方法一一一一一一一一一一一一一一一一一一一一一一一一一一一一
- (void)getMessageFromSocket:(NSDictionary *)message {
    //接收到消息后做相关处理
    [_mainTableView reloadData];
}


- (void)creatTableView{
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"DemoTableViewCell" bundle:nil] forCellReuseIdentifier:@"DemoTableViewCell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _talkArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoTableViewCell" forIndexPath:indexPath];
    [cell getTalkwith:self.talkArr[indexPath.row]];
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}
@end
