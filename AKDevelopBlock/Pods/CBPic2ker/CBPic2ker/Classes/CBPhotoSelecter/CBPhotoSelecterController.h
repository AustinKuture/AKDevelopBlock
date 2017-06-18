// CBPhotoSelecterController.h
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
#import <CBPic2ker/CBPhotoSelecterControllerDelegate.h>
#import <CBPic2ker/UINavigationController+CBPic2ker.h>

@class CBPhotoSelecterPhotoLibrary;

@interface CBPhotoSelecterController : UIViewController

/**
 Default no limit, set a specified number.
 */
@property (nonatomic, assign, readwrite) NSInteger maxSlectedImagesCount;

/**
 Default is 4, used in photos collectionView, change the number of colum.
 */
@property (nonatomic, assign, readwrite) NSInteger columnNumber;

/**
 Default self.view.frame.size.height / 2, the height of pre scollView.
 */
@property (nonatomic, assign, readwrite) NSInteger preScrollViewHeight;

/**
 Just a delegate object.
 */
@property (nonatomic, weak, readwrite) id<CBPickerControllerDelegate> pickerDelegate;

/**
 Init method with delegate.
 
 @param delegate Just a delegate object.
 */
- (instancetype)initWithDelegate:(id<CBPickerControllerDelegate>)delegate;

/**
 Init method with maxImagesCount & delegate;
 
 @param maxSelectedImagesCount Default no limit, set a specified number.
 @param delegate Just a delegate object.
 */
- (instancetype)initWithMaxSelectedImagesCount:(NSInteger)maxSelectedImagesCount
                                      delegate:(id<CBPickerControllerDelegate>)delegate;

/**
 Init method with maxImagesCount & delegate & columnNumber.
 
 @param maxSelectedImagesCount Default no limit, set a specified number.
 @param columnNumber Default is 3, Use in photos collectionView, change the number of colum.
 @param delegate Just a delegate object.
 */
- (instancetype)initWithMaxSelectedImagesCount:(NSInteger)maxSelectedImagesCount
                                  columnNumber:(NSInteger)columnNumber
                                      delegate:(id<CBPickerControllerDelegate>)delegate;

@end
