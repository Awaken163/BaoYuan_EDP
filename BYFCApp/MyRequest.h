//
//  MyRequest.h
//  BYFCApp
//
//  Created by PengLee on 14/12/2.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PL_Header.h"
#import "RoomData.h"
#import "VisiterData.h"
#import "AppointVisiterData.h"
#import "PriceRangeData.h"
#import "CustomersFollowData.h"
#import "ADDPropertyContactData.h"
#import "CustFollowListData.h"
#import "WebData.h"
#import "AddData.h"
#import "CardData.h"
#import "VisiterUpdate.h"
typedef NS_ENUM(NSInteger, NETWORK_TYPE_TEST) {
    NETWORK_TYPE_TEST_NONE = 0,//没有网络
    NETWORK_TYPE_TEST_2G = 1, //2G网络
    NETWORK_TYPE_TEST_3G = 2,
    NETWORK_TYPE_TEST_4G = 3,
    NETWORK_TYPE_TEST_5G = 4,
    NETWORK_TYPE_TEST_WIFI = 5,
    
    
};
@protocol PersonDelegate;

@interface MyRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
{
    NSMutableData       * _resultData;
    NSXMLParser         * _xmlParser;
    NSMutableString     * _soapResults;
    BOOL                recordResults;
    //
    NSURLConnection      *connection;
    RoomData            *roomSourceInfo;
    UIAlertView *aler;
    //id delegate;
    
}

@property(nonatomic,copy)void (^blockCall)(NSMutableString * string);
@property(nonatomic,copy)void (^blockString)(NSString  * string);
@property(nonatomic,copy)void (^blockArray)(NSMutableArray * array);
@property(nonatomic,copy)void (^blockAreaArray)(NSMutableArray * areaArray);
@property(nonatomic,copy)void (^blockPriceArray)(NSMutableArray * array);
@property (nonatomic,copy)void (^blockUploadImage)(NSString * string);
@property(nonatomic,copy)void(^blockNSArray)(NSArray * resultArray);
@property(nonatomic,copy) void (^blockNeedString)(NSString *string);
@property(nonatomic,copy)void(^LeaveDateString)(NSString*str);

//接受图片的blcok
@property(nonatomic,copy)void (^iamgeBlock)(UIImage * image);

@property(nonatomic,copy)void (^noticeBlock)(NSDictionary * dict);

//接收任意类型的数据block
@property(nonatomic,copy) void (^allTypeBlock)(id obj);



@property(nonatomic,copy)NSMutableString * string;
@property(nonatomic,assign)id<PersonDelegate>delegate;

+(instancetype)allocWithZone:(struct _NSZone *)zone;
-(id)init;
+(MyRequest *)defaultsRequest;
//记录程序启动的次数
+ (BOOL)firstLunch;
//检查网络状态
+ (NETWORK_TYPE_TEST)checkNetWorking;

//考勤点击切换
- (void)GetRHHisSinTime:(NSString *)userid token:(NSString *)token hCall:(void (^)(id obj))block;
//登录
-(void)getWebServiceData:( void (^)(NSMutableString * string) )block userName:(NSString * )name userPass:(NSString *)password;
-(void)afgetWebServiceUserName:(NSString * )name userPass:(NSString *)password backInfo:(void (^)(NSMutableString * string))block;

-(void)afgetWebServiceData:( void (^)(NSMutableString * string) )block userName:(NSString * )name userPass:(NSString *)password;

//修改密码
-(void)changePassWord:(void (^)(NSMutableString * string))block userid:(NSString *)userid userPass:(NSString *)password token:(NSString *)token NewPwd:(NSString *)NewPwd;

-(BOOL)isLoginCheckTokenExist;
-(void)disConnect;
-(void)getEmpInfo:(NSString *)userName userToken:(NSString *)token  backInfoMessage:(void (^)(id obj))block;
//房源列表信息
-(void)getRoomInfoEasterList:(RoomData *)roomInfo   backInfoMessage:(void (^)(NSMutableArray  * array1))block;
-(void)getCustomList:(VisiterData *)customInfo backInfoMessage:(void (^)(NSMutableString * string))block;
-(void)getCustomDetailInfoEasterList:(AppointVisiterData *)customDetailInfo   backInfoMessage:(void (^)(NSMutableString * string))block;
//请求区域行政区列表，以及片区列表
-(void)requestAreaInfoMessage:(NSString *)areaKind roomDistrictId:(NSString *)districtId roomDisName:(NSString *)districetName mode:(NSString *)mode userName:(NSString *)userid userTokne:(NSString *)token backInfoMessage:(void (^)(NSMutableArray * array))block;
//
# pragma mark --房源详情---
-(void)GetPropertyDetail:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId userid:(NSString *)userid token:(NSString *)token;
//客源价格区间
-(void)getPriceRange:(PriceRangeData *)price   backInfoMessage:(void (^)(NSMutableString * string))block;
//房源列表价格区间
-(void)returnRoomPriceRange:(PriceRangeData *)price callBackArray:(void (^)(NSMutableString * string))block;

//客源写跟进
-(void)getAddCustomersFollow:(CustomersFollowData *)follow   backInfoMessage:(void (^)(NSMutableString * string))block;
//房源纠错
-(void)addErrorPropertyPropertyId:(NSString *)propertyId PropertyName:(NSString *)propertyName BuildingNo:(NSString *)buildingNo RoomNo:(NSString *)roomNo ErrorContent:(NSString *)errorContent ContentType:(NSString *)contentType OldValue:(NSString *)oldValue NewValue:(NSString *)newValue userid:(NSString *)userid token:(NSString *)token completBack:(void (^)(id))block;
//房源写跟进
-(void)addPropertyContact:(ADDPropertyContactData *)contact   backInfoMessage:(void (^)(NSMutableString * string))block;

#pragma mark 名片申请提交
-(void)BusinessCardInfo:(CardData *)card   backInfoMessage:(void (^)(NSMutableString * string))block;

#pragma mark --修改意向度
- (void)afUpdateCustLevelCustID:(NSString *)CustID CustLevel:(NSString *)CustLevel userid:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block;
#pragma mark --全部跟进
- (void)afGetCustFollowCustID:(NSString *)CustID StartIndex:(NSString *)StartIndex  PageSize:(NSString *)PageSize userid:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block;

#pragma mark --公客
- (void)afCancelPrivateCustID:(NSString *)CustID userid:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block;

#pragma mark --获取公客数量
- (void)afGetPublicCount:(NSString *)name userToken:(NSString *)token completeBack:(void (^)(id))block;
#pragma mark 请假申请历史
-(void)GetAskForLeaveGroup_Listmode:(NSString *)mode userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block;
#pragma mark 请假修改里的请假详情列表
-(void)GetAskForLeave_ListprocessId:(NSString *)processId userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block;

#pragma mark  请假列表
- (void)afGetEveryDaylLeaveList:(NSString *)name userToken:(NSString *)token string:(void (^)(NSMutableArray *array))block;

#pragma mark -----请假申请
- (void)afGetLeaveLeaveType:(NSString *)LeaveType StartDate:(NSString *)StartDate EndDate:(NSString *)EndDate Reason:(NSString *)Reason ImageFlg:(NSString *)imageFlg Imagebytes:(NSString *)imagebytes userid:(NSString *)name token:(NSString *)token  completeBack:(void (^)(id))block;
#pragma mark --修改请假延期延后
-(void)updateLeaveLeaveType:(NSString *)leaveType StartDate:(NSString *)startDate EndDate:(NSString *)endDate
                     Reason:(NSString *)reason UpdateType:(NSString *)updateType Hours:(NSString *)hours OldSaveNo:(NSString *)oldSaveNo OldStartDate:(NSString *)oldStartDate ImageFlg:(NSString *)imageFlg Imagebytes:(NSString *)imagebytes userid:(NSString *)name token:(NSString *)token  completeBack:(void (^)(id))block;
#pragma mark--培训申请请假提交
-(void)LessonLeaveLessonNo:(NSString*)lessonNo LessonName:(NSString*)lessonName LessonType:(NSString*)lessonType LessonTypeName:(NSString*)lessonTypeName Reason:(NSString*)reason Userid:(NSString*)userid Token:(NSString*)token completeBack:(void (^)(id))block;
#pragma mark--培训请假数据请求
-(void)GetLessonListUserid:(NSString*)userid Token:(NSString*)token string:(void (^)(NSMutableArray *))block;
#pragma mark -- 房源缺失登记
-(void)roomLostEstateName:(NSString *)estateName EstateAddress:(NSString *)estateAddress DistrictName:(NSString *)districtName userid:(NSString *)name token:(NSString *)token  completeBack:(void (^)(id))block;

#pragma mark  ---选择框

- (void)afGetSelectLeaveInfo:(NSString *)name userToken:(NSString *)token completeBack:(void (^)(id))block;
#pragma mark  ---外出接口
- (void)getSelectForgetDate:(NSString *)date type:(NSString *)timeType OutoPlace:(NSString *)place Reason:(NSString *)reacon Summary:(NSString *)sum userid:(NSString *)userid token:(NSString *)token completeBack:(void (^)(id))block;
#pragma mark =---外出申请撤销
-(void)getGoulistbackoutUserid:(NSString*)userid Token:(NSString*)token processId:(NSString*)Prcesssid Type:(NSString*)type Date:(NSString*)date  string:(void (^)(NSString * str))block;
#pragma mark =---请假申请撤销
-(void)backoutHoliDayUserid:(NSString*)userid Token:(NSString*)token processId:(NSString*)Prcesssid Type:(NSString*)type Date:(NSString*)date  string:(void (^)(NSString * str))block;
#pragma mark --外出豁免判断
-(void)GetGoutCheckForgetExemptUserid:(NSString*)userid Token:(NSString*)token string:(void (^)(NSString * str))block;
#pragma mark--单条数据提交请假
-(void)CheckLeaveLeaveType:(NSString*)leaveType StartDate:(NSString*)startDate EndDate:(NSString *)endDate PrevEndDate:(NSString *)prevEndDate userid:(NSString *)userid token:(NSString*)token complteBack:(void(^)(NSString*str))block;
#pragma mark --新版多条请假申请
-(void)MultibarHouliDayJsonData:(NSString*)josndata userID:(NSString*)userid Token:(NSString*)token complteBack:(void(^)(NSString*string))block;
#pragma mark --外出豁免申请
-(void)getGoutCommitSaveGoOutUserid:(NSString*)userid Token:(NSString*)token ForgetDate:(NSString*)forgeDate Type:(NSString*)type OutofPlace:(NSString*)outofPlace Reason:(NSString*)reason Summary:(NSString*)summary StartTime:(NSString*)starTime EndTime:(NSString*)endTime string:(void(^)(NSString*str))block;


#pragma mark - 销假申请提交
-(void)resumptionLeaveJsonData:(NSString *)jsonData Reason:(NSString *)reason userid:(NSString *)userid token:(NSString *)token completeBack:(void(^)(NSString *string))block;
#pragma mark ---修改请假假期列表
-(void)holiDayGetRequestUserid:(NSString*)userid Token:(NSString*)token completeBack:(void (^)(NSMutableArray *array))block;
#pragma mark --请假上传附件
-(void)holiDayUpDowloadData:(NSString*)upDataImage userid:(NSString*)userid Token:(NSString*)token uPpic:(void(^)(NSString*str))block;
//客源跟进列表
-(void)GetCustFollow:(CustFollowListData *)followList   backInfoMessage:(void (^)(NSMutableString * string))block  ;

//图片信息请求

-(void)getImageInfo:(NSString * )propertyID  proMode:(NSString * )mode userID:(NSString * )userid userToken:(NSString *)userToken  callBack:(void (^)(UIImage   * image))block  string:(void (^)(NSString * str))block;
//上传图片

-(void)uploadImage:(NSString * )propertyID type:(NSString *)photoType phovalue:(NSString *)photoSource photoValue:(NSString *)photoValue imagebytes:(NSString * )bytes  userid:(NSString * )userid token:(NSString * )userToken  string:(void (^)(NSString * str))block;

//跟进类型
-(void)GetFollowTypeList:(void (^)(NSMutableString * string))block userid:(NSString *)userid token:(NSString *)token;
//跟进方式
-(void)GetFollowWayList:(void (^)(NSMutableString * string))block userid:(NSString *)userid token:(NSString *)token;

//# pragma mark --房源收藏---
//-(void)CollectProperty:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId Mode:(NSString *)Mode userid:(NSString *)userid token:(NSString *)token;
#pragma mark --房源收藏---
-(void)CollectPropertyId:(NSString *)PropertyId Mode:(NSString *)Mode userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableString * string))block ;

#pragma mark 房源跟进列表

-(void)GetPropertyContactListPropertyId:(NSString *)PropertyId userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableString * string))block;
#pragma mark  楼盘详情
-(void)GetEstateDetail:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token;
#pragma mark 名片申请查询列表
-(void)CardLookStartIndex:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block;
#pragma mark 端口申请查询列表
-(void)PortListStartIndex:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block;
#pragma mark 外出申请查询列表
-(void)GetGoOutListStartIndex:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token string:(void(^)(NSMutableArray * array))block;


#pragma mark  有效房源数量
-(void)GetLegelProperties:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token;
# pragma mark --拨打电话---
-(void)DialCustTelephone:(void (^)(NSMutableString * string))block CameraNumber:(NSString *)CameraNumber CustPhone:(NSString *)CustPhone userid:(NSString *)userid token:(NSString *)token;
#pragma mark --获取房源收藏列表接口
-(void)getPropertyCollectid:(NSString * )userId token:(NSString *)userToken
                       call:(void (^)(NSMutableString * string))block;
#pragma mark --获取客户电话接口
#pragma mark --主页公告列表
-  (void)getNoticeList:(NSString *)statedIndex page:(NSString *)pagesize userName:(NSString *)user passToken:(NSString *)token call:(void (^)(NSArray  * dict))block;

#pragma mark 更多筛选
-(void)GetPropertyAddChosen:(void (^)(NSMutableString * string))block  PropertyType:(NSString *)PropertyType userid:(NSString *)userid token:(NSString *)token;
#pragma mark --签到接口
- (void)getSignTimer:(NSString  *)signTimer gprsX:(NSString *)x gprs:(NSString *)y  userName:(NSString *)user token:(NSString *)token callBack:(void (^)(NSString * string))block;
#pragma mark --网站接口
-(void)GetWebSiteList:(void (^)(NSMutableString * string))block WebSiteMode:(NSString *)WebSiteMode userid:(NSString *)userid token:(NSString *)token;
#pragma mark --考勤历史数据请求


- (void)afGetResaultUser:(NSString *)userid userCookie:(NSString *)token call:(void (^)(id   obj))block;

#pragma mark -- 房源推广

- (void)afGetBroked_idLinePeoperty_ID:(NSString *)propertyID user:(NSString *)useerid usertoken:(NSString * )token call:(void (^)(id obj))block;


//- (void)afShareRoomUploadHouseSourceApi_key:(NSString * )appkey houseSourceSign:(NSString *)sign pramas:(RoomHouseSouseData *)houseData  callBack:(void (^)(id obj))block;

#pragma mark --新增客源

- (void)afCustomCreate:(AddData *)addCustomer callBack:(void (^)(NSMutableString * string))block;

#pragma mark --名片申请
-(void)afGetEmpInfo:(NSString *)userid token:(NSString *)token call:(void (^)(id obj))block;

#pragma mark 套餐申请
-(void)setApplication:(WebData *)web   backInfoMessage:(void (^)(NSMutableString * string))block;
#pragma mark --房源纠错处理
- (void)afHandleRoomSourceUserName:(NSString *)name correctStyle:(NSString *)style content:(NSString *)contentstr userToken:(NSString *)token call:(void (^)(id obj))block;
#pragma mark --获取精英标志位
- (void)afGetEXcellentFlag_userID:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id obj))block;

#pragma mark --获取私客数量
- (void)afGetPriviteCount:(NSString *)name userToken:(NSString *)token completeBack:(void (^)(id obj))block;

- (void)afCompleteLink_user:(NSString *)string user_Token:(NSString * )token completeBack:(void (^)(NSString *  obj))block;
//请求上级
/**
 *  <#Description#>
 *
 *  @param userId <#userId description#>
 *  @param token  <#token description#>
 *  @param block  <#block description#>
 */
- (void)afGetSupFromSnapshot:(NSString *)userId userToken:(NSString *)token completeBack:(void (^)(NSString *str))block;
//请求下级
/**
 *  <#Description#>
 *
 *  @param userCode <#userCode description#>
 *  @param block    <#block description#>
 */
- (void)afGetSubFromSnapshot:(NSString *)userCode FLG:(NSString *)fLG  Status:(NSString *)status ShowLevel:(NSString *)showLevel completeBack:(void (^)(NSString *str))block;

#pragma mark 下属客源列表
/**
 *  @brief
 *
 *  @param customInfo visiterData 类，具体参数参照接口文档
 *  @param block      回调闭包
 */
-(void)getSubCustomList:(VisiterData *)customInfo   backInfoMessage:(void (^)(NSMutableString * string))block;
#pragma mark --获取通话记录
/**
 *  @brief
 *
 *  @param IO          <#IO description#>
 *  @param time        时间，
 *  @param Type        <#Type description#>
 *  @param FlagSubs    下属或个人
 *  @param SubUserCode 下属usercode
 *  @param phone       电话号码
 *  @param SubDutyCode 下属dutycode
 *  @param Index       页码
 *  @param userId      userid
 *  @param token       token
 *  @param block       回调闭包
 */
- (void)afGetPhoneHistory:(NSString *)IO   Time:(NSString *)time Type:(NSString *)Type  FlagSubs:(NSString *)FlagSubs SubUserCode:(NSString *)SubUserCode  SubPhone:(NSString *)phone SubDutyCode:(NSString *)SubDutyCode  StarIndex:(NSString *)Index  userid:(NSString *)userId  userToken:(NSString *)token  completeBack:(void (^)(NSMutableString *str))block;
#pragma mark --获取上级编号
/**
 *  @brief
 *
 *  @param userId userif
 *  @param token  token
 *  @param block  回调闭包
 */
- (void)afGetSupFromUserCode:(NSString *)userId userToken:(NSString *)token completeBack:(void (^)(NSString *str))block;

//联系人
-(void)getEmpInfoList:(NSString *)text index:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token backInfoMessage:(void (^)(NSMutableArray  * array))block;
//日志
-(void)GetUpgradeLog:(NSString *)mode userid:(NSString *)userid token:(NSString *)token backInfoMessage:(void (^)(NSMutableArray  * array))block;
//请求最新版本号
-(void)GetUpgradeLogNew:(NSString *)mode userid:(NSString *)userid token:(NSString *)token backInfoMessage:(void (^)(NSString  * str))block;

#pragma mark -----最新拨打电话
/**
 *  @brief
 *
 *  @param CameraNumber custltele
 *  @param CustPhone    <#CustPhone description#>
 *  @param ID           <#ID description#>
 *  @param Type         <#Type description#>
 *  @param FromCode     <#FromCode description#>
 *  @param userId       <#userId description#>
 *  @param token        <#token description#>
 *  @param block        <#block description#>
 */
- (void)afDialCustTelephone:(NSString *)CameraNumber   CustPhone:(NSString *)CustPhone   ID:(NSString *)ID   Type:(NSString *)Type FromCode:(NSString *)FromCode  userid:(NSString *)userId  userToken:(NSString *)token  completeBack:(void (^)(NSMutableString *str))block;
#pragma mark --客源信息修改
/**
 *  @brief
 *
 *  @param visiterUpdate <#visiterUpdate description#>
 *  @param block         <#block description#>
 */
- (void)afSetCustUpdate:(VisiterUpdate *)visiterUpdate  completeBack:(void (^)(NSString *str))block;
#pragma mark --添加约看
/**
 *  <#Description#>
 *
 *  @param propertyID <#propertyID description#>
 *  @param custID     <#custID description#>
 *  @param source     <#source description#>
 *  @param userId     <#userId description#>
 *  @param token      <#token description#>
 *  @param block      <#block description#>
 */
- (void)afSetGoSee:(NSString*)propertyID CustID:(NSString*)custID Source:(NSString*)source AppointmentTime:(NSString*)appointmentTime userID:(NSString *)userId userToken:(NSString *)token completeBack:(void (^)(NSString *str))block;
#pragma mark --更新电话
/**
 *  @brief
 *
 *  @param ID       房源/客源id
 *  @param oldPhone 旧电话号码
 *  @param newPhone 新电话号码
 *  @param mode     房源or客源
 *  @param userid   用户id
 *  @param token    用户token
 *  @param block    回调闭包
 */
-(void)afSetPhoneUpdOrInsID:(NSString *)ID OldPhone:(NSString *)oldPhone NewPhone:(NSString *)newPhone Mode:(NSString *)mode completeBack:(void (^)(NSMutableString *str))block;
#pragma mark --查询电话号码
/**
 *  @brief
 *
 *  @param ID    id
 *  @param type  type
 *  @param block 闭包
 */
-(void)afGetPhoneID:(NSString *)ID type:(NSString *)type completeBack:(void (^)(NSMutableString *str))block;
#pragma mark --获取房源指定数据
/**
 *  @brief
 *
 *  @param propertyid 房源id
 *  @param name       有效或无效，
 *  @param block      回调闭包
 */
-(void)afGetHouseValueWithPropertyID:(NSString *)propertyid Name:(NSString *)name call:(void (^)(NSMutableString *str))block;
#pragma mark --获取房源特点
/**
 *  @brief
 *
 *  @param propertyid 房源id
 *  @param block      回调闭包
 */
-(void)afGetHouseMarksWithPropertyID:(NSString *)propertyid call:(void (^)(NSArray *array))block;
#pragma mark -- 修改房源特点
/**
 *  @brief
 *
 *  @param info  房源信息
 *  @param block 回调闭包
 */
-(void)afSetHousMarks:(RoomRevisInfo *)info call:(void (^)(NSMutableString *str))block;
#pragma mark --修改房源有效无效
/**
 *  @brief
 *
 *  @param info  房源信息
 *  @param block 回调闭包
 */
-(void)SetStatusWithPropertyID:(NSString *)propertyid Status:(NSString *)status LastRentDate:(NSString *)lastRentDate call:(void (^)(NSString *str))block;
#pragma mark --修改房源需求
/**
 *  @brief
 *
 *  @param info  修改房源类
 *  @param block 回调闭包
 */
-(void)afSetHouseUpdate:(RoomRevisInfo *)info call:(void (^)(NSString *str))block;
#pragma mark -- 客源转移
/**
 *  @brief
 *
 *  @param custid        客源id
 *  @param toempcode     目标人员id
 *  @param tounitcode    目标部门编号
 *  @param frflagPrivate 原公司客标志
 *  @param toflagPrivate 目标公司客标志
 *  @param block         回调闭包
 */
-(void)afSetCustMoveWithCustID:(NSString *)custid ToEmpCode:(NSString *)toempcode ToUnitCode:(NSString *)tounitcode FrFlagPrivate:(NSString *)frflagPrivate ToFlagPrivate:(NSString *)toflagPrivate CompleteBack:(void (^)(NSString *str))block;
#pragma mark --5.21客源列表
/**
 *  @brief
 *
 *  @param customInfo 客源类
 *  @param block      回调闭包
 */
-(void)afXYGetCustomListWithVist:(VisiterData *)customInfo ComPleteBack:(void(^)(NSMutableString *str))block;
#pragma mark --约看列表
/**
 *  @brief
 *
 *  @param districtName 片区名
 *  @param areaName     小区名
 *  @param estateName   楼栋名，目前位@“”
 *  @param dateFrom     开始日期
 *  @param dateTo       结束日期
 *  @param flagSubs     下属或个人
 *  @param startIndex   起始页
 *  @param block        回调闭包
 */
-(void)afGetGoSeeListWithDistrictName:(NSString *)districtName AreaName:(NSString *)areaName EstateName:(NSString *)estateName DateFrom:(NSString *)dateFrom DateTo:(NSString *)dateTo FlagSubs:(NSString *)flagSubs SubUserCode:(NSString *)subUserCode StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block;
#pragma mark --获取约看结果
/**
 *  @brief
 *
 *  @param goseeid 客源或房源约看ID
 *  @param block   回调闭包
 */
-(void)afGetGoSeeRecordWithGoSeeID:(NSString *)goseeid completeBack:(void (^)(NSString *str))block;
#pragma mark --添加约看结果
/**
 *  @brief
 *
 *  @param goseeID    约看id
 *  @param recordMark 添加的内容
 *  @param dateTime   约看时间
 *  @param type       约看类型：预约或记录
 *  @param block      回调闭包
 */
-(void)afSetgoSeeRecordWithGoSeeID:(NSString *)goseeID RecordReMark:(NSString *)recordMark DateTime:(NSString *)dateTime Type:(NSString *)type  completeBack:(void (^)(NSString *str))block;
#pragma mark --请求跟进列表
/**
 *  #brief
 *
 *  @param trade          交易类型
 *  @param followtype     跟进类型
 *  @param followway      跟进方式
 *  @param followdatefrom 开始日期
 *  @param followdateto   结束日期
 *  @param flagsubs       下属或个人
 *  @param startindex     页码
 *  @param block          回调闭包
 */
#pragma mark --请求跟进列表
-(void)afGetFollowListTrade:(NSString *)trade FollowType:(NSString *)followtype FollowWay:(NSString *)followway FollowDateFrom:(NSString *)followdatefrom FollowDateTo:(NSString *)followdateto FlagSubs:(NSString*)flagsubs SubUserCode:(NSString *)subUserCode StartIndex:(NSString *)startindex completeBack:(void (^)(NSString *str))block;
#pragma mark --房源请求跟进列表
-(void)afGetFollowListDistrictName:(NSString *)districtName AreaName:(NSString *)areaName FollowDateFrom:(NSString *)followDateFrom FollowDateTo:(NSString *)followDateTo FlagSubs:(NSString*)flagsubs SubUserCode:(NSString *)subUserCode  StartIndex:(NSString *)startindex completeBack:(void (^)(NSString *str))block;

#pragma mark -- 获取房客源筛选下属的员工编号
-(void)afGetSubordinateNewuserCode:(NSString *)userCode FLG:(NSString *)flg Status:(NSString *)status ShowLevel:(NSString *)showLevel completeBack:(void (^)(NSString *str))block;
//-(void)afGetSubordinateNewuserCode:(NSString *)userCode DutyCode:(NSString *)dutyCode StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block;

#pragma MARK --获取部门信息
/**
 *  @brief
 *
 *  @param unitCode   部门编号
 *  @param spaceLevel 间隔等级
 *  @param dutycode   登录人dutycode
 *  @param block      回调闭包
 */
-(void)afGetDeptFromSnapshotWithUnitCode:(NSString *)unitCode SpaceLevel:(NSString *)spaceLevel DutyCode:(NSString *)dutycode completeBack:(void (^)(NSString *str))block;
#pragma mark -- 获取房源修改前的数据
/**
 *  @brief
 *
 *  @param propertyID 房源id
 *  @param block      回调
 */
-(void)afGetHouseValueUpdWithPropertyID:(NSString *)propertyID completeBack:(void (^)(NSString *str))block;

#pragma mark --获取约看客源列表
/**
 *  @brief
 *
 *  @param custName   客户姓名
 *  @param startIndex 第几页
 *  @param block      回调
 */
-(void)afGetGoSeeCustListWithCustName:(NSString *)custName StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block;


#pragma mark --约看房源列表
-(void)afGetGoSeePropertyListEstateName:(NSString *)estateName BuildingName:(NSString *)buildingName RoomNo:(NSString *)roomNo   StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block;

@end
@protocol PersonDelegate <NSObject>

@optional
-(void)compareResults:(NSMutableString  *)string   dict:(NSDictionary *)dictonry;


-(void)completeReturnResults:(RoomData *)roomSource;
//行政区片区
-(void)returnBackArray:(NSMutableArray *)areaArray  pianquArray:(NSMutableArray *)pianquArray3;
//
-(void)returnRoomInfoList:(NSArray *)array;



@end