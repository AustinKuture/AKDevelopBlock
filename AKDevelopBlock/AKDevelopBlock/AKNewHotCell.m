//
//  AKNewHotCell.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2016/10/18.
//  Copyright © 2016年 李亚坤. All rights reserved.
//

#import "AKNewHotCell.h"

@implementation AKNewHotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
//        self.backgroundColor = GROUNDSAME(248, 1);
        self.backgroundColor = COLORS_WHITE;
        
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = COLORS_WHITE;
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.picView = [[UIImageView alloc]init];
        self.picView.layer.cornerRadius = 5;
        self.picView.layer.masksToBounds = YES;
        [backView addSubview:_picView];
        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(75.9, 45));
            make.left.equalTo(backView.mas_left).offset(2.5);
            make.top.equalTo(backView.mas_top).offset(2.5);
        }];
        
        self.projName = [[UILabel alloc]init];
        _projName.numberOfLines = 0;
        _projName.font = FONT_S(15);
        [backView addSubview:_projName];
        [_projName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_picView.mas_right).offset(10);
            make.right.equalTo(backView.mas_right).offset(-50);
            make.top.equalTo(_picView.mas_top);
            make.height.mas_equalTo(35);
        }];
        
        self.partment = [[UILabel alloc]init];
        _partment.textAlignment = NSTextAlignmentCenter;
        _partment.font = FONT_S(9);
        _partment.textColor = BLUE_LOW;
        [backView addSubview:_partment];
        [_partment mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(60, 10));
            make.right.equalTo(_projName.mas_right);
            make.bottom.equalTo(backView.mas_bottom).offset(-3);
        }];
        
        self.person = [[UILabel alloc]init];
        _person.textAlignment = NSTextAlignmentCenter;
        _person.font = FONT_S(12);
        _person.textColor = GROUNDSAME(125, 1);
        [backView addSubview:_person];
        [_person mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(50, 17));
            make.right.equalTo(backView.mas_right);
            make.top.equalTo(_projName.mas_top).offset(10);
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = FONT_S(9);
        _timeLabel.textColor = GROUNDSAME(180, 1);
        [backView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(80, 10));
            make.right.equalTo(_person.mas_right);
            make.bottom.equalTo(backView.mas_bottom).offset(-3);
        }];
        
    }
    
    return self;
}

@end
