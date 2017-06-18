// CBCollectionViewScrollDelegate.h
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

#import <Foundation/Foundation.h>

@class CBCollectionViewAdapter;
@class CBCollectionViewSectionController;

@protocol CBCollectionViewScrollDelegate <NSObject>

/**
 Tells the delegate that the section controller was scrolled on screen.
 
 @param adapter The list adapter whose collection view was scrolled.
 @param sectionController The visible section controller that was scrolled.
 */
- (void)adapter:(CBCollectionViewAdapter *)adapter didScrollSectionController:(CBCollectionViewSectionController *)sectionController;

/**
 Tells the delegate that the section controller will be dragged on screen.
 
 @param adapter The list adapter whose collection view will drag.
 @param sectionController The visible section controller that will drag.
 */
- (void)adapter:(CBCollectionViewAdapter *)adapter willBeginDraggingSectionController:(CBCollectionViewSectionController *)sectionController;

/**
 Tells the delegate that the section controller did end dragging on screen.
 
 @param adapter The list adapter whose collection view ended dragging.
 @param sectionController The visible section controller that ended dragging.
 */
- (void)adapter:(CBCollectionViewAdapter *)adapter didEndDraggingSectionController:(CBCollectionViewSectionController *)sectionController willDecelerate:(BOOL)decelerate;


@end
