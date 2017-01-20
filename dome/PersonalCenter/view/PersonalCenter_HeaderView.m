//
//  PersonalCenter_HeaderView.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import "PersonalCenter_HeaderView.h"

@interface PersonalCenter_HeaderView()
@property (nonatomic,strong)UIImageView *userImage;
@property (nonatomic,strong)UIButton *modifyBtn;
@end
@implementation PersonalCenter_HeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor blueColor];
        [self setSubview];
    }
    return self;
}
-(void)userImageClick:(id)sender{
    
    if (_delegate&&[_delegate respondsToSelector:@selector(userImageViewClick)]) {
        [_delegate userImageViewClick];
    }
}
-(void)modifyInformationBtnClick{
    if (_delegate&&[_delegate respondsToSelector:@selector(modifyInformation)]) {
        [_delegate modifyInformation];
    }
}
#pragma mark -- setupSubview
- (void)setSubview {
 
    [self addSubview:self.userImage];
    [self addSubview:self.modifyBtn];
}
#pragma mark -- 懒加载
-(UIImageView *)userImage{
    if (!_userImage) {
        _userImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
        _userImage.center = self.center;
        _userImage.layer.masksToBounds =YES;
        _userImage.layer.cornerRadius = 72/2;
        _userImage.backgroundColor =[UIColor whiteColor];
        _userImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImageClick:)];
        tapGesture.numberOfTapsRequired = 1;
        [_userImage addGestureRecognizer:tapGesture];
    }
    return _userImage;
}
-(UIButton *)modifyBtn{
    
    if (!_modifyBtn) {
        _modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _modifyBtn.frame = CGRectMake(CGRectGetMidX(self.userImage.frame)-55, CGRectGetMaxY(self.userImage.frame)+20, 110, 30);
        [_modifyBtn setTitle:@"修改个人资料" forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_modifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _modifyBtn.layer.masksToBounds = YES;
        _modifyBtn.layer.cornerRadius = 4;
        _modifyBtn.layer.borderWidth = 1;
        _modifyBtn.layer.borderColor =[UIColor whiteColor].CGColor;
        [_modifyBtn addTarget:self action:@selector(modifyInformationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyBtn;
}
@end
