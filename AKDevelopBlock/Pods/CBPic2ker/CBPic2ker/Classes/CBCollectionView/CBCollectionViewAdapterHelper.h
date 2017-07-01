// CBCollectionViewAdapterHelper.h
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

@class CBCollectionViewSectionController;

@interface CBCollectionViewAdapterHelper : NSObject

/**
 Fetch the objects.

 @return The all objects.
 */
- (NSArray *)objects;

/**
 Fetch the object for a section
 
 @param section The section index of the object.
 
 @return The object corresponding to the section.
 */
- (id)objectForSection:(NSInteger)section;

/**
 Update the map with objects and the section controller counterparts.
 
 @param objects The objects in the collection.
 @param sectionControllers The section controllers that map to each object.
 */
- (void)updateWithObjects:(NSArray <id <NSObject>> *)objects
       sectionControllers:(NSArray <CBCollectionViewSectionController *> *)sectionControllers;

/**
 Fetch a section controller given an object. Can return nil.
 
 @param object The object that maps to a section controller.
 
 @return A section controller.
 */
- (id)sectionControllerForObject:(id)object;

/**
 Query the section controller at a given section index. Constant time lookup.
 
 @param section A section in the list.
 
 @return A section controller or `nil` if the section does not exist.
 */
- (CBCollectionViewSectionController *)sectionControllerForSection:(NSInteger)section;

/**
 Look up the section index for an object.
 
 @param object The object to look up.
 
 @return The section index of the given object if it exists, NSNotFound otherwise.
 */
- (NSInteger)sectionForObject:(id)object;

/**
 Look up the section index for a section controller.
 
 @param sectionController The list to look up.
 
 @return The section index of the given section controller if it exists, NSNotFound otherwise.
 */
- (NSInteger)sectionForSectionController:(id)sectionController;

/**
 Remove all saved objects and section controllers.
 */
- (void)removeAllObjectsAndSectionController;

/**
 Applies a given block object to the entries of the section controller map.
 
 @param block A block object to operate on entries in the section controller map.
 */
- (void)enumerateUsingBlock:(void (^)(id object, CBCollectionViewSectionController *sectionController, NSInteger section, BOOL *stop))block;

@end
