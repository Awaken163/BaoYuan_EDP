//
//  RoomCustomCell.m
//  BYFCApp
//
//  Created by PengLee on 15/2/5.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RoomCustomCell.h"

@implementation RoomCustomCell
@synthesize roomImageInfo;
@synthesize districtNameLable;
@synthesize countFLable;
@synthesize estateNameLable;
@synthesize squareLable;
@synthesize priceLable;
@synthesize tradeStateLable;

@synthesize shaleLable;
@synthesize zuLable;
@synthesize roomNumLable;
@synthesize areaLable;
@synthesize jingliTuiJianLable;
@synthesize jishouLable;
@synthesize xuequfangLable;
@synthesize changeBtn;
@synthesize telBnt;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //[self initWithContent];
    
}

- (instancetype)init
{
    if (self = [super init])
    {
       
        
    }
    return self;
    
}
- (void)initWithContent
{
    //出售  出租 标签
    
    shaleLable = [[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/25, PL_HEIGHT/36,PL_WIDTH/20 , PL_WIDTH/20)];
    [self addSubview:shaleLable];
    
    
    
    zuLable = [[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/25, CGRectGetMaxY(shaleLable.frame)+kPLhorisionCelledgedSpace+5, PL_WIDTH/20, PL_WIDTH/20)];
    [self addSubview:zuLable];
    //宝源默认图片
    
    roomImageInfo = [[UIImageView alloc]init];
    roomImageInfo.frame = CGRectMake(CGRectGetMaxX(shaleLable.frame)+kPLhorisionCelledgedSpace, PL_HEIGHT/36,CGRectGetHeight(shaleLable.frame)*4.3 , CGRectGetHeight(shaleLable.frame)*4.0) ;
    
    [self addSubview:roomImageInfo];
    
    estateNameLable = [[UIButton alloc]init];
    [estateNameLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    estateNameLable.frame= CGRectMake(CGRectGetMaxX(roomImageInfo.frame)+kPLhorisionCelledgedSpace, CGRectGetMinY(roomImageInfo.frame)-12, CGRectGetWidth(shaleLable.frame)*7, CGRectGetHeight(shaleLable.frame)+15);
    //estateNameLable.backgroundColor = [UIColor redColor];
    estateNameLable.titleLabel.font = [UIFont boldSystemFontOfSize:kPLStatusSystemFontSize+2];
    estateNameLable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft|UIControlContentVerticalAlignmentBottom;
//    [estateNameLable addTarget:self action:@selector(esateClick) forControlEvents:UIControlEventTouchUpInside];
    //estateNameLable.titleEdgeInsets = UIEdgeInsetsZero;
    estateNameLable.contentEdgeInsets = UIEdgeInsetsZero;
    estateNameLable.backgroundColor = [UIColor redColor];
    [self addSubview:estateNameLable];
    countFLable = [[UILabel alloc]init];
    
    
    countFLable.backgroundColor = [UIColor clearColor];
    
    
    countFLable.frame = CGRectMake(CGRectGetMinX(estateNameLable.frame), CGRectGetMaxY(estateNameLable.frame), CGRectGetWidth(shaleLable.frame)*2.1  , CGRectGetHeight(shaleLable.frame)*0.9);
    // countFLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:countFLable];
    roomNumLable = [[UILabel alloc]init];
    // roomNumLable.text = @"12幢103室";
    roomNumLable.backgroundColor = [UIColor clearColor];
    
    
    roomNumLable.frame = CGRectMake(CGRectGetMaxX(countFLable.frame)*1.12  , CGRectGetMaxY(estateNameLable.frame), CGRectGetWidth(shaleLable.frame)*3, CGRectGetHeight(shaleLable.frame)*0.9);
    
    [self addSubview:roomNumLable];
    squareLable = [[UILabel alloc]init];
    // squareLable.text = @"188 平米";
    // CGSize squreSize  = kPLautoLableSize(squareLable.text);
    squareLable.backgroundColor = [UIColor clearColor];
    squareLable.frame = CGRectMake(CGRectGetMinX(countFLable.frame), CGRectGetMaxY(countFLable.frame),CGRectGetHeight(shaleLable.frame)*3, CGRectGetHeight(countFLable.frame));
    squareLable.contentMode = UIViewContentModeScaleAspectFill;
    // squareLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:squareLable];
    districtNameLable = [[UIButton alloc]init];
    
    districtNameLable.frame = CGRectMake(CGRectGetMaxX(roomImageInfo.frame)+kPLhorisionCelledgedSpace, CGRectGetMaxY(squareLable.frame)+3, CGRectGetWidth(shaleLable.frame)*2.5, CGRectGetWidth(shaleLable.frame));
    districtNameLable.contentMode = UIViewContentModeScaleAspectFit;
    districtNameLable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
//    [districtNameLable addTarget:self action:@selector(districtClick) forControlEvents:UIControlEventTouchUpInside];
    
    [districtNameLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    districtNameLable.backgroundColor=[UIColor clearColor];
    [self addSubview:districtNameLable];
    priceLable = [[UILabel alloc]init];
    
    priceLable.frame = CGRectMake(CGRectGetMinX(roomNumLable.frame), CGRectGetMaxY(roomNumLable.frame), CGRectGetWidth(estateNameLable.frame),  CGRectGetHeight(shaleLable.frame)*0.9);
    
    [self addSubview:priceLable];
    areaLable = [[UIButton alloc]init];
    
    areaLable.backgroundColor = [UIColor clearColor];
    areaLable.frame = CGRectMake(CGRectGetMinX(priceLable.frame), CGRectGetMaxY(priceLable.frame)+3, CGRectGetWidth(shaleLable.frame)*2.5, CGRectGetHeight(shaleLable.frame)*0.9);
    //[areaLable addTarget:self action:@selector(areaClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:areaLable];
    self.cellHeight = CGRectGetMaxY(roomImageInfo.frame)+kPLhorisionCelledgedSpace;
    jingliTuiJianLable = [[UIImageView alloc]init];
    jingliTuiJianLable.backgroundColor = [UIColor clearColor];
    jingliTuiJianLable.frame = CGRectMake(PL_WIDTH/1.5, CGRectGetMinY(estateNameLable.frame), CGRectGetWidth(shaleLable.frame)*3, CGRectGetHeight(shaleLable.frame));
    // jingliTuiJianLable.image =[UIImage imageNamed:@"jinglituijian_lan.png"];
    
    [jingliTuiJianLable.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    jingliTuiJianLable.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:jingliTuiJianLable];
    jishouLable = [[UIImageView alloc]init];
    jishouLable.backgroundColor = [UIColor clearColor];
    jishouLable.frame = CGRectMake(CGRectGetMinX(jingliTuiJianLable.frame), CGRectGetMaxY(jingliTuiJianLable.frame)+6, CGRectGetWidth(jingliTuiJianLable.frame), CGRectGetHeight(jingliTuiJianLable.frame));
    // jishouLable.image = [UIImage imageNamed:@"jishou_hong.png"];
    
    [jishouLable.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    
    jishouLable.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:jishouLable];
    xuequfangLable = [[UIImageView alloc]init];
    xuequfangLable.backgroundColor = [UIColor clearColor];
    xuequfangLable.frame = CGRectMake(CGRectGetMinX(jishouLable.frame), CGRectGetMaxY(jishouLable.frame)+6, CGRectGetWidth(jishouLable.frame), CGRectGetHeight(jishouLable.frame));
    // xuequfangLable.image = [UIImage imageNamed:@"xuequfang_fen.png"];
    
    [xuequfangLable.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    
    xuequfangLable.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:xuequfangLable];
    //写跟进
    changeBtn = [[UIButton alloc]init];
    changeBtn.backgroundColor = [UIColor redColor];
    changeBtn.frame = CGRectMake(CGRectGetMaxX(jingliTuiJianLable.frame)+15, CGRectGetMinY(jingliTuiJianLable.frame), CGRectGetWidth(shaleLable.frame)*1.7, CGRectGetWidth(shaleLable.frame)*1.7);
    
    
    [self addSubview:changeBtn];
    telBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    telBnt.frame = CGRectMake(CGRectGetMinX(changeBtn.frame), CGRectGetMaxY(changeBtn.frame)+10, CGRectGetWidth(changeBtn.frame), CGRectGetHeight(changeBtn.frame));
    telBnt.backgroundColor = [UIColor redColor];
    [telBnt bringSubviewToFront:self];
    
    [self addSubview:telBnt];

}
@end