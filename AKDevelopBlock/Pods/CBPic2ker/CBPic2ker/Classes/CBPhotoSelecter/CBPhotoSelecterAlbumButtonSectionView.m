// CBPhotoSelecterAlbumButtonSectionView.m
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

#import <CBPic2ker/CBPhotoSelecterAlbumButtonSectionView.h>
#import <CBPic2ker/CBPhotoSelecterAlbumButton.h>

@implementation CBPhotoSelecterAlbumButtonSectionView

- (UIEdgeInsets)inset {
    return UIEdgeInsetsMake(2, 0, 2, 0);
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 40);
}

- (NSInteger)numberOfItems {
    return 1;
}

- (void)didUpdateToObject:(id)object {
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[UICollectionViewCell class]
                                                               forSectionController:self
                                                                            atIndex:index];
    if (cell && self.albumButton.superview != cell) {
        [cell.contentView addSubview:self.albumButton];
    }
    
    return cell;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
}

- (UIButton *)albumButton {
    if (!_albumButton) {
        _albumButton = [[CBPhotoSelecterAlbumButton alloc] initWithFrame:CGRectMake(2, 0, self.viewController.view.frame.size.width - 4, 40)];
        [_albumButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _albumButton.layer.cornerRadius = 3;
        [_albumButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:18]];
        [_albumButton addTarget:self
                         action:@selector(albumAction:)
               forControlEvents:UIControlEventTouchUpInside];
        _albumButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15];
    }
    return _albumButton;
}


- (void)albumAction:(UIButton *)sender {
    !_albumButtonTouchActionBlockInternal ?: _albumButtonTouchActionBlockInternal(sender);
}

@end
