// CBPhotoSelecterPhotoLibrary.h
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

@class CBPhotoSelecterAlbumModel, CBPhotoSelecterAssetModel;

@interface CBPhotoSelecterPhotoLibrary : NSObject

/**
 Default is 3, Use in photos collectionView, change the number of colum.
 */
@property (nonatomic, assign, readwrite) NSInteger columnNumber;

/**
 Default self.view.frame.size.height / 2, the height of pre scollView.
 */
@property (nonatomic, assign, readwrite) NSInteger preScrollViewHeight;

/**
 The radio of size of preView's image.
 */
@property (nonatomic, assign, readwrite) CGFloat preViewImageSizeRadio;

/**
 Space betwwen two items.
 */
@property (nonatomic, assign, readwrite) NSInteger itemSpace;

/**
 Default no limit, set a specified number.
 */
@property (nonatomic, assign, readwrite) NSInteger maxSlectedImagesCount;

/**
 Selected assets arr;
 */
@property (nonatomic, strong, readwrite) NSMutableArray<CBPhotoSelecterAssetModel *> *selectedAssetArr;

/**
 Selected assets identifiers arr.
 */
@property (nonatomic, strong, readwrite) NSMutableArray<NSString *> *selectedAssetIdentifierArr;

/**
 Used to judge if the library was inseting asset.
 */
@property (nonatomic, assign, readwrite) BOOL isInsetAsset;

/**
 Shared instance.
 */
+ (instancetype)sharedPhotoLibrary;

/**
 Wipe all shared data.
 */
+ (void)wipeSharedData;

/**
 Judge if grant the photo permission.
 
 @return YES if permission is granted.
 */
- (BOOL)authorizationStatusAuthorized;

/**
 Add selected asset with model.
 
 @param assetMdoel CBPhotoSelecterAssetModel model
 */
- (void)addSelectedAssetWithModel:(CBPhotoSelecterAssetModel *)assetMdoel;

/**
 Remove selected asset with identifier string.
 
 @param identifier Identifier string
 */
- (void)removeSelectedAssetWithIdentifier:(NSString *)identifier;

/**
 Get cameraRoll album.

 @param completion Completion block.
 */
- (void)getCameraRollAlbumWithCompletion:(void (^)(CBPhotoSelecterAlbumModel *model))completion;

/**
 Get all albums.

 @param completion Completion block.
 */
- (void)getAllAlbumsWithCompletion:(void (^)(NSArray<CBPhotoSelecterAlbumModel *> *models))completion;

/**
 Get asset with result.

 @param result PHFetchResult result.
 @param completion Completion block.
 */
- (void)getAssetsFromFetchResult:(id)result
                      completion:(void (^)(NSArray<CBPhotoSelecterAssetModel *> *models))completion;

/**
 Get post image with model.

 @param model CBPhotoSelecterAlbumModel model.
 @param completion Completion block.
 */
- (void)getPostImageWithAlbumModel:(CBPhotoSelecterAlbumModel *)model
                        completion:(void (^)(UIImage *image))completion;

/**
 Get photo with asset.

 @param asset Asset data.
 @param photoWidth Photo width.
 @param completion Completion block.
 @param progressHandler Progress block.
 @return Image request id.
 */
- (PHImageRequestID)getPhotoWithAsset:(id)asset
                           photoWidth:(CGFloat)photoWidth
                           completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion
                      progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;

/**
 Get GIF photo with asset.
 
 @param asset Asset data.
 @param completion Completion block.
 @param progressHandler Progress block.
 @return Image request id.
 */
- (PHImageRequestID)getGIFPhotoWithAsset:(id)asset
                              completion:(void (^)(NSData *data, NSDictionary *info, BOOL isDegraded))completion
                         progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;

/**
 Get full size photo.
 
 @param asset Asset data.
 @param completion Completion block.
 @param progressHandler Progress block.
 @return Image request id.
 */
- (PHImageRequestID)getFullSizePhotoWithAsset:(id)asset
                                   completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion
                              progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;

/**
 Get full size live photo.
 
 @param asset Asset data.
 @param completion Completion block.
 @param progressHandler Progress block.
 @return Image request id.
 */
- (PHImageRequestID)getFullSizeLivePhotoForAsset:(PHAsset *)asset
                                      completion:(void (^)(PHLivePhoto *, NSDictionary *))completion
                                 progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler;

/**
 Get live photo.
 
 @param asset Asset data.
 @param photoWidth Photo width.
 @param completion Completion block.
 @param progressHandler Progress block.
 @return Image request id.
 */
- (PHImageRequestID)getLivePhotoForAsset:(PHAsset *)asset
                              photoWidth:(CGFloat)photoWidth
                              completion:(void (^)(PHLivePhoto *livePhoto, NSDictionary *info))completion
                         progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;

@end
