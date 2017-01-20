//
//  MenuTableViewCell.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell {
    UIView *_lineView;
    UILabel *_titleLable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    _lineView = lineView;
    [self addSubview:_lineView];
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.backgroundColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable = titleLable;
    [self addSubview:_titleLable];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _lineView.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width , 1);
    _titleLable.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-1);
}

- (void)setMenuModel:(MenuModel *)menuModel{
    _menuModel = menuModel;
    _titleLable.text = menuModel.itemName;
}

@end
