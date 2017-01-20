//
//  CustomPopView.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width
#import "CustomPopView.h"
#import "UIColor+Additional.h"
@interface CustomPopView()

@property(nonatomic,strong)UIView *bgMask;//蒙版
@property(nonatomic,strong)UIView *btnView;
@end
@implementation CustomPopView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setSubviews];
        self.frame = CGRectMake(0, 0, Swidth, SHeight);
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)setSubviews{
    [self addSubview:self.bgMask];
    [self addSubview:self.btnView];
    [self addsBtnsWithItems:self.itemNames];
}
-(void)addsBtnsWithItems:(NSArray *)items{
    UIButton *cancelBtn = [self backBtnWithTitle:@"取消" titColor:[UIColor colorWithHex:0x506dde]];
    cancelBtn.frame = CGRectMake(0, SHeight-44,Swidth, 44);
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, SHeight-60, Swidth, 14)];
    spaceView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    [self addSubview:spaceView];
    CGFloat y = CGRectGetMinY(spaceView.frame);
    NSInteger itemCount = items.count;
    for (NSInteger i = 0; i<itemCount; i++) {
      UIButton *btn = [self backBtnWithTitle:items[i] titColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(itemsClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, y-44, Swidth, 44);
        btn.tag = i+100;
        [self.btnView addSubview:btn];
    }
}
-(UIButton *)backBtnWithTitle:(NSString *)title titColor:(UIColor *)titleColor
{
    UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:16];
    
    return btn;
}
-(void)bgMaskClick:(id)sender
{
    
}
-(void)itemsClick:(id)sender
{
}
//
-(void)cancelBtnClick:(id)sender
{
    
}
-(UIView *)btnView{

    if (!_btnView) {
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth, self.itemNames.count*44+58)];
    }
    return _btnView;
}
-(UIView *)bgMask{
    if (!_bgMask) {
        _bgMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth, SHeight)];
        _bgMask.backgroundColor =[UIColor blackColor];
        _bgMask.alpha = 0;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgMaskClick:)];
        tapGesture.numberOfTapsRequired = 1;
        [_bgMask addGestureRecognizer:tapGesture];
    }
    return _bgMask;
}
@end
