//
//  PersonalCenrer_rootCell.h
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenrer_rootCell : UITableViewCell
-(void)setLableNameWithDic:(NSDictionary *)dic;
@property (nonatomic,strong) UILabel *versionLable;//版本号
@end
