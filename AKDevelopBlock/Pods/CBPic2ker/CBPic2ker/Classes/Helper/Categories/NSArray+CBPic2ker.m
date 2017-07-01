// NSArray+CBPic2ker.m
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

#import "NSArray+CBPic2ker.h"


@implementation NSArray (CBPic2ker)

- (BOOL)determineWhetherArrayHaveTheSamePhotosAssetsWithComparedArray:(NSArray<CBPhotoSelecterAssetModel *> *)comparedArray {
    if (self.count != comparedArray.count) { return NO; }
    if (!self.count) { return YES; }
    
    __block BOOL result = YES;
    
    NSMutableArray *tempComparedArrayIdentifierStringArray = [[NSMutableArray alloc] init];
    [comparedArray enumerateObjectsUsingBlock:^(CBPhotoSelecterAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempComparedArrayIdentifierStringArray addObject:[obj.asset localIdentifier]];
    }];
    
    NSMutableArray *tempSelfArrayIdentifierStringArray = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(CBPhotoSelecterAssetModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempSelfArrayIdentifierStringArray addObject:[obj.asset localIdentifier]];
    }];
    
    [tempSelfArrayIdentifierStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![tempComparedArrayIdentifierStringArray containsObject:obj]) {
            result = NO;
        }
    }];
    
    [tempComparedArrayIdentifierStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![tempSelfArrayIdentifierStringArray containsObject:obj]) {
            result = NO;
        }
    }];
    
    return result;
}

- (NSInteger)findDelectedOrInsertedIndexByComparingWithOldArray:(NSArray<CBPhotoSelecterAssetModel *> *)oldArray {
    NSMutableArray *tempSelfArrayIdentifierStringArray = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(CBPhotoSelecterAssetModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempSelfArrayIdentifierStringArray addObject:[obj.asset localIdentifier]];
    }];
    
    NSMutableArray *tempComparedArrayIdentifierStringArray = [[NSMutableArray alloc] init];
    [oldArray enumerateObjectsUsingBlock:^(CBPhotoSelecterAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempComparedArrayIdentifierStringArray addObject:[obj.asset localIdentifier]];
    }];
    
    __block NSInteger deleteIndex = NSNotFound;
    [tempComparedArrayIdentifierStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![tempSelfArrayIdentifierStringArray containsObject:obj]) {
            deleteIndex = idx;
        }
    }];
    
    if (deleteIndex != NSNotFound) {
        return deleteIndex;
    }
    
    __block NSInteger insertIndex = NSNotFound;
    [tempSelfArrayIdentifierStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![tempComparedArrayIdentifierStringArray containsObject:obj]) {
            insertIndex = idx;
        }
    }];
    
    return insertIndex == NSNotFound ? deleteIndex : insertIndex;
}

@end
