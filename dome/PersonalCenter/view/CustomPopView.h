//
//  CustomPopView.h
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//




//自定义 弹出界面
#import <UIKit/UIKit.h>
@protocol CustomPopViewDelegate <NSObject>


@end
@interface CustomPopView : UIView
@property(nonatomic,weak)id<CustomPopViewDelegate> delegate;
@property(nonatomic,strong)NSArray *itemNames;
@end
