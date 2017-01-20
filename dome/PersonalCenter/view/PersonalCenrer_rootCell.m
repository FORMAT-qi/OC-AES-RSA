//
//  PersonalCenrer_rootCell.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width
#import "PersonalCenrer_rootCell.h"
#import "UIColor+Additional.h"
#import "UIImage+ColorToImage.h"
@interface PersonalCenrer_rootCell()
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UIImageView *spaceLine;//分割线
@end
@implementation PersonalCenrer_rootCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubview];
    }
    return self;
}
-(void)setLableNameWithDic:(NSDictionary *)dic
{
    self.name.text = [dic objectForKey:@"name"];
    self.spaceLine.hidden = [[dic objectForKey:@"lineHidden"] isEqualToString:@"YES"]?YES:NO;
}
#pragma mark -- setupSubview
- (void)setUpSubview {
    [self.contentView addSubview:self.lableName];
    [self.contentView addSubview:self.spaceLine];
    [self.contentView addSubview:self.versionLable];
}
#pragma mark -- 懒加载
-(UILabel *)lableName{
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(15, 0,Swidth-30, 51)];
        _name.textColor = [UIColor colorWithHex:0x555555];
        _name.font = [UIFont systemFontOfSize:16.0];
        }
    return _name;

}
-(UILabel *)versionLable{
    if (!_versionLable) {
        _versionLable = [[UILabel alloc]initWithFrame:CGRectMake(Swidth-175, 0,100, 51)];
        _versionLable.textColor = [UIColor colorWithHex:0x999999];
        _versionLable.font = [UIFont systemFontOfSize:16.0];
        _versionLable.text = [NSString stringWithFormat:@"v%@",
                              [[[NSBundle mainBundle] infoDictionary]
                              objectForKey:@"CFBundleVersion"]];
        _versionLable.backgroundColor =[UIColor clearColor];
        _versionLable.textAlignment = NSTextAlignmentRight;
        _versionLable.hidden= YES;
    }
    return _versionLable;
    
}
-(UIImageView *)spaceLine{
    if (!_spaceLine) {
        _spaceLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, Swidth, 1)];
        _spaceLine.image = [UIImage createImageWithColor:[UIColor colorWithHex:0xe1e1e1] frame:CGRectMake(0, 0, 1, 1)];
        
    }
    return _spaceLine;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
