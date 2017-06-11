//
//  AKCacheClean.m
//  AKDevelopBlock
//
//  Created by 李亚坤 on 2017/6/11.
//  Copyright © 2017年 Kuture. All rights reserved.
//

#import "AKCacheClean.h"

@interface AKCacheClean ()

@property (nonatomic,strong) NSFileManager* manager;
@property (nonatomic,copy) NSString* fileName;
@property (nonatomic,copy) NSString* fileAbsolutePath;
@property (nonatomic,copy) NSString * currentVolum;

@end

@implementation AKCacheClean

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [self caculatorSize];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell){
        
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.textLabel.text = @"清除缓存";
    cell.detailTextLabel.text = _currentVolum;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self cleanCache];
}


- (void)cleanCache{
    
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"" message:@"将清除所有已缓存图片、表格及网页信息" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *doneA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self cleanCacheAndReload];
    }];
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertV addAction:doneA];
    [alertV addAction:cancelA];
    
    NSString *deviceType = [[UIDevice currentDevice] model];
    
    if ([deviceType isEqualToString:@"iPad"]){
        
        UIView *bacV = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
        bacV.backgroundColor = BLUE_HARD;
        
        UIPopoverPresentationController *popPresenter = [alertV popoverPresentationController];
        popPresenter.sourceView = bacV;
        popPresenter.sourceRect = bacV.bounds;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self presentViewController:alertV animated:YES completion:nil];
        });
        
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self presentViewController:alertV animated:YES completion:nil];
        });
    }

}


#pragma mark ***清楚缓存并重新加载***
- (void)cleanCacheAndReload{
    
    [self cleanTheCaheForWebView];
    [self caculatorSize];
    [self.tableView reloadData];
}

#pragma mark ***获取缓存***
- (void)caculatorSize{
    
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSFileManager* manager = [NSFileManager defaultManager];
    _manager = manager;
    
    if (![_manager fileExistsAtPath:cacheFilePath]){
        
        NSLog(@"Null");
    }
    
    NSEnumerator *childFilesEnumerator = [[_manager subpathsAtPath:cacheFilePath] objectEnumerator];
    NSString* fileName;
    _fileName = fileName;
    long long folderSize = 0;
    
    while ((_fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [cacheFilePath stringByAppendingPathComponent:_fileName];
        _fileAbsolutePath = fileAbsolutePath;
        folderSize += [[_manager attributesOfItemAtPath:fileAbsolutePath error:nil]fileSize];
        
        //MyLog(@"FillCache======:%@",fileAbsolutePath);
    }
    
    CGFloat intg = [[SDImageCache sharedImageCache] getSize];
    CGFloat sum = folderSize + intg;
    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:sum]];
    _currentVolum = currentVolum;
}

#pragma ***清除缓存***
- (void)cleanTheCaheForWebView{
    
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSEnumerator *childFilesEnumerator = [[_manager subpathsAtPath:cacheFilePath] objectEnumerator];
    NSString *fileOne;
    
    while ((fileOne = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [cacheFilePath stringByAppendingPathComponent:fileOne];
        
        //文件过滤规则
        if ([fileAbsolutePath rangeOfString:@"Jpush"].location != NSNotFound || [fileAbsolutePath rangeOfString:@"JPUSH"].location != NSNotFound){
            
        }else{
            
            [_manager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
}

#pragma mark ***计算文件大小***
- (NSString *)fileSizeWithInterge:(CGFloat)size{
    
    if (size < 1024) {// 小于1k
        
        return size>200 ? [NSString stringWithFormat:@"%ldB",(long)size]:[NSString stringWithFormat:@"0B"];
        
    }else if (size < 1024 * 1024){// 小于1m
        
        CGFloat aFloat = size/1024;
        
        return [NSString stringWithFormat:@"%.0fK",aFloat];
        
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        
        CGFloat aFloat = size/(1024 * 1024);
        
        return [NSString stringWithFormat:@"%.2fM",aFloat];
        
    }else{
        
        CGFloat aFloat = size/(1024*1024*1024);
        
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self caculatorSize];
}
















@end
