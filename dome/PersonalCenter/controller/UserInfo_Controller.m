//
//  UserInfo_Controller.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width
#define key_imageName @"key_imageName"
#define key_subtitle @"key_subtitle"
#import "UserInfo_Controller.h"
#import "TitleRImageMoreCell.h"
#import "UIColor+Additional.h"
#import "UIImage+ColorToImage.h"
#import "CustomPopView.h"
#import "MenuView.h"
@interface UserInfo_Controller ()<UIScrollViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataSource;
//@property (nonatomic, strong) MenuView *menuView;
@end

@implementation UserInfo_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [[NSMutableArray alloc]init];
    self.title = @"个人资料";
    [self setupSubView];
    [self initDataSource];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark -- request Datas



- (void)initDataSource {
    [self.dataSource removeAllObjects];
    NSMutableArray *sectionArr = [[NSMutableArray alloc]init];
    
    //第一分区
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"icon_headportrait" forKey:key_imageName];
    [dic setObject:@"" forKey:key_subtitle];
    [dic setObject:@"头像" forKey:@"title"];
    [sectionArr addObject:dic];
     [self.dataSource addObject:sectionArr];
     //第二分区
    sectionArr = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:key_imageName];
    [dic setObject:@"155151515" forKey:key_subtitle];
    [dic setObject:@"昵称" forKey:@"title"];
    [sectionArr addObject:dic];
    
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:key_imageName];
    NSString *title = @"卡门";
    [dic setObject:title forKey:key_subtitle];
    [dic setObject:@"当前帐户" forKey:@"title"];
    [sectionArr addObject:dic];
    [self.dataSource addObject:sectionArr];
    //第三分区
    sectionArr = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:key_imageName];
    [dic setObject:@"" forKey:key_subtitle];
    [dic setObject:@"修改密码" forKey:@"title"];
    [sectionArr addObject:dic];
    
    [self.dataSource addObject:sectionArr];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource objectAtIndex:section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *dataDic = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];    
    if (indexPath.section==0) {//用户头像cell
        static NSString * titleImageMoreIndentifier = @"titleImageMoreIndentifier";
        TitleRImageMoreCell *imageCell = [tableView dequeueReusableCellWithIdentifier:titleImageMoreIndentifier];
        if (!imageCell) {
            imageCell = [[TitleRImageMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleImageMoreIndentifier];
            imageCell.backgroundColor = [UIColor whiteColor];
        }
         imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
         imageCell.title = [dataDic objectForKey:@"title"];
//        imageCell.userImage = [UIImage imageNamed:[dataDic objectForKey:key_imageName]];
        return imageCell;
       
    } else {//公共cell
       static NSString * titleValueMoreIndentifier = @"titleValueMoreIndentifier";
       UITableViewCell *commonCell = [tableView dequeueReusableCellWithIdentifier:titleValueMoreIndentifier];
        if (!commonCell) {
            commonCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:titleValueMoreIndentifier];
            commonCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            commonCell.backgroundColor = [UIColor whiteColor];
        }
        if (indexPath.row==1&&indexPath.section==1) {
            commonCell.accessoryType = UITableViewCellAccessoryNone;
            UIImageView*spaceLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Swidth, 1)];
            spaceLine.image = [UIImage createImageWithColor:[UIColor colorWithHex:0xe1e1e1] frame:CGRectMake(0, 0, 1, 1)];
            [commonCell addSubview:spaceLine];

        }
        commonCell.textLabel.font = [UIFont systemFontOfSize:16];
        commonCell.textLabel.textColor = [UIColor colorWithHex:0x555555];
        commonCell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        commonCell.detailTextLabel.textColor = [UIColor colorWithHex:0x999999];
        commonCell.textLabel.text = [dataDic objectForKey:@"title"];
        commonCell.detailTextLabel.text = [dataDic objectForKey:key_subtitle];
        return commonCell;
    }
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 87;
    }
    return 50;
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
    
    if (indexPath.section==0) {//用户头像cell
         [MenuView showMenuWithAnimation:YES];
    }else if (indexPath.section == 1) {
            if (indexPath.row == 0) {//昵称
           
        } else if (indexPath.row == 1) {//账户
          
        }
    }else if ( indexPath.section == 2 ) {//修改密码
     
        
    }
}
#pragma mark -- MenuView回调事件
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)self;
    picker.allowsEditing = YES;//设置可编辑
    if (tag == 0) {//相机
        //还需要加个是否授权判断
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (tag == 1){
        //相册
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    [MenuView hidden];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage, *originalImage;
        editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        NSDictionary *dataDic = [[self.dataSource objectAtIndex:0] objectAtIndex:0];
        [dataDic setValue:editedImage forKey:key_imageName];
        [self.tableView reloadData];
        
        // 保存原图片到相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(originalImage, self, nil, NULL);
        }
    }];
}
#pragma mark -- 初始化子视图
- (void)setupSubView {
   
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0
                                                              , 0
                                                              , CGRectGetWidth(self.view.bounds)
                                                              , CGRectGetHeight(self.view.bounds))
                                             style:UITableViewStyleGrouped];
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.backgroundColor = [UIColor colorWithHex:0xefefef];
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    _tableView.tableFooterView = footView;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton *quitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitLoginButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    quitLoginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    quitLoginButton.frame = CGRectMake(50, SHeight-44-20, Swidth - 100, 44);
    UIImage *loginImage = [UIImage createImageWithColor:[UIColor colorWithHex:0xef4e46] frame:CGRectMake(0, 0, Swidth - 100, 44)];
    loginImage = [loginImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    [quitLoginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
    quitLoginButton.layer.masksToBounds = YES;
    quitLoginButton.layer.cornerRadius = 4;
    [quitLoginButton addTarget:self action:@selector(quitLoginEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitLoginButton];
    
    //弹出视图
    NSDictionary *dict1 = @{@"itemName" : @"拍照"};
    NSDictionary *dict2 = @{ @"itemName" : @"从相册中选择"};
    NSArray *dataArray = @[dict1,dict2];
    __weak __typeof(&*self)weakSelf = self;
   /**
        参数target必填， 参数dataArray必填
    */
    [MenuView createMenuWithTarget:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
    
    [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
   
    } backViewTap:^{
    // 点击背景遮罩view后的block，可自定义事件
    // 这里的目的是，让rightButton点击，可再次pop出menu
    }];

}
//退出按钮
- (void)quitLoginEvent {
   
}

#pragma mark -- getter method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [MenuView clearMenu];   // 移除菜单
}
@end
