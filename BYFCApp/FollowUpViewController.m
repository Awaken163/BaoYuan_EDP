//
//  FollowUpViewController.m
//  BYFCApp
//
//  Created by zzs on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "FollowUpViewController.h"
#import "PL_Header.h"
@interface FollowUpViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    __weak IBOutlet UIButton *daqufuzongButton;
    __weak IBOutlet UIButton *quyuzongjianButton;
    __weak IBOutlet UIButton *quyujingliButton;
    __weak IBOutlet UIButton *fenhangjingliButton;
    __weak IBOutlet UIButton *yewuyuanButton;
    NSString *userCodeString;
    NSString *dutyCodeString;
    //保存请求出来的数据
    NSMutableArray * screenArray;
    NSString *showLevelStr;
    NSString *flgStr;
    
    
}
@property(nonatomic,assign) NSInteger levelNum;
@property(nonatomic,assign) NSInteger virtulIndex;
@property(nonatomic,copy) void (^userStringBlock)(NSDictionary *);
@property (nonatomic,strong) UITableView  *dropDownTableView;
//用户等级
@property(nonatomic,copy) NSString *dutycode;
@property(nonatomic,copy) NSMutableArray *virtulArray;
@end

@implementation FollowUpViewController
-(NSMutableArray *)virtulArray
{
    if (!_virtulArray) {
        _virtulArray = [[NSMutableArray alloc]init];
        [_virtulArray addObject:@{@"UserCode":@""}];
        [_virtulArray addObject:@{@"UserCode":@""}];
        [_virtulArray addObject:@{@"UserCode":@""}];
        [_virtulArray addObject:@{@"UserCode":@""}];
        [_virtulArray addObject:@{@"UserCode":@""}];
    }
    return _virtulArray;
}

-(UITableView *)dropDownTableView{

    if (!_dropDownTableView ) {
        _dropDownTableView = [[UITableView alloc]init];
        _dropDownTableView.delegate = self;
        _dropDownTableView.dataSource = self;
        //_dropDownTableView.backgroundColor = [UIColor grayColor];
    }
    return _dropDownTableView;
}
-(NSString *)dutycode{
   
    if (_dutycode == nil) {
        NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
        _dutycode = [[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)];
    }
    return _dutycode;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    showLevelStr = @"";
    flgStr = @"0";
    NSLog(@"-----------<>>>>>>%@",self.dutycode);
    self.title = _titleStr;
    //导航栏隐藏属性设置
    self.navigationController.navigationBarHidden = NO;
    
    //给usercodeing赋值
    userCodeString = [PL_USER_STORAGE objectForKey:PL_USER_code];
    NSLog(@"%@",userCodeString);
    //判断点的哪个按钮
    [self findlevenumber];

    
    //请求上级领导
    [self postsup];
    
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}
#pragma mark -----自定义返回按钮方法
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----选择大区
- (IBAction)DaQuButton:(UIButton *)sender {
    //刷新表格数据
    [self.dropDownTableView reloadData];
    quyujingliButton.selected=NO;
    quyuzongjianButton.selected = NO;
    fenhangjingliButton.selected = NO;
    yewuyuanButton.selected = NO;
    showLevelStr = @"YA";
    dutyCodeString = @"A";
    [self getUserCode:0];
    [self post:dutyCodeString];
     // userCodeString = @"";
    
    if (!sender.selected)
    {
        
        self.dropDownTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, 135, 180) ;
        
        [sender.superview addSubview:self.dropDownTableView];
//         self.dropDownTableView.backgroundColor = [UIColor grayColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
    }
    [self getuserCodeByBlock:^(NSDictionary *dic) {
        
        sender.selected = NO;
        [self.virtulArray replaceObjectAtIndex:0 withObject:dic];
//        userCodeString = dic[@"UserCode"];
//        [sender setTitle:@"12233" forState:UIControlStateNormal];
        //NSLog(@">>>>>>>>>>%@",dic[@"usercode"]);
//        [sender setTitle:dic[@"UserName"] forState:UIControlStateNormal];
        [sender setTitle:dic[@"Department"] forState:UIControlStateNormal];
        NSLog(@"<<<<<<<<<%@",sender.currentTitle);
    }];

    
}
-(void)getuserCodeByBlock:(void (^)(NSDictionary *dic))block
{
    self.userStringBlock = nil;
    self.userStringBlock = block;
}

#pragma mark ----选择董事
- (IBAction)QuyuzongjianButton:(UIButton *)sender {
    
    [self EmatyButton:sender];
    
    quyujingliButton.selected=NO;
    daqufuzongButton.selected = NO;
    fenhangjingliButton.selected = NO;
    yewuyuanButton.selected = NO;
    showLevelStr = @"YB";
    dutyCodeString = @"B";
    //userCodeString = @"";
    [self getUserCode:1];
        //请求数据
    [self post:dutyCodeString];

    if (!sender.selected)
    {
        
        self.dropDownTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, 135, 180) ;
        
        [sender.superview addSubview:self.dropDownTableView];
        //         self.dropDownTableView.backgroundColor = [UIColor grayColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
    }

     [self getuserCodeByBlock:^(NSDictionary *dic) {
         sender.selected = NO;
         [self.virtulArray replaceObjectAtIndex:1 withObject:dic];

//         userCodeString = dic[@"UserCode"];
//         [quyuzongjianButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
         [quyuzongjianButton setTitle:dic[@"Department"] forState:UIControlStateNormal];
     }];
    
}
#pragma mark ----选择总监
- (IBAction)QuyujingliButton:(UIButton *)sender {

    [self EmatyButton:sender];
    daqufuzongButton.selected=NO;
    quyuzongjianButton.selected = NO;
    fenhangjingliButton.selected = NO;
    yewuyuanButton.selected = NO;
    showLevelStr = @"YC";
    dutyCodeString = @"C";
    //userCodeString = @"";
    [self getUserCode:2];
    //请求数据
   [self post:dutyCodeString];

    
    if (!sender.selected)
    {
        
        self.dropDownTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, 135, 180) ;
        
        [sender.superview addSubview:self.dropDownTableView];
        //         self.dropDownTableView.backgroundColor = [UIColor grayColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
    }

    [self getuserCodeByBlock:^(NSDictionary *dic) {
        sender.selected = NO;
        [self.virtulArray replaceObjectAtIndex:2 withObject:dic];

//        userCodeString = dic[@"UserCode"];
//        [quyujingliButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
        [quyujingliButton setTitle:dic[@"Department"] forState:UIControlStateNormal];
    }];
    
    
}
#pragma mark ----选择分行经理
- (IBAction)FenhangjingliButton:(UIButton *)sender {

    [self EmatyButton:sender];
    quyujingliButton.selected=NO;
    quyuzongjianButton.selected = NO;
    daqufuzongButton.selected = NO;
    yewuyuanButton.selected = NO;
    showLevelStr = @"YD";
    dutyCodeString = @"D";
    //userCodeString = @"";
    [self getUserCode:3];
    //请求数据
    [self post:dutyCodeString];


    
    if (!sender.selected)
    {
        
        self.dropDownTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, 135, 180) ;
        
        [sender.superview addSubview:self.dropDownTableView];
        //         self.dropDownTableView.backgroundColor = [UIColor grayColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
    }
    
    [self getuserCodeByBlock:^(NSDictionary *dic) {
        sender.selected = NO;
        [self.virtulArray replaceObjectAtIndex:3 withObject:dic];
//        userCodeString = dic[@"UserCode"];
        [fenhangjingliButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
        
    }];
    

}
#pragma mark ----选择客户经理
- (IBAction)YewuyuanButton:(UIButton *)sender {

    [self EmatyButton:sender];
    quyujingliButton.selected=NO;
    quyuzongjianButton.selected = NO;
    fenhangjingliButton.selected = NO;
    daqufuzongButton.selected = NO;
    showLevelStr = @"YE";
    dutyCodeString = @"E";
    //请求数据
    [self getUserCode:4];
    [self post:dutyCodeString];

    if (!sender.selected)
    {
        
        self.dropDownTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, 135, 180) ;
        
        [sender.superview addSubview:self.dropDownTableView];
        //         self.dropDownTableView.backgroundColor = [UIColor grayColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
    }
    //回调
    [self getuserCodeByBlock:^(NSDictionary *dic) {
        sender.selected = NO;
        [self.virtulArray replaceObjectAtIndex:4 withObject:dic];
//        userCodeString = dic[@"UserCode"];
        [yewuyuanButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
        
    }];

}
#pragma mark -- 获取usercode
-(void)getUserCode:(int)row
{
    NSLog(@"row      %d",row);
    
    for (int index = row; index < self.virtulArray.count  ; index++) {
        [self.virtulArray replaceObjectAtIndex:index withObject:@{@"UserCode":@""}];
    }
//    NSLog(@"%@",self.virtulArray[row - 1]);
    for (int index = row ;index >= 0; index--) {
        NSLog(@"+++++++++++%d",index);
        NSDictionary *dic = self.virtulArray[index];
        NSString *str = dic[@"UserCode"];
        NSLog(@">>>>>>>>>>>>>>+++++%@",dic);

        NSLog(@"%@",str);
        if (str.length != 0) {
            
            NSLog(@"<<<<<<<<>>>>>>>>>>>>>>%@",str);
            userCodeString =str;
            break;
        }
        if (index == 0 && str.length == 0) {
            userCodeString = [PL_USER_STORAGE objectForKey:PL_USER_code];
        }
    }

}

#pragma mark ----提交
- (IBAction)SendButton:(UIButton *)sender {
    
    NSString *codeStr ;
    
    for (int index = (int)self.virtulArray.count - 1; index >= 0; index --) {
        NSDictionary *dic = self.virtulArray[index];
        NSString *str = dic[@"UserCode"];
        if (str.length != 0) {
            codeStr = str;
            break;
        }
        if (index == 0 && str.length != 0) {
            codeStr = [PL_USER_STORAGE objectForKey:PL_USER_code];
        }
    }
    NSLog(@"++++++++++++++++++::::::::::::::::%@",self.virtulArray.lastObject);
    if ([_fromString isEqualToString:@"客源"])
    {
        if ([self.toString isEqualToString:@"带看"]) {
            LookAboutViewController *lookAboutVC = [[LookAboutViewController alloc]init];
            lookAboutVC.subUserCode = codeStr;
            [self.navigationController pushViewController:lookAboutVC animated:YES];
        }
        else
        {
        FollowUpListViewController *followuplistVc = [[FollowUpListViewController alloc]init];
        followuplistVc.dutyCode = codeStr;
        [self.navigationController pushViewController:followuplistVc animated:YES];
        }
    }
    else if ([_fromString isEqualToString:@"房源"])
    {
    
        if ([self.toString isEqualToString:@"带看"]) {
            LookAboutViewController *lookAboutVC = [[LookAboutViewController alloc]init];
            lookAboutVC.subUserCode = codeStr;
            [self.navigationController pushViewController:lookAboutVC animated:YES];
        }
        else
        {
        RoomFollowUpListViewController *roomFollowUpListVc = [[RoomFollowUpListViewController alloc]init];
        roomFollowUpListVc.dutyCode = codeStr;
        [self.navigationController pushViewController:roomFollowUpListVc animated:YES];
        }
    }
  
    
}

#pragma mark ----清空
- (IBAction)EmatyButton:(UIButton *)sender {
   
    if (sender.tag > 0) {
        for (UIView *view  in self.view.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                if (view.tag > sender.tag) {
                    [((UIButton *)view) setTitle:@"" forState:UIControlStateNormal];
                }
                
            }
        }

    }
    else
    {
        
        for (UIView *view  in self.view.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                if (view.tag > self.levelNum) {
                    [((UIButton *)view) setTitle:@"" forState:UIControlStateNormal];
                }
                
            }
        }
        for (NSInteger index = self.virtulIndex + 1; index < self.virtulArray.count; index++) {
            [self.virtulArray replaceObjectAtIndex:index withObject:@{@"UserCode":@""}];
        }

    }
    
}




-(void)postsup
{
    NSLog(@"%s",__FUNCTION__);
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetSupFromSnapshot:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
    
        NSLog(@">>>>>>>>>>>>>>>>>%@",str);
        
        SBJSON *json = [[SBJSON alloc]init];
        
        NSArray *array = [json objectWithString:str error:nil];
        
        for (NSDictionary *dic in array) {
            
            if ([dic[@"Sort"] isEqualToString:@"A"]) {
               
//                [daqufuzongButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
                if([daqufuzongButton.titleLabel.text isEqualToString:@""] || daqufuzongButton.titleLabel.text == nil
                   ){
                    [daqufuzongButton setTitle:dic[@"Department"] forState:UIControlStateNormal];
                }
            }
            if ([dic[@"Sort"] isEqualToString:@"B"]) {
                
//                [quyuzongjianButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
                if([quyuzongjianButton.titleLabel.text isEqualToString:@""] || quyuzongjianButton.titleLabel.text == nil
                   ){
                    [quyuzongjianButton setTitle:dic[@"Department"] forState:UIControlStateNormal];
                }
            }
            if ([dic[@"Sort"] isEqualToString:@"C"]) {
                
//                [quyujingliButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
                if([quyujingliButton.titleLabel.text isEqualToString:@""] || quyujingliButton.titleLabel.text == nil
                   ){
                    [quyujingliButton setTitle:dic[@"Department"] forState:UIControlStateNormal];
                }
            }
            if ([dic[@"Sort"] isEqualToString:@"D"]) {
                
                [fenhangjingliButton setTitle:dic[@"UserName"] forState:UIControlStateNormal];
            }
            
        }
        
        PL_PROGRESS_DISMISS;

    }];
}



-(void)findlevenumber
{
    NSLog(@"%@",self.dutycode);
    if ([self.dutycode isEqualToString:@"A"] && ![[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"]) {
        daqufuzongButton.userInteractionEnabled=NO;
        self.levelNum = 3;
        self.virtulIndex = 0;
//        [daqufuzongButton setTitle:[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME] forState:UIControlStateNormal];
        [self.virtulArray replaceObjectAtIndex:0 withObject:@{@"UserCode":[PL_USER_STORAGE objectForKey:PL_USER_code]}];
        
    };
    if ([self.dutycode isEqualToString:@"B"]) {
       
        daqufuzongButton.userInteractionEnabled=NO;
        quyuzongjianButton.userInteractionEnabled = NO;
        self.levelNum = 4;
        self.virtulIndex = 1;

//        [quyuzongjianButton setTitle:[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME] forState:UIControlStateNormal];
                [self.virtulArray replaceObjectAtIndex:1 withObject:@{@"UserCode":[PL_USER_STORAGE objectForKey:PL_USER_code]}];
        
        
    };
    if ([self.dutycode isEqualToString:@"C"]) {
        NSLog(@"Ccccccccccc");
        daqufuzongButton.userInteractionEnabled=NO;
        quyuzongjianButton.userInteractionEnabled = NO;
        quyujingliButton.userInteractionEnabled = NO;
        self.levelNum = 5;
        self.virtulIndex = 2;

//        [quyujingliButton setTitle:[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME] forState:UIControlStateNormal];
                [self.virtulArray replaceObjectAtIndex:2 withObject:@{@"UserCode":[PL_USER_STORAGE objectForKey:PL_USER_code]}];
        NSLog(@"%@",self.virtulArray[2]);
        
        
        
    };
    if ([self.dutycode isEqualToString:@"D"]) {
        daqufuzongButton.userInteractionEnabled=NO;
        quyuzongjianButton.userInteractionEnabled = NO;
        quyujingliButton.userInteractionEnabled = NO;
        fenhangjingliButton.userInteractionEnabled=NO;
//        [fenhangjingliButton setTitle:[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME] forState:UIControlStateNormal];
                [self.virtulArray replaceObjectAtIndex:3 withObject:@{@"UserCode":[PL_USER_STORAGE objectForKey:PL_USER_code]}];
        self.levelNum = 6;
        self.virtulIndex = 3;

        
        
    };
    if ([self.dutycode isEqualToString:@"E"]) {
        
        self.levelNum = 7;
        self.virtulIndex = 4;

                [self.virtulArray replaceObjectAtIndex:4 withObject:@{@"UserCode":[PL_USER_STORAGE objectForKey:PL_USER_code]}];
        
    };
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return screenArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    NSDictionary *dict = [screenArray objectAtIndex:indexPath.row];
    //cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.text = [dict objectForKey:@"UserName"];
    if([dict[@"Sort"] isEqualToString:@"A"] || [dict[@"Sort"] isEqualToString:@"B"] || [dict[@"Sort"] isEqualToString:@"C"]){
        cell.textLabel.text = [dict objectForKey:@"Department"];
        
    }else{
        cell.textLabel.text = [dict objectForKey:@"UserName"];
        
    }

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [screenArray objectAtIndex:indexPath.row];
    if ([dic[@"UserName"] isEqualToString:@"直属"]) {
        flgStr = @"1";
    }
    else
    {
        flgStr = @"0";
    }
    self.userStringBlock(dic);
    [self.dropDownTableView removeFromSuperview];
    
}


-(void)post:(NSString *)dutyCode{

//    [[MyRequest defaultsRequest]afGetSubordinateNewuserCode:userCodeString DutyCode:dutyCodeString StartIndex:@"1" completeBack:^(NSString *str) {
    [[MyRequest defaultsRequest]afGetSubordinateNewuserCode:userCodeString FLG:flgStr Status:@"0" ShowLevel:showLevelStr completeBack:^(NSString *str) {

        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>%@",str);
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
//            UILabel * label = [[UILabel alloc]init];
//            label.text = @"暂无数据";
//            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无数据");
            [self.dropDownTableView removeFromSuperview];

            [screenArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [screenArray removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            screenArray=[json objectWithString:str error:nil];
            
            NSLog(@"%lu",(unsigned long)screenArray.count);
            //NSLog(@"---------------------------->>>>>>>%@",_array);
            
        }
        [self.dropDownTableView reloadData];
        
        
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
