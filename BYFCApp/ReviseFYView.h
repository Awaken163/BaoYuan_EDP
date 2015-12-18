//
//  ReviseFYView.h
//  BYFCApp
//
//  Created by PengLee on 15/5/15.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
//enum
//{
//    TopSet_None = 0,
//    TopSet_Forever,
//    TopSet_Three,
//    TopSet_Seven,
//    TopSet_Fifteen,
//    TopSet_Thirty,
//    
//};
//typedef NSInteger TopSet;
@protocol ReviseFYViewDelegate<NSObject>
-(void)clickViewSender:(RoomRevisInfo *)roomInfo;
-(void)clickClearButton;

@optional
-(void)transFormSetHouseMarks:(RoomRevisInfo *)info;

@end


@interface ReviseFYView : UIView
{
    //定义字符串判断领导与业务员
    NSString * flagSubs;
}
@property(nonatomic,strong) RoomData * reviseRoomData;
//主tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *arrayData;//售价租价等数据
@property (nonatomic,strong)UITextField *rentPriceTextField;
@property (nonatomic,strong)UITextField *salePriceTextField;
@property(nonatomic,strong)NSString     *statusString;
@property(nonatomic,strong)NSString     *jiShouString;
@property(nonatomic,strong)NSString     *jingLiTuiJianString;
@property(nonatomic)BOOL         isEq;
@property (nonatomic,strong) NSString *propertyIDString;
@property (nonatomic,weak) id <ReviseFYViewDelegate>ViewDelegate;


//@property (weak, nonatomic) IBOutlet UITextField *rentPriceTextField;
@property (weak, nonatomic) IBOutlet UIView *decorationView;
@property (weak, nonatomic) IBOutlet UIButton *validButton;
@property (weak, nonatomic) IBOutlet UIButton *needButton;
//@property (weak, nonatomic) IBOutlet UITextField *salePriceTextField;
@property (weak, nonatomic) IBOutlet UIButton *recommandButton;
@property (weak, nonatomic) IBOutlet UIButton *salesButton;



//@property (nonatomic,assign) TopSet  topset;
@property(nonatomic,strong)NSString *roomdutycode;
@property(nonatomic,strong)NSString *dutyCode;
@property (weak, nonatomic) IBOutlet UIButton *topSetButton;
@property (weak, nonatomic) IBOutlet UIButton *topBut;

@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonAayy;
@property(nonatomic,strong)NSString *followListdutyCode;


//@property (weak, nonatomic) IBOutlet UIButton *butAction;
@property (weak, nonatomic) IBOutlet UIButton *sendAciton;
@property (weak, nonatomic) IBOutlet UIButton *cancelAction;
- (IBAction)sendAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

-(void)refreshUI:(RoomData *)roomInfo;
@end
