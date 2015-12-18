//
//  CustomCell.h
//  BYFCApp
//
//  Created by PengLee on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"

#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

#import "SWTableViewCell.h"
@interface CustomCell : SWTableViewCell
{
//    UIView *leftView;
//    UIView *view;
   
}
@property(nonatomic,weak) IBOutlet UIImageView        * shaleLable;
@property(nonatomic,weak)IBOutlet UIImageView        * zuLable;

@property (nonatomic,weak)IBOutlet UIImageView       * roomImageInfo;
//东方城市

@property (weak, nonatomic) IBOutlet UIButton *     districtButton;
@property (weak,nonatomic)IBOutlet UILabel          * districtNameLable;
@property (weak, nonatomic)IBOutlet UILabel         *estateNameLable;
@property (weak, nonatomic)IBOutlet UILabel          *countFLable;
@property (weak,nonatomic) IBOutlet UILabel           *roomNumLable;
@property (weak, nonatomic)IBOutlet UILabel          *squareLable;
@property (strong, nonatomic) UILabel          *tradeStateLable;

@property (weak, nonatomic)IBOutlet UILabel            *priceLable;
@property (weak ,nonatomic)IBOutlet UILabel           *areaLable;
@property (weak, nonatomic)  UIImageView        *roomImage;
@property (assign,nonatomic) float              cellHeight;
@property (weak, nonatomic) IBOutlet UIButton * btn1Click;
@property (weak, nonatomic) IBOutlet UIButton * btn2Click;

@property (weak,nonatomic)IBOutlet UIImageView             * jingliTuiJianLable;
@property (weak,nonatomic)IBOutlet UIImageView             * jishouLable;
@property (weak,nonatomic)IBOutlet UIImageView             * xuequfangLable;
@property (weak,nonatomic)IBOutlet UIButton            *leftBtn;
@property (weak,nonatomic)IBOutlet UIButton            *photoBtn;
@property (strong,nonatomic) NSString * cellTag;
@property (weak, nonatomic) IBOutlet UIImageView *roomStars;
//TwoYears
@property (weak, nonatomic) IBOutlet UIImageView *TwoYears;
//dujia
@property (weak, nonatomic) IBOutlet UIImageView *dujia;

//KeyHome
@property (weak, nonatomic) IBOutlet UIImageView *KeyHome;

//右边按钮

@property (weak,nonatomic)IBOutlet  UIButton           *telBnt;
@property (weak,nonatomic)IBOutlet  UIButton            * changeBtn;
-(void)initView;


@end
