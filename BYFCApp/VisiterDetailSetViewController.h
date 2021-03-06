//
//  VisiterDetailSetViewController.h
//  BYFCApp
//
//  Created by zzs on 15/5/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisiterDetailSetViewController : UIViewController
{
    NSString *_string1;
  NSString * _string2;
    NSArray * priceArray;
    NSString *areaId;
//面积大小
//    NSString *hallStr;
    NSString *hallStrText;
    NSString *bigStr;
    NSString *bigStrText;
    //售价大小
    NSString *hallPrice;
    NSString *hallPriceSend;
    NSString *bigPrice;
    NSString *bigPriceSend;
    NSString *priceName;
    
    //租价大小
    NSString *hallRent;
    NSString *hallRentSend;
    NSString *bigRent;
    NSString *bigRentSend;
    NSString *RentName;
    //厅 房
    NSString *room;
    NSString *roomText;
    NSString *hall;
    NSString *hallText;
    //意向区域
    NSString *districName;
    NSString *areaID1;
    NSString *districNameSend;
   
}
@property (weak, nonatomic) IBOutlet UITextField *houseTextField;
@property (weak, nonatomic) IBOutlet UITextField *houseBigTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomTextField;
@property (weak, nonatomic) IBOutlet UITextField *hallTextField;
//客源ID
@property(nonatomic,strong)NSString *CustID;
//房
@property(nonatomic,strong)NSString *roomStr;
//厅
@property(nonatomic,strong)NSString *hallStr;
//最小面积
@property(nonatomic,strong)NSString *smallStr;
//最大面积
@property(nonatomic,strong)NSString *BigStr;
//意向区域
@property(nonatomic,strong)NSString *DistricName;
@property(nonatomic,strong)NSString *AreaName;
//片区ID
@property(nonatomic,strong)NSString *AreaID;
//购价
@property(nonatomic,strong)NSString *Price;
//最大购价
@property(nonatomic,strong)NSString *Rental;

@end
