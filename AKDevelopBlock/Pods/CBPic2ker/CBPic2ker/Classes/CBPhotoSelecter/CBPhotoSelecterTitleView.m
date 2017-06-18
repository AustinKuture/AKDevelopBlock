// CBPhotoSelecterTitleView.m
// Copyright (c) 2017 陈超邦.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <CBPic2ker/CBPhotoSelecterTitleView.h>

@interface CBPhotoSelecterTitleView ()

@property(nonatomic, strong, readwrite) navigationBarTitleViewSelectedBlock inSelectedBlock;
@property(nonatomic, strong, readwrite) navigationBarTitleViewUnSelectedBlock inUnSelectedBlock;

@end

@implementation CBPhotoSelecterTitleView

#pragma 初始化
- (instancetype)initWithFrame:(CGRect)frame
                selectedBlock:(navigationBarTitleViewSelectedBlock)selectedBlock
              unSelectedBlock:(navigationBarTitleViewUnSelectedBlock)unselectedBlock{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initNavigationBarTitleButton];
        [self initNavigationBarTitleImageView];
        [self addConstraints];
        
        _inSelectedBlock = selectedBlock;
        _inUnSelectedBlock = unselectedBlock;
    }
    return self;
}

- (void)initNavigationBarTitleButton {
    if (!_navigationBarTitleButton) {
        _navigationBarTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navigationBarTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
        [_navigationBarTitleButton addTarget:self action:@selector(navigationBarTitleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBarTitleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_navigationBarTitleButton];
    }
}

- (void)initNavigationBarTitleImageView {
    if (!_navigationBarTitleImageView) {
        _navigationBarTitleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_navigationBarTitleImageView setImage:[[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"CBPic2kerPicker" ofType:@"bundle"] stringByAppendingString:@"/ARR"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [_navigationBarTitleImageView setTintColor:[UIColor whiteColor]];
        [_navigationBarTitleImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_navigationBarTitleImageView];
    }
}

- (void)navigationBarTitleButtonAction:(id)sender {
    if (!_navigationBarTitleButton.selected) {
        [UIView animateWithDuration:0.1f
                              delay:0.f
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _navigationBarTitleImageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
                             _inSelectedBlock ? _inSelectedBlock() : nil;
                         } completion:nil];
        
        [_navigationBarTitleButton setSelected:YES];
    }else {
        [UIView animateWithDuration:0.1f
                              delay:0.f
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _navigationBarTitleImageView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
                             _inUnSelectedBlock ? _inUnSelectedBlock() : nil;
                         } completion:nil];
        
        [_navigationBarTitleButton setSelected:NO];
    }
}

- (void)hiddenImageViewWithTitle:(NSString *)title {
    if (!title.length) { return; }
    
    self.navigationBarTitleImageView.hidden = true;
    self.navigationBarTitleButton.userInteractionEnabled = false;
    
    [self.navigationBarTitleButton setTitle:title forState:UIControlStateNormal];
}

- (void)unHiddenImageViewWithTitle:(NSString *)title {
    if (!title.length) { return; }

    self.navigationBarTitleImageView.hidden = false;
    self.navigationBarTitleButton.userInteractionEnabled = true;
    
    [self.navigationBarTitleButton setTitle:title forState:UIControlStateNormal];
}

#pragma 添加约束
- (void)addConstraints {
    NSLayoutConstraint *buttonConstraintsBottom = [NSLayoutConstraint constraintWithItem:_navigationBarTitleButton
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.f
                                                                                constant:0.f];
    
    NSLayoutConstraint *buttonContraintsTop = [NSLayoutConstraint constraintWithItem:_navigationBarTitleButton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.f
                                                                            constant:0.f];
    
    NSLayoutConstraint *buttonContraintsCenterX = [NSLayoutConstraint constraintWithItem:_navigationBarTitleButton
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.f
                                                                                constant:-15];
    
    NSLayoutConstraint *imageContraintsLeft = [NSLayoutConstraint constraintWithItem:_navigationBarTitleImageView
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_navigationBarTitleButton
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.f
                                                                            constant:5.f];
    
    NSLayoutConstraint *imageContraintsCenterX = [NSLayoutConstraint constraintWithItem:_navigationBarTitleButton
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:_navigationBarTitleImageView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.f
                                                                               constant:-1.5f];
    
    [self addConstraints:@[buttonContraintsTop, buttonConstraintsBottom, buttonContraintsCenterX, imageContraintsLeft, imageContraintsCenterX]];
}

@end

