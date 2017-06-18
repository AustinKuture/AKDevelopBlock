// CBPhotoSelecterAssetCollectionSectionView.h
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

#import <CBPic2ker/CBCollectionViewSectionController.h>
#import <CBPic2ker/CBCollectionView.h>

@interface CBPhotoSelecterAssetCollectionSectionView : CBCollectionViewSectionController

/**
 CollectionView.
 */
@property (nonatomic, strong, readwrite) CBCollectionView *collectionView;

/**
Asset action block
 */
@property (nonatomic, copy, readwrite) void(^assetButtonTouchActionBlockInternal)(id model, id cell, NSInteger index);

/**
 CollectionView did scroll block.
 */
@property (nonatomic, copy, readwrite) void(^collectionViewDidScroll)(id scrollView);

/**
 Init Method.

 @param columnNumber The colum number of assetCollection.
 @param preViewHeight The height of pre-scrollView.
 @return CBPhotoSelecterAssetCollectionSectionView instance.
 */
- (instancetype)initWithColumnNumber:(NSInteger)columnNumber
                       preViewHeight:(NSInteger)preViewHeight;

@end
