// CBPhotoBrowserScrollView+scrollViewDelegate.m
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

#import <CBPic2ker/CBPhotoBrowserScrollView+scrollViewDelegate.h>
#import <CBPic2ker/CBPhotoBrowserScrollViewCell.h>
#import <CBPic2ker/UIView+CBPic2ker.h>
#import <CBPic2ker/CBPhotoBrowserScrollViewDelegate.h>

@implementation CBPhotoBrowserScrollView (scrollViewDelegate)

#pragma mark - Internal
- (void)updateCellsForReuse {
    for (CBPhotoBrowserScrollViewCell *cell in self.cells) {
        if (cell.superview) {
            if (cell.originLeft > self.contentOffset.x + self.sizeWidth * 2||
                cell.originRight < self.contentOffset.x - self.sizeWidth) {
                [cell removeFromSuperview];
                cell.page = -1;
                cell.assetModel = nil;
            }
        }
    }
}

- (CBPhotoBrowserScrollViewCell *)dequeueReusableCell {
    CBPhotoBrowserScrollViewCell *cell = nil;
    for (cell in self.cells) {
        if (!cell.superview) {
            return cell;
        }
    }
    
    cell = [CBPhotoBrowserScrollViewCell new];
    cell.size = self.viewController.view.size;
    cell.imageContainerView.size = self.viewController.view.size;
    cell.validView.size = cell.bounds.size;
    cell.page = -1;
    cell.assetModel = nil;
    [self.cells addObject:cell];
    return cell;
}

#pragma mark - ScrollView delegate.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self hidePageControl];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self hidePageControl];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.imageBrowserDelegate respondsToSelector:@selector(imageBrowserScrollView:currentIndex:)]) {
        [self.imageBrowserDelegate imageBrowserScrollView:self currentIndex:targetContentOffset->x / self.sizeWidth];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCellsForReuse];
    
    CGFloat floatPage = self.contentOffset.x / self.sizeWidth;
    NSInteger page = self.contentOffset.x / self.sizeWidth + 0.5;
    
    for (NSInteger i = page - 3; i <= page + 3; i++) {
        if (i >= 0 && i < self.currentAssetArray.count) {
            CBPhotoBrowserScrollViewCell *cell = [self cellForPage:i];
            if (!cell) {
                CBPhotoBrowserScrollViewCell *cell = [self dequeueReusableCell];
                
                cell.page = i;
                cell.originLeft = (self.sizeWidth) * i + 10;
                
                if (self.isPresented) {
                    [cell configureCellWithModel:self.currentAssetArray[i]];
                }
                
                [self addSubview:cell];
            } else {
                if (self.isPresented && !cell.assetModel) {
                    [cell configureCellWithModel:self.currentAssetArray[i]];
                }
            }
        }
    }
    
    for (NSInteger i = 0; i < page - 3; i++) {
        CBPhotoBrowserScrollViewCell *cell = [self cellForPage:i];
        [[PHImageManager defaultManager] cancelImageRequest:cell.imageRequestID];
    }
    
    for (NSInteger i = page + 3; i < self.currentAssetArray.count - 1; i++) {
        CBPhotoBrowserScrollViewCell *cell = [self cellForPage:i];
        [[PHImageManager defaultManager] cancelImageRequest:cell.imageRequestID];
    }
    
    NSInteger intPage = floatPage + 0.5;
    intPage = intPage < 0 ? 0 : intPage >= self.currentAssetArray.count ? (int)self.currentAssetArray.count - 1 : intPage;
    self.pageControl.currentPage = intPage;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.pageControl.alpha = 1;
                     } completion:nil];
}

@end
