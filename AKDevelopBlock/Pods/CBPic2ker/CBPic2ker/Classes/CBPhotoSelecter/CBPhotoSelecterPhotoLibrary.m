// CBPhotoSelecterPhotoLibrary.m
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

#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>
#import <CBPic2ker/CBPhotoSelecterAlbumModel.h>
#import <CBPic2ker/CBPhotoSelecterAssetModel.h>
#import <CBPic2ker/UIImage+CBPic2ker.h>
#import <CBPic2ker/UIImage+CBPic2ker.h>

static NSString * const kCBPhotoSelecterPhotoLibraryImageRequestID = @"kCBPhotoSelecterPhotoLibraryImageRequestID";
static NSString * const kCBPhotoSelecterPhotoLibraryImage = @"kCBPhotoSelecterPhotoLibraryImage";
static NSString * const kCBPhotoSelecterPhotoLibraryAssetIdentifier = @"kCBPhotoSelecterPhotoLibraryAssetIdentifier";

@interface CBPhotoSelecterPhotoLibrary()

@property (nonatomic, assign, readwrite) CGSize gridThumbnailSize;
@property (nonatomic, strong, readwrite) NSMutableDictionary *imageRequestingDictionaray;

@end

@implementation CBPhotoSelecterPhotoLibrary

#pragma mark - Public Methods.
+ (instancetype)sharedPhotoLibrary {
    static CBPhotoSelecterPhotoLibrary *photoLibrary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photoLibrary = [[CBPhotoSelecterPhotoLibrary alloc] init];
        photoLibrary.columnNumber = 3;
    });
    return photoLibrary;
}

- (NSMutableDictionary *)fullSizeImageRequestingDictionaray{
    if (!_imageRequestingDictionaray) {
        _imageRequestingDictionaray = [[NSMutableDictionary alloc] init];
    }
    return _imageRequestingDictionaray;
}

+ (void)wipeSharedData {
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary].selectedAssetArr removeAllObjects];
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary].selectedAssetIdentifierArr removeAllObjects];
}

- (void)removeSelectedAssetWithIdentifier:(NSString *)identifier {
    if (!identifier.length) { return; }
    
    if ([self.selectedAssetIdentifierArr containsObject:identifier]) {
        NSInteger index = [self.selectedAssetIdentifierArr indexOfObject:identifier];
        [self.selectedAssetIdentifierArr removeObject:identifier];
        [self.selectedAssetArr removeObjectAtIndex:index];
        
        _isInsetAsset = NO;
    }
}

- (void)addSelectedAssetWithModel:(CBPhotoSelecterAssetModel *)assetMdoel {
    if (!assetMdoel) { return; }
    
    if (![self.selectedAssetIdentifierArr containsObject:[assetMdoel.asset localIdentifier]]) {
        [self.selectedAssetIdentifierArr addObject:[assetMdoel.asset localIdentifier]];
        [self.selectedAssetArr addObject:assetMdoel];
        
        _isInsetAsset = YES;
    }
}

- (BOOL)authorizationStatusAuthorized {
    NSInteger status = [PHPhotoLibrary authorizationStatus];
    
    if (status == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                // ...
            }];
        });
    }
    
    return status == 3;
}

- (void)getCameraRollAlbumWithCompletion:(void (^)(CBPhotoSelecterAlbumModel *))completion {
    __block CBPhotoSelecterAlbumModel *model;
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"
                                                             ascending:NO]];
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
        
        if ([self isCameraRollAlbum:collection.localizedTitle]) {
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            model = [CBPhotoSelecterAlbumModel modelWithResult:fetchResult
                                                    name:collection.localizedTitle];
            if (completion) completion(model);
            break;
        }
    }
}

- (void)getAllAlbumsWithCompletion:(void (^)(NSArray<CBPhotoSelecterAlbumModel *> *))completion {
    NSMutableArray *albumArr = [NSMutableArray array];

    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"
                                                             ascending:NO]];
    PHFetchResult *myPhotoStreamAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil];
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
    PHFetchResult *sharedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumCloudShared options:nil];
    NSArray *allAlbums = @[myPhotoStreamAlbum,smartAlbums,topLevelUserCollections,syncedAlbums,sharedAlbums];
    for (PHFetchResult *fetchResult in allAlbums) {
        for (PHAssetCollection *collection in fetchResult) {
            if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            if (fetchResult.count < 1) continue;
            if ([collection.localizedTitle containsString:@"Deleted"] || [collection.localizedTitle isEqualToString:@"最近删除"]) continue;
            if ([self isCameraRollAlbum:collection.localizedTitle]) {
                [albumArr insertObject:[CBPhotoSelecterAlbumModel modelWithResult:fetchResult
                                                                       name:collection.localizedTitle] atIndex:0];
            } else {
                [albumArr addObject:[CBPhotoSelecterAlbumModel modelWithResult:fetchResult
                                                                    name:collection.localizedTitle]];
            }
        }
    }
    if (completion && albumArr.count > 0) completion(albumArr);
}

- (void)getAssetsFromFetchResult:(id)result
                      completion:(void (^)(NSArray<CBPhotoSelecterAssetModel *> *))completion {
    if (!result) { return; }

    NSMutableArray *photoArr = [NSMutableArray array];
    
    if (![result isKindOfClass:[PHFetchResult class]]) { return; }
    
    PHFetchResult *fetchResult = (PHFetchResult *)result;
    [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CBPhotoSelecterAssetModel *model = [self assetModelWithAsset:obj];
        if ([[[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] selectedAssetIdentifierArr] containsObject:[(PHAsset *)obj localIdentifier]]) {
            model.isSelected = YES;
        }
        if (model) {
            [photoArr addObject:model];
        }
    }];
    if (completion) completion(photoArr);
}

- (CBPhotoSelecterAssetModel *)assetModelWithAsset:(id)asset {
    if (!asset || ![asset isKindOfClass:[PHAsset class]]) { return nil; }

    CBPhotoSelecterAssetModel *model;
    CBPhotoSelecterAssetModelMediaType type = CBPhotoSelecterAssetModelMediaTypePhoto;
    
    PHAsset *phAsset = (PHAsset *)asset;
    if (phAsset.mediaType == PHAssetMediaTypeVideo)      type = CBPhotoSelecterAssetModelMediaTypeVideo;
    else if (phAsset.mediaType == PHAssetMediaTypeAudio) type = CBPhotoSelecterAssetModelMediaTypeAudio;
    else if (phAsset.mediaType == PHAssetMediaTypeImage) {
        if ([[phAsset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
            type = CBPhotoSelecterAssetModelMediaTypeGif;
        }
    }
    
    if (phAsset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        type = CBPhotoSelecterAssetModelMediaTypeLivePhoto;
    }
    
    NSString *timeLength;
    switch (type) {
        case CBPhotoSelecterAssetModelMediaTypeVideo:
        case CBPhotoSelecterAssetModelMediaTypeGif:
        case CBPhotoSelecterAssetModelMediaTypeLivePhoto:
            timeLength = [NSString stringWithFormat:@"%0.0f",phAsset.duration];
            break;
        default:
            timeLength = @"";
            break;
    }
    timeLength = [self getNewTimeFromDurationSecond:timeLength.integerValue];
    model = [CBPhotoSelecterAssetModel modelWithAsset:asset
                                           type:type
                                     timeLength:timeLength];
    return model;
}

- (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}

- (void)getPostImageWithAlbumModel:(CBPhotoSelecterAlbumModel *)model
                        completion:(void (^)(UIImage *))completion {
    if (!model) { return; }
    
    id asset = [model.result firstObject];
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getPhotoWithAsset:asset
                                                       photoWidth:80
                                                       completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                                                           if (completion) completion(photo);
                                                       } progressHandler:nil];
}

- (PHImageRequestID)getFullSizeLivePhotoForAsset:(PHAsset *)asset
                                      completion:(void (^)(PHLivePhoto *, NSDictionary *))completion
                                 progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler {
    return [self getLivePhotoForAsset:asset
                           photoWidth:CGFLOAT_MAX
                           completion:completion
                      progressHandler:progressHandler];
}

- (PHImageRequestID)getLivePhotoForAsset:(PHAsset *)asset
                              photoWidth:(CGFloat)photoWidth
                              completion:(void (^)(PHLivePhoto *, NSDictionary *))completion
                         progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler {
    if (!asset || ![asset isKindOfClass:[PHAsset class]]) { return 0; }
    
    CGSize imageSize;

    PHAsset *phAsset = (PHAsset *)asset;
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    CGFloat pixelWidth = photoWidth * 2;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    imageSize = CGSizeMake(pixelWidth, pixelHeight);
    
    if (photoWidth == CGFLOAT_MAX) {
        imageSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 2, [[UIScreen mainScreen] bounds].size.height * 2);
    }
    
    PHLivePhotoRequestOptions *option = [[PHLivePhotoRequestOptions alloc] init];
    option.version = PHImageRequestOptionsVersionCurrent;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    option.networkAccessAllowed = YES;
    option.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressHandler) {
                progressHandler(progress, error, stop, info);
            }
        });
    };
    
    return [[PHCachingImageManager defaultManager] requestLivePhotoForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
        BOOL downloadFinined = (![[info objectForKey:PHLivePhotoInfoCancelledKey] boolValue] && ![info objectForKey:PHLivePhotoInfoErrorKey]);
        if (downloadFinined && completion && livePhoto) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(livePhoto,info);
            });
        }
    }];
}

- (PHImageRequestID)getPhotoWithAsset:(id)asset
                           photoWidth:(CGFloat)photoWidth
                           completion:(void (^)(UIImage *, NSDictionary *, BOOL))completion
                      progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler {
    if (!asset || ![asset isKindOfClass:[PHAsset class]]) { return 0; }
    
    CGSize imageSize;
    
    PHAsset *phAsset = (PHAsset *)asset;
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    CGFloat pixelWidth = photoWidth * 2;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    imageSize = CGSizeMake(pixelWidth, pixelHeight);
    
    if (photoWidth == CGFLOAT_MAX) {
        imageSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 2, [[UIScreen mainScreen] bounds].size.height * 2);
    }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    option.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressHandler) {
                progressHandler(progress, error, stop, info);
            }
        });
    };
    
    NSMutableDictionary *requestDic;
    
    PHImageRequestID imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (downloadFinined && result) {
            result = [UIImage fixOrientation:result];
            if (completion) completion(result,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
        }
        
        if (requestDic) {
            [requestDic setObject:result
                           forKey:kCBPhotoSelecterPhotoLibraryImage];
            [self.fullSizeImageRequestingDictionaray setObject:requestDic
                                                        forKey:[(PHAsset *)asset localIdentifier]];
        }
    }];
    
    requestDic = [self.fullSizeImageRequestingDictionaray objectForKey:[(PHAsset *)asset localIdentifier]];
    if (requestDic) {
        if ([requestDic objectForKey:kCBPhotoSelecterPhotoLibraryImage]) {
            completion([requestDic objectForKey:kCBPhotoSelecterPhotoLibraryImage], nil, NO);
            [[PHImageManager defaultManager] cancelImageRequest:imageRequestID];
        }
        
        if (![requestDic objectForKey:kCBPhotoSelecterPhotoLibraryImageRequestID]) {
            [requestDic setObject:@(imageRequestID)
                           forKey:kCBPhotoSelecterPhotoLibraryImageRequestID];
        }
    } else {
        requestDic = [[NSMutableDictionary alloc] init];
        [requestDic setObject:@(imageRequestID)
                       forKey:kCBPhotoSelecterPhotoLibraryImageRequestID];
    }
    
    [self.fullSizeImageRequestingDictionaray setObject:requestDic
                                                forKey:[(PHAsset *)asset localIdentifier]];
    
    return imageRequestID;
}

- (PHImageRequestID)getGIFPhotoWithAsset:(id)asset
                              completion:(void (^)(NSData *, NSDictionary *, BOOL))completion
                         progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler {
    if (!asset || ![asset isKindOfClass:[PHAsset class]]) { return 0; }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
    option.networkAccessAllowed = YES;
    option.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressHandler) {
                progressHandler(progress, error, stop, info);
            }
        });
    };
    
    PHImageRequestID imageRequestID = [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (downloadFinined && imageData) {
            BOOL isDegraded = [[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (completion) completion(imageData, info, isDegraded);
        }
    }];
    
    return imageRequestID;
}

- (PHImageRequestID)getFullSizePhotoWithAsset:(id)asset
                                   completion:(void (^)(UIImage *, NSDictionary *, BOOL))completion
                              progressHandler:(void (^)(double, NSError *, BOOL *, NSDictionary *))progressHandler {
    return [self getPhotoWithAsset:asset
                        photoWidth:CGFLOAT_MAX
                        completion:completion
                   progressHandler:progressHandler];
}

#pragma mark - Internal.
- (BOOL)isCameraRollAlbum:(NSString *)albumName {
    return [albumName isEqualToString:@"Camera Roll"] || [albumName isEqualToString:@"相机胶卷"] || [albumName isEqualToString:@"所有照片"] || [albumName isEqualToString:@"All Photos"];
}

- (void)setPreScrollViewHeight:(NSInteger)preScrollViewHeight {
    _preScrollViewHeight = preScrollViewHeight;
    self.preViewImageSizeRadio = [[UIScreen mainScreen] bounds].size.width * 0.75 / _preScrollViewHeight;
}

- (void)setColumnNumber:(NSInteger)columnNumber {
    _columnNumber = columnNumber;
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - _itemSpace * (columnNumber + 1)) / columnNumber;
    _gridThumbnailSize = CGSizeMake(itemWH * 2, itemWH * 2);
}

- (NSMutableArray<CBPhotoSelecterAssetModel *> *)selectedAssetArr {
    if (!_selectedAssetArr) {
        _selectedAssetArr = [[NSMutableArray alloc] init];
    }
    return _selectedAssetArr;
}

- (NSMutableArray<NSString *> *)selectedAssetIdentifierArr {
    if (!_selectedAssetIdentifierArr) {
        _selectedAssetIdentifierArr = [[NSMutableArray alloc] init];
    }
    return _selectedAssetIdentifierArr;
}

@end
