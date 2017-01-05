//
//  DemoTableViewCell.h
//  wesocketDemo
//
//  Created by 花花一世界 on 17/1/4.
//  Copyright © 2017年 花花一世界. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *talkLable;
- (void)getTalkwith:(NSString *)contant;
@end
