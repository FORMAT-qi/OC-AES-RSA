//
//  AboutUsController.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width
#import "AboutUsController.h"
#import "UIColor+Additional.h"
@interface AboutUsController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIView *headerView;
@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title=indexPath.row ==0?@"关于我们":@"风险展示";
    static NSString *CellIdentifier = @"AboutUsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithHex:0x555555];
    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -- 初始化视图
- (void)setupSubview {
    [self.view addSubview:self.tableView];
}
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
        tableview.tableHeaderView = self.headerView;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth,1)];
        tableview.tableFooterView = footView;
        _tableView = tableview;
    }
    return _tableView;
}
-(UIView *)headerView{

    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth, 240)];
        _headerView.backgroundColor = [UIColor colorWithHex:0xefefef];
        UIImageView *logoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        logoImageView.backgroundColor = [UIColor grayColor];
        logoImageView.center = _headerView.center;
        logoImageView.layer.masksToBounds =YES;
        logoImageView.layer.cornerRadius = 8;
        [_headerView addSubview:logoImageView];
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageView.frame), Swidth, 30)];
        nameLable.text =@"文艺复星";
        nameLable.textColor = [UIColor colorWithHex:0x555555];
        nameLable.font =[UIFont systemFontOfSize:18];
        nameLable.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:nameLable];
        UILabel *versionLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLable.frame), Swidth, 30)];
        versionLable.text =[NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"]];;
        versionLable.textColor = [UIColor colorWithHex:0x555555];
        versionLable.font =[UIFont systemFontOfSize:18];
        versionLable.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:versionLable];
    }
    return _headerView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
