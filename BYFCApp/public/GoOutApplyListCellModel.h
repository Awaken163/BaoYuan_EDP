//
//  GoOutApplyListCellModel.h
//  BYFCApp
//
//  Created by PengLee on 15/7/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoOutApplyListCellModel : NSObject

//日期
@property (nonatomic,strong) NSString *data;

//时间段
@property(nonatomic,strong) NSString *timeBuck;
//外出地点
@property(nonatomic,strong) NSString *goOutAdress;
//备注
@property(nonatomic,strong) NSString *remark;
//结果
@property(nonatomic,strong) NSString *result;
//ID
@property(nonatomic,strong)NSString*ProcessId;
@property(nonatomic,strong)NSString*StartTime;
@property(nonatomic,strong)NSString*EndTime;

@end
