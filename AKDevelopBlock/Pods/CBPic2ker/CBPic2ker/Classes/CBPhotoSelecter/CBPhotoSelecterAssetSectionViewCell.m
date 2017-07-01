// CBPhotoSelecterAssetSectionViewCellCollectionViewCell.m
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

#import <CBPic2ker/CBPhotoSelecterAssetSectionViewCell.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>
#import <CBPic2ker/CBPhotoSelecterAssetModel.h>
#import <CBPic2ker/UIImage+CBPic2ker.h>

@interface CBPhotoSelecterAssetSectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *assetImageView;
//@property (nonatomic, strong, readwrite) UIImageView *videoImgView;
@property (nonatomic, strong, readwrite) UIView *bottomView;
@property (nonatomic, strong, readwrite) UILabel *typeLable;
@property (nonatomic, strong, readwrite) UILabel *timeLength;
@property (nonatomic, strong, readwrite) UIButton *selectButton;

@property (nonatomic, copy, readwrite) NSString *representedAssetIdentifier;
@property (nonatomic, assign, readwrite) PHImageRequestID imageRequestID;
@property (nonatomic, assign, readwrite) CBPhotoSelecterAssetModelMediaType type;

@property (nonatomic, strong, readwrite) CBPhotoSelecterAssetModel *assetModel;

@property (nonatomic, copy, readwrite) void(^selectedActionBlockInternal)(id model);

@end

@implementation CBPhotoSelecterAssetSectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.assetImageView];
        [self.contentView addSubview:self.bottomView];
        [self.bottomView addSubview:self.typeLable];
        [self.bottomView addSubview:self.timeLength];
        [self.contentView addSubview:self.selectButton];
    }
    return self;
}

- (void)configureWithAssetModel:(CBPhotoSelecterAssetModel *)assetModel
            selectedActionBlock:(void (^)(id model))selectedActionBlock {
    if (!assetModel) { return; }
    
    _assetModel = assetModel;
    _selectedActionBlockInternal = selectedActionBlock;
    
    self.representedAssetIdentifier = [(PHAsset *)assetModel.asset localIdentifier];
    self.type = (NSInteger)assetModel.mediaType;
    
    self.assetImageView.image = assetModel.middleSizeImage ? assetModel.middleSizeImage : assetModel.smallSizeImage;
    
    if (!assetModel.smallSizeImage) {
        self.imageRequestID = [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getPhotoWithAsset:assetModel.asset photoWidth:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            if ([self.representedAssetIdentifier isEqualToString:[(PHAsset *)assetModel.asset localIdentifier]]) {
                self.assetImageView.image = photo;
                assetModel.smallSizeImage = photo;
            } else {
                [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
            }
        } progressHandler:nil];
    }
    
    self.selectedStatus = assetModel.isSelected;
}

- (void)selectAction:(id)sender {
    self.selectedStatus = !self.selectedStatus;
    !self.selectedActionBlockInternal ?: self.selectedActionBlockInternal(_assetModel);
    self.assetImageView.image = _assetModel.middleSizeImage ? _assetModel.middleSizeImage : _assetModel.smallSizeImage;
}

- (UIImageView *)assetImageView {
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _assetImageView.contentMode = UIViewContentModeScaleAspectFill;
        _assetImageView.clipsToBounds = YES;
    }
    return _assetImageView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 17, self.frame.size.width, 17)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _bottomView;
}

- (UILabel *)typeLable {
    if (!_typeLable) {
        _typeLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 50, 17)];
        _typeLable.textColor = [UIColor whiteColor];
        _typeLable.font = [UIFont boldSystemFontOfSize:11];
        _typeLable.textAlignment = NSTextAlignmentLeft;
    }
    return _typeLable;
}

- (void)setType:(CBPhotoSelecterAssetModelMediaType)type {
    _type = type;
    
    switch (_type) {
            /*
        case CBPhotoSelecterAssetModelMediaTypeVideo:
            _bottomView.hidden = false;
            _typeLable.hidden = false;
            _typeLable.text = @"VIDEO";
            _timeLength.text = _assetModel.timeLength;
            break;
        case CBPhotoSelecterAssetModelMediaTypeGif:
            _bottomView.hidden = false;
            _typeLable.hidden = YES;
            _timeLength.text = @"GIF";
            break;
        case CBPhotoSelecterAssetModelMediaTypeLivePhoto:
            _bottomView.hidden = false;
            _typeLable.hidden = false;
            _typeLable.text = @"LIVE";
            _timeLength.text = @"0:03";
            break;
             */
        default:
            _bottomView.hidden = YES;
            break;
    }
}

- (UILabel *)timeLength {
    if (!_timeLength) {
        _timeLength = [[UILabel alloc] init];
        _timeLength.frame = CGRectMake(self.typeLable.frame.origin.x + self.typeLable.frame.size.width, 0, self.frame.size.width - self.typeLable.frame.origin.x - self.typeLable.frame.size.width - 5, 17);
        _timeLength.textColor = [UIColor whiteColor];
        _timeLength.font = [UIFont boldSystemFontOfSize:11];
        _timeLength.textAlignment = NSTextAlignmentRight;
    }
    return _timeLength;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (void)setSelectedStatus:(BOOL)selectedStatus {
    if (_selectedStatus == selectedStatus) { return; }
    
    _selectedStatus = selectedStatus;
    _assetModel.isSelected = selectedStatus;
    
    if (selectedStatus) {
        [_selectButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"CBPic2kerPicker" ofType:@"bundle"] stringByAppendingString:@"/SEL"]] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformMakeScale(0.975, 0.975);
        }];
    } else {
        [_selectButton setBackgroundImage:nil forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
}

@end
