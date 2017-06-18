<p align="center">
  <img src="http://ww1.sinaimg.cn/large/006tNbRwgy1fgfgm49j1yj30az0b5747.jpg" width="220" height="220"/>
</p>

[![Cbangchen](https://img.shields.io/badge/cbangchen-iOS-yellow.svg)](http://cbangchen.com)
[![Version](https://img.shields.io/cocoapods/v/CBPic2ker.svg?style=flat)](http://cocoapods.org/pods/CBPic2ker)
[![License](https://img.shields.io/cocoapods/l/CBPic2ker.svg?style=flat)](http://cocoapods.org/pods/CBPic2ker)
[![Platform](https://img.shields.io/cocoapods/p/CBPic2ker.svg?style=flat)](http://cocoapods.org/pods/CBPic2ker)

中文介绍，请点击[此](https://github.com/cbangchen/CBPic2ker/blob/master/README_CN.md)处。

## Effect

<p align="center">
  <img src="PhotoPickerInteraction.gif" width="600" height="450"/>
</p>

## Features

- Cool 
- Smooth 
- Face Recognition 

## Requirements 

- iOS 8.0

## Installation 

CBPic2ker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CBPic2ker"
```

Don't forget the Privacy Description in `info.plist`.

![](http://ww2.sinaimg.cn/large/006tNbRwgy1fghh98s9wqj31g8024t8u.jpg)

## Usage 

### Import

```Objective-C
#import "CBPic2ker.h"
```

### Call

```Objective-C
CBPhotoSelecterController *controller = [[CBPhotoSelecterController alloc] initWithDelegate:self];
controller.columnNumber = 4;
controller.maxSlectedImagesCount = 5;
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
[self presentViewController:nav animated:YES completion:nil];
```

### Delegate

```Objective-C
- (void)photoSelecterController:(CBPhotoSelecterController *)pickerController sourceAsset:(NSArray *)sourceAsset {
	/...
}
- (void)photoSelecterDidCancelWithController:(CBPhotoSelecterController *)pickerController {
   /...
}
```

## Author

cbangchen, cbangchen007@gmail.com

## License 

CBPic2ker is available under the MIT license. See the LICENSE file for more info.
