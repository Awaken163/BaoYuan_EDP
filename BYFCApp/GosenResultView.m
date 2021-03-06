//
//  GosenResultView.m
//  BYFCApp
//
//  Created by PengLee on 15/5/22.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GosenResultView.h"
#import "PL_Header.h"
@interface GosenResultView()<UITextFieldDelegate>
{
    GoseeResultTableViewCell *goseeTableViewCell;
    UIView *typeView;
    NSString * _goseeID;
    NSString *_typeString;
    NSString *_dateTimeString;
    BOOL isSednd2;
}
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;
//@property (weak, nonatomic) IBOutlet UITableView *dataSourcesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *downOrupImageView;
@property (weak, nonatomic) IBOutlet UIButton *timeSelectButton;
@property (weak, nonatomic) IBOutlet UIView *buttomView;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;


@end
@implementation GosenResultView
- (IBAction)rightCloseButton:(UIButton *)sender {
    [self removeFromSuperview];
}

-(NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
-(instancetype)initWithFrame:(CGRect)frame isBool:(BOOL)isbool {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"GosenResultView" owner:self options:nil].lastObject;
        self.frame = frame;
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.7];
//        _resultTextField.returnKeyType=UIReturnKeyDefault;
        [self.dataSourcesTableView registerNib:[UINib nibWithNibName:@"GoseeResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"goseeCellReusedID"];
        self.dataSourcesTableView.delegate = self;
        self.dataSourcesTableView.dataSource = self;
//        [self setupRefresh];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        //键盘消失
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
         isSednd2  = isbool;
        
        [self loadView];
        
    }
    return self;
}
-(void)loadView
{
    
}
-(void)addSelfInAView:(UIView *)sup andGoseeID:(NSString *)goseeID
{
    [sup addSubview:self];
    [self bringSubviewToFront:sup];
    [self fadeIn];
    [self postRequest:goseeID];
    _goseeID = goseeID;
}
-(void)postSetGoSeeRecord
{
      [[MyRequest defaultsRequest]afSetgoSeeRecordWithGoSeeID:_goseeID RecordReMark:self.resultTextField.text DateTime:_dateTimeString Type:_typeString completeBack:^(NSString *str) {
        
        if ([str isEqualToString:@"NOLOGIN"]) {
//            ViewController *login=[[ViewController alloc]init];
            
        }
        if ([str isEqualToString:@"[]"]) {
            
//            UILabel * label = [[UILabel alloc]init];
//            label.text = @"暂无数据";
//            label.textAlignment = NSTextAlignmentCenter;
//            PL_ALERT_SHOW(@"暂无私客数据");
            [self.dataSourceArray removeAllObjects];
            [self.dataSourcesTableView reloadData];
            
        }
        if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [self.dataSourceArray removeAllObjects];
            [self.dataSourcesTableView reloadData];
            
        }
        if ([str isEqualToString:@"OK"]) {
            PL_ALERT_SHOW(@"添加成功");
            [self fadeOut];
        }
        if ([str isEqualToString:@"ERR"]) {
            PL_ALERT_SHOW(@"添加失败");
        }
        
    }];
}

-(void)postRequest:(NSString *)string
{
    if (isSednd2 == YES) {
        return;
    }
    [[MyRequest defaultsRequest]afGetGoSeeRecordWithGoSeeID:string completeBack:^(NSString *str) {
        NSLog(@"%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
//            ViewController *login=[[ViewController alloc]init];
               }
        if ([str isEqualToString:@"[]"]) {
            
//            UILabel * label = [[UILabel alloc]init];
//            label.text = @"暂无数据";
//            label.textAlignment = NSTextAlignmentCenter;
//            PL_ALERT_SHOW(@"暂无数据");
            [self.dataSourceArray removeAllObjects];
            [self.dataSourcesTableView reloadData];
            
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [self.dataSourceArray removeAllObjects];
            [self.dataSourcesTableView reloadData];
            
        }
        else
        {
            
            SBJSON *json=[[SBJSON alloc]init];
            NSArray *array = [json objectWithString:str error:nil];
            [self.dataSourceArray addObjectsFromArray:array];
            [self.dataSourcesTableView reloadData];
        }
    
    }];
}

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)fadeOut
{
//    [UIView animateWithDuration:.25 animations:^{
//        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
//        self.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [self removeFromSuperview];
//        }
//    }];
    [_resultTextField resignFirstResponder];
    _lableJieGu.text = @"";
    [_lableLX setTitle:@"" forState:UIControlStateNormal];
    _lmg.image = [UIImage imageNamed:@""];
    self.frame = CGRectMake(0, 0, 0, 0);
}



- (IBAction)clickSendButton:(UIButton *)sender
{
    if ([self.typeButton.currentTitle isEqualToString:@"类型"]) {
        PL_ALERT_SHOW(@"请选择预约还是记录");
    }
    else
    {
        [self creatSend];
        [self postSetGoSeeRecord];
        self.resultTextField.text = @"";
      
    }
   
}
-(void)creatSend
{
    
    if ([_typeString isEqualToString:@"记录"]) {
        
      dateTimeButton.hidden = YES;
        
        _dateTimeString = @"";
    }
    if ([_typeString isEqualToString:@"预约"]) {
        _dateTimeString = self.timeSelectButton.currentTitle;
    }
}

- (IBAction)clickTypeButton:(UIButton *)sender
{
    if (!sender.selected) {
        sender.selected = YES;
        [self typeViewFadin:sender];
    }
    else
    {
        sender.selected = NO;
        [self typeViewFadout];
    }

    
    
}
-(void)typeViewFadout
{
    [typeView removeFromSuperview];
}
-(void)typeViewFadin:(UIButton *)sender
{
    CGRect fram = sender.frame;
    typeView = [[UIView alloc]initWithFrame:CGRectMake(fram.origin.x, fram.origin.y  + fram.size.height + 1, fram.size.width+20, 60)];
    [sender.superview addSubview:typeView];
    typeView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:1];
    UIButton *typeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, typeView.frame.size.width, 30)];
    [typeButton setTitle:@"预约" forState:UIControlStateNormal];
    [typeView addSubview:typeButton];
    [typeButton addTarget:self action:@selector(clickYuyueButton:) forControlEvents:UIControlEventTouchUpInside];
    typeButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    typeButton.layer.borderWidth = 1.0f;
    UIButton *timeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, typeView.frame.size.width, 30)];
    
    [typeView addSubview:timeButton];
    [timeButton setTitle:@"记录" forState:UIControlStateNormal];
    timeButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    timeButton.layer.borderWidth = 1.0f;
    [timeButton addTarget:self action:@selector(clickRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)clickYuyueButton:(UIButton *)sender
{
    [self.typeButton setTitle:sender.currentTitle forState:UIControlStateNormal];
    self.typeButton.selected = NO;
    dateTimeButton.hidden = NO;
    [self typeViewFadout];
    [self.timeSelectButton setTitle:@"点此选择时间" forState:UIControlStateNormal];

    _typeString = sender.currentTitle;
    
}
-(void)clickRecordButton:(UIButton *)sender
{
    [self.typeButton setTitle:sender.currentTitle forState:UIControlStateNormal];
    self.typeButton.selected = NO;
    dateTimeButton.hidden = YES;
    [self typeViewFadout];
    [self.timeSelectButton setTitle:@"" forState:UIControlStateNormal];
    _typeString = sender.currentTitle;

}


- (IBAction)clicTimeSelectButton:(UIButton *)sender
{
    if ([self.typeButton.currentTitle isEqualToString:@"预约"]) {
        DatePickerView *datapicker = [[DatePickerView alloc]initWithFrame:self.frame];
        [datapicker addSelfInAView:self comPleteBlock:^(NSString *str) {
            [sender setTitle:str forState:UIControlStateNormal];
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    goseeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"goseeCellReusedID"];
    if (self.dataSourceArray ) {
        NSDictionary *dic = self.dataSourceArray[indexPath.row];
        goseeTableViewCell.contentLabel.text = dic[@"RecordRemark"];
        goseeTableViewCell.nameLabel.text    = dic[@"EmpName"];
        goseeTableViewCell.timeLabel.text    = dic[@"LastGoSeeTime"];
    }
    return goseeTableViewCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71.0f;
}
//- (void)setupRefresh
//{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
//    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
//    [self.dataSourcesTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    //#warning 自动刷新(一进入程序就下拉刷新)
//    //    [self.tableView headerBeginRefreshing];
//    
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.dataSourcesTableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.dataSourcesTableView.headerPullToRefreshText = @"下拉刷新";
//    self.dataSourcesTableView.headerReleaseToRefreshText = @"松开刷新";
//    self.dataSourcesTableView.headerRefreshingText = @"客源正在刷新中";
//    
//    self.dataSourcesTableView.footerPullToRefreshText = @"上拉加载更多数据";
//    self.dataSourcesTableView.footerReleaseToRefreshText = @"松开加载更多数据";
//    self.dataSourcesTableView.footerRefreshingText = @"客源正在加载中";
//}
//
//#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    pagecount ++;
//    [self postRequest];
//    [self.sourcesTableView headerEndRefreshing];
//}
//
//- (void)footerRereshing
//{
//    pagecount ++ ;
//    [self postRequest];
//    [self.sourcesTableView footerEndRefreshing];
//    
//}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    GoseeResultTableViewCell *cell = goseeTableViewCell;
//    cell.translatesAutoresizingMaskIntoConstraints = NO;
//    cell.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    NSDictionary *dic = self.dataSourceArray[indexPath.row];
//    goseeTableViewCell.contentLabel.text = dic[@"RecordRemark"];
//    
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height + 1;
//    
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self fadeOut];
    [_resultTextField resignFirstResponder];
//    _lableJieGu.text = @"";
//    [_lableLX setTitle:@"" forState:UIControlStateNormal];
//    _lmg.image = [UIImage imageNamed:@""];
//    [self removeFromSuperview];
//    _dataSourcesTableView.frame = CGRectMake(0, 0, 0, 0);
//    [self clearTel:nil];
    
}

- (IBAction)textFiledReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}
- (void)clearTel:(UIGestureRecognizer *)tap
{
    [self fadeOut];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -200);
    //使视图使用这个变换
    self.transform = pTransform;
    //_scroll1.contentSize=CGSizeMake(PL_WIDTH, PL_HEIGHT*1.2);
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // 创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    self.transform = pTransform;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
