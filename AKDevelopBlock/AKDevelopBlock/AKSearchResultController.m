//
//  AKSearchResultController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/18.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKSearchResultController.h"
#import "AKanimationView.h"

@interface AKSearchResultController ()<UIWebViewDelegate>

@property (nonatomic,strong) AKanimationView *aniV;
@property (nonatomic,strong) UIImageView *loadV;

@end

@implementation AKSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _aniV = [AKanimationView sharedAKanimationView];
    _loadV = [_aniV animationViewFram:CGRectMake(SCREEN_WIDTH / 2 - 30, 164, 60, 60) ImageName:@"timg_" ImageCount:16 AnimationTime:1.f];
    
    [self setupWebSearchResult];
}


#pragma mark ***web搜索结果***
- (void)setupWebSearchResult{
    
//    谷歌搜索：http://www.google.com.hk/search?hl=zh-CN&source=hp&q=
//    百度搜索：http://www.baidu.com/s?wd=
//    百度贴吧：http://tieba.baidu.com/f?kw=
//    百度图片：http://image.baidu.com/i?ct=201326592&&word=
//    百度音乐：http://mp3.baidu.com/m?tn=baidump3&ct=134217728&lm=-1&word=
//    优酷搜索：http://www.soku.com/v?keyword=
//    必应搜索：http://cn.bing.com/search?q=
//    土豆搜索：http://so.tudou.com/isearch/
//    有道搜索：http://www.youdao.com/search?q=
//    天眼查 :http://www.tianyancha.com/search?key=
    
    NSString *url = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@",[_searchWords stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webV.delegate = self;
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [webV addSubview:_loadV];
    
    [self.view addSubview:webV];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [_aniV startAKanimationView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [_aniV stopAKanimationView];
}
















@end
