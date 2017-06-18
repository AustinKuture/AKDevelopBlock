// CBPhotoSelecterAlbumSectionView.m
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

#import <CBPic2ker/CBPhotoSelecterAlbumSectionView.h>
#import <CBPic2ker/CBPhotoSelecterAlbumSectionViewCell.h>

@interface CBPhotoSelecterAlbumSectionView()

@property (nonatomic, strong, readwrite) NSArray *dataModelArr;
@property (nonatomic, copy, readwrite) void(^albumBlock)(CBPhotoSelecterAlbumModel *model);

@end

@implementation CBPhotoSelecterAlbumSectionView

- (instancetype)initWithSelectedAlbumBlock:(void (^)(CBPhotoSelecterAlbumModel *))albumBlock {
    self = [super init];
    if (self) {
        _albumBlock = albumBlock;
    }
    return self;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width - 16, 65);
}

- (NSInteger)numberOfItems {
    return _dataModelArr.count;
}

- (void)didUpdateToObject:(id)object {
    _dataModelArr = object;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    if (index >= _dataModelArr.count) { return nil; }
    
    CBPhotoSelecterAlbumSectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[CBPhotoSelecterAlbumSectionViewCell class]
                                                                        forSectionController:self
                                                                                     atIndex:index];
    [cell configureWithAlbumModel:_dataModelArr[index]];
    return cell;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    if (index >= _dataModelArr.count) { return; }
    
    if (_albumBlock) {
        _albumBlock(_dataModelArr[index]);
    }
}

@end
