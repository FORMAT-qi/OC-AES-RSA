//
//  oneViewController.m
//  dome
//
//  Created by 贾仕琪 on 2017/1/19.
//  Copyright © 2017年 贾仕琪. All rights reserved.
//
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width

#import "oneViewController.h"
#import "UIColor+Additional.h"
#import "UIImage+ColorToImage.h"

#define KleftSpace  20
@interface oneViewController ()
@property (nonatomic,strong)NSMutableArray *btnArr;
@property (nonatomic,strong)UITextField * textFile;
@property (nonatomic,assign)NSInteger number;
@property (nonatomic,assign)NSInteger surplus;
@property (nonatomic,assign)NSInteger loss;
@property (nonatomic,strong)UISwitch *positionSW;//持仓开关
@property (nonatomic,strong)UISwitch *tradingSW;//实时交易开关
@property (nonatomic,strong)UIButton *determineBtn;//实时交易开关
@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"5THG燃料油";
    self.profitAndLoss =@"5";
    self.price =@"2658";
    self.poundage =@"38";
    self.direction =@"多";
    self.onePrice = @"400";
    self.priceOne = @"400";
    self.deferred = @"1" ;
    self.btnArr = [[NSMutableArray alloc]init];
    _number = 1;
    _surplus = 0;
    _loss = 0;
    [self setSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 初始化控件
-(void)setSubviews{
    //
    UILabel *confirmLabel = [self getLableWithText:@"建仓确认" font:16 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    confirmLabel.frame = CGRectMake(KleftSpace, 0, Swidth-2*KleftSpace, 30);
    [self.view addSubview:confirmLabel];
    //每手单价
    UILabel *onePriceLabel = [self getLableWithText:[NSString stringWithFormat:@"%@/手",self.onePrice] font:18 textColor:0x2367f9 Alignment:NSTextAlignmentRight];
    onePriceLabel.frame = CGRectMake(KleftSpace, 0, Swidth-2*KleftSpace, CGRectGetHeight(confirmLabel.bounds));
    [self.view addSubview:onePriceLabel];
    //名字
    UILabel *nameLabel = [self getLableWithText:[NSString stringWithFormat:self.name,self.onePrice] font:18 textColor:0x2367f9 Alignment:NSTextAlignmentLeft];
    nameLabel.frame = CGRectMake(KleftSpace, CGRectGetMaxY(confirmLabel.frame)-6, Swidth-2*KleftSpace, 30);
    [self.view addSubview:nameLabel];
    //亏盈
    UILabel *profitAndLossLabel = [self getLableWithText:[NSString stringWithFormat:@"盈波动盈亏%@元",self.profitAndLoss] font:14 textColor:0x555555 Alignment:NSTextAlignmentRight];
    profitAndLossLabel.frame = CGRectMake(KleftSpace, CGRectGetMinY(nameLabel.frame), Swidth-2*KleftSpace, CGRectGetHeight(nameLabel.bounds));
    [self.view addSubview:profitAndLossLabel];
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+6, Swidth, 1)];
    lineView.backgroundColor = [UIColor colorWithHex:0xefefef];
    [self.view addSubview:lineView];
    //价格
    UILabel *priceLabel = [self getLableWithText:[NSString stringWithFormat:@"价格：%@",self.price] font:14 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    priceLabel.frame = CGRectMake(KleftSpace, CGRectGetMaxY(lineView.frame)+6, Swidth-2*KleftSpace, 30);
    [self.view addSubview:priceLabel];
    //手续费
    UILabel *poundageLabel = [self getLableWithText:[NSString stringWithFormat:@"手续费：%@",self.onePrice] font:14 textColor:0x555555 Alignment:NSTextAlignmentRight];
    poundageLabel.frame = CGRectMake(KleftSpace, CGRectGetMinY(priceLabel.frame), Swidth-2*KleftSpace, CGRectGetHeight(priceLabel.bounds));
    [self.view addSubview:poundageLabel];
    //方向
    UILabel *directionLable = [self getLableWithText:[NSString stringWithFormat:@"方向：%@",self.direction] font:14 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    directionLable.frame = CGRectMake(KleftSpace, CGRectGetMaxY(poundageLabel.frame), Swidth-2*KleftSpace, 20);
    [self.view addSubview:directionLable];
    // 400元
    UILabel *priceoneLabel = [self getLableWithText:[NSString stringWithFormat:@"%@元",self.priceOne] font:14 textColor:0x555555 Alignment:NSTextAlignmentRight];
    priceoneLabel.frame = CGRectMake(KleftSpace, CGRectGetMinY(directionLable.frame), Swidth-2*KleftSpace, CGRectGetHeight(directionLable.bounds));
    [self.view addSubview:priceoneLabel];
    // 按钮
    UILabel *buttonViewTitle = [self getLableWithText:@"手数选择" font:16 textColor:0x555555 Alignment:NSTextAlignmentCenter];
    buttonViewTitle.frame = CGRectMake(KleftSpace, CGRectGetMaxY(directionLable.frame)+20, Swidth-2*KleftSpace, CGRectGetHeight(directionLable.bounds));
    [self.view addSubview:buttonViewTitle];
    CGFloat w = (Swidth-KleftSpace*6)/5;
    CGFloat y = CGRectGetMaxY(buttonViewTitle.frame)+20;
    CGFloat x;
    CGFloat nextY = y;
    [self.btnArr removeAllObjects];
    for (NSInteger i=0; i<9; i++) {
        UIButton *btn = [self getButtonWithTitle:[NSString stringWithFormat:@"%ld",(long)i+1] font:16 noTitleColor:0x555555 seleTitleColor:0xffffff noBgColor:0xefefef seleBgColor:0x2367f9 tag:i+101];
        btn.selected = i==0?YES:NO;
        if (i<5) {
            x = KleftSpace+(KleftSpace+w)*i;
        }else{
            x = KleftSpace+(KleftSpace+w)*(i-5);
            nextY = y+KleftSpace+w;
        }
       btn.frame = CGRectMake(x,nextY, w, w);
      [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [self.btnArr addObject:btn];
    }
   // 手动填写
    _textFile = [[UITextField alloc]initWithFrame:CGRectMake(5*KleftSpace+4*w, nextY, w, w)];
    _textFile.placeholder = @"手数";
    _textFile.layer.borderWidth = 1;
    _textFile.layer.borderColor = [UIColor colorWithHex:0xefefef].CGColor;
    _textFile.layer.masksToBounds = YES;
    _textFile.layer.cornerRadius = 4;
    _textFile.textAlignment = NSTextAlignmentCenter;
    _textFile.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_textFile];
    //止盈
    UILabel *surplusLable = [self getLableWithText:@"止盈（0~50%)" font:14 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    surplusLable.frame = CGRectMake(KleftSpace, CGRectGetMaxY(_textFile.frame)+20, Swidth-2*KleftSpace, 40);
    [self.view addSubview:surplusLable];
    
    UIView *viewOne = [self getPercentViewWithFrame:CGRectMake(Swidth/3, CGRectGetMinY(surplusLable.frame), Swidth/3*2, 40) countLableTag:1000];
//    viewOne.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewOne];
    //止损
    UILabel *lossLable = [self getLableWithText:@"止损（0~50%)" font:14 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    lossLable.frame = CGRectMake(KleftSpace, CGRectGetMaxY(surplusLable.frame), Swidth-2*KleftSpace, 40);
    [self.view addSubview:lossLable];
    
    UIView *viewTwo = [self getPercentViewWithFrame:CGRectMake(Swidth/3, CGRectGetMinY(lossLable.frame), Swidth/3*2, 40) countLableTag:2000];
    //    viewOne.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewTwo];
    
  //持仓过夜
    UILabel *positionLable = [self getLableWithText:@"持仓过夜" font:14 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    positionLable.frame = CGRectMake(KleftSpace, CGRectGetMaxY(lossLable.frame), Swidth-2*KleftSpace, 40);
    [self.view addSubview:positionLable];
    //持仓开关
    _positionSW=[[UISwitch alloc]initWithFrame:CGRectMake(Swidth-60, CGRectGetMinY(positionLable.frame)+5, 0 , 0)];
     _positionSW.transform= CGAffineTransformMakeScale(0.6,0.6);
    _positionSW.onTintColor=[UIColor colorWithHex:0x2367f9];
    [_positionSW setOn:NO animated:YES];
    [self.view addSubview:_positionSW];
    UILabel *deferredLable = [self getLableWithText:[NSString stringWithFormat:@"(递延费：%@元/Tx天)",self.deferred] font:14 textColor:0x999999 Alignment:NSTextAlignmentRight];
    deferredLable.frame = CGRectMake(Swidth/2-100, CGRectGetMinY(positionLable.frame), Swidth/2, 40);
    [self.view addSubview:deferredLable];
    //实时交易
    UILabel *tradingLable = [self getLableWithText:@"按实时价格成交" font:14 textColor:0x555555 Alignment:NSTextAlignmentLeft];
    tradingLable.frame = CGRectMake(KleftSpace, CGRectGetMaxY(positionLable.frame), Swidth-2*KleftSpace, 40);
    [self.view addSubview:tradingLable];
    //实时交易
    _tradingSW=[[UISwitch alloc]init];
    _tradingSW.frame=CGRectMake(Swidth-60, CGRectGetMinY(tradingLable.frame)+5, 40 , 20);
    _tradingSW.transform= CGAffineTransformMakeScale(0.6,0.6);
    _tradingSW.onTintColor=[UIColor colorWithHex:0x2367f9];
    [_tradingSW setOn:YES animated:YES];
    [self.view addSubview:_tradingSW];
    
    //确定按钮
    _determineBtn = [self getButtonWithTitle:@"确定" font:20 noTitleColor:0xffffff seleTitleColor:0 noBgColor:0xfc3e43 seleBgColor:0 tag:0];
    _determineBtn.frame = CGRectMake(Swidth/3, SHeight-40-40, Swidth/3, 40);
    [_determineBtn addTarget:self action:@selector(determineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_determineBtn];
}

//判断是不是整数
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
#pragma mark -- 按钮点击
//加  减 按钮
-(void)PercentViewClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    UILabel *surplusLable = (UILabel *)[self.view viewWithTag:1000];
    _surplus = surplusLable.text.integerValue;
    UILabel *losslable = (UILabel *)[self.view viewWithTag:2000];
    _loss = losslable.text.integerValue;
    switch (button.tag) {
        case 1001:
            _surplus ++;
           self.surplus = _surplus >=50? 50:_surplus;
            break;
        case 1002:
            _surplus --;
          self.surplus = _surplus <=0? 0:_surplus;
            break;
        case 2001:
            _loss ++;
           self.loss = _loss >=50? 50:_loss;
            break;
        case 2002:
            _loss --;
            self.loss = _loss <=0? 0:_loss;
            break;
        default:
            break;
    }
    surplusLable.text = [NSString stringWithFormat:@"%ld",(long)_surplus];
    losslable.text = [NSString stringWithFormat:@"%ld",(long)_loss];
    
}
//按钮的tag
-(void)buttonClick:(id)sender
{
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton* button, NSUInteger idx, BOOL *stop) {
        button.selected = NO;
    }];
    UIButton* btn = (UIButton*)sender;
    btn.selected =!btn.selected;
   
    _number = btn.tag-100;
     NSLog(@"%ld",(long)_number);
}
//确定按钮
-(void)determineBtn:(id)sender{
    if (_textFile.text.length!=0) {
        if ([self isPureInt:self.textFile.text]) {
            _number = self.textFile.text.integerValue;
        }else{
          //弹出框 提示输入的不是纯数字 格式不对
        }
    }
    NSLog(@"手数：%ld--止盈：%ld--止损：%ld--持仓开关：%@--成交开关：%@",(long)_number,(long)_surplus,(long)_loss,_positionSW.isOn?@"yes":@"no",_tradingSW.isOn?@"yes":@"no");
   
}
//按钮显示状态
-(void)setSurplus:(NSInteger)surplus
{
    _surplus = surplus;
    UIButton *jiaBtn = (UIButton *)[self.view viewWithTag:1001];
    UIButton *jianBtn = (UIButton *)[self.view viewWithTag:1002];
    NSInteger jia = 0;
    NSInteger jian = 0;
    if (_surplus == 0) {
        jianBtn.enabled = NO;
        jiaBtn.enabled = YES;
        jian = 0xcfcfcf;
        jia = 0x2367f9;
    }else if(_surplus == 50){
        jianBtn.enabled = YES;
        jiaBtn.enabled = NO;
        jia = 0xcfcfcf;
        jian = 0x2367f9;
    }else{
        jian = 0x2367f9;
        jia = 0x2367f9;
        jianBtn.enabled =YES ;
        jiaBtn.enabled =YES ;
    }
    [jianBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:jian] frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
    [jiaBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:jia] frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
    
}
-(void)setLoss:(NSInteger)loss
{
    _loss = loss;
    UIButton *jiaBtn = (UIButton *)[self.view viewWithTag:2001];
    UIButton *jianBtn = (UIButton *)[self.view viewWithTag:2002];
    NSInteger jia = 0;
    NSInteger jian = 0;
    if (_loss == 0) {
        jianBtn.enabled = NO;
        jiaBtn.enabled = YES;
        jian = 0xcfcfcf;
        jia = 0x2367f9;
    }else if(_loss == 50){
        jianBtn.enabled = YES;
        jiaBtn.enabled = NO;
        jia = 0xcfcfcf;
        jian = 0x2367f9;
    }else{
        jian = 0x2367f9;
        jia = 0x2367f9;
        jianBtn.enabled =YES ;
        jiaBtn.enabled =YES ;
    }
    [jianBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:jian] frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
    [jiaBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:jia] frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
}
#pragma mark -
-(UIView *)getPercentViewWithFrame:(CGRect)frame countLableTag:(NSInteger)countLableTag{
    UIView * view =[[UIView alloc]initWithFrame:frame];
    UILabel *symbolable = [self getLableWithText:@"%" font:14 textColor:0x555555 Alignment:NSTextAlignmentCenter];
    symbolable.frame = CGRectMake(view.bounds.size.width-KleftSpace-16, view.bounds.size.height/2-8, 16, 16);
    [view addSubview:symbolable];
    //
    UIButton * jia = [self getButtonWithTitle:@"+" font:18 noTitleColor:0xffffff  seleTitleColor:0 noBgColor:0x2367f9 seleBgColor:0 tag:1000];
    jia.frame = CGRectMake(CGRectGetMinX(symbolable.frame)-25, view.bounds.size.height/2-13, 25, 25);
    [jia addTarget:self action:@selector(PercentViewClick:) forControlEvents:UIControlEventTouchUpInside];
    jia.tag = countLableTag+1;
    [view addSubview:jia];
    //
    UILabel * countLable = [self getLableWithText:@"0" font:16 textColor:0x555555 Alignment:NSTextAlignmentCenter];
    countLable.frame = CGRectMake(CGRectGetMinX(jia.frame)-50, view.bounds.size.height/2-13, 40, 25);
    countLable.tag = countLableTag;
    countLable.layer.borderWidth = 1 ;
    countLable.layer.borderColor =[UIColor colorWithHex:0xcfcfcf].CGColor;
    [view addSubview:countLable];
    //
    UIButton * jian = [self getButtonWithTitle:@"-" font:18 noTitleColor:0xffffff seleTitleColor:0 noBgColor:0xcfcfcf seleBgColor:0 tag:1000];
    jian.frame = CGRectMake(CGRectGetMinX(countLable.frame)-35, view.bounds.size.height/2-13, 25, 25);
    [jian addTarget:self action:@selector(PercentViewClick:) forControlEvents:UIControlEventTouchUpInside];
    jian.enabled =NO;
    jian.tag = countLableTag+2;
    [view addSubview:jian];
    
    return view;
}
-(UILabel *)getLableWithText:(NSString *)text font:(CGFloat )font textColor:(NSInteger)textColor Alignment:(NSTextAlignment)alignment{
    UILabel *lable = [[UILabel alloc]init];
    lable.font =[UIFont systemFontOfSize:font];
    lable.textColor = [UIColor colorWithHex:textColor];
    lable.textAlignment = alignment;
    lable.text = text;
    return lable;
}
-(UIButton *)getButtonWithTitle:(NSString *)title font:(CGFloat )font noTitleColor:(NSInteger)notitleColor seleTitleColor:(NSInteger)seleTitleColor noBgColor:(NSInteger)noBgColor seleBgColor:(NSInteger)seleBgColor tag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHex:notitleColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHex:seleTitleColor] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:noBgColor] frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:seleBgColor] frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateSelected];
    button.tag = tag;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4.0;
    return button;
}
@end
