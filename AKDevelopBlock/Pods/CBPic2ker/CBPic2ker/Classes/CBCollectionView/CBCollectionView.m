// CBCollectionView.m
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

#import "CBCollectionView.h"

@implementation CBCollectionView

#pragma mark - Init Methods.
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame
                     direction:CBPic2kerCollectionDirectionVertical];
}

- (instancetype)initWithFrame:(CGRect)frame
                    direction:(CBPic2kerCollectionDirection)direction {
    self.direction = direction;
    self.scrollEnabled = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = [self getCorrespondingLayoutDirection:direction];
    
    return [super initWithFrame:frame
           collectionViewLayout:layout];
}

#pragma mark - Setter && Getter
- (void)setDirection:(CBPic2kerCollectionDirection)direction {
    _direction = direction;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = [self getCorrespondingLayoutDirection:direction];
    
    [self startInteractiveTransitionToCollectionViewLayout:layout completion:nil];
}

#pragma mark - Internal
- (UICollectionViewScrollDirection)getCorrespondingLayoutDirection:(CBPic2kerCollectionDirection)direction {
    switch (direction) {
            case CBPic2kerCollectionDirectionVertical:
            return UICollectionViewScrollDirectionVertical;
            break;
            case CBPic2kerCollectionDirectionHorizontal:
            return UICollectionViewScrollDirectionHorizontal;
            break;
        default:
            break;
    }
}

@end
