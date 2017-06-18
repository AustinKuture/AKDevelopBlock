// CBPhotoSelecterAssetSectionView.m
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

#import <CBPic2ker/CBPhotoSelecterAssetSectionView.h>
#import <CBPic2ker/CBPhotoSelecterAssetSectionViewCell.h>

@interface CBPhotoSelecterAssetSectionView()

@property (nonatomic, assign, readwrite) NSInteger columNumber;
@property (nonatomic, strong, readwrite) NSMutableArray<CBPhotoSelecterAssetModel *> *currentAlbumAssetsModelsArray;

@property (nonatomic, copy, readwrite) void(^assetButtonTouchActionBlockInternal)(id model, id cell, NSInteger idnex);

@end

@implementation CBPhotoSelecterAssetSectionView

- (UIEdgeInsets)inset {
    return UIEdgeInsetsMake(0, 2, 2, 2);
}

- (CGFloat)minimumLineSpacing {
    return 1;
}

- (instancetype)initWithColumNumber:(NSInteger)columNumber
        assetButtonTouchActionBlock:(void (^)(id model, id cell, NSInteger idnex))assetButtonTouchActionBlock {
    self = [super init];
    if (self) {
        _columNumber = columNumber;
        _assetButtonTouchActionBlockInternal = assetButtonTouchActionBlock;
    }
    return self;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake((self.viewController.view.frame.size.width - (_columNumber - 1) * 1 - 4) / _columNumber, (self.viewController.view.frame.size.width - (_columNumber - 1) * 1 - 4) / _columNumber);
}

- (NSInteger)numberOfItems {
    return _currentAlbumAssetsModelsArray.count;
}

- (void)didUpdateToObject:(id)object {
    _currentAlbumAssetsModelsArray = object;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    if (_currentAlbumAssetsModelsArray.count <= index) { return nil; }
    
    CBPhotoSelecterAssetSectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[CBPhotoSelecterAssetSectionViewCell class]
                                            forSectionController:self
                                                         atIndex:index];
    
    [cell configureWithAssetModel:_currentAlbumAssetsModelsArray[index]
              selectedActionBlock:^(id model) {
                  !_assetButtonTouchActionBlockInternal ?: _assetButtonTouchActionBlockInternal(model, cell, index);
              }];
    return cell;
}

@end
