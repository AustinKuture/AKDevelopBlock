// CBCollectionViewAdapterDataSource.h
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

NS_ASSUME_NONNULL_BEGIN // igore nullable warn

@class CBCollectionViewAdapter;
@class CBCollectionViewSectionController;

@protocol CBCollectionViewAdapterDataSource <NSObject>

@required

/**
 Asks the data source for the objects to display in the Timeline.
 
 @param adapter The Timeline adapter requesting this information.
 
 @return An array of objects for the Timeline.
 */
- (NSArray *)objectsForAdapter:(CBCollectionViewAdapter *)adapter;

/**
 Asks the data source for a section controller for the specified object in the Timeline.
 
 @param adapter The Timeline adapter requesting this information.
 @param object An object in the list.
 
 @return A new section controller instance that can be displayed in the Timeline.
 */
- (CBCollectionViewSectionController *)adapter:(CBCollectionViewAdapter *)adapter
             sectionControllerForObject:(id)object;

@optional

/**
 Asks the data source for a view to use as the collection view background when the Timeline is empty.
 
 @param adapter The Timeline adapter requesting this information.
 
 @return A view to use as the collection view background, or `nil` if you don't want a background view.
 */
- (nullable UIView *)emptyViewForAdapter:(CBCollectionViewAdapter *)adapter;

NS_ASSUME_NONNULL_END

@end
