//
//  RoomFollowUpListViewController.m
//  BYFCApp
//
//  Created by zzs on 15/5/22.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RoomFollowUpListViewController.h"
#import "PL_Header.h"
@interface RoomFollowUpListViewController ()<CustomDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //跟进列表
    UITableView *FollowUpListTableView;
    __weak IBOutlet UILabel *quyuLable;

    __weak IBOutlet UILabel *pianquLable;
    __weak IBOutlet UIButton *firstdateTimeButton;
    __weak IBOutlet UIButton *lastdateTimeButton;

    __weak IBOutlet UIButton *quyuButton;
    
    NSMutableArray *_followListArray;
    
    //页数记录器
    NSInteger pageCount;
    
    //定义字符串判断领导与业务员
    NSString * flagSubs;
}

@property(nonatomic,strong)NSString *roomdutycode;

@end

@implementation RoomFollowUpListViewController
-(NSString *)roomdutycode
{

if (_roomdutycode == nil) {
NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
_roomdutycode = [[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)];
}
return _roomdutycode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跟进查询";
    self.navigationController.navigationBarHidden=NO;
    quyuButton.layer.borderColor = [UIColor blackColor].CGColor;
    //quyuButton.layer.borderWidth = 0.5;
    //初始化页数
    pageCount = 1;
    //判断领导与业务员
    [self isBoss];
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
   //初始化跟进列表
    [self formatFollowUpList];
    //刷新
    [self  setupRefresh];
    
    
}
#pragma mark -----自定义返回按钮方法
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---区域按钮
- (IBAction)QuyuButton:(UIButton *)sender {
    
    [self post];
    
}
#pragma mark ----第一个日期
- (IBAction)FirstdateTimeButton:(UIButton *)sender {
    
    DatePickerView *datePickerView = [[DatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [datePickerView addSelfInAView:self.view comPleteBlock:^(NSString *str) {
        
        NSLog(@"%@",str);
        [firstdateTimeButton setTitle:str forState:UIControlStateNormal];
        firstdateTimeStr = str;
        NSLog(@"%@",firstdateTimeStr);
       
        
    }];

}
#pragma mark ----第二个日期
- (IBAction)LastdateTimeButton:(UIButton *)sender {
    
    DatePickerView *datePickerView = [[DatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [datePickerView addSelfInAView:self.view comPleteBlock:^(NSString *str) {
        
        [lastdateTimeButton setTitle:str forState:UIControlStateNormal];
        lastdateTimeStr = str;
        NSLog(@"%@",lastdateTimeStr);

        
    }];

    
}

#pragma mark ---判断领导与业务员
-(void)isBoss{
    
    if ([_roomdutycode isEqualToString:@"E"]) {
        flagSubs =@"0";
        _dutyCode  = _roomdutycode;
    }else
    {
        flagSubs = @"1";
    }
    
    
}


#pragma mark ----搜索按钮
- (IBAction)searchButton:(UIButton *)sender {

     pageCount = 1;
    NSLog(@"%@",_quyuStr);
    NSLog(@"%@",_pianquStr);
    NSLog(@"%@",firstdateTimeStr);
    NSLog(@"%@",lastdateTimeStr);
    
    if (_quyuStr ==nil) {
        _quyuStr=@"";
    }
    if (_pianquStr==nil) {
        _pianquStr=@"";
    }
    if (firstdateTimeStr==nil) {
        firstdateTimeStr=@"";
    }
    if (lastdateTimeStr==nil) {
        lastdateTimeStr=@"";
    }
    if (_dutyCode == nil) {
        _dutyCode = @"";
    }
    NSLog(@"%@",_dutyCode);
    
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetFollowListDistrictName:_quyuStr AreaName:_pianquStr FollowDateFrom:firstdateTimeStr FollowDateTo:lastdateTimeStr FlagSubs:flagSubs SubUserCode:_dutyCode StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount]  completeBack:^(NSString *str) {
        
        NSLog(@"%@",str);
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无跟进数据");
            [_followListArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_followListArray removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _followListArray=[json objectWithString:str error:nil];
            NSLog(@"_followListArray   %@",_followListArray);
          //  NSLog(@"%lu",(unsigned long)_followListArray.count);
            //NSLog(@"---------------------------->>>>>>>%@",_array);
        }
        [FollowUpListTableView reloadData];
        PL_PROGRESS_DISMISS;
    }];
}
-(void)post{
    [[VisitersRequest defaultsRequest]requestAreaInfoMessage:@"2" roomDistrictId:@"" roomDisName:@"" userName:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
        if (array.count>0)
        {
            //            NSLog(@"=========%s",__FUNCTION__);
            NSMutableArray * tempArray = [NSMutableArray array];
            for (NSDictionary * dict in array)
            {
                roomAreaPlace * roomArea = [[roomAreaPlace alloc]init];
                roomArea.areaDistrictId = dict[@"DistrictId"];
                roomArea.areaDistrictName =dict[@"DistrictName"];
                NSLog(@"++++++%@,%@",roomArea.areaDistrictId,roomArea.areaDistrictName);
                [tempArray addObject:roomArea];
            }
            roomAreaPlace * virtuRoom = [[roomAreaPlace alloc]init];
            virtuRoom.areaDistrictName = @"不限";
            virtuRoom.areaDistrictId   = @"";
            [tempArray insertObject:virtuRoom atIndex:0];
            CustomAddView * addView = [[CustomAddView alloc]initWithArray:tempArray];
            addView.delegate = nil;
            addView.delegate = self;
            [addView showInView:self.view animation:YES];
        }
        else
        {
            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无区域数据");

        }
        
    } string:^(NSString *string) {
        
    }];

}
#pragma mark -----初始化跟进列表
-(void)formatFollowUpList{
    
    FollowUpListTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 140, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-140) style:UITableViewStylePlain];
    FollowUpListTableView.delegate=self;
    FollowUpListTableView.dataSource=self;
    FollowUpListTableView.tableFooterView=[UIView new];
    FollowUpListTableView.rowHeight = 144;
    [FollowUpListTableView registerNib:[UINib nibWithNibName:@"RoomGenjinTableViewCell" bundle:nil] forCellReuseIdentifier:@"roomGenjinCell"];
    //FollowUpListTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    //subVisterTableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:FollowUpListTableView];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _followListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

 
    NSDictionary *dict = [_followListArray objectAtIndex:indexPath.row];
    
         RoomGenjinTableViewCell *roomGenjinCell = [tableView dequeueReusableCellWithIdentifier:@"roomGenjinCell"];
  
    roomGenjinCell.UserName.text = [dict objectForKey:@"UserName"];
    roomGenjinCell.DistrictName.text = [dict objectForKey:@"DistrictName"];
     roomGenjinCell.AreaName.text = [dict objectForKey:@"AreaName"];
     roomGenjinCell.EstateName.text = [dict objectForKey:@"EstateName"];
     roomGenjinCell.FollowWay.text = [dict objectForKey:@"FollowWay"];
     roomGenjinCell.FollowType.text = [dict objectForKey:@"FollowType"];
     roomGenjinCell.FollowDate.text = [[[dict objectForKey:@"FollowDate"] stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:19];
    roomGenjinCell.Content.text = [dict objectForKey:@"Content"];

    
    return roomGenjinCell;
 
}





-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath administrativeArea:(NSString *)adminnistat
{
    quyuLable.text = adminnistat;
    if ([adminnistat isEqualToString:@"不限"]) {
        _quyuStr = @"";
        _quyuStr = @"";
    }
    else
    {
        _quyuStr = adminnistat;
        _pianquStr = @"";
    }
}

-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath sadministativeArea:(NSString *)adminnistat
{
    
    if ([adminnistat isEqualToString:@"全部片区"])
    {
        _pianquStr = @"";
    }
    else
    {
      
        pianquLable.text = adminnistat;
        _pianquStr = adminnistat;
    }
}

#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [FollowUpListTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [FollowUpListTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    FollowUpListTableView.headerPullToRefreshText = @"下拉刷新";
    FollowUpListTableView.headerReleaseToRefreshText = @"松开刷新";
    FollowUpListTableView.headerRefreshingText = @"正在刷新中";
    
    FollowUpListTableView.footerPullToRefreshText = @"上拉加载更多数据";
    FollowUpListTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    FollowUpListTableView.footerRefreshingText = @"正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSLog(@"---%@",_dutyCode);
    NSLog(@"---%@",_quyuStr);
    NSLog(@"---%@",_pianquStr);
    NSLog(@"---%@",firstdateTimeStr);
    NSLog(@"---%@",lastdateTimeStr);
    NSLog(@"---%ld",(long)pageCount);
    
    if (_quyuStr ==nil) {
        _quyuStr=@"";
    }
    if (_pianquStr==nil) {
        _pianquStr=@"";
    }
    if (firstdateTimeStr==nil) {
        firstdateTimeStr=@"";
    }
    if (lastdateTimeStr==nil) {
        lastdateTimeStr=@"";
    }

    
    pageCount ++;
    [[MyRequest defaultsRequest]afGetFollowListDistrictName:_quyuStr AreaName:_pianquStr FollowDateFrom:firstdateTimeStr FollowDateTo:lastdateTimeStr FlagSubs:flagSubs SubUserCode:_dutyCode StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount]  completeBack:^(NSString *str) {
        
        NSLog(@"%@",str);
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无跟进数据");
            // [_followListArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            // [_followListArray removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _followListArray=[json objectWithString:str error:nil];
            NSLog(@"_followListArray   %@",_followListArray);
            //  NSLog(@"%lu",(unsigned long)_followListArray.count);
            //NSLog(@"---------------------------->>>>>>>%@",_array);
            
        }
        [FollowUpListTableView reloadData];
        [FollowUpListTableView headerEndRefreshing];
        
        PL_PROGRESS_DISMISS;
 
    }];
}
- (void)footerRereshing
{
    pageCount ++;
    [[MyRequest defaultsRequest]afGetFollowListDistrictName:_quyuStr AreaName:_pianquStr FollowDateFrom:firstdateTimeStr FollowDateTo:lastdateTimeStr FlagSubs:flagSubs SubUserCode:_dutyCode StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount]  completeBack:^(NSString *str) {
        
        NSLog(@"%@",str);
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无跟进数据");
            // [_followListArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            // [_followListArray removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            [_followListArray addObjectsFromArray:[json objectWithString:str error:nil]];
            //_followListArray=[json objectWithString:str error:nil];
            NSLog(@"_followListArray   %@",_followListArray);
            //  NSLog(@"%lu",(unsigned long)_followListArray.count);
            //NSLog(@"---------------------------->>>>>>>%@",_array);
            
        }
        [FollowUpListTableView reloadData];
        //结束刷新
        [FollowUpListTableView footerEndRefreshing];

        
        PL_PROGRESS_DISMISS;
        
    }];
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
