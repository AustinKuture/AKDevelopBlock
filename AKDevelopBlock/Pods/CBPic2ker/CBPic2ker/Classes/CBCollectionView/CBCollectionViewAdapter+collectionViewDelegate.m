// CBCollectionViewAdapter+collectionViewDelegate.m
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

#import <CBPic2ker/CBCollectionViewAdapterHelper.h>
#import <CBPic2ker/CBCollectionViewSectionController.h>
#import <CBPic2ker/CBCollectionViewAdapter+collectionViewDelegate.h>
#import <CBPic2ker/CBCollectionView.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation CBCollectionViewAdapter (collectionViewDelegate)

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.adapterHelper.objects.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [[self.adapterHelper sectionControllerForSection:section] numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CBCollectionViewSectionController *sectionController = [self.adapterHelper sectionControllerForSection:indexPath.section];
    UICollectionViewCell *cell = [sectionController cellForItemAtIndex:indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CBCollectionViewSectionController *sectionController = [self.adapterHelper sectionControllerForSection:indexPath.section];
    UICollectionReusableView *view = [sectionController viewForSupplementaryElementOfKind:kind atIndex:indexPath.item];
    return view;
}

#pragma mark - UItableViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.collectionViewDelegate collectionView:collectionView
                           didSelectItemAtIndexPath:indexPath];
    }
    
    CBCollectionViewSectionController * sectionController = [self.adapterHelper sectionControllerForSection:indexPath.section];
    [sectionController didSelectItemAtIndex:indexPath.item];
}

#pragma mark - Layout Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.adapterHelper sectionControllerForSection:indexPath.section] sizeForItemAtIndex:indexPath.item];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [[self.adapterHelper sectionControllerForSection:section] inset];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [[self.adapterHelper sectionControllerForSection:section] minimumLineSpacing];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [[self.adapterHelper sectionControllerForSection:section] minimumInteritemSpacing];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([[self.adapterHelper sectionControllerForSection:section] respondsToSelector:@selector(sizeForSupplementaryViewOfKind:atIndex:)]) {
        return  [[self.adapterHelper sectionControllerForSection:section] sizeForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndex:section];
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if ([[self.adapterHelper sectionControllerForSection:section] respondsToSelector:@selector(sizeForSupplementaryViewOfKind:atIndex:)]) {
        return  [[self.adapterHelper sectionControllerForSection:section] sizeForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndex:section];
    } else {
        return CGSizeZero;
    }
}

#pragma clang diagnostic pop

@end
