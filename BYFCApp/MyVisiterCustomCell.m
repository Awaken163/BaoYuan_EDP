//
//  MyVisiterCustomCell.m
//  BYFCApp
//
//  Created by zzs on 15/3/23.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MyVisiterCustomCell.h"
#import "PL_Header.h"

@implementation MyVisiterCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
    }
    return self;
}
-(void)initView
{
    _gou=[[UIImageView alloc]initWithFrame:CGRectMake(8/320.00*PL_WIDTH, 16, 18, 18)];
    _gou.image=[UIImage imageNamed:@"gou_hui.png"];
    [self addSubview:_gou];
    
    _zu=[[UIImageView alloc]initWithFrame:CGRectMake(8/320.00*PL_WIDTH, 44, 18, 18)];
    _zu.image=[UIImage imageNamed:@"zu_hui.png"];
    [self addSubview:_zu];
    
    _name=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_gou.frame)+4, 15, 109, 17)];
    _name.font=[UIFont systemFontOfSize:12];
    //_name.backgroundColor=[UIColor redColor];
    [self addSubview:_name];
//    _source=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_name.frame)+4, 15, 109, 17)];
//    _source.font=[UIFont systemFontOfSize:12];
//    //_name.backgroundColor=[UIColor redColor];
//    [self addSubview:_source];
    
    
    _yixiang=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_name.frame), 45, 30, 17)];
    _yixiang.text=@"意向:";
    _yixiang.font=[UIFont systemFontOfSize:12];
    [self addSubview:_yixiang];
    _xiaoqu=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_yixiang.frame), 45, 55, 17)];
    _xiaoqu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _xiaoqu.titleLabel.font=[UIFont systemFontOfSize:12];
    _xiaoqu.backgroundColor=[UIColor clearColor];
    [self addSubview:_xiaoqu];
    _pianqu=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_xiaoqu.frame), 45, 75, 17)];
    _pianqu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _pianqu.backgroundColor=[UIColor clearColor];
    //[_pianqu setTitle:@"aaaaaaaaaaaaaaa" forState:UIControlStateNormal];
    _pianqu.titleLabel.font=[UIFont systemFontOfSize:12];
     
    [self addSubview:_pianqu];
    _jinglituijian=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_yixiang.frame)-2, 65, 36, 17)];
    _jinglituijian.image=[UIImage imageNamed:@"jinglituijian_hui.png"];
    [self addSubview:_jinglituijian];
    _jixu=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_jinglituijian.frame)+3, 65, 36, 17)];
    _jixu.image=[UIImage imageNamed:@"急需_hui.png"];
    [self addSubview:_jixu];
    _xuequfang=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_jixu.frame)+3, 65, 36, 17)];
    _xuequfang.image=[UIImage imageNamed:@"xuequfang_hui.png"];
    [self addSubview:_xuequfang];
    _yixiangdu=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2, 17, 51, 12)];
    _yixiangdu.text=@"意向度:";
    _yixiangdu.font=[UIFont systemFontOfSize:12];
    [self addSubview:_yixiangdu];
    _XX1=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_yixiangdu.frame)-10, 14, 13, 13)];
    _XX1.image=[UIImage imageNamed:@"小灰星星.png"];
    [self addSubview:_XX1];
    _XX2=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_XX1.frame)+1, 14, 13, 13)];
    _XX2.image=[UIImage imageNamed:@"小灰星星.png"];
    [self addSubview:_XX2];
    _XX3=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_XX2.frame)+1, 14, 13, 13)];
    _XX3.image=[UIImage imageNamed:@"小灰星星.png"];
    [self addSubview:_XX3];
    _XX4=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_XX3.frame)+1, 14, 13, 13)];
    _XX4.image=[UIImage imageNamed:@"小灰星星.png"];
    [self addSubview:_XX4];
    _XX5=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_XX4.frame)+1, 14, 13, 13)];
    _XX5.image=[UIImage imageNamed:@"小灰星星.png"];
    [self addSubview:_XX5];
    _roomInfo=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_pianqu.frame)+2, 45, 119, 17)];
    _roomInfo.font=[UIFont systemFontOfSize:12];
    //_roomInfo.backgroundColor=[UIColor redColor];
    [self addSubview:_roomInfo];
    _yixiangPrice=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_yixiangdu.frame), 67, 119, 17)];
    _yixiangPrice.font=[UIFont systemFontOfSize:12];
    //_yixiangPrice.backgroundColor=[UIColor redColor];
    [self addSubview:_yixiangPrice];
    _genjin=[[UIButton alloc]initWithFrame:CGRectMake(280/320.00*PL_WIDTH, 5, 40, 40)];
    [_genjin setImage:[UIImage imageNamed:@"写跟进1.png"] forState:UIControlStateNormal];
    [self addSubview:_genjin];
    _phoneBtn=[[UIButton alloc]initWithFrame:CGRectMake(280/320.00*PL_WIDTH, 45, 40, 50)];
    [_phoneBtn setImage:[UIImage imageNamed:@"打电话1.png"] forState:UIControlStateNormal];
    [_phoneBtn addTarget:self action:@selector(clickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_phoneBtn];
}
-(void)clickPhoneButton:(UIButton *)sender
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)awakeFromNib {
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//    NSLog(@"%s%@",__FUNCTION__,[NSDate date]);
//
//}

@end
