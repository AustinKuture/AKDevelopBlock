//
//  AKPickImgController.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/18.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKPickImgController.h"
#import "YRImagePicker.h"
#import "NSObject+AKGesture.h"

@interface AKPickImgController ()

@property (nonatomic,strong) UIImageView *pickImgView;
@property (nonatomic,strong) UIButton *disV;

@end

@implementation AKPickImgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPickViewInitSetting];
}

#pragma mark ***图片选择器初始化***
- (void)setupPickViewInitSetting{
    
    //图片容器
    _pickImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    _pickImgView.userInteractionEnabled = YES;
    
    //容器标识
    _disV = [[UIButton alloc]init];
    _disV.backgroundColor = GROUNDSAME(230, 1);
    _disV.layer.borderColor = COLORS_LIGHTGRAY.CGColor;
    _disV.layer.borderWidth = 1;
    _disV.titleLabel.font = FONT_S(25);
    [_disV setTitle:@"NO Photo Selected" forState:UIControlStateNormal];
    [_disV setTitleColor:COLORS_BLACK forState:UIControlStateNormal];
    [self addGestureRecognizerInToView:_pickImgView];
    
    [_pickImgView addSubview:_disV];
    [_disV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_pickImgView.mas_centerX);
        make.centerY.equalTo(_pickImgView.mas_centerY);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH * 0.9, SCREEN_WIDTH * 0.9));
    }];

    
    //选择按钮
    UIButton *pickBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 100, SCREEN_WIDTH + 20, 200, 30)];
    pickBtn.titleLabel.font = SMLABEL_FONT;
    [pickBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [pickBtn setTitle:@"请选择图片" forState:UIControlStateNormal];
    [pickBtn setTitleColor:COLORS_BLUE forState:UIControlStateNormal];
    
    [pickBtn addTarget:self action:@selector(setupPickViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_pickImgView];
    [self.view addSubview:pickBtn];
}

- (void)setupPickViewClick{
    

  [YRImagePicker startPickingFromViewController:self
                                      sourceTypes:kYRImagePickerSourceTypeAll
                                       completion:^(UIImage *pickedImage) {
                                           
                                           _pickImgView.image = pickedImage;
                                           _disV.hidden = YES;
                                       }];
}



















@end
