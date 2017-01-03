//
//  ViewController.m
//  test
//
//  Created by zitopay on 2017/1/3.
//  Copyright © 2017年 zitopay. All rights reserved.
//

#import "ViewController.h"
#import "ZITOPay.h"
#import "ZITOPayObjects.h"
@interface ViewController ()<ZITOPayDelegate>
@property (nonatomic,strong) UIButton *zhifubaoBtn;
@property (nonatomic,strong) UIButton *wxBtbn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubViewsOntest];
}

- (void)viewWillAppear:(BOOL)animated
{
#pragma mark - 设置delegate
    [ZITOPay setZITOPayDelegate:self];
}
- (void)addSubViewsOntest {
    [self.view addSubview:self.zhifubaoBtn];
    [self.view addSubview:self.wxBtbn];
}
- (UIButton *)zhifubaoBtn {
    if (!_zhifubaoBtn) {
        _zhifubaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, 100, 35)];
        [_zhifubaoBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
        [_zhifubaoBtn addTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
    }
        return _zhifubaoBtn;
}

- (UIButton *)wxBtbn {
    if (!_wxBtbn) {
        _wxBtbn = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, 100, 35)];
        [_wxBtbn setTitle:@"微信支付" forState:UIControlStateNormal];
        [_wxBtbn addTarget:self action:@selector(doPay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtbn;
}


- (void)doPay:(PayChannel)channel {
    NSString *billno = [self genBillNo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    ZITOPayReq *payReq = [[ZITOPayReq alloc] init];
    payReq.channel = PayChannelAliApp; //支付渠道
//    payReq.title = [self.dicData objectForKey:@"orderTitle"];//订单标题
    payReq.title = @"卖狗肉卖狗肉";
    payReq.currency = @"cny";//币种必填
        payReq.totalFee = @"0.01";//订单价格;以元为单位的整数
//    payReq.totalFee = [self.dicData objectForKey:@"proPrice"];
    payReq.billNo = billno;//商户自定义订单号
    payReq.scheme = @"paySchemes";//URL Scheme,在Info.plist中配置; 支付宝必填参数
    payReq.billTimeOut = 300;//订单超时时间
    payReq.idCard = @"370802199503215121";//丰付快捷M＋必填
    payReq.viewController = self; //丰付快捷M＋、畅捷通快捷、甬易银联支付必填
    payReq.goodsname = @"二哈一只";//商品名称，选填
    payReq.goodsdetail = @"狗生人家";//商品描述，选填
//    payReq.goodsname = [self.dicData objectForKey:@"proName"];;//商品名称，选填
//    payReq.goodsdetail = [self.dicData objectForKey:@"proDetail"];;//商品描述，选
    payReq.cardType = 0; //0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
    payReq.bgRetUrl = @"http://www.baidu.com";//丰付快捷M＋、甬易银联快捷、畅捷通快捷必填,支付结果会同步返回给用户
    payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
    
    [ZITOPay sendZITOReq:payReq];
}

- (void)onZITOPayResp:(ZITOBaseResp *)resp {
    NSLog(@"%@",resp.resultMsg);
}

#pragma mark - 生成订单号
- (NSString *)genBillNo {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
