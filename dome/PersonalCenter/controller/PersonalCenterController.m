//
//  PersonalCenterController.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//
//设备的高和宽
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width

#import "UIColor+Additional.h"
#import "PersonalCenterController.h"
#import "PersonalCenrer_rootCell.h"
#import "PersonalCenter_HeaderView.h"
#import "UserInfo_Controller.h"
#import "AboutUsController.h"
@interface PersonalCenterController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_nameArr;
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)PersonalCenter_HeaderView *headerView;
@end

@implementation PersonalCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameArr = @[
      @[@{@"name":@"一分钟了解文艺复星",@"lineHidden":@"NO"},@{@"name":@"常见问题",@"lineHidden":@"YES"}],
      @[@{@"name":@"关于我们",@"lineHidden":@"NO"},@{@"name":@"在线客服",@"lineHidden":@"NO"},@{@"name":@"版本测试",@"lineHidden":@"YES"}],
      @[@{@"name":@"收藏",@"lineHidden":@"NO"},@{@"name":@"分享领代金卷",@"lineHidden":@"YES"}]];
    [self setupSubview];
}


#pragma mark--PersonalCenter_HeaderViewDelegate
-(void)modifyInformation{
    UserInfo_Controller *userVc =[[UserInfo_Controller alloc]init];
       [self presentViewController:userVc animated:YES completion:nil];
}
-(void)userImageViewClick{
    NSLog(@"用户头像");
}
#pragma mark--  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_nameArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"userCenterCell";
    
    PersonalCenrer_rootCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PersonalCenrer_rootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
       [cell setLableNameWithDic:_nameArr[indexPath.section][indexPath.row]];
    if (indexPath.section==1&&indexPath.row==2) {
        cell.versionLable.hidden = NO;
    }
    return cell;
}
#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section==0) {
        if (indexPath.row == 0) {//一分钟
            
        } else if (indexPath.row == 1) {//常见问题
            
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {//关于我们
            AboutUsController *aboutVC = [[AboutUsController alloc]init];
           [self presentViewController:aboutVC animated:YES completion:nil];
        } else if (indexPath.row == 1) {//在线客服
            
        }else if (indexPath.row == 2) {//版本测试
            
        }
    }else if ( indexPath.section == 2 ) {
        
        if (indexPath.row == 0) {//收藏
            
        } else if (indexPath.row == 1) {//分享领代金卷
            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHex:0xefefef];
    return view;
}
#pragma mark -- 初始化视图
- (void)setupSubview {
    [self.view addSubview:self.tableView];
}
#pragma mark --- 懒加载控件
- (UITableView*)tableView {
    if (!_tableView) {
        CGRect tableFrame = CGRectMake(0, 0, Swidth, SHeight);
        UITableView *tableview = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor =[UIColor colorWithHex:0xefefef];
        tableview.showsVerticalScrollIndicator =NO;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.rowHeight = 51;
        self.headerView = [[PersonalCenter_HeaderView alloc]initWithFrame:CGRectMake(0, 0, Swidth, 220)];
        tableview.tableHeaderView = self.headerView;
        self.headerView.delegate = (id<PersonalCenter_HeaderViewDelegate>)self;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth,1)];
        tableview.tableFooterView = footView;
        _tableView = tableview;
    }
    return _tableView;
}
@end
