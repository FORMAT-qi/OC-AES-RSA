//
//  PersonalCenter_HeaderView.h
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalCenter_HeaderViewDelegate <NSObject>

-(void)modifyInformation;
-(void)userImageViewClick;
@end
@interface PersonalCenter_HeaderView : UIView
@property(nonatomic,weak)id<PersonalCenter_HeaderViewDelegate> delegate;
@end
