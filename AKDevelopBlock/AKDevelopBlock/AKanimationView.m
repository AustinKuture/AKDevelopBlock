//
//  AKanimationView.m
//  AKLoadingGif
//
//  Created by 李亚坤 on 2017/1/22.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKanimationView.h"
#import "NSObject+AKGesture.h"

@interface AKanimationView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIActivityIndicatorView *act;
@property (nonatomic,strong) NSArray *picArray;

@property (nonatomic,strong) UIView *backGrayView;
@property (nonatomic) int imgNumberCount;
@property (nonatomic) int imgSaveCount;
@property (nonatomic,strong) UILabel *imgNumberL;

@end
@implementation AKanimationView


+ (instancetype)sharedAKanimationView{
    
    static dispatch_once_t once = 0;
    static AKanimationView *animation = nil;
    dispatch_once(&once, ^{
        
        animation = [[AKanimationView alloc]init];
    });
    
    return animation;
}

//图片动画
- (UIImageView *)animationViewFram:(CGRect)fram ImageName:(NSString *)imageName ImageCount:(NSInteger)imageCount AnimationTime:(float)animationTime{
    
    _imageV = [[UIImageView alloc]initWithFrame:fram];
    NSMutableArray *imagArray = [NSMutableArray array];
    
    for (int i = 1;i<=imageCount;i++){
        
        [imagArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",imageName,i]]];
    }
    
    [_imageV setAnimationImages:imagArray];
    [_imageV setAnimationRepeatCount:99999];
    [_imageV setAnimationDuration:animationTime];
    [_imageV startAnimating];
    
    return _imageV;
    
}

//开始
- (void)startAKanimationView{
    
    [_imageV startAnimating];
}

//停止
- (void)stopAKanimationView{
    
    [_imageV stopAnimating];
//    [_imageV removeFromSuperview];
}

//原始加载动画
- (UIActivityIndicatorView *)originalAnimationWithFrame:(CGRect)frame
                            Style:(UIActivityIndicatorViewStyle)style
                            Color:(UIColor *)aniColor{
    
    _act = [[UIActivityIndicatorView  alloc]initWithFrame:frame];
    _act.activityIndicatorViewStyle = style;
    _act.color=aniColor;
    _act.hidesWhenStopped = YES;
    
    return _act;
}

#pragma mark ***图片浏览的封装***
- (UIScrollView *)browsePhotoWith:(NSMutableArray *)picArray Frame:(CGRect)frame Bounces:(BOOL)bounecs ExHeight:(CGFloat)exHeight{
    
    _picArray = [[NSArray alloc]init];
    _picArray = picArray;

    UIScrollView *photoScroView = [[UIScrollView alloc]initWithFrame:frame];
    photoScroView.backgroundColor = COLORS_GRAY;
    photoScroView.pagingEnabled = YES;
    photoScroView.scrollEnabled = YES;
    photoScroView.bounces = bounecs;
    photoScroView.backgroundColor = COLORS_CLEAR;
    photoScroView.showsHorizontalScrollIndicator = NO;
    photoScroView.delegate = self;
    photoScroView.contentSize = CGSizeMake(frame.size.width,(_picArray.count/3 + exHeight) * (frame.size.width/3 + 1));
    
    if (_picArray.count > 0){
        
        for (int i = 0;i < _picArray.count;i++){
            
            UIButton *conImgBtn = [[UIButton alloc]init];
            conImgBtn.tag = i;
            
            //创建并导入图像资源
            UIImageView *conImg = [[UIImageView alloc]init];
            [conImg sd_setImageWithURL:[NSURL URLWithString:picArray[i]] placeholderImage:[UIImage imageNamed:@"placherPic"]];
            [conImgBtn addSubview:conImg];
            [conImg mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(conImgBtn.mas_left);
                make.right.equalTo(conImgBtn.mas_right);
                make.top.equalTo(conImgBtn.mas_top);
                make.bottom.equalTo(conImgBtn.mas_bottom);
            }];
            
            //图像容器的布局
            [photoScroView addSubview:conImgBtn];
            
            CGFloat picX;
            CGFloat picY;
            CGFloat picW;
  
            picW = frame.size.width/3;
            picX = (i%3) * (picW + 1);
            picY = (i/3) * (picW + 1);

            [conImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.mas_equalTo(CGSizeMake(picW, picW));
                make.left.equalTo(photoScroView.mas_left).offset(picX);
                make.top.equalTo(photoScroView.mas_top).offset(picY);
            }];
            
            //图像容器的点击方法
            [conImgBtn addTarget:self action:@selector(detailPicWith:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return photoScroView;
}

#pragma  mark ***放大图片***
- (void)detailPicWith:(UIButton *)btn{
    
    //导入指定Cell的图像数组
   
    _backGrayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backGrayView.backgroundColor = COLORS_BLACK;
    
    //获得当前图像的下标值
    _imgNumberCount = [[NSString stringWithFormat:@"%ld",btn.tag] intValue] + 1;
    
    //图片滑动浏览
     UIScrollView *imgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/4, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    imgScrollView.pagingEnabled = YES;
    imgScrollView.scrollEnabled = YES;
    imgScrollView.bounces = NO;
    imgScrollView.backgroundColor = COLORS_CLEAR;
    imgScrollView.showsHorizontalScrollIndicator = NO;
    imgScrollView.delegate = self;
    imgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _picArray.count, SCREEN_HEIGHT/2);
    
    //点击保存
    UIButton *imgSave = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, SCREEN_HEIGHT - 50, 100, 40)];
    UILabel *savL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    savL.text = @"保存";
    savL.textAlignment = ALIG_RIGHT;
    savL.textColor = COLORS_WHITE;
    savL.font = NORMAL_FONT;
    [imgSave addSubview:savL];
    
    //图片滚动数字
    _imgNumberL = [[UILabel alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 50, 100, 40)];
    _imgNumberL.text = [NSString stringWithFormat:@"%d/%ld",_imgNumberCount,_picArray.count];
    _imgNumberL.font = NORMAL_FONT;
    _imgNumberL.textColor = COLORS_WHITE;
    
    //创建所有的滑动图片
    for (int i = 0;i<_picArray.count;i++){
        
        UIImageView *conImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        [conImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _picArray[i]]] placeholderImage:[UIImage imageNamed:@"placherPic"]];
        [imgScrollView addSubview:conImg];
    }
    
    //进行入时定位到当前图像的位置
    imgScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * btn.tag, 0);
    
    [_backGrayView addSubview:imgScrollView];
    [_backGrayView addSubview:imgSave];
    [_backGrayView addSubview:_imgNumberL];
    
    //点击保存图片
    [imgSave addTarget:self action:@selector(saveWeiboPic:) forControlEvents:UIControlEventTouchUpInside];
    
    //点击图像时让图像背景进入当前控制器视图顶层
    UIApplication *apli = [UIApplication sharedApplication];
    [apli.keyWindow addSubview:_backGrayView];
    
    //背景图添加点击手势
    UITapGestureRecognizer *cancelPic = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBigPic)];
    cancelPic.numberOfTapsRequired = 1;
    cancelPic.numberOfTouchesRequired = 1;
    
    [_backGrayView addGestureRecognizer:cancelPic];
    [self addGestureRecognizerInToView:imgScrollView];
    
}

#pragma mark ***移除放大的图片***
- (void)cancelBigPic{
    
    [_backGrayView removeFromSuperview];
}

#pragma mark ***保存图片***
- (void)saveWeiboPic:(UIButton *)btn{
    
    //获得当前图像数组
    
    //创建并加载当前所要保存的图像
    UIImageView *conImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    [conImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _picArray[_imgSaveCount]]] placeholderImage:[UIImage imageNamed:@"placherPic"]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * 0.4)), dispatch_get_main_queue(), ^{
        
        //保存指定图像
        UIImageWriteToSavedPhotosAlbum(conImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        
        //弹窗指示
        UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75, SCREEN_HEIGHT/2 - 92.7/2, 150, 92.7)];
        alertView.layer.cornerRadius = 5;
        alertView.backgroundColor = GROUNDSAME(66, 0.9);
        UILabel *alertTex = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 92.7)];
        alertTex.textAlignment = ALIG_CENTER;
        alertTex.font = FONTS_STYLE(15);
        alertTex.textColor = COLORS_WHITE;
        alertTex.text = @"保存完成";
        [alertView addSubview:alertTex];
        [_backGrayView addSubview:alertView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * 1.2)), dispatch_get_main_queue(), ^{
            
            [alertView removeFromSuperview];
        });
    });
}

#pragma mark ***保存图像成功后的回调方法***
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

#pragma mark ***Sroll滚动监听***
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.x / SCREEN_WIDTH + 0.5;
    
    _imgSaveCount = page;
    int imgCount = scrollView.contentSize.width / SCREEN_WIDTH;
    _imgNumberL.text = [NSString stringWithFormat:@"%d/%d",page + 1,imgCount];
}

#pragma mark ***颜色的渐变***
- (UIView *)fadeViewWithBeginColor:(UIColor *)beginColor MidelColor:(UIColor *)midelColor EndColor:(UIColor *)endColor Frame:(CGRect)frame{
    
    UIView *fadeView = [[UIView alloc]initWithFrame:frame];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)beginColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0.1, @0.9, @1.0];//渐变的强度,渐变的区间,暂定
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = frame;
    
    [fadeView.layer addSublayer:gradientLayer];
    
    return fadeView;
}














@end
