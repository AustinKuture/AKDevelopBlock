//
//  PrefixHeader.h
//  AKIRPManage
//
//  Created by 李亚坤 on 16/9/18.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

/*
 *
 //项目字段说明
   webUrlStr 首页、最新、最热等详情 url 本地化存储字段;
   WEBURLPUBLICK 推出公用控制器通知字段;
 *
 */


#ifndef PrefixHeader_h
#define PrefixHeader_h

//Main Define
#define SCREEN_ALL [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BTH_WIDTH ((SCREEN_WIDTH - 12) / 4)
#define GROUNDCOLOR(r,g,b,a) [UIColor colorWithRed: r / 255.0 green: g / 255.0 blue: b / 255.0 alpha: a]
#define FONT_S(s) [UIFont systemFontOfSize:s]
#define FONTS_STYLE(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]

//Api
#define USERTOKEN [[NSUserDefaults standardUserDefaults]objectForKey:@"LoginToken"]

#define EASYBUG_PROJID [[NSUserDefaults standardUserDefaults]objectForKey:@"EasyBugProjId"]
#define KONWLEDGE_PROJID [[NSUserDefaults standardUserDefaults]objectForKey:@"KonwLedgeProjId"]

#define API_TESTINPORT [NSString stringWithFormat:@"http://192.168.199.248:8080/irp/phone/"]
//#define API_MAININPORT [NSString stringWithFormat:@"http://irp.ruisiming.com.cn:8085/irp/phone/"]

//测试接口
//#define API_MAIN [NSString stringWithFormat:@"http://192.168.199.248:8080"]
//#define API_MAINSUBPORT [NSString stringWithFormat:@"http://192.168.199.248:8080/irp"]
//#define API_MAININPORT [NSString stringWithFormat:@"http://192.168.199.248:8080/irp/phone/"]

//正常接口
#define API_MAIN [NSString stringWithFormat:@"http://irp.ruisiming.com.cn:8085"]
#define API_MAINSUBPORT [NSString stringWithFormat:@"http://irp.ruisiming.com.cn:8085/irp"]
#define API_MAININPORT [NSString stringWithFormat:@"http://irp.ruisiming.com.cn:8085/irp/phone/"]


#define API_NEW [NSString stringWithFormat:@"%@index_new.action?",API_MAININPORT]
#define API_NEWHOT [NSString stringWithFormat:@"%@index_hot.action?",API_MAININPORT]
#define API_BESTVALUE [NSString stringWithFormat:@"%@index_valuable.action?",API_MAININPORT]
#define API_DETAIL [NSString stringWithFormat:@"%@document_detail.action?",API_MAININPORT]
#define API_USERRANK [NSString stringWithFormat:@"%@user_rank.action?",API_MAININPORT]
#define API_GUSS [NSString stringWithFormat:@"%@guess_app.action?",API_MAININPORT]
#define API_KONWFIRST [NSString stringWithFormat:@"%@getchannels_app.action?",API_MAININPORT]
#define API_KONWSECOND [NSString stringWithFormat:@"%@findChildChannelByParentId_app.action?",API_MAININPORT]
#define API_PERSONINFO [NSString stringWithFormat:@"%@personinfo_app.action?",API_MAININPORT]
#define API_KONWSECONDEDETAIL [NSString stringWithFormat:@"%@getdocumentlist_app.action?",API_MAININPORT]

//微博API
#define API_WEIBO_MAIN_INPORT [NSString stringWithFormat:@"http://192.168.199.243/iOS/IRP/weiblog/"]
#define API_WEIBO_INPORT [NSString stringWithFormat:@"http://192.168.199.243/iOS/IRP/"]



//Times Out
#define TIMES_OUT 20.f

//Signature
#define IRP_SIGNATURE [NSString stringWithFormat:@""]

//NSLog
#ifdef DEBUG
#define MyLog(format,...)  NSLog((@"[函数名:%s]\n" "[行号:%d]\n" format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define MyLog(...)
#endif


//COLORS
#define GROUNDSAME(n,a) GROUNDCOLOR(n,n,n,a)
#define COLORS_RANDOM(a) GROUNDSAME(arc4random_uniform(255),a)
#define COLORS_SHADOW GROUNDCOLOR(180,189,207,1)

#define BLUE_HARD GROUNDCOLOR(15,58,121,1)
#define BLUE_LOW GROUNDCOLOR(25,154,255,1)
#define BLUE_LOW_NEW GROUNDCOLOR(24,73,166,1)
#define GREEN_LOW GROUNDCOLOR(80,141,26,1)

#define COLORS_WHITE [UIColor whiteColor]
#define COLORS_RED [UIColor redColor]
#define COLORS_GREEN [UIColor greenColor]
#define COLORS_BLUE [UIColor blueColor]
#define COLORS_PURPLE [UIColor purpleColor]
#define COLORS_ORANGE [UIColor orangeColor]
#define COLORS_YELLOW [UIColor yellowColor]
#define COLORS_GRAY [UIColor grayColor]
#define COLORS_LIGHTGRAY [UIColor lightGrayColor]
#define COLORS_BLACK [UIColor blackColor]
#define COLORS_DARKGRAY [UIColor darkGrayColor]
#define COLORS_CYAN [UIColor cyanColor]
#define COLORS_MAGENTA [UIColor magentaColor]
#define COLORS_BROWN [UIColor brownColor]
#define COLORS_CLEAR [UIColor clearColor]

//十六进制
#define COLORS_HEX(s,a) [UIColor colorWithRed:((float)((s & 0xFF0000) >> 16))/255.0 green:((float)((s & 0xFF00) >>8))/255.0 blue:((float)(s & 0xFF))/255.0 alpha:a]

//Text Alignment
#define ALIG_CENTER NSTextAlignmentCenter
#define ALIG_LEFT NSTextAlignmentLeft
#define ALIG_RIGHT NSTextAlignmentRight
#define ALIG_NATURAL NSTextAlignmentNatural
#define ALIG_JUSTIFIED NSTextALignmentJustified

//String Random

#define R_N(n) arc4random_uniform(n)
#define STR_RANDOM(S,n,m) [NSString stringWithFormat:@"%@%d",S,R_N(n) + m]

//微博图片宽高
#define WB_PIC_HW SCREEN_WIDTH/3

//微博字体及颜色
#define NAME_COLOR GROUNDCOLOR(15,58,121,1)
#define SMLABEL_COLOR GROUNDCOLOR(128, 128, 128, 1)
#define TOOL_LINE_COLOR GROUNDCOLOR(239,239,239,1)
#define NORMAL_FONT FONT_S(16)
#define SMLABEL_FONT FONT_S(14)
#define FONTS_FAMILY(name,s) [UIFont fontWithName:name size:s]

//中医药浅蓝
#define BLUE_BABY GROUNDCOLOR(46,137,166,1)
#define CIN_BACK_BLUE COLORS_HEX(0xedf6f9, 1)

//登录
//外网IP
#define CIN_MAININPORT [NSString stringWithFormat:@"https://cintmed.cintcm.com/"]
#define CIN_LOGIN_ACCOUNT [NSString stringWithFormat:@"%@cintmed/app/user/token/grant_token.html",CIN_MAININPORT]

//Head File
//#import "UIView+AKCategory.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AKNetPackegeAFN.h"
#import "AKDateTrans.h"
//#import "ChineseString.h"
//#import <BaiduMapAPI_Map/BMKMapView.h>
//#import <BaiduMapAPI_Location/BMKLocationService.h>
//#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
//#import "SDCycleScrollView.h"

//#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
//#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
//#import <UMSocialCore/UMSocialCore.h>
//#import "UMSocialUIManager.h"
//#import "AKBugPriority.h"

//#import "AKRefresh.h"
//#import "AKanimationView.h"


#endif /* PrefixHeader_h */



























