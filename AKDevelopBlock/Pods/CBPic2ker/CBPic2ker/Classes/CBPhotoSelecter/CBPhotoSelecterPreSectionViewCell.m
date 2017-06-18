// CBPhotoSelecterPreSectionViewCell.m
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

#import <CBPic2ker/CBPhotoSelecterPreSectionViewCell.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <CBPic2ker/UIImage+CBPic2ker.h>

@interface CBPhotoSelecterPreSectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) PHLivePhotoView *livePhotoView;
@property (nonatomic, strong, readwrite) UIButton *playButton;
@property (nonatomic, strong, readwrite) UIWebView *GIFImageWebView;

@property (nonatomic, strong, readwrite) CBPhotoSelecterAssetModel *assetModel;
@property (nonatomic, strong, readwrite) NSString *representedAssetIdentifier;
@property (nonatomic, assign, readwrite) int imageRequestID;

@property (nonatomic, copy, readwrite) void(^selectedActionBlockInternal)(id model);

@end

@implementation CBPhotoSelecterPreSectionViewCell

- (void)configureWithAssetModel:(CBPhotoSelecterAssetModel *)assetModel
            selectedActionBlock:(void (^)(id))selectedActionBlock {
    if (!assetModel) { return; }
    
    _selectedActionBlockInternal = selectedActionBlock;
    
    self.assetModel = assetModel;
    self.representedAssetIdentifier = [(PHAsset *)assetModel.asset localIdentifier];
    
    PHImageRequestID imageRequestID = 0;
    switch (assetModel.mediaType) {
            /*
        case CBPhotoSelecterAssetModelMediaTypeLivePhoto: {
            [self.contentView addSubview:self.livePhotoView];
            self.imageView.image = _assetModel.fullSizeImage ? _assetModel.fullSizeImage : (_assetModel.middleSizeImage ? _assetModel.middleSizeImage: _assetModel.smallSizeImage);
            
            if (!_assetModel.middleSizeImage) {
                imageRequestID = [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getLivePhotoForAsset:assetModel.asset photoWidth:self.frame.size.width completion:^(PHLivePhoto *livePhoto, NSDictionary *info) {
                    self.livePhotoView.livePhoto = livePhoto;
                    [self.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleHint];
                } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                    
                }];
            }
        }
            break;
            */
        default: {
            [self.contentView addSubview:self.imageView];
            /*
            if (assetModel.mediaType == CBPhotoSelecterAssetModelMediaTypeVideo) {
                [self.contentView addSubview:self.playButton];
            }
             */
            
            self.imageView.image = _assetModel.fullSizeImage ? _assetModel.fullSizeImage : (_assetModel.middleSizeImage ? _assetModel.middleSizeImage: _assetModel.smallSizeImage);
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *faceImage = [self.imageView.image betterFaceImageForSize:self.contentView.frame.size accuracy:kBFAccuracyLow];
                if (faceImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self updateImageViewWithImage:faceImage];
                    });
                }
            });
            
            if (!_assetModel.middleSizeImage) {
                imageRequestID = [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getPhotoWithAsset:assetModel.asset photoWidth:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                    if (!isDegraded) {
                        if ([self.representedAssetIdentifier isEqualToString:[(PHAsset *)assetModel.asset localIdentifier]]) {
                            self.imageView.image = photo;
                            assetModel.middleSizeImage = photo;
                            
                            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                UIImage *faceImage = [self.imageView.image betterFaceImageForSize:self.contentView.frame.size accuracy:kBFAccuracyLow];
                                if (faceImage) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self updateImageViewWithImage:faceImage];
                                    });
                                }
                            });
                        } else {
                            [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
                        }
                    }
                } progressHandler:nil];
            }
        }
            break;
    }
    
    self.imageRequestID = imageRequestID;
}

- (void)updateImageViewWithImage:(UIImage *)image {
    UIViewAnimationOptions option;
    if ([[[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] selectedAssetArr] count] == 1 && [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] isInsetAsset] ) {
        option = UIViewAnimationOptionTransitionCrossDissolve;
    } else {
        option = UIViewAnimationOptionCurveEaseIn;
    }
    
    [UIView transitionWithView:self.imageView
                      duration:0.5
                       options:option
                    animations:^{
                        self.imageView.image = image;
                        self.assetModel.middleSizeImage = image;
                    } completion:nil];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapAction:)]];
    }
    return _imageView;
}

- (UIWebView *)GIFImageWebView {
    if (!_GIFImageWebView) {
        _GIFImageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _GIFImageWebView;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _playButton.center = _imageView.center;
        [_playButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"CBPic2kerPicker" ofType:@"bundle"] stringByAppendingString:@"/PLAY"]] forState:UIControlStateNormal];
    }
    return _playButton;
}

- (PHLivePhotoView *)livePhotoView {
    if (!_livePhotoView) {
        _livePhotoView = [[PHLivePhotoView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _livePhotoView.clipsToBounds = YES;
        _livePhotoView.backgroundColor = [UIColor grayColor];
        [_livePhotoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tapAction:)]];
        _livePhotoView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _livePhotoView;
}

- (void)tapAction:(id)sender {
    !_selectedActionBlockInternal ?: _selectedActionBlockInternal(_assetModel);
}

@end
