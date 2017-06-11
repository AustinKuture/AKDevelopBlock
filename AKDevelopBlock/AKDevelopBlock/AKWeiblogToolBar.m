//
//  AKWeiblogToolBar.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKWeiblogToolBar.h"
#import "UIImage+AKImgEx.h"
#import "AKOthers.h"


@interface AKWeiblogToolBar ()

@property (nonatomic,strong) UIImageView *toolView;

@end

@implementation AKWeiblogToolBar

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setWBToolBar];
}

#pragma mark ***设置工具Bar***
- (void)setWBToolBar{
    
    _toolView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 40)];
    _toolView.layer.borderColor = COLORS_GRAY.CGColor;
    _toolView.layer.borderWidth = 1;
    [self.view addSubview:_toolView];
    
    _toolView.userInteractionEnabled = YES;
    //ToolBar竖线
    [self wbToolBarWithVertical];
    [self wbToolBarWithThreeBtn];
}

#pragma mark ***ToolBar竖线***
- (void)wbToolBarWithVertical{
    
    UILabel *topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 10, 1)];
    topLine.backgroundColor = TOOL_LINE_COLOR;
    
    for (int i = 0;i <= 1;i++){
        
        UILabel *verticalLine = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 10) / 3 * (i + 1), 8, 1, 24)];
        verticalLine.backgroundColor = TOOL_LINE_COLOR;
        verticalLine.layer.cornerRadius = 1;
        verticalLine.alpha = 0.8;
        verticalLine.layer.masksToBounds = YES;
        [_toolView addSubview:verticalLine];
    }
    
    [_toolView addSubview:topLine];
}

#pragma mark ***ToolBar三个火枪手***
- (void)wbToolBarWithThreeBtn{
    
    
    NSArray *imgArray = @[@"timeline_icon_retweet_disable",@"timeline_icon_comment_disable",@"composer_rating_icon"];
    NSArray *imgSelecArray = @[@"timeline_icon_retweet",@"timeline_icon_comment",@"composer_rating_icon_highlighted"];
    //    NSArray *toolArray = @[@"转发",@"评论",@"收藏"];
    
    for (int i = 0;i < 3;i++){
        
        UIButton *toolBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 10)/3 * i, 0, (SCREEN_WIDTH - 10)/3, 40)];
        toolBtn.tag = i;
        [toolBtn setImage:[UIImage resizeWithImageName:imgSelecArray[i]] forState:UIControlStateNormal];
        [toolBtn setImage:[UIImage resizeWithImageName:imgArray[i]] forState:UIControlStateHighlighted];
       
        if (toolBtn.tag == 2){
       
            if (!toolBtn.selected){
                
                toolBtn.selected = 1;
                [toolBtn setImage:[UIImage resizeWithImageName:@"composer_rating_icon_highlighted"] forState:UIControlStateNormal];
                [toolBtn setImage:[UIImage resizeWithImageName:@"composer_rating_icon"] forState:UIControlStateHighlighted];
            }else{
                
                toolBtn.selected = 0;
                [toolBtn setImage:[UIImage resizeWithImageName:@"composer_rating_icon"] forState:UIControlStateNormal];
                [toolBtn setImage:[UIImage resizeWithImageName:@"composer_rating_icon_highlighted"] forState:UIControlStateHighlighted];
            }
            
            [toolBtn addTarget:self action:@selector(setButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        toolBtn.titleLabel.font = NORMAL_FONT;
     
        [toolBtn setTitleColor:SMLABEL_COLOR forState:UIControlStateNormal];

        

        [_toolView addSubview:toolBtn];
    }
}

- (void)setButtonWith:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    //设定收藏的状态,未收藏时点击跳动并收藏,已收藏的点击后取消收藏
    if (btn.selected == 1){
        
        //当前按钮的跳动方法
        AKOthers *others = [[AKOthers alloc]init];
        [others viewJumpAnimationWith:btn Number:3 Height:10 Frame:btn.frame Num:3 Duration:0.05];
        [btn setImage:[UIImage resizeWithImageName:@"composer_rating_icon_highlighted"] forState:UIControlStateNormal];
    }else{
        
        [btn setImage:[UIImage resizeWithImageName:@"composer_rating_icon"] forState:UIControlStateNormal];
    }

}


























@end
