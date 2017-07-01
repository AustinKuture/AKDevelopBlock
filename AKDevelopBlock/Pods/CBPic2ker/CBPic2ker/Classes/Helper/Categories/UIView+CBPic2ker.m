// UIView+CBPic2ker.m
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

#import "UIView+CBPic2ker.h"

@implementation UIView (CBPic2ker)

#pragma Getter
- (CGFloat)originLeft {
    return self.frame.origin.x;
}

- (CGFloat)originUp {
    return self.frame.origin.y;
}

- (CGFloat)originRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)originDown {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)sizeWidth {
    return self.frame.size.width;
}

- (CGFloat)sizeHeight {
    return self.frame.size.height;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

#pragma Setter
- (void)setOriginLeft:(CGFloat)originLeft {
    if (!isnan(originLeft)) {
        self.frame = CGRectMake(originLeft, self.originUp, self.sizeWidth, self.sizeHeight);
    }
}

- (void)setOriginUp:(CGFloat)originUp {
    if (!isnan(originUp)) {
        self.frame = CGRectMake(self.originLeft, originUp, self.sizeWidth, self.sizeHeight);
    }
}

- (void)setOriginRight:(CGFloat)originRight {
    if (!isnan(originRight)) {
        self.frame = CGRectMake(originRight - self.sizeWidth, self.originUp, self.sizeWidth, self.sizeHeight);
    }
}

- (void)setOriginDown:(CGFloat)originDown {
    if (!isnan(originDown)) {
        self.frame = CGRectMake(self.originLeft, originDown - self.sizeHeight, self.sizeWidth, self.sizeHeight);
    }
}

- (void)setSizeWidth:(CGFloat)sizeWidth {
    if (!isnan(sizeWidth)) {
        self.frame = CGRectMake(self.originLeft, self.originUp, sizeWidth, self.sizeHeight);
    }
}

- (void)setSizeHeight:(CGFloat)sizeHeight {
    if (!isnan(sizeHeight)) {
        self.frame = CGRectMake(self.originLeft, self.originUp, self.sizeWidth, sizeHeight);
    }
}

- (void)setSize:(CGSize)size {
    if (!isnan(size.height)) {
        self.frame = CGRectMake(self.originLeft, self.originUp, size.width, size.height);
    }
}

- (void)setOrigin:(CGPoint)origin {
    if (!isnan(origin.x)) {
        self.frame = CGRectMake(origin.x, origin.y, self.sizeWidth, self.sizeHeight);
    }
}

- (void)setCenterX:(CGFloat)centerX {
    if (!isnan(centerX)) {
        self.center = CGPointMake(centerX, self.center.y);
    }
}

- (void)setCenterY:(CGFloat)centerY {
    if (!isnan(centerY)) {
        self.center = CGPointMake(self.center.x, centerY);
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
