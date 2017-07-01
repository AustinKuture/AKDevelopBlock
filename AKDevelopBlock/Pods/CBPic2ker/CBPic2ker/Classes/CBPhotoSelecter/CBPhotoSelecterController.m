// CBPhotoSelecterController.m
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

#import <CBPic2ker/CBPhotoSelecterController.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>
#import <CBPic2ker/UIColor+CBPic2ker.h>
#import <CBPic2ker/CBPhotoSelecterPermissionView.h>
#import <CBPic2ker/CBPhotoSelecterAlbumView.h>
#import <CBPic2ker/CBPhotoSelecterAlbumModel.h>
#import <CBPic2ker/CBCollectionView.h>
#import <CBPic2ker/UIView+CBPic2ker.h>
#import <CBPic2ker/CBPhotoSelecterAssetModel.h>
#import <CBPic2ker/CBCollectionViewAdapter+collectionViewDelegate.h>
#import <CBPic2ker/CBPhotoSelecterPreCollectionSectionView.h>
#import <CBPic2ker/CBPhotoSelecterAlbumButtonSectionView.h>
#import <CBPic2ker/CBPhotoSelecterAssetSectionViewCell.h>
#import <CBPic2ker/CBPhotoSelecterAssetCollectionSectionView.h>

@interface CBPhotoSelecterController () <CBCollectionViewAdapterDataSource>

@property (nonatomic, strong, readwrite) CBPhotoSelecterPermissionView *permissionView;
@property (nonatomic, strong, readwrite) CBCollectionView *collectionView;
@property (nonatomic, strong, readwrite) CBPhotoSelecterAlbumView *albumView;
@property (nonatomic, strong, readwrite) CBPhotoSelecterAssetCollectionSectionView *collectionSectionView;
@property (nonatomic, strong, readwrite) CBPhotoSelecterAlbumButtonSectionView *albumButtonSectionView;
@property (nonatomic, strong, readwrite) CBPhotoSelecterPreCollectionSectionView *preCollectionSectionView;
@property (nonatomic, strong, readwrite) UILabel *titleLableView;

@property (nonatomic, strong, readwrite) NSMutableArray *albumDataArr;
@property (nonatomic, strong, readwrite) CBPhotoSelecterAlbumModel *currentAlbumModel;
@property (nonatomic, strong, readwrite) NSMutableArray<CBPhotoSelecterAssetModel *> *currentAlbumAssetsModelsArray;

@property (nonatomic, strong, readwrite) CBPhotoSelecterPhotoLibrary *photoLibrary;
@property (nonatomic, strong, readwrite) CBCollectionViewAdapter *adapter;

@property (nonatomic, strong, readwrite) NSTimer *timer;

@property (nonatomic, assign, readwrite) UIStatusBarStyle originBarStyle;

@end

@implementation CBPhotoSelecterController {
    BOOL _alreadyShowPreView;
}

@synthesize currentAlbumModel = _currentAlbumModel;

#pragma mark - Life cycle.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigation];
    [self setViewsUp];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:_originBarStyle
                                                animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.originBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault
                                                animated:NO];
    
    if (![self.photoLibrary authorizationStatusAuthorized]) {
        [self.view addSubview:self.permissionView];
        [self.titleLableView setText:@"NO PERMISSION"];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                  target:self
                                                selector:@selector(observeAuthrizationStatusChange)
                                                userInfo:nil
                                                 repeats:YES];
        } else {
            [self fetchDataWhenEntering];
    }
}

#pragma mark -Internal
- (void)observeAuthrizationStatusChange {
    if ([[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] authorizationStatusAuthorized]) {
        [self fetchDataWhenEntering];
        
        [self.permissionView removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)fetchDataWhenEntering {
    [self.titleLableView setText:@"Fetching ..."];
    
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getCameraRollAlbumWithCompletion:^(CBPhotoSelecterAlbumModel *model) {
        self.currentAlbumModel = model;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !self.albumButtonSectionView.albumButton ?: [self.albumButtonSectionView.albumButton setTitle:_currentAlbumModel.name forState:UIControlStateNormal];
        });
        
        [self.titleLableView setText:@"Select Photos"];
    }];
    
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getAllAlbumsWithCompletion:^(NSArray<CBPhotoSelecterAlbumModel *> *models) {
        self.albumDataArr = [models mutableCopy];
        
        [self.view addSubview:self.albumView];
        [self.titleLableView setText:@"Select Photos"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpNavigation {
    [self setupNavigationBartitleLableView];
    
    NSMutableDictionary *itemStyleDic = [[NSMutableDictionary alloc] init];
    itemStyleDic[NSFontAttributeName] = [UIFont fontWithName:@"Euphemia-UCAS" size:15];
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                      target:self
                                                                                      action:@selector(backAction:)];
    UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Use"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(useAction:)];
    [userButtonItem setTitleTextAttributes:itemStyleDic forState:UIControlStateNormal];
    [cancelButtonItem setTitleTextAttributes:itemStyleDic forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    self.navigationItem.rightBarButtonItem = userButtonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (void)setViewsUp {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.collectionView];
    [self.adapter setDataSource:self];
}

- (void)backAction:(id)sender {
    if ([self.pickerDelegate respondsToSelector:@selector(photoSelecterDidCancelWithController:)]) {
        [self.pickerDelegate photoSelecterDidCancelWithController:self];
    }
    
    [CBPhotoSelecterPhotoLibrary wipeSharedData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)useAction:(id)sender {
    if ([self.pickerDelegate respondsToSelector:@selector(photoSelecterController:sourceAsset:)]) {
        NSMutableArray *assetArr = [[NSMutableArray alloc] init];
        [self.photoLibrary.selectedAssetArr enumerateObjectsUsingBlock:^(CBPhotoSelecterAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [assetArr addObject:obj.asset];
        }];
        
        [self.pickerDelegate photoSelecterController:self
                                         sourceAsset:assetArr.copy];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [CBPhotoSelecterPhotoLibrary wipeSharedData];
}

- (void)reachPhotoNumberLimitWithCell:(CBPhotoSelecterAssetSectionViewCell *)cell {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reach Photo Number Limit" message:[NSString stringWithFormat:@"You can only select %ld photos.",(long) self.photoLibrary.maxSlectedImagesCount] delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
    [alert show];
    cell.selectedStatus = NO;
}

- (void)setCurrentAlbumModel:(CBPhotoSelecterAlbumModel *)currentAlbumModel {
    _currentAlbumModel = currentAlbumModel;
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getAssetsFromFetchResult:currentAlbumModel.result
                                                              completion:^(NSArray<CBPhotoSelecterAssetModel *> *models) {
                                                                  _currentAlbumAssetsModelsArray = [models mutableCopy];
                                                                  
                                                                  [self.adapter reloadDataWithCompletion:nil];
                                                              }];
}

- (void)setupNavigationBartitleLableView {
    self.titleLableView = [[UILabel alloc] init];
    [self.titleLableView setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:18]];
    [self.titleLableView setTextAlignment:NSTextAlignmentCenter];
    [self.titleLableView setTextColor:[UIColor lightGrayColor]];
    [self.titleLableView setText:@"Fetching ..."];
    
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleLableView.sizeWidth, self.titleLableView.sizeHeight)];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleLableView.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.navigationController.navigationBar.sizeWidth, self.navigationController.navigationBar.sizeHeight);
        weakSelf.titleLableView.frame = [weakSelf.view.window convertRect:weakSelf.titleLableView.frame toView:weakSelf.navigationItem.titleView];
        [weakSelf.navigationItem.titleView addSubview:weakSelf.titleLableView];
    });
}

- (CBPhotoSelecterPermissionView *)permissionView {
    if (!_permissionView) {
        _permissionView = [[CBPhotoSelecterPermissionView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.sizeHeight + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.sizeWidth, self.view.sizeHeight - self.navigationController.navigationBar.sizeHeight - [[UIApplication sharedApplication] statusBarFrame].size.height) grantButtonAction:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
    }
    return _permissionView;
}

- (CBPhotoSelecterAlbumView *)albumView {
    if (!_albumView) {
        _albumView = [[CBPhotoSelecterAlbumView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.sizeHeight - self.collectionView.originUp) albumArray:_albumDataArr didSelectedAlbumBlock:^(CBPhotoSelecterAlbumModel *model) {
            self.currentAlbumModel = model;
            
            !self.albumButtonSectionView.albumButton ?: [self.albumButtonSectionView.albumButton setTitle:model.name forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.albumView.frame = CGRectMake(self.albumView.originLeft, self.view.originDown, self.albumView.sizeWidth, self.albumView.sizeHeight);
                             }];
        }];
    }
    return _albumView;
}

- (CBPhotoSelecterAssetCollectionSectionView *)collectionSectionView {
    if (!_collectionSectionView) {
        _collectionSectionView = [[CBPhotoSelecterAssetCollectionSectionView alloc] initWithColumnNumber:_columnNumber preViewHeight:_preScrollViewHeight];
        
        __weak typeof(self) weakSelf = self;
        self.collectionSectionView.assetButtonTouchActionBlockInternal = ^(CBPhotoSelecterAssetModel *model, CBPhotoSelecterAssetSectionViewCell *cell, NSInteger index) {
            __strong __typeof(self) strongSelf = weakSelf;
            
            if (strongSelf.photoLibrary.maxSlectedImagesCount && strongSelf.photoLibrary.maxSlectedImagesCount <= strongSelf.photoLibrary.selectedAssetArr.count && ![strongSelf.photoLibrary.selectedAssetIdentifierArr containsObject:[(PHAsset *)model.asset localIdentifier]]) {
                [strongSelf reachPhotoNumberLimitWithCell:cell];
            } else {
                if ([strongSelf.photoLibrary.selectedAssetIdentifierArr containsObject:[(PHAsset *)model.asset localIdentifier]]) {
                    [strongSelf.photoLibrary removeSelectedAssetWithIdentifier:[(PHAsset *)model.asset localIdentifier]];
                } else {
                    [strongSelf.photoLibrary addSelectedAssetWithModel:model];
                    if(strongSelf -> _alreadyShowPreView) {
                        [UIView animateWithDuration:0.15
                                         animations:^{
                                             [strongSelf.collectionSectionView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
                                         } completion:nil];
                    }
                }
                
                strongSelf.titleLableView.text = strongSelf.photoLibrary.selectedAssetArr.count ? [NSString stringWithFormat:@"%lu Photos Selected", (unsigned long)strongSelf.photoLibrary.selectedAssetArr.count] : @"Select Photos";
                
                [strongSelf colectonViewChangeWithCellIndex:index];
            }
        };
    }
    return _collectionSectionView;
}

- (void)colectonViewChangeWithCellIndex:(NSInteger)index {
    [self.adapter updateObjects:[self objectsForAdapter:self.adapter] dataSource:self];
    if (self.photoLibrary.selectedAssetArr.count == 0 && self.collectionView.numberOfSections == 3) {
        [UIView animateWithDuration:0.25
                              delay:0
             usingSpringWithDamping:0.85
              initialSpringVelocity:20
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:0]];
                         } completion:^(BOOL finished) {
                             _alreadyShowPreView = NO;
                             
                             [self.preCollectionSectionView changeCollectionViewLocation];
                         }];
    } else if (self.photoLibrary.selectedAssetArr.count == 1 && self.collectionView.numberOfSections == 2) {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.65
              initialSpringVelocity:20
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:0]];
                         } completion:^(BOOL finished) {
                             _alreadyShowPreView = YES;
                             
                             [self.collectionSectionView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
                             
                             [self.preCollectionSectionView changeCollectionViewLocation];
                         }];
    } else {
        [self.preCollectionSectionView changeCollectionViewLocation];
    }
}

#pragma mark - Setter && Getter
- (CBPhotoSelecterPreCollectionSectionView *)preCollectionSectionView {
    if (!_preCollectionSectionView) {
        _preCollectionSectionView = [[CBPhotoSelecterPreCollectionSectionView alloc] initWithPreViewHeight:_preScrollViewHeight];
    }
    return _preCollectionSectionView;
}

- (NSArray *)albumDataArr {
    if (!_albumDataArr) {
        _albumDataArr = [[NSMutableArray alloc] init];
    }
    return _albumDataArr;
}

- (CBPhotoSelecterPhotoLibrary *)photoLibrary {
    _photoLibrary = [CBPhotoSelecterPhotoLibrary sharedPhotoLibrary];
    _photoLibrary.maxSlectedImagesCount = self.maxSlectedImagesCount;
    return _photoLibrary;
}

- (CBPhotoSelecterAlbumModel *)currentAlbumModel {
    if (!_currentAlbumModel) {
        _currentAlbumModel = [[CBPhotoSelecterAlbumModel alloc] init];
    }
    return _currentAlbumModel;
}

- (void)setPreScrollViewHeight:(NSInteger)preScrollViewHeight {
    _preScrollViewHeight = preScrollViewHeight;
    self.photoLibrary.preScrollViewHeight = preScrollViewHeight;
}

- (NSMutableArray<CBPhotoSelecterAssetModel *> *)currentAlbumAssetsModelsArray {
    if (!_currentAlbumAssetsModelsArray) {
        _currentAlbumAssetsModelsArray = [[NSMutableArray alloc] init];
    }
    return _currentAlbumAssetsModelsArray;
}

- (CBCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[CBCollectionView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.sizeHeight + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.sizeWidth, self.view.sizeHeight - self.navigationController.navigationBar.sizeHeight - [[UIApplication sharedApplication] statusBarFrame].size.height)];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.scrollsToTop = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (CBPhotoSelecterAlbumButtonSectionView *)albumButtonSectionView {
    if (!_albumButtonSectionView) {
        _albumButtonSectionView = [[CBPhotoSelecterAlbumButtonSectionView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        self.albumButtonSectionView.albumButtonTouchActionBlockInternal = ^(id albumButton) {
            __strong __typeof(self) strongSelf = weakSelf;
            
            [UIView animateWithDuration:0.25
                             animations:^{
                                 strongSelf.albumView.frame = CGRectMake(strongSelf.albumView.originLeft, strongSelf.collectionView.originUp, strongSelf.albumView.sizeWidth, strongSelf.albumView.sizeHeight);
                             } completion:nil];
        };
    }
    return _albumButtonSectionView;
}

- (CBCollectionViewAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[CBCollectionViewAdapter alloc] initWithViewController:self];
        _adapter.collectionView = self.collectionView;
    }
    return _adapter;
}

#pragma mark - Public Methods.
- (instancetype)init {
    return [self initWithDelegate:nil];
}

- (instancetype)initWithDelegate:(id<CBPickerControllerDelegate>)delegate {
    return [self initWithMaxSelectedImagesCount:0
                                       delegate:delegate];
}

- (instancetype)initWithMaxSelectedImagesCount:(NSInteger)maxSelectedImagesCount
                                      delegate:(id<CBPickerControllerDelegate>)delegate {
    return [self initWithMaxSelectedImagesCount:maxSelectedImagesCount
                                   columnNumber:4
                                       delegate:delegate];
}

- (instancetype)initWithMaxSelectedImagesCount:(NSInteger)maxSelectedImagesCount
                                  columnNumber:(NSInteger)columnNumber
                                      delegate:(id<CBPickerControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        _maxSlectedImagesCount = maxSelectedImagesCount;
        _columnNumber = columnNumber;
        _pickerDelegate = delegate;
        self.preScrollViewHeight = [[UIScreen mainScreen] bounds].size.width / 2.25;
    }
    return self;
}

#pragma mark - Adapter DataSource
- (NSArray *)objectsForAdapter:(CBCollectionViewAdapter *)adapter {
    NSMutableArray *adapterDataArr = [[NSMutableArray alloc] init];
    if (self.photoLibrary.selectedAssetArr.count) {
        [adapterDataArr addObject:[NSMutableArray arrayWithObjects:@"SelectedAssets", self.photoLibrary.selectedAssetArr, nil]];
    }
    [adapterDataArr addObject:@"AlbumButton"];
    [adapterDataArr addObject:[NSMutableArray arrayWithObjects:@"CurrentAlbumAssets", self.currentAlbumAssetsModelsArray, nil]];
    return adapterDataArr;
}

- (CBCollectionViewSectionController *)adapter:(CBCollectionViewAdapter *)adapter
                    sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[NSMutableArray class]] && [object containsObject:@"SelectedAssets"]) {
        return self.preCollectionSectionView;
    } else if([object isKindOfClass:[NSString class]]) {
        return self.albumButtonSectionView;
    } else {
        return self.collectionSectionView;
    }
}

@end

