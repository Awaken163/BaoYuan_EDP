//
//  LouPanCell.m
//  BYFCApp
//
//  Created by PengLee on 15/2/10.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "LouPanCell.h"

@implementation LouPanCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(NSInteger)font
{
    
    if (str.length == 0 || !str) {
        
        return CGSizeZero;
    }
    
    
NSDictionary * attDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor],[UIFont systemFontOfSize:font], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
        
        
        NSAttributedString * attStr = [[NSAttributedString alloc]initWithString:str attributes:attDic];
        NSRange range = NSMakeRange(0, attStr.length);
        NSDictionary * dic = [attStr attributesAtIndex:0 effectiveRange:&range];
        
        //
        CGRect  rect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:Nil];
        return rect.size;
    }
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        
        //片区
        self.pianquLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];
        self.pianquLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.pianquLable.text = @"片       区:";
        [self addSubview:self.pianquLable];
        
        
        self.areaLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pianquLable.frame), CGRectGetMinY(self.pianquLable.frame)+2, PL_WIDTH-CGRectGetMaxX(self.pianquLable.frame)-5, 25)];
        
        [self.areaLable setFont:[UIFont systemFontOfSize:PL_USER_fONT_SIZE]];
        self.areaLable.backgroundColor = [UIColor clearColor];
        [self addSubview:self.areaLable];
       
       
        //地址
        self.addreLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pianquLable.frame), CGRectGetMaxY(self.pianquLable.frame), CGRectGetWidth(self.pianquLable.frame), CGRectGetHeight(self.pianquLable.frame))];
        self.addreLable.text = @"地       址:";
        self.addreLable.backgroundColor = [UIColor clearColor];
        self.addreLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        
        [self addSubview:self.addreLable];

        self.roomDistrictLable  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.areaLable.frame), CGRectGetMinY(self.addreLable.frame)+2, CGRectGetWidth(self.areaLable.frame), CGRectGetHeight(self.areaLable.frame))];
        [self.roomDistrictLable setFont:[UIFont systemFontOfSize:PL_USER_fONT_SIZE]];
       // self.roomDistrictLable.backgroundColor = [UIColor clearColor];
        self.roomDistrictLable.contentMode = UIViewContentModeLeft|UIViewContentModeTop;
         self.roomDistrictLable.numberOfLines =0;
        self.roomDistrictLable.backgroundColor = [UIColor clearColor];
        self.roomDistrictLable.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByCharWrapping;
        
        
//        CGSize sizeLable = [self getSizeWithWidth:CGRectGetWidth(self.areaLable.frame) content:self.roomDistrictLable.text font:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
//        self.roomDistrictLable.frame =CGRectMake(CGRectGetMinX(self.areaLable.frame), CGRectGetMinY(self.addreLable.frame), PL_WIDTH-60, sizeLable.height+30);
        [self addSubview:self.roomDistrictLable];
//
     
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.roomDistrictLable.frame)+5, PL_WIDTH, 160-CGRectGetMaxY(self.addreLable.frame))];
        _view.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_view];
        
       
        self.cheweiLable = [[UILabel alloc]init];
        self.cheweiLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.cheweiLable.text = @"车       位:";
        [_view addSubview:self.cheweiLable];
        [self.cheweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@3).with.offset(0);
            make.width.greaterThanOrEqualTo(@40);
            make.height.equalTo(@30);
            
        }];
        
        self.wuyefeiLable = [[UILabel alloc]init];
        
        self.wuyefeiLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.wuyefeiLable.text = @"物业费用:";
        [_view addSubview:self.wuyefeiLable];
        [self.wuyefeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cheweiLable.mas_left).with.offset(0);
            make.top.equalTo(self.cheweiLable.mas_bottom).with.offset(0);
            make.width.greaterThanOrEqualTo(self.cheweiLable.mas_width);
            make.height.equalTo(self.cheweiLable.mas_height);
            
        }];
        
        self.stopingCount = [[UILabel alloc]init];
        self.stopingCount.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        self.stopingCount.text = @"";
        self.stopingCount.textAlignment = NSTextAlignmentLeft;
        
        [_view addSubview:self.stopingCount];
        [self.stopingCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cheweiLable.mas_right);
            make.centerY.equalTo(self.cheweiLable.mas_centerY).with.offset(0);
            make.width.equalTo(self.cheweiLable.mas_width);
            make.height.equalTo(self.areaLable.mas_height);
            
        }];
        
        self.areaPrice = [[UILabel alloc]init];
        self.areaPrice.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        self.areaPrice.text = @"";
        //self.areaPrice.numberOfLines = 0;
        
        [_view addSubview:self.areaPrice];
        [self.areaPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wuyefeiLable.mas_right);
            make.centerY.equalTo(self.wuyefeiLable.mas_centerY);
            make.width.equalTo(self.wuyefeiLable.mas_width);
            
            make.height.equalTo(@25);
            
        }];

                self.jugongLable = [[UILabel alloc]init];
        self.jugongLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.jugongLable.text = @"竣工时间:";
        [_view addSubview:self.jugongLable];
        [self.jugongLable mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.greaterThanOrEqualTo(self.wuyefeiLable.mas_left).with.offset(0);
            make.top.equalTo(self.wuyefeiLable.mas_bottom).with.offset(0);
            make.width.greaterThanOrEqualTo(self.wuyefeiLable.mas_width);
            make.height.equalTo(self.wuyefeiLable.mas_height);
            
        }];
        self.completeTime = [[UILabel alloc]init];
        self.completeTime.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        self.completeTime.text = @"";
        [_view addSubview:self.completeTime];
        [self.completeTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.jugongLable.mas_right).with.offset(0);
            make.centerY.equalTo(self.jugongLable.mas_centerY).with.offset(0);
            make.width.greaterThanOrEqualTo(self.jugongLable.mas_width);
            make.height.equalTo(self.jugongLable.mas_height);
            
        }];

        
        self.allMianjiLable = [[UILabel alloc]init];
        self.allMianjiLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.allMianjiLable.text = @"总面积:";
        [_view addSubview:self.allMianjiLable];
        [self.allMianjiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_view.mas_centerX).with.offset(10);
            make.centerY.equalTo(self.cheweiLable.mas_centerY).with.offset(0);
            make.width.greaterThanOrEqualTo(self.cheweiLable.mas_width);
            make.height.equalTo(self.addreLable.mas_height);
            
        }];
        self.squreLable = [[UILabel alloc]init];
        self.squreLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        self.squreLable.text = @"";
        [_view addSubview:self.squreLable];
        [self.squreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.allMianjiLable.mas_right).with.offset(2);
            make.centerY.equalTo(self.allMianjiLable.mas_centerY).with.offset(0);
            make.width.greaterThanOrEqualTo(self.allMianjiLable.mas_width);
            make.height.equalTo(@25);
            
        }];
//
//        
        self.allPeople = [[UILabel alloc]init];
        self.allPeople.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.allPeople.text = @"总户数:";
        [_view addSubview:self.allPeople];
        [self.allPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.allMianjiLable.mas_centerX).with.offset(0);
            make.centerY.equalTo(self.wuyefeiLable.mas_centerY).with.offset(0);
            make.width.greaterThanOrEqualTo(self.allMianjiLable.mas_width);
            make.height.equalTo(self.allMianjiLable.mas_height);
            
        }];
        self.countUser = [[UILabel alloc]init];
        self.countUser.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        self.countUser.text = @"0";
        [_view addSubview:self.countUser];
        [self.countUser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.squreLable.mas_left).with.offset(0);
            make.centerY.equalTo(self.allPeople.mas_centerY).with.offset(0);
            make.width.greaterThanOrEqualTo(self.allMianjiLable.mas_width);
            make.height.equalTo(self.squreLable);
            
        }];
////
        self.kaifashangLable = [[UILabel alloc]init];
        self.kaifashangLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        self.kaifashangLable.text = @"开发商:";
        [_view addSubview:self.kaifashangLable];
        [self.kaifashangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.allMianjiLable.mas_centerX).with.offset(0);
            make.centerY.equalTo(self.jugongLable.mas_centerY).with.offset(0);
            make.width.greaterThanOrEqualTo(self.allMianjiLable.mas_width);
            make.height.equalTo(self.allMianjiLable.mas_height);
            
        }];
        self.componyLableName = [[UILabel alloc]init];
        self.componyLableName.numberOfLines =0;
      
        [self.componyLableName setFont:[UIFont systemFontOfSize:PL_USER_fONT_SIZE]];
        
        
     
        [_view addSubview:self.componyLableName];
        [self.componyLableName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.squreLable.mas_left).with.offset(0);
            make.centerY.equalTo(self.kaifashangLable.mas_centerY).with.offset(0);
            make.width.equalTo(@100);
            make.height.greaterThanOrEqualTo(self.squreLable.mas_height);
            
        }];
//        NSLog(@"%@--%f ",self.kaifashangLable.mas_width,self.cellHeight);
        
      
        
        
       
        
        
        
        
    }
    return self;
    
}
- (void)setCellChangeHeight_roomDistrict:(NSString *)string
{
  _cellframe  = [self frame];
    
    self.roomDistrictLable.text = string;
    self.roomDistrictLable.numberOfLines = 0;
    self.roomDistrictLable.contentMode = UIViewContentModeTop;
    //self.roomDistrictLable.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByCharWrapping;
    CGSize sizeBig = [self getSizeWithWidth:CGRectGetWidth(self.areaLable.frame) content:self.roomDistrictLable.text font:PL_USER_fONT_SIZE];
    self.roomDistrictLable.frame = CGRectMake(CGRectGetMaxX(self.addreLable.frame), CGRectGetMinY(self.addreLable.frame)+8, sizeBig.width, sizeBig.height);
    _view.frame =CGRectMake(0, CGRectGetMaxY(self.roomDistrictLable.frame)+3, PL_WIDTH, 100);
    
    
     _cellframe.size.height = sizeBig.height+40+CGRectGetHeight(_view.frame)+15;
    self.frame = _cellframe;
    
}
- (void)layoutIfNeeded{
    
}
-  (void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
    
}
/*
+ (CGFloat)heightForRowWithModel:(PhotoInfo *)photoInfo
{
    //1.图片的高度
    //让图片等比例缩放
    //(1)获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ZZ" ofType:@"png"]];
    CGFloat imageHeight = [self heightForImage:image];
    //2.文本的高度
    CGFloat textHeight = [self heightForText:photoInfo.introduction];
    //3.返回cell 的总高度
    return kPhotoCell_TitleLabel_Height + imageHeight + textHeight + 4 * kPhotoCell_MarginBetween;
}
 */
/*
//单独计算图片的高度
+ (CGFloat)heightForImage:(UIImage *)image
{
    //(2)获取图片的大小
    CGSize size = image.size;
    //(3)求出缩放比例
    CGFloat scale = kPhotoCell_Width / size.width;
    CGFloat imageHeight = size.height * scale;
    return imageHeight;
}
 */
//单独计算文本的高度
+ (CGFloat)heightForText:(NSString *)text
{
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE]};
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
    
}
@end
