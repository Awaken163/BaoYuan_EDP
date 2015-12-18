//
//  GoOutApplyListCell.h
//  BYFCApp
//
//  Created by PengLee on 15/7/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoOutApplyListCellModel.h"
@interface GoOutApplyListCell : UITableViewCell
//外出时间段
@property (weak, nonatomic) IBOutlet UILabel *goOutPeriod;
//备注
@property (weak, nonatomic) IBOutlet UILabel *event;
//地址
@property (weak, nonatomic) IBOutlet UILabel *address;
//外出日期
@property (weak, nonatomic) IBOutlet UILabel *goOutData;
//审核
@property (weak, nonatomic) IBOutlet UILabel *check;
@property(nonatomic,strong)NSString*precessID;
@property(nonatomic,copy)NSString*strTimerCom;
- (void)cellData:(GoOutApplyListCellModel *)model;
@end
