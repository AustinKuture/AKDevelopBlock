// CBCollectionViewAdapterHelper.m
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

@interface CBCollectionViewAdapterHelper()

@property (nonatomic, strong, readwrite) NSMutableArray *objects;
@property (nonatomic, strong, readwrite) NSMutableDictionary *sectionToObjectDic;
@property (nonatomic, strong, readwrite) NSMutableDictionary *sectionToSectionControllerDic;

@end

@implementation CBCollectionViewAdapterHelper

#pragma mark - Init Methods.
- (void)updateWithObjects:(NSArray<id<NSObject>> *)objects
       sectionControllers:(NSArray<CBCollectionViewSectionController *> *)sectionControllers {
    NSCAssert(objects.count == sectionControllers.count, @"objects and sectionControllers should have same count");
    
    NSInteger minIndexCount = MIN(objects.count, sectionControllers.count);
    
    self.objects = [objects mutableCopy];
    
    [self removeAllObjectsAndSectionController];
    
    for (int idx = 0; idx < minIndexCount; idx++) {
        id object = objects[idx];
        CBCollectionViewSectionController *sectionControler = sectionControllers[idx];
        
        sectionControler.section = idx;
        
        [self.sectionToSectionControllerDic setObject:sectionControler forKey:@(idx)];
        [self.sectionToObjectDic setObject:object forKey:@(idx)];
    }
}

#pragma mark - Data Haneler.
- (NSArray *)objects {
    return [_objects mutableCopy];
}

- (id)sectionControllerForObject:(id)object {
    NSCAssert(object, @"object can't be nil");
    
    if (!object) { return nil; }
    
    NSInteger idx = [self.objects indexOfObject:object];
    return [self.sectionToSectionControllerDic objectForKey:@(idx)];
}

- (CBCollectionViewSectionController *)sectionControllerForSection:(NSInteger)section {
    if (section >= _objects.count) { return nil; }
    
    id object = [self.objects objectAtIndex:section];
    
    return [self sectionControllerForObject:object];
}

- (void)enumerateUsingBlock:(void (^)(id, CBCollectionViewSectionController *, NSInteger, BOOL *))block {
    if (!_objects.count) { return; }
    
    BOOL stop = NO;
    
    for (id object in _objects) {
        NSInteger idx = [_objects indexOfObject:object];
        id secntionController = [self sectionControllerForObject:object];
        
        block(object, secntionController, idx, &stop);
        
        if (stop) {
            break;
        }
    }
}

- (NSInteger)sectionForSectionController:(id)sectionController {
    if (!sectionController) { return NSNotFound; }
    
    NSArray *valueArr = [self.sectionToSectionControllerDic allValues];
    
    return [valueArr indexOfObject:sectionController];
}

- (NSInteger)sectionForObject:(id)object {
    if (!object) { return NSNotFound; }
    
    return [_objects indexOfObject:object];
}

- (id)objectForSection:(NSInteger)section {
    if (section >= _objects.count) { return nil; }
    
    return _objects[section];
}

- (void)removeAllObjectsAndSectionController {
    [self enumerateUsingBlock:^(id object, CBCollectionViewSectionController *sectionController, NSInteger section, BOOL *stop) {
        sectionController.section = NSNotFound;
    }];
    
    [self.sectionToSectionControllerDic removeAllObjects];
    [self.sectionToObjectDic removeAllObjects];
}

#pragma mark - Lazy
- (NSMutableDictionary *)sectionToSectionControllerDic {
    if (!_sectionToSectionControllerDic) {
        _sectionToSectionControllerDic = [[NSMutableDictionary alloc] init];
    }
    return _sectionToSectionControllerDic;
}

- (NSMutableDictionary *)sectionToObjectDic {
    if (!_sectionToObjectDic) {
        _sectionToObjectDic = [[NSMutableDictionary alloc] init];
    }
    return _sectionToObjectDic;
}

@end
