// CBCollectionViewSectionController.h
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
#import <CBPic2ker/CBCollectionViewScrollDelegate.h>
#import <CBPic2ker/CBCollectionViewContextProtocol.h>

@interface CBCollectionViewSectionController : NSObject

/**
 Section index of current sectionController.
 */
@property (nonatomic, assign, readwrite) NSInteger section;

/**
 Taeget viewController.
 */
@property (nonatomic, weak, readwrite) UIViewController *viewController;

/**
 The margins used to lay out content in the section controller.
 
 @see `-[UICollectionViewFlowLayout sectionInset]`.
 */
@property (nonatomic, assign) UIEdgeInsets inset;

/**
 The minimum spacing to use between rows of items.
 
 @see `-[UICollectionViewFlowLayout minimumLineSpacing]`.
 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/**
 The minimum spacing to use between items in the same row.
 
 @see `-[UICollectionViewFlowLayout minimumInteritemSpacing]`.
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**
 A context object for interacting with the collection.
 
 Use this property for accessing the collection size, dequeing cells, reloading, inserting, deleting, etc.
 */
@property (nonatomic, weak, readwrite) id <CBCollectionViewContextProtocol> collectionContext;

/**
 Returns the number of items in the section.
 
 @return A count of items in the list.
 
 @note The count returned is used to drive the number of cells displayed for this section controller. The default
 implementation returns 1. **Calling super is not required.**
 */
- (NSInteger)numberOfItems;

/**
 Returns the size of a cell at the specified index path.
 
 @param index The index of the cell.
 
 @return The size of the cell.
 */
- (CGSize)sizeForItemAtIndex:(NSInteger)index;

/**
 Return a dequeued cell for a given index.
 
 @param index The index of the requested row.
 
 @return A configured `UICollectionViewCell` subclass.
 */
- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index;

/**
 Asks the SupplementaryViewSource for a configured supplementary view for the specified kind and index.
 
 @param elementKind The kind of supplementary view being requested
 @param index The index for the supplementary veiw being requested.
 
 @note This is your opportunity to do any supplementary view setup and configuration.
 */
- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                        atIndex:(NSInteger)index;

/**
 Asks the SupplementaryViewSource for the size of a supplementary view for the given kind and index path.
 
 @param elementKind The kind of supplementary view.
 @param index The index of the requested view.
 
 @return The size for the supplementary view.
 */
- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                 atIndex:(NSInteger)index;

/**
 Updates the section controller to a new object.
 
 @param object The object mapped to this section controller.
 */
- (void)didUpdateToObject:(id)object;

/**
 Tells the section controller that the cell at the specified index path was selected.
 
 @param index The index of the selected cell.
 */
- (void)didSelectItemAtIndex:(NSInteger)index;

/**
 An object that handles scroll events for the section controller. Can be `nil`.
 
 @return An object that conforms to `CBCollectionViewScrollDelegate` or `nil`.
 */
@property (nonatomic, weak, readwrite) id <CBCollectionViewScrollDelegate> scrollDelegate;

@end
