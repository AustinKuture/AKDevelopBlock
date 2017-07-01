// CBPhotoBrowserScrollViewCell.m
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

#import <CBPic2ker/CBPhotoBrowserScrollViewCell.h>
#import <CBPic2ker/CBPhotoBrowserAssetModel.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>
#import <CBPic2ker/UIView+CBPic2ker.h>
#import <PhotosUI/PhotosUI.h>
#import <Photos/Photos.h>

@interface CBPhotoBrowserScrollViewCell() <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) CBPhotoSelecterPhotoLibrary *photoLibrary;
@property (nonatomic, strong, readwrite) CAShapeLayer *progressLayer;
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) PHLivePhotoView *livePhotoView;

@end

@implementation CBPhotoBrowserScrollViewCell

#pragma init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.bouncesZoom = YES;
        self.maximumZoomScale = 3;
        self.multipleTouchEnabled = YES;
        self.alwaysBounceVertical = NO;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.imageContainerView];
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}

#pragma maek - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.progressLayer.frame;
    CGPoint center = CGPointMake(self.sizeWidth / 2, self.sizeHeight / 2);
    frame.origin.x = center.x - frame.size.width * 0.5;
    frame.origin.y = center.y - frame.size.height * 0.5;
    self.progressLayer.frame = frame;
}

#pragma mark - Setter && Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UIView *)validView {
    switch (_assetModel.mediatype) {
            /*
        case 0:
            return self.imageView;
            break;
        case 1:
            return self.livePhotoView;
            break;
             */
        default:
            return self.imageView;
            break;
    }
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 40, 40);
        _progressLayer.cornerRadius = 20;
        _progressLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_progressLayer.bounds, 7, 7) cornerRadius:(40 / 2 - 7)];
        _progressLayer.path = path.CGPath;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.lineWidth = 4;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        _progressLayer.hidden = YES;
    }
    return _progressLayer;
}

- (UIView *)imageContainerView {
    if (!_imageContainerView) {
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
    }
    return _imageContainerView;
}

- (CBPhotoSelecterPhotoLibrary *)photoLibrary {
    if (!_photoLibrary) {
        _photoLibrary = [CBPhotoSelecterPhotoLibrary sharedPhotoLibrary];
    }
    return _photoLibrary;
}

- (PHLivePhotoView *)livePhotoView {
    if (!_livePhotoView) {
        _livePhotoView = [[PHLivePhotoView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _livePhotoView.clipsToBounds = YES;
    }
    return _livePhotoView;
}

#pragma mark - Public
- (void)configureCellWithModel:(CBPhotoBrowserAssetModel *)model {
    if (!model) { return; }
    
    self.assetModel = model;
    
    [self setZoomScale:1.0 animated:NO];
    self.maximumZoomScale = 3;
    
    self.progressLayer.hidden = NO;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.progressLayer.strokeEnd = 0;
    self.progressLayer.hidden = YES;
    [CATransaction commit];
    
    switch (model.mediatype) {
            /*
        case 1: { // CBPhotoSelecterAssetModelMediaTypeLivePhoto
            [self.imageContainerView addSubview:self.livePhotoView];

            self.livePhotoView.livePhoto = model.livePhoto ? model.livePhoto : nil;
            
            if (!model.livePhoto || model.livePhoto.size.width != self.frame.size.width) {
                _imageRequestID = [self.photoLibrary getFullSizeLivePhotoForAsset:model.asset completion:^(PHLivePhoto *livePhoto, NSDictionary *info) {
                    if ([livePhoto isKindOfClass:[livePhoto class]]) {
                        self.livePhotoView.livePhoto = livePhoto;
                        self.progressLayer.hidden = YES;
                        self.maximumZoomScale = 3;
                        [self reLayoutSubviews];
                    }
                } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                    if (isnan(progress)) progress = 0;
                    self.progressLayer.hidden = NO;
                    self.progressLayer.strokeEnd = progress;
                }];
            } else if (model.livePhoto) {
                [self.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleHint];
            }
        }
            break;
        */
        default: {
            [self.imageContainerView addSubview:self.imageView];
            
            self.imageView.image = model.fullSizeImage ? model.fullSizeImage : model.middleSizeImage ? model.middleSizeImage : model.smallSizeImage;
            
            if (!model.fullSizeImage) {
                _imageRequestID = [self.photoLibrary getFullSizePhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                    if ([photo isKindOfClass:[UIImage class]]) {
                        self.imageView.image = photo;
                        model.fullSizeImage = photo;
                        self.progressLayer.hidden = YES;
                        [self reLayoutSubviews];
                        self.maximumZoomScale = 3;
                    }
                } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                    if (isnan(progress)) progress = 0;
                    self.progressLayer.hidden = NO;
                    self.progressLayer.strokeEnd = progress;
                }];
            } else {
                self.maximumZoomScale = 3;
            }
        }
            break;
    }
    
    [self reLayoutSubviews];
}

- (void)reLayoutSubviews {
    self.imageContainerView.origin = CGPointZero;
    self.imageContainerView.sizeWidth = self.sizeWidth;
    
    CGSize size = self.imageView.image ? self.imageView.image.size : self.livePhotoView.livePhoto.size;
    if (size.height / size.width > self.sizeHeight / self.sizeWidth) {
        self.imageContainerView.sizeHeight = floor(size.height / (size.width / self.sizeWidth));
    } else{
        CGFloat height = floor(size.height / size.width * self.sizeWidth);
        self.imageContainerView.sizeHeight = height;
        self.imageContainerView.centerY = self.sizeHeight / 2;
    }
    
    self.contentSize = CGSizeMake(self.sizeWidth, MAX(_imageContainerView.sizeHeight, self.sizeHeight));
    [self scrollRectToVisible:self.bounds animated:NO];

    if (_imageContainerView.sizeHeight < self.sizeHeight) {
        self.alwaysBounceVertical = NO;
    } else {
        self.alwaysBounceVertical = YES;
    }

    self.imageView.frame = _imageContainerView.bounds;
    self.livePhotoView.frame = _imageContainerView.bounds;
}

@end
