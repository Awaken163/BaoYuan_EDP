//
//  CheckVC.m
//  BYFCApp
//
//  Created by PengLee on 14/12/16.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "CheckVC.h"
#import "PL_Header.h"
@interface CheckVC ()<UIWebViewDelegate>

@end

@implementation CheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的审核";
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(10, 10, 15, 25);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PL_USER_CHECK_URL,[PL_USER_STORAGE objectForKey:PL_USER_NAME]]];
    
    
    
    
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    
       self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, PL_WIDTH, PL_HEIGHT-64)];
    [web loadRequest:request];
    web.scalesPageToFit = NO;
   // web.scrollView.scrollEnabled = YES;
    web.delegate = self;
    web.scrollView.showsHorizontalScrollIndicator = NO;
    web.scrollView.alwaysBounceHorizontal = YES;
   // web.scrollView.bounces = YES;
    
    web.scrollView.contentSize = CGSizeMake(0, PL_HEIGHT-64);
    //改变成左右滑动的样式
    
   // web.transform = CGAffineTransformMakeRotation(M_PI/-2);
    
                                                  
    web.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    
    [self.view addSubview:web];
    PL_PROGRESS_SHOW;
   // [[ShowActivityLoad shareDefault] setBaseProgressUI];
   //隐藏滚动条和上下滚动是出边界的后面的黑色
    web.backgroundColor = [UIColor clearColor];
    for (UIView * _aView in [web subviews])
    {
        [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
        for (UIView * _inScrollow in _aView.subviews)
        {
            if ([_inScrollow isKindOfClass:[UIImageView class]])
            {
                _inScrollow.hidden = YES;
            }
        }
        [(UIScrollView *)_aView setPagingEnabled:YES];
    }
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    PL_PROGRESS_SHOW;
        return YES;
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [[ShowActivityLoad shareDefault] showErrorAndStatus];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[ShowActivityLoad shareDefault]dismissProgress];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end