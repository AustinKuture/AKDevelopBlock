// CBPhotoSelecterAssetCollectionSectionView.m
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

#import <CBPic2ker/CBPhotoSelecterAssetCollectionSectionView.h>
#import <CBPic2ker/UIView+CBPic2ker.h>
#import <CBPic2ker/CBCollectionViewAdapter.h>
#import <CBPic2ker/CBPhotoSelecterAssetSectionView.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>

@interface CBPhotoSelecterAssetCollectionSectionView() <CBCollectionViewAdapterDataSource, UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) CBCollectionViewAdapter *adapter;
@property (nonatomic, strong, readwrite) CBPhotoSelecterAssetSectionView *assetSectionView;

@property (nonatomic, copy, readwrite) NSArray *assetArray;
@property (nonatomic, assign, readwrite) NSInteger preViewHeightInternal;
@property (nonatomic, assign, readwrite) NSInteger columnNumberInternal;

@property (nonatomic, strong, readwrite) CBPhotoSelecterPhotoLibrary *photoLibrary;

@end

@implementation CBPhotoSelecterAssetCollectionSectionView {
    bool _isAlreadyPresent;
}

- (instancetype)initWithColumnNumber:(NSInteger)columnNumber
                       preViewHeight:(NSInteger)preViewHeight {
    self = [super init];
    if (self) {
        _columnNumberInternal = columnNumber;
        _preViewHeightInternal = preViewHeight;
    }
    return self;
}

- (CBCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[CBCollectionView alloc] init];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.scrollsToTop = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (CBCollectionViewAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[CBCollectionViewAdapter alloc] initWithViewController:self.viewController];
        _adapter.collectionView = self.collectionView;
        _adapter.dataSource = self;
        _adapter.scrollViewDelegate = self;
    }
    return _adapter;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    CGFloat heightOffset = self.section == 2 ? _preViewHeightInternal : 0;

    NSInteger dureation = _isAlreadyPresent ? 0.25 : 0;
    [UIView animateWithDuration:dureation
                     animations:^{
                         self.collectionView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - self.viewController.navigationController.navigationBar.sizeHeight - [[UIApplication sharedApplication] statusBarFrame].size.height - 44 - heightOffset);
                     }];
    
    return self.collectionView.frame.size;
}

- (NSInteger)numberOfItems {
    return 1;
}

- (void)didUpdateToObject:(id)object {
    NSMutableArray *currentAlbumAssetsModelsArray = object[1];
    
    if (!currentAlbumAssetsModelsArray.count) { return; }
    
    if (_assetArray.count != [(NSMutableArray *)currentAlbumAssetsModelsArray count]) {
        self.assetArray = currentAlbumAssetsModelsArray;
        [self.adapter reloadDataWithCompletion:nil];
    }
}

- (CBPhotoSelecterPhotoLibrary *)photoLibrary {
    _photoLibrary = [CBPhotoSelecterPhotoLibrary sharedPhotoLibrary];
    return _photoLibrary;
}

- (CBPhotoSelecterAssetSectionView *)assetSectionView {
    if (!_assetSectionView) {
        __weak typeof(self) weakSelf = self;
        _assetSectionView = [[CBPhotoSelecterAssetSectionView alloc] initWithColumNumber:_columnNumberInternal assetButtonTouchActionBlock:^(id model, id cell, NSInteger index) {
            __strong __typeof(self) strongSelf = weakSelf;

            !strongSelf.assetButtonTouchActionBlockInternal ?: strongSelf.assetButtonTouchActionBlockInternal(model, cell, index);
        }];
    }
    return _assetSectionView;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[UICollectionViewCell class]
                                                               forSectionController:self
                                                                            atIndex:index];
    if (cell && self.collectionView.superview != cell.contentView) {
        [cell.contentView addSubview:self.collectionView];
    }
    return cell;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
}

- (NSArray *)objectsForAdapter:(CBCollectionViewAdapter *)adapter {
    return [NSArray arrayWithObjects:_assetArray, nil];
}

- (CBCollectionViewSectionController *)adapter:(CBCollectionViewAdapter *)adapter
                    sectionControllerForObject:(id)object {
    return self.assetSectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !_collectionViewDidScroll ?: _collectionViewDidScroll(scrollView);
}

@end
