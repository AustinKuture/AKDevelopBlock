// CBPhotoSelecterPermissionView.m
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

#import "CBPhotoSelecterPermissionView.h"

static CGFloat const kCBPhotoSelecterPermissionViewImageViewHeightAndWidth = 120;

@interface CBPhotoSelecterPermissionView()

@property (nonatomic, strong, readwrite) UIImageView *accessImageView;
@property (nonatomic, strong, readwrite) UILabel *accessName;
@property (nonatomic, strong, readwrite) UILabel *accessDetail;
@property (nonatomic, strong, readwrite) UIButton *accessButton;
@property (nonatomic, weak, readwrite) void(^grantButtonAction)(void);

@end

@implementation CBPhotoSelecterPermissionView

#pragma mark - Public Methods.
- (instancetype)initWithFrame:(CGRect)frame
            grantButtonAction:(void (^)(void))grantButtonAction {
    self = [super initWithFrame:frame];
    if (self) {
        _grantButtonAction = grantButtonAction;
        
        [self setupViews];
    }
    return self;
}

#pragma mark - Internal.
- (UIImageView *)accessImageView {
    if (!_accessImageView) {
        _accessImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCBPhotoSelecterPermissionViewImageViewHeightAndWidth, kCBPhotoSelecterPermissionViewImageViewHeightAndWidth * 1.06)];
        _accessImageView.center = CGPointMake(self.center.x, self.frame.size.height / 4 - 25);
        [_accessImageView setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"CBPic2kerPicker" ofType:@"bundle"] stringByAppendingString:@"/PER"]]];
    }
    return _accessImageView;
}

- (UILabel *)accessName {
    if (!_accessName) {
        _accessName = [[UILabel alloc] initWithFrame:CGRectMake(_accessImageView.frame.origin.x, _accessImageView.frame.origin.y + _accessImageView.frame.size.height + 10, _accessImageView.frame.size.width, 25)];
        _accessName.text = @"Photo Access";
        _accessName.textColor = [UIColor grayColor];
        _accessName.font = [UIFont fontWithName:@"Avenir-BlackOblique" size:18.f];
    }
    return _accessName;
}

- (UILabel *)accessDetail {
    if (!_accessDetail) {
        _accessDetail = [[UILabel alloc] initWithFrame:CGRectMake(_accessName.frame.origin.x - 25, _accessName.frame.origin.y + _accessName.frame.size.height + 10, _accessName.frame.size.width + 50, 85)];
        _accessDetail.numberOfLines = 0;
        _accessDetail.text = [NSString stringWithFormat:@"%@ needs to access your photo data before your selecting photos.", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey]];
        _accessDetail.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        _accessDetail.font = [UIFont fontWithName:@"AvenirNext-Regular" size:15.f];
        _accessDetail.textAlignment = NSTextAlignmentCenter;
        _accessDetail.textColor = [UIColor lightGrayColor];
    }
    return _accessDetail;
}

- (UIButton *)accessButton {
    if (!_accessButton) {
        _accessButton = [[UIButton alloc] initWithFrame:CGRectMake(_accessDetail.frame.origin.x - 25, _accessDetail.frame.origin.y + _accessDetail.frame.size.height + 25, _accessDetail.frame.size.width + 50, 40)];
        _accessButton.layer.cornerRadius = 5;
        [_accessButton setTitle:@"Grant Permission" forState:UIControlStateNormal];
        [_accessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accessButton.titleLabel setFont:[UIFont fontWithName:@"DINAlternate-Bold" size:18.f]];
        [_accessButton setBackgroundColor:[UIColor colorWithRed:(253 / 255.0) green:(193 / 255.0)  blue:(57 / 255.0) alpha:1.0]];
        [_accessButton addTarget:self
                          action:@selector(accessButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _accessButton;
}

- (void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.accessImageView];
    [self addSubview:self.accessName];
    [self addSubview:self.accessDetail];
    [self addSubview:self.accessButton];
}

- (void)accessButtonAction:(id)sender {
    !_grantButtonAction ?: _grantButtonAction();
}

@end
