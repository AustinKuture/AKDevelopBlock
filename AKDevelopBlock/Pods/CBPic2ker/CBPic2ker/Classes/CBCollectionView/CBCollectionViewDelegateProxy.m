// CBCollectionViewDelegateProxy.m
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

#import <CBPic2ker/CBCollectionViewDelegateProxy.h>

@interface CBCollectionViewDelegateProxy()

@property (nonatomic, weak, readwrite) id collectionViewDelegate;
@property (nonatomic, weak, readwrite) id scrollViewDelegate;
@property (nonatomic, strong, readwrite) id timelineAdapter;

@end

@implementation CBCollectionViewDelegateProxy

#pragma mark - Init Methods.
- (instancetype)initWithCollectionViewTarget:(id<UICollectionViewDelegate>)collectionViewTarget
                            scrollViewTarget:(id<UIScrollViewDelegate>)scrollViewTarget
                                     adapter:(CBCollectionViewAdapter *)adapter {
    NSCAssert(adapter != nil, @"timelineAdapter can't be nil");
    
    if (adapter == nil) { return nil; }
    
    if (self) {
        _collectionViewDelegate = collectionViewTarget;
        _scrollViewDelegate = scrollViewTarget;
        _timelineAdapter = adapter;
    }
    
    return self;
}

#pragma mark - Methods Forwarding.
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_timelineAdapter respondsToSelector:aSelector]
    || [_collectionViewDelegate respondsToSelector:aSelector]
    || [_scrollViewDelegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (!_timelineAdapter) { return nil; }
    
    return [_timelineAdapter respondsToSelector:aSelector] ? _timelineAdapter : [_collectionViewDelegate respondsToSelector:aSelector] ? _collectionViewDelegate : _scrollViewDelegate;
}

#pragma mark - Unrelated Methods.
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
