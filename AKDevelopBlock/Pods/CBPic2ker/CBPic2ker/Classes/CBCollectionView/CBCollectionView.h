// CBCollectionView.h
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

#import <UIKit/UIKit.h>
#import <CBPic2ker/CBCollectionViewAdapterDataSource.h>

@class CBCollectionViewAdapter;

/**
 CBPic2ker direction.

 - CBPic2kerCollectionDirectionVertical: vertical.
 - CBPic2kerCollectionDirectionHorizontal: horizontal.
 */
typedef NS_ENUM(NSInteger, CBPic2kerCollectionDirection) {
    CBPic2kerCollectionDirectionVertical,
    CBPic2kerCollectionDirectionHorizontal
};

@interface CBCollectionView : UICollectionView

/**
 CBPic2ker direction, used to judge the direction of CBPic2ker.
 */
@property (nonatomic, assign, readwrite) CBPic2kerCollectionDirection direction;

/**
 Initializes a new "CBCollectionView" instance

 @param frame Target rect.
 @return "CBCollectionView" instance.
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 Initializes a new "CBCollectionView" instance

 @param frame Target rect.
 @param direction The direction of CBPic2ker.
 @return "CBCollectionView" instance.
 */
- (instancetype)initWithFrame:(CGRect)frame
                    direction:(CBPic2kerCollectionDirection)direction;

@end
