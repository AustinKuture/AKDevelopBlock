// CBPhotoBrowserScrollView.m
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

#import <CBPic2ker/CBPhotoBrowserScrollView.h>
#import <CBPic2ker/UIView+CBPic2ker.h>
#import <CBPic2ker/CBPhotoBrowserAssetModel.h>
#import <CBPic2ker/CBPhotoBrowserScrollViewCell.h>
#import <CBPic2ker/CBPhotoBrowserScrollView+scrollViewDelegate.h>

@interface CBPhotoBrowserScrollView() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, strong, readwrite) UIView *fromView;
@property (nonatomic, strong, readwrite) UIView *containerView;

@property (nonatomic, assign, readwrite) NSInteger fromItemIndex;
@property (nonatomic, assign, readwrite) BOOL fromNavigationBarHidden;

@end

@implementation CBPhotoBrowserScrollView {
    CGPoint _panGestureBeginPoint;
}

#pragma mark - Init methods.
- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.scrollsToTop = NO;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
        self.userInteractionEnabled = NO;
        self.cells = @[].mutableCopy;
        self.alpha = 1;
    }
    
    return self;
}

#pragma mark - Setter && Getter
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = self.bounds;
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 1;
    }
    return _backgroundView;
}

- (void)setCurrentAssetArray:(NSMutableArray *)currentAssetArray {
    _currentAssetArray = currentAssetArray;
    
    self.contentSize = CGSizeMake(_containerView.sizeWidth * currentAssetArray.count, _containerView.sizeHeight);
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.sizeHeight - 36, self.sizeWidth - 30, 10)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.alpha = 0;
    }
    return _pageControl;
}

#pragma mark - Internal
- (CBPhotoBrowserScrollViewCell *)cellForPage:(NSInteger)page {
    for (CBPhotoBrowserScrollViewCell *cell in _cells) {
        if (cell.page == page) {
            return cell;
        }
    }
    return nil;
}

- (void)hidePageControl {
    [UIView animateWithDuration:0.3
                          delay:0.8
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
                            self.pageControl.alpha = 0;
                        } completion:nil];
}

- (void)addGesture {
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(doubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    [doubleTap requireGestureRecognizerToFail:doubleTap];
    [self.backgroundView addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(dismiss:)];
    singleTap.delegate = self;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.backgroundView addGestureRecognizer:singleTap];
    
    /*
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(longPress:)];
    longPress.delegate = self;
    [self.backgroundView addGestureRecognizer:longPress];
    */
     
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(panGesture:)];
    [self.backgroundView addGestureRecognizer:panGesture];
}

- (void)doubleTap:(id)sender {
    CBPhotoBrowserScrollViewCell *tile = [self cellForPage:self.currentPage];
    if (tile) {
        if (tile.zoomScale > 1) {
            [tile setZoomScale:1 animated:YES];
        } else {
            CGPoint touchPoint = [sender locationInView:tile.validView];
            CGFloat newZoomScale = tile.maximumZoomScale;
            CGFloat xsize = self.sizeWidth / newZoomScale;
            CGFloat ysize = self.sizeHeight / newZoomScale;
            [tile zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        }
    }
}

- (void)dismiss:(id)sender  {
    [self dismissAnimated:YES
               completion:nil];
}

/*
- (void)longPress:(id)sender  {
    CBPhotoBrowserScrollViewCell *tile = [self cellForPage:self.currentPage];
    if (!tile.imageView.image) return;
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[tile.imageView.image] applicationActivities:nil];
    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)]) {
        activityViewController.popoverPresentationController.sourceView = self;
    }
    [self.viewController presentViewController:activityViewController animated:YES completion:nil];
}
 */

- (void)panGesture:(UIPanGestureRecognizer *)sender  {
    if (!_isPresented) return;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _panGestureBeginPoint = [sender locationInView:self.backgroundView];
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        CGFloat changeDistanceY = [sender locationInView:self.backgroundView].y - _panGestureBeginPoint.y;
        self.originUp = changeDistanceY;
        
        CGFloat alpha = (1.5 - fabs(changeDistanceY) / 200);
        alpha > 1 ? alpha = 1 : alpha < 0 ? alpha = 0 : alpha;
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.backgroundView.alpha = alpha;
                            } completion:nil];
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        CGPoint moveSpeed = [sender velocityInView:self.backgroundView];
        CGPoint changeToPoint = [sender locationInView:self.backgroundView];
        CGFloat changeDistanceY = changeToPoint.y - _panGestureBeginPoint.y;
        
        if (fabs(moveSpeed.y) > 1000 || fabs(changeDistanceY) > 200) {
            _isPresented = NO;
            
            BOOL moveToTop = (moveSpeed.y < - 50 || (moveSpeed.y < 50 && changeDistanceY < 0));
            CGFloat duration = (moveToTop ? self.originDown : self.sizeHeight - self.originUp) / (fabs(moveSpeed.y) > 1 ? fabs(moveSpeed.y) : 1);
            duration > 0.1 ? duration = 0.1 : duration < 0.05 ? duration = 0.05 : duration;
            [UIView animateWithDuration:duration
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState animations:^{
                                    self.backgroundView.alpha = 0;
                                    if (moveToTop) {
                                        self.originDown = 0;
                                    } else {
                                        self.originUp = self.sizeHeight;
                                    }
                                    
                                     [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation: UIStatusBarAnimationNone];
                                } completion:^(BOOL finished) {
                                    [self.backgroundView removeFromSuperview];
                                }];
        } else {
            [UIView animateWithDuration:0.4f
                                  delay:0.f
                 usingSpringWithDamping:0.9f
                  initialSpringVelocity:moveSpeed.y / 1000.f
                                options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.originUp = 0;
                                 self.backgroundView.alpha = 1;
                             } completion:nil];
        }
    }
}

- (NSInteger)currentPage {
    NSInteger page = self.contentOffset.x / self.sizeWidth + 0.5;
    if (page >= _currentAssetArray.count) page = (NSInteger)_currentAssetArray.count - 1;
    if (page < 0) page = 0;
    return page;
}

#pragma mark - Public
- (void)presentFromImageView:(UIView *)fromView
                       index:(NSInteger)index
                   container:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    if (!fromView || !container) { return; }
    _fromView = fromView;
    _containerView = container;
    _fromItemIndex = index;
    
    self.frame = CGRectMake(-10, 0, container.size.width + 20, container.size.height);
    [container addSubview:self.backgroundView];
    [self.backgroundView addSubview:self];
    [self.backgroundView addSubview:self.pageControl];

    self.pageControl.numberOfPages = self.currentAssetArray.count;

    [self addGesture];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    self.contentSize = CGSizeMake(self.sizeWidth * self.currentAssetArray.count, self.sizeHeight);
    [self scrollRectToVisible:CGRectMake(self.sizeWidth * self.fromItemIndex, 0, self.sizeWidth, self.sizeHeight) animated:NO];
    [self scrollViewDidScroll:self];
    
    CBPhotoBrowserAssetModel *item = self.currentAssetArray[self.currentPage];
    CBPhotoBrowserScrollViewCell *imageCell = [self cellForPage:_fromItemIndex];
    [imageCell configureCellWithModel:item];
    
    [self showWithAnimated:YES
                      cell:imageCell
                completion:nil];
}

- (void)showWithAnimated:(BOOL)animated
                    cell:(CBPhotoBrowserScrollViewCell *)cell
              completion:(void (^)(void))completion {
    if (!cell) { return; }
    
    CGRect fromFrame = [_fromView convertRect:_fromView.bounds
                                       toView:cell.imageContainerView];
    cell.imageContainerView.clipsToBounds = NO;
    cell.validView.frame = fromFrame;
    cell.validView.contentMode = UIViewContentModeScaleAspectFill;

    float oneTime = animated ? 0.18 : 0;
    [UIView animateWithDuration:oneTime
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        cell.validView.frame = cell.imageContainerView.bounds;
        [cell.validView.layer setValue:@(1.01) forKey:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:oneTime delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
            [cell.validView.layer setValue:@(1.0) forKey:@"transform.scale"];
            self.pageControl.alpha = 1;
        }completion:^(BOOL finished) {
            self.isPresented = YES;
            [self scrollViewDidScroll:self];
            self.userInteractionEnabled = YES;
            [self hidePageControl];
            if (completion) completion();
        }];
    }];
    
}

- (void)dismissAnimated:(BOOL)animated
             completion:(void (^)(void))completion {
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation: UIStatusBarAnimationNone];
    
    UIView *fromView = nil;
    CBPhotoBrowserScrollViewCell *imageCell = [self cellForPage:_fromItemIndex];
    CBPhotoBrowserAssetModel *item = self.currentAssetArray[self.currentPage];

    if (_fromItemIndex == [self currentPage]) {
        fromView = _fromView;
    } else {
        fromView = item.sourceView;
    }
    
    self.isPresented = NO;
    self.cells = @[].mutableCopy;
    
    [UIView animateWithDuration:animated ? 0.2 : 0
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
                            self.pageControl.alpha = 0.0;
                            self.backgroundView.alpha = 0.0;
                            
                            CGRect fromFrame = [fromView convertRect:fromView.bounds
                                                              toView:imageCell.imageContainerView];
                            imageCell.imageContainerView.clipsToBounds = NO;
                            imageCell.validView.contentMode = fromView.contentMode;
                            imageCell.validView.frame = fromFrame;
                            // imageCell.imageView.image = item.middleSizeImage;
                        }completion:^(BOOL finished) {
                            [UIView animateWithDuration:animated ? 0.15 : 0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                self.alpha = 0;
                            } completion:^(BOOL finished) {
                                imageCell.imageContainerView.layer.anchorPoint = CGPointMake(0.5, 0.5);
                                [self.backgroundView removeFromSuperview];
                                if (completion) completion();
                            }];
                        }];
}

@end
