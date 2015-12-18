//
//  TimeFilterView.h
//  BYFCApp
//
//  Created by PengLee on 15/5/5.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureMenuViewController.h"
@protocol TimeFilterViewDelegate<NSObject>
@optional
-(void)whichButtonClick:(UIButton *)sender;
@end

@interface TimeFilterView : UIView<TimeFilterViewDelegate>
@property(nonatomic,weak) id<TimeFilterViewDelegate>delegate;


 /*  <#Description#>
 *
 *  @param frame      视图frame
 *  @param titleArray 视图标题数组
 *
 *  @return self       视图本身
 */
-(id)initWithFrame:(CGRect)frame ;
@end
