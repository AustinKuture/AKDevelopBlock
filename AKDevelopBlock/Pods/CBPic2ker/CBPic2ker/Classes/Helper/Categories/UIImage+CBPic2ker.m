// UIImage+CBPic2ker.m
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

#import <CBPic2ker/UIImage+CBPic2ker.h>
#include <ImageIO/ImageIO.h>

#define GOLDEN_RATIO (0.618)

@implementation UIImage (fixOrientation)

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    if (!aImage) { return nil; }
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)betterFaceImageForSize:(CGSize)size
                           accuracy:(BFAccuracy)accurary {
    NSArray *features = [UIImage _faceFeaturesInImage:self accuracy:accurary];
    if ([features count] == 0) {
        return nil;
    } else {
        return [self _subImageForFaceFeatures:features
                                         size:size];
    }
}

- (UIImage *)_subImageForFaceFeatures:(NSArray *)faceFeatures size:(CGSize)size {
    CGRect fixedRect = CGRectMake(MAXFLOAT, MAXFLOAT, 0, 0);
    CGFloat rightBorder = 0, bottomBorder = 0;
    CGSize imageSize = self.size;
    
    for (CIFaceFeature * faceFeature in faceFeatures){
        CGRect oneRect = faceFeature.bounds;
        // Mirror the frame of the feature
        oneRect.origin.y = imageSize.height - oneRect.origin.y - oneRect.size.height;
        
        // Always get the minimum x & y
        fixedRect.origin.x = MIN(oneRect.origin.x, fixedRect.origin.x);
        fixedRect.origin.y = MIN(oneRect.origin.y, fixedRect.origin.y);
        
        // Calculate the faces rectangle
        rightBorder = MAX(oneRect.origin.x + oneRect.size.width, rightBorder);
        bottomBorder = MAX(oneRect.origin.y + oneRect.size.height, bottomBorder);
    }
    
    // Calculate the size of rectangle of faces
    fixedRect.size.width = rightBorder - fixedRect.origin.x;
    fixedRect.size.height = bottomBorder - fixedRect.origin.y;
    
    CGPoint fixedCenter = CGPointMake(fixedRect.origin.x + fixedRect.size.width / 2.0,
                                      fixedRect.origin.y + fixedRect.size.height / 2.0);
    CGPoint offset = CGPointZero;
    CGSize finalSize = imageSize;
    if (imageSize.width / imageSize.height > size.width / size.height) {
        //move horizonal
        finalSize.height = size.height;
        finalSize.width = imageSize.width/imageSize.height * finalSize.height;
        
        // Scale the fixed center with image scale(scale image to adjust image view)
        fixedCenter.x = finalSize.width/imageSize.width * fixedCenter.x;
        fixedCenter.y = finalSize.width/imageSize.width * fixedCenter.y;
        
        offset.x = fixedCenter.x - size.width * 0.5;
        if (offset.x < 0) {
            // Move outside left
            offset.x = 0;
        } else if (offset.x + size.width > finalSize.width) {
            // Move outside right
            offset.x = finalSize.width - size.width;
        }
        
        // If you want the final image is fit to the image view, you should set the width adjust the image view.
        finalSize.width = size.width;
    } else {
        //move vertical
        finalSize.width = size.width;
        finalSize.height = imageSize.height/imageSize.width * finalSize.width;
        
        // Scale the fixed center with image scale(scale image to adjust image view)
        fixedCenter.x = finalSize.width/imageSize.width * fixedCenter.x;
        fixedCenter.y = finalSize.width/imageSize.width * fixedCenter.y;
        
        offset.y = fixedCenter.y - size.height * (1 - GOLDEN_RATIO);
        if (offset.y < 0) {
            // Move outside top
            offset.y = 0;
        } else if (offset.y + size.height > finalSize.height){
            // Move outside bottom
            // offset.y = finalSize.height = size.height;
            offset.y = finalSize.height - size.height;
        }
        
        // If you want the final image is fit to the image view, you should set the height adjust the image view.
        finalSize.height = size.height;
    }
    
    // The finalSize is just fit the image view now, so we should scale the frame to the image size.
    CGFloat scale = imageSize.width/finalSize.width;
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    // Get the final image rect
    CGRect finalRect = CGRectApplyAffineTransform(CGRectMake(offset.x, offset.y, finalSize.width, finalSize.height),transform);
    // Creat image
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], finalRect);
    UIImage *subImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return subImage;
}

+ (NSArray *)_faceFeaturesInImage:(UIImage *)image accuracy:(BFAccuracy)accurary {
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    NSString *accuraryStr = (accurary == kBFAccuracyLow) ? CIDetectorAccuracyLow : CIDetectorAccuracyHigh;
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:@{CIDetectorAccuracy: accuraryStr}];
    
    return [detector featuresInImage:ciImage];
}


@end
