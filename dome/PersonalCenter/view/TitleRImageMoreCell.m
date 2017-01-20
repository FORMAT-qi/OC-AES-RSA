
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved

#import "UIColor+Additional.h"
#import "TitleRImageMoreCell.h"
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width
@interface TitleRImageMoreCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *userIconView;
@end
@implementation TitleRImageMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0 , 100, 87)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.textColor = [UIColor colorWithHexString:@"#555555"];
            [self.contentView addSubview:_titleLabel];
        }
        if (!_userIconView) {
            
            _userIconView = [[UIImageView alloc] initWithFrame:CGRectMake((Swidth - 50)- 15- 30+2
                                                                          , 15
                                                                          , 58
                                                                          , 58)];
            _userIconView.backgroundColor = [UIColor blueColor];
            _userIconView.layer.masksToBounds = YES;
            _userIconView.layer.cornerRadius = 58/2;
            [self.contentView addSubview:_userIconView];
        }
    }
    return self;
}
- (void)setUserImage:(UIImage *)userImage {
    _userIconView.image = userImage;
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
