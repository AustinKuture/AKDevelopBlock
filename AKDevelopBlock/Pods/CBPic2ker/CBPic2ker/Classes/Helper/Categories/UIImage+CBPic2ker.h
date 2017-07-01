// UIImage+CBPic2ker.h
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

typedef NS_ENUM(NSUInteger, BFAccuracy) {
    kBFAccuracyLow = 0,
    kBFAccuracyHigh,
};

@interface UIImage (CBPic2ker)

/**
 Fix image orientation.

 @param aImage Target image.
 @return Fixed image.
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 Scale image to specified size.
 
 @param image Target image.
 @param size Target size.
 @return Handled image.
 */
+ (UIImage *)scaleImage:(UIImage *)image
                 toSize:(CGSize)size;

/**
 Handle image to suit human face.
 
 @param size Target size.
 @param accurary Image quilty.
 @return Handled image.
 */
- (UIImage *)betterFaceImageForSize:(CGSize)size
                           accuracy:(BFAccuracy)accurary;

@end
