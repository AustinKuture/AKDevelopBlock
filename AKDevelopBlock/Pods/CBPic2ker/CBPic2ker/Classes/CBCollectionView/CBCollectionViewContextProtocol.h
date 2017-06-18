// CBCollectionViewContextProtocol.h
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

@class CBCollectionViewSectionController;

@protocol CBCollectionViewContextProtocol <NSObject>

/**
 The size of the collection view. You can use this for sizing cells.
 */
@property (nonatomic, readonly) CGSize containerSize;

/**
 Dequeues a cell from the collection view reuse pool.
 
 @param cellClass The class of the cell you want to dequeue.
 @param sectionController The section controller requesting this information.
 @param index The index of the cell.
 
 @return A cell dequeued from the reuse pool or a newly created one.
 
 @note This method uses a string representation of the cell class as the identifier.
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                         forSectionController:(CBCollectionViewSectionController *)sectionController
                                                      atIndex:(NSInteger)index;

/**
 Dequeues a supplementary view from the collection view reuse pool.
 
 @param elementKind The kind of supplementary view.
 @param viewClass The class of the view.
 @param sectionController The section controller requesting this information.
 @param index The index of the supplementary view.
 
 @return A supplementary view dequeued from the reuse pool or a newly created one.
 */
- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewFromStoryboardOfKind:(NSString *)elementKind
                                                                                  viewClass:(Class)viewClass
                                                                       forSectionController:(CBCollectionViewSectionController *)sectionController
                                                                                    atIndex:(NSInteger)index;

@end
