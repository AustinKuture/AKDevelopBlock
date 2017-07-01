// CBCollectionViewAdapter+context.m
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

#import <objc/runtime.h>
#import <CBPic2ker/CBCollectionViewAdapter+context.h>
#import <CBPic2ker/CBCollectionViewAdapterHelper.h>
#import <CBPic2ker/CBCollectionViewSectionController.h>

static char* const kCBCollectionViewAdapterContextRegisterCellClassArr = "kCBCollectionViewAdapterContextRegisterCellClassArr";
static char* const kCBCollectionViewAdapterContextRegisterSupplementaryViewClassArr = "kCBCollectionViewAdapterContextRegisterSupplementaryViewClassArr";

@implementation CBCollectionViewAdapter (context)

- (CGSize)containerSize {
    return self.collectionView.bounds.size;
}

- (UICollectionViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                forSectionController:(CBCollectionViewSectionController *)sectionController
                                             atIndex:(NSInteger)index {
    if (!self.collectionView) { return nil; }
    
    NSString *identifier = [NSString stringWithFormat:@"%@%@", NSStringFromClass([sectionController class]) , NSStringFromClass(cellClass)];
    NSInteger section = [self.adapterHelper sectionForSectionController:sectionController];
    NSIndexPath *indexPath =  [NSIndexPath indexPathForItem:index inSection:section];
    
    NSMutableArray *registerCellClassArr = objc_getAssociatedObject(self, kCBCollectionViewAdapterContextRegisterCellClassArr);
    
    if (!registerCellClassArr) {
        registerCellClassArr = [[NSMutableArray alloc] init];
    }
    
    if (![registerCellClassArr containsObject:identifier]) {
        [registerCellClassArr addObject:identifier];
        
        [self.collectionView registerClass:cellClass
                forCellWithReuseIdentifier:identifier];
    }
    
    objc_setAssociatedObject(self, kCBCollectionViewAdapterContextRegisterCellClassArr, registerCellClassArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                          forIndexPath:indexPath];
}

- (UICollectionReusableView *)dequeueReusableSupplementaryViewFromStoryboardOfKind:(NSString *)elementKind viewClass:(Class)viewClass forSectionController:(CBCollectionViewSectionController *)sectionController atIndex:(NSInteger)index {
    if (!self.collectionView) { return nil; }
    
    NSString *identifier = [NSString stringWithFormat:@"%@%@", NSStringFromClass([sectionController class]) , NSStringFromClass(viewClass)];

    NSInteger section = [self.adapterHelper sectionForSectionController:sectionController];
    NSIndexPath *indexPath =  [NSIndexPath indexPathForItem:index inSection:section];
    
    NSMutableArray *registerRegisterSupplementaryViewClassArr = objc_getAssociatedObject(self, kCBCollectionViewAdapterContextRegisterSupplementaryViewClassArr);
    
    if (!registerRegisterSupplementaryViewClassArr) {
        registerRegisterSupplementaryViewClassArr = [[NSMutableArray alloc] init];
    }
    
    if (![registerRegisterSupplementaryViewClassArr containsObject:identifier]) {
        [registerRegisterSupplementaryViewClassArr addObject:identifier];
        
        [self.collectionView registerClass:viewClass
                forSupplementaryViewOfKind:elementKind
                       withReuseIdentifier:identifier];
    }
    
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
}
@end
