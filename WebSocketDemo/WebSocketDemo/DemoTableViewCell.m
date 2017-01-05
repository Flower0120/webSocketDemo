//
//  DemoTableViewCell.m
//  wesocketDemo
//
//  Created by 花花一世界 on 17/1/4.
//  Copyright © 2017年 花花一世界. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)getTalkwith:(NSString *)contant{
    self.talkLable.text = contant;
}

@end
