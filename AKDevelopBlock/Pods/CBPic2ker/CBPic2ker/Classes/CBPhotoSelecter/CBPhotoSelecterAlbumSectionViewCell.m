// CBPhotoSelecterAlbumSectionViewCell.m
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

#import <CBPic2ker/CBPhotoSelecterAlbumSectionViewCell.h>
#import <CBPic2ker/CBPhotoSelecterPhotoLibrary.h>

@interface CBPhotoSelecterAlbumSectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *albumCoverImage;
@property (nonatomic, strong, readwrite) UILabel *albumName;
@property (nonatomic, strong, readwrite) UILabel *albumCount;

@end

@implementation CBPhotoSelecterAlbumSectionViewCell

- (void)configureWithAlbumModel:(CBPhotoSelecterAlbumModel *)albumModel {
    if (!albumModel) { return; }
    
    [self.contentView addSubview:self.albumCoverImage];
    [self.contentView addSubview:self.albumName];
    [self.contentView addSubview:self.albumCount];
    
    [[CBPhotoSelecterPhotoLibrary sharedPhotoLibrary] getPostImageWithAlbumModel:albumModel
                                                                completion:^(UIImage *image) {
                                                                    self.albumCoverImage.image = image;
                                                                    self.albumName.text = albumModel.name;
                                                                    self.albumCount.text = [NSString stringWithFormat:@"%ld", (long)albumModel.count];
                                                                }];
}

#pragma mark - Lazy
- (UILabel *)albumName {
    if (!_albumName) {
        _albumName = [[UILabel alloc] initWithFrame:CGRectMake(_albumCoverImage.frame.origin.x + _albumCoverImage.frame.size.width + 10, _albumCoverImage.frame.origin.y + 5, self.frame.size.width - (_albumCoverImage.frame.origin.x + _albumCoverImage.frame.size.width + 10), 20)];
        _albumName.center = CGPointMake(_albumName.center.x, _albumCoverImage.center.y - 10);
        _albumName.textColor = [UIColor grayColor];
        _albumName.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15];
    }
    return _albumName;
}

- (UILabel *)albumCount {
    if (!_albumCount) {
        _albumCount = [[UILabel alloc] initWithFrame:CGRectMake(_albumCoverImage.frame.origin.x + _albumCoverImage.frame.size.width + 10, _albumName.frame.origin.y + _albumName.frame.size.height, self.frame.size.width - (_albumCoverImage.frame.origin.x + _albumCoverImage.frame.size.width + 10), 20)];
        _albumCount.center = CGPointMake(_albumCount.center.x, _albumCoverImage.center.y + 10);
        _albumCount.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15];
        _albumCount.textColor = [UIColor grayColor];
    }
    return _albumCount;
}

- (UIImageView *)albumCoverImage {
    if (!_albumCoverImage) {
        _albumCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.height - 10, self.frame.size.height - 10)];
        _albumCoverImage.contentMode = UIViewContentModeScaleAspectFill;
        _albumCoverImage.clipsToBounds = true;
    }
    return _albumCoverImage;
}

@end
