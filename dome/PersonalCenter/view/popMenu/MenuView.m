//
//  MenuView.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/12.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//

#import "MenuView.h"
#import "MenuModel.h"
#import "MenuTableViewCell.h"
#define MENU_TAG 99999  // MenuView的tag
#define BACKVIEW_TAG 88888  // 背景遮罩view的tag
#define KRowHeight 40   // cell行高
#define KDefaultMaxValue 13 // 菜单项最大值
#define KNavigationBar_H 64 // 导航栏64
#define KIPhoneSE_ScreenW 375
#define KMargin 10

@interface MenuView () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,assign) CGFloat menuHeight;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIViewController * target;

@end

@implementation MenuView
#pragma mark -- setDataArray
- (void)setDataArray:(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[MenuModel class]]) {
            MenuModel *model = [MenuModel MenuModelWithDict:(NSDictionary *)obj];
            [_dataArray addObject:model];
        }
    }];
}

- (void)setMaxValueForItemCount:(NSInteger)maxValueForItemCount{
//    if (maxValueForItemCount <= KDefaultMaxValue) {
        _maxValueForItemCount = maxValueForItemCount;
//    }else{
//        _maxValueForItemCount = KDefaultMaxValue;
//    }
}

#pragma mark -- layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.bounds = self.bounds;
}

#pragma mark -- initMenu
- (void)setUpUIWithFrame:(CGRect)frame{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.rowHeight = KRowHeight;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"cell"];
    //取消按钮
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width, KRowHeight+KMargin)];
    footView.backgroundColor = [UIColor colorWithRed:238/255.0 green:236/255.0 blue:244/255.0 alpha:1];
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor colorWithRed:68/255.0 green:93/255.0 blue:210/255.0 alpha:1] forState:UIControlStateNormal];
    cleanBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    cleanBtn.backgroundColor = [UIColor whiteColor];
    cleanBtn.frame =CGRectMake(0, KMargin, frame.size.width, KRowHeight);
    [cleanBtn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview: cleanBtn];
    self.tableView.tableFooterView = footView;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.target.view.bounds.size.width, self.target.view.bounds.size.height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.userInteractionEnabled = YES;
    backView.alpha = 0.0;
    backView.tag = BACKVIEW_TAG;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    self.backView = backView;
    
    [self.target.view addSubview:backView];
    [self addSubview:self.tableView];
}
#pragma mark -- UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuModel *model = self.dataArray[indexPath.row];
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.menuModel = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuModel *model = self.dataArray[indexPath.row];
    NSInteger tag = indexPath.row + 1;
    if (self.itemsClickBlock) {
        self.itemsClickBlock(model.itemName,tag);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KRowHeight;
}


#pragma mark -- UITapGestureRecognizer
- (void)tap:(UITapGestureRecognizer *)sender{
    [MenuView showMenuWithAnimation:NO];
    if (self.backViewTapBlock) {
        self.backViewTapBlock();
    }
}


#pragma mark -- Adjust Menu Frame
- (void)adjustFrameForMenu{
    
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    menuView.maxValueForItemCount = menuView.dataArray.count;
    if (menuView.maxValueForItemCount>KDefaultMaxValue) {
        return;
    }
    CGRect rect = CGRectMake(0, 0, menuView.tableView.frame.size.width, KRowHeight * (menuView.maxValueForItemCount+1)+KMargin);
    CGRect frame = CGRectMake(menuView.frame.origin.x, [UIScreen mainScreen].bounds.size.height, menuView.frame.size.width, (menuView.maxValueForItemCount+1) * KRowHeight + KMargin);
    
    menuView.tableView.frame = rect;   // 根据菜单项，调整菜单内tableView的大小
    menuView.frame = frame;     // 根据菜单项，调整菜单的整体frame
}

#pragma mark -- Create Menu
+ (MenuView *)createMenuWithTarget:(UIViewController *)target dataArray:(NSArray *)dataArray itemsClickBlock:(void (^)(NSString *, NSInteger))itemsClickBlock backViewTap:(void (^)())backViewTapBlock{
    CGRect frame;
    // 计算frame
    CGFloat width =  [UIScreen mainScreen].bounds.size.width ;
    CGFloat height = dataArray.count > KDefaultMaxValue ? KDefaultMaxValue * KRowHeight : dataArray.count * KRowHeight +KMargin +KRowHeight;
    CGFloat x = 0;
    CGFloat y = [UIScreen mainScreen].bounds.size.height;
    CGRect rect = CGRectMake(x, y, width, height);    // 菜单中tableView的frame
    frame = CGRectMake(x, y, width, height); // 菜单的整体frame
    MenuView *menuView = [[MenuView alloc] init];
    menuView.tag = MENU_TAG;
    menuView.frame = frame;
    menuView.target = target;
    menuView.dataArray = [NSMutableArray arrayWithArray:dataArray];
    menuView.itemsClickBlock = itemsClickBlock;
    menuView.backViewTapBlock = backViewTapBlock;
    menuView.maxValueForItemCount = dataArray.count;
    [menuView setUpUIWithFrame:rect];
    [target.view addSubview:menuView];
    return menuView;
}


#pragma mark -- Show With Animation
+ (void)showMenuWithAnimation:(BOOL)isShow{
    
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    UIView *backView = [[UIApplication sharedApplication].keyWindow viewWithTag:BACKVIEW_TAG];
    menuView.tableView.contentOffset = CGPointZero;
    CGRect frame = menuView.frame;
    [UIView animateWithDuration:0.25 animations:^{
        if (isShow) {
            menuView.alpha = 1;
            backView.alpha = 0.5;
            CGFloat y = frame.origin.y - frame.size.height;
            menuView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
        }else{
            menuView.alpha = 0;
            backView.alpha = 0;
            CGFloat y = frame.origin.y + frame.size.height;
            menuView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
        }
    }];
}


#pragma mark -- Append Menu Items
+ (void)appendMenuItemsWith:(NSArray *)appendItemsArray{
    
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    NSMutableArray *tempMutableArr = [NSMutableArray arrayWithArray:menuView.dataArray];
    [tempMutableArr addObjectsFromArray:appendItemsArray];
    menuView.dataArray = tempMutableArr;
    
    [menuView.tableView reloadData];
    [menuView adjustFrameForMenu];
}


#pragma mark -- Update Menu Items
+ (void)updateMenuItemsWith:(NSArray *)newItemsArray{
    
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    [menuView.dataArray removeAllObjects];
    menuView.dataArray = [NSMutableArray arrayWithArray:newItemsArray];
    
    [menuView.tableView reloadData];
    [menuView adjustFrameForMenu];
}


#pragma mark -- Hidden & Clear
+ (void)hidden{
    [MenuView showMenuWithAnimation:NO];
}

+ (void)clearMenu{
    [MenuView showMenuWithAnimation:NO];
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    UIView *backView = [[UIApplication sharedApplication].keyWindow viewWithTag:BACKVIEW_TAG];
    [menuView removeFromSuperview];
    [backView removeFromSuperview];
}



@end










