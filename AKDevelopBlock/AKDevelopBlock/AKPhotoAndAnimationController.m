//
//  AKPhotoAndAnimationController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/5/31.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKPhotoAndAnimationController.h"
#import "AKanimationView.h"

@interface AKPhotoAndAnimationController ()

@property (nonatomic,strong) NSMutableArray *photoDic;

@end

@implementation AKPhotoAndAnimationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    _photoDic = [NSMutableArray array];
    
    NSArray *picArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496232861860&di=7dd8b3db2dee256609b5eb06e12d4b56&imgtype=0&src=http%3A%2F%2Fwww.ysg88.com%2FUploadFiles%2FFCK%2F2014-08%2F201408110V06J8L4J4.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496233003406&di=e80035a3d77c01cbbb0fdf4eaf433097&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201601%2F08%2F20160108161200_LaQtr.thumb.700_0.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496233003407&di=c1e11a1bde6d039931079ddc1a312d63&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201605%2F19%2F20160519231357_CEWsT.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496828494&di=1284a170b8ccd6ed67b0d14b5d0a128d&imgtype=jpg&er=1&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fblog%2F201410%2F09%2F20141009084507_NckLP.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1496223695&di=2eb282dc09671a8c58bf1c2ce80e297b&src=http://www.kele8.com/uploadfile/2012/1012/20121012021314398.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=57105767,3629530100&fm=23&gp=0.jpg"];
    
    for (int i = 0;i<20;i++){
        
        [_photoDic addObject:picArray[arc4random_uniform(6)]];
    }
    
    AKanimationView *animV = [AKanimationView sharedAKanimationView];
    UIScrollView *scrolV = [animV browsePhotoWith:_photoDic Frame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT) Bounces:YES ExHeight:2];
    scrolV.alwaysBounceVertical = YES;
    [self.view addSubview:scrolV];
    
}













@end
