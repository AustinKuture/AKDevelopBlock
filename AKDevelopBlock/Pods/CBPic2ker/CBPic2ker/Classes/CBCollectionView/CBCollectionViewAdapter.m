// CBCollectionViewAdapter.m
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

#import <CBPic2ker/CBCollectionViewAdapter.h>
#import <CBPic2ker/CBCollectionViewDelegateProxy.h>
#import <CBPic2ker/CBCollectionViewAdapterHelper.h>
#import <CBPic2ker/CBCollectionViewSectionController.h>

@class CBCollectionViewContextProtocol;

@interface CBCollectionViewAdapter()

@property (nonatomic, strong, readwrite) CBCollectionViewDelegateProxy *delegateProxy;

@end

@implementation CBCollectionViewAdapter

#pragma mark - Init
- (instancetype)initWithViewController:(nullable UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}

- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

#pragma mark - Setter & Getter
- (void)setCollectionView:(UICollectionView *)collectionView {
    if (_collectionView != collectionView || _collectionView.dataSource != self) {
        _collectionView = collectionView;
        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
        _collectionView.delegate = (id<UICollectionViewDelegate>)self.delegateProxy ?: (id<UICollectionViewDelegate>)self;
        [_collectionView.collectionViewLayout invalidateLayout];
        
        [self updateAfterPublicSettingsChange];
    }
}

- (void)setCollectionViewDelegate:(id<UICollectionViewDelegate>)collectionViewDelegate {
    _collectionViewDelegate = collectionViewDelegate;
    _collectionView.delegate = (id<UICollectionViewDelegate>)self.delegateProxy ?: (id<UICollectionViewDelegate>)self;
}

- (void)setScrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate {
    _scrollViewDelegate = scrollViewDelegate;
    _collectionView.delegate = (id<UICollectionViewDelegate>)self.delegateProxy ?: (id<UICollectionViewDelegate>)self;
}

#pragma mark - Data Handler
- (void)setDataSource:(id<CBCollectionViewAdapterDataSource>)dataSource {
    _dataSource = dataSource;
    [self updateAfterPublicSettingsChange];
}

- (void)updateAfterPublicSettingsChange {
    if (_dataSource && _collectionView) {
        [self updateObjects:[[_dataSource objectsForAdapter:self] copy] dataSource:_dataSource];
    }
}

- (void)updateObjects:(NSArray *)objects
           dataSource:(id<CBCollectionViewAdapterDataSource>)dataSource {
    NSMutableArray *sectionControllers = [NSMutableArray new];
    NSMutableArray *validObjects = [NSMutableArray new];

    for (id object in objects) {
        CBCollectionViewSectionController *sectionController = [self.adapterHelper sectionControllerForObject:object];

        if (!sectionController) {
            sectionController = [_dataSource adapter:self
                                  sectionControllerForObject:object];
        }
        
        if (!sectionController) { continue; }
        
        sectionController.viewController = _viewController;
        sectionController.collectionContext = (id <CBCollectionViewContextProtocol>)self;

        [sectionControllers addObject:sectionController];
        [validObjects addObject:object];
    }
    
    [self.adapterHelper updateWithObjects:validObjects
                       sectionControllers:sectionControllers];
    
    for (id object in validObjects) {
        [[self.adapterHelper sectionControllerForObject:object] didUpdateToObject:object];
    }
}

//- (void)performUpdatesAnimated:(BOOL)animated
//                    completion:(CBPic2kerUpdaterCompletion)completion {
//    if (_dataSource == nil || _collectionView == nil) {
//        if (completion) {
//            completion(NO);
//        }
//        return;
//    }
//    
//    NSArray *newObjects = [_dataSource objectsForAdapter:self];
//    if (!newObjects.count) { return; }
//    
//    [self updateObjects:newObjects
//             dataSource:_dataSource];
//    
//    void (^updateBlock)() = ^{
//       
//    };
//    
//    if (animated) {
//        [_collectionView performBatchUpdates:^{
//            [_collectionView performBatchUpdates:updateBlock
//                                      completion:completion];
//        } completion:nil];
//    } else {
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
//        [_collectionView performBatchUpdates:^{
//            
//        } completion:^(BOOL finished) {
//            !completion ?: completion(finished);
//            [CATransaction commit];
//        }];
//    }
//}

- (void)reloadDataWithCompletion:(CBPic2kerUpdaterCompletion)completion {
    if (_dataSource == nil || _collectionView == nil) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSArray *newObjects = [_dataSource objectsForAdapter:self];
    if (!newObjects.count) { return; }
    
    [self updateObjects:newObjects
             dataSource:_dataSource];
    
    [_collectionView reloadData];
    [_collectionView.collectionViewLayout invalidateLayout];
//    [_collectionView layoutIfNeeded];
    
    !completion ?: completion(YES);
}

#pragma mark - Lazy
- (CBCollectionViewDelegateProxy *)delegateProxy {
    if (!_delegateProxy) {
        _delegateProxy = [[CBCollectionViewDelegateProxy alloc] initWithCollectionViewTarget:_collectionViewDelegate
                                                                 scrollViewTarget:_scrollViewDelegate
                                                                              adapter:self];
    }
    return _delegateProxy;
}

- (CBCollectionViewAdapterHelper *)adapterHelper {
    if (!_adapterHelper) {
        _adapterHelper = [[CBCollectionViewAdapterHelper alloc] init];
    }
    return _adapterHelper;
}

@end
