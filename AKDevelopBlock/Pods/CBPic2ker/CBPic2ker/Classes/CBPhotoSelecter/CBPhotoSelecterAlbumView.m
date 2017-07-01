// CBPic2kerAlbumTableView.m
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

#import <CBPic2ker/CBPhotoSelecterAlbumView.h>
#import <CBPic2ker/CBCollectionViewAdapter.h>
#import <CBPic2ker/CBPhotoSelecterAlbumSectionView.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>
#import <CBPic2ker/CBCollectionView.h>
#import <CBPic2ker/CBCollectionViewAdapter+collectionViewDelegate.h>

@interface CBPhotoSelecterAlbumView() <CBCollectionViewAdapterDataSource>

@property (nonatomic, strong, readwrite) CBCollectionView *collectionView;
@property (nonatomic, strong, readwrite) CBCollectionViewAdapter *adapter;
@property (nonatomic, copy, readwrite) NSArray *albumDataArr;

@property (nonatomic, copy, readwrite) void(^albumBlock)(CBPhotoSelecterAlbumModel *model);

@end

@implementation CBPhotoSelecterAlbumView

- (instancetype)initWithFrame:(CGRect)frame
                   albumArray:(NSArray *)albumArray
        didSelectedAlbumBlock:(void (^)(CBPhotoSelecterAlbumModel *))albumBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.albumDataArr = albumArray;
        self.albumBlock = albumBlock;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpBlurView];
        
        [self.adapter setDataSource:self];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setUpBlurView {
    UIBlurEffect *blurView = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blurView];
    effectview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    [self addSubview:effectview];
}

- (CBCollectionViewAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[CBCollectionViewAdapter alloc] initWithViewController:nil];
        _adapter.collectionView = self.collectionView;
    }
    return _adapter;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[CBCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (NSArray *)albumDataArr {
    if (!_albumDataArr) {
        _albumDataArr = [[NSMutableArray alloc] init];
    }
    return _albumDataArr;
}

#pragma mark - Adapter DataSource
- (NSArray *)objectsForAdapter:(CBCollectionViewAdapter *)adapter {
    return [NSArray arrayWithObjects:self.albumDataArr, nil];
}

- (CBCollectionViewSectionController *)adapter:(CBCollectionViewAdapter *)adapter
             sectionControllerForObject:(id)object {
    return [[CBPhotoSelecterAlbumSectionView alloc] initWithSelectedAlbumBlock:_albumBlock];
}

@end
