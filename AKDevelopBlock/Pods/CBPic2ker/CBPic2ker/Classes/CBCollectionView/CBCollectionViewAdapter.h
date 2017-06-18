// CBCollectionViewAdapter.h
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
#import <Foundation/Foundation.h>
#import <CBPic2ker/CBCollectionViewAdapterDataSource.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A block to execute when the CBPic2ker updates are completed.
 
 @param finished Specifies whether or not the update animations completed successfully.
 */
typedef void (^CBPic2kerUpdaterCompletion)(BOOL finished);

@class CBCollectionViewAdapterHelper;

@interface CBCollectionViewAdapter : NSObject

/**
 The view controller that houses the adapter.
 */
@property (nonatomic, weak, readwrite) UIViewController *viewController;

/**
 The collectionView view used with the adapter.
 */
@property (nonatomic, weak, readwrite) UICollectionView *collectionView;

/**
 The object that acts as the data source for the adapter.
 */
@property (nonatomic, weak, readwrite) id <CBCollectionViewAdapterDataSource> dataSource;

/**
 The object that receives top-level events for section controllers.
 */
@property (nonatomic, weak, readwrite) id delegate;

/**
 The data handler class, used to handle all data.
 */
@property (nonatomic, strong, readwrite) CBCollectionViewAdapterHelper *adapterHelper;

/**
 The object that receives `UICollectionViewDelegate` events.
 
 @note This object *will not* receive `UIScrollViewDelegate` events. Instead use scrollViewDelegate.
 */
@property (nonatomic, weak, readwrite) id <UICollectionViewDelegate> collectionViewDelegate;

/**
 The object that receives `UIScrollViewDelegate` events.
 */
@property (nonatomic, weak, readwrite) id <UIScrollViewDelegate> scrollViewDelegate;

/**
 Initializes a new `CBCollectionViewAdapter` object.
 
 @param viewController The view controller that will house the adapter.
 
 @return A new list adapter object.
 */
- (instancetype)initWithViewController:(nullable UIViewController *)viewController;

///**
// Perform an update from the previous state of the data source.
// 
// @param animated A flag indicating if the transition should be animated.
// @param completion The block to execute when the updates complete.
// */
//- (void)performUpdatesAnimated:(BOOL)animated
//                    completion:(nullable CBPic2kerUpdaterCompletion)completion;

/**
 Perform an immediate reload of the data in the data source, discarding the old objects.
 
 @param completion The block to execute when the reload completes.
 */
- (void)reloadDataWithCompletion:(nullable CBPic2kerUpdaterCompletion)completion;

/**
 Update adapater data.

 @param objects New data.
 @param dataSource DataSource.
 */
- (void)updateObjects:(NSArray *)objects
           dataSource:(id<CBCollectionViewAdapterDataSource>)dataSource;

NS_ASSUME_NONNULL_END

@end
