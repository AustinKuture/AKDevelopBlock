// CBPhotoSelecterAlbumModel.h
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
#import <Photos/Photos.h>

@interface CBPhotoSelecterAlbumModel : NSObject

/**
 The album name.
 */
@property (nonatomic, strong, readwrite) NSString *name;

/**
 The count of photos the album contain.
 */
@property (nonatomic, assign, readwrite) NSInteger count;

/**
 PHFetchResult<PHAsset>.
 */
@property (nonatomic, strong, readwrite) id result;

/**
 Asset data array.
 */
@property (nonatomic, strong, readwrite) NSArray *models;

/**
 Selected asset data array.
 */
@property (nonatomic, strong, readwrite) NSArray *selectedModels;

/**
 Selected asset count.
 */
@property (nonatomic, assign, readwrite) NSUInteger selectedCount;

/**
 Init Methods.

 @param result PHFetchResult.
 @param name Collection localizedTitle.
 @return CBPhotoSelecterAlbumModel instance.
 */
+ (instancetype)modelWithResult:(PHFetchResult *)result
                           name:(NSString *)name;

@end
