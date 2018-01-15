//
//  OrderCenterController.m
//  theOld
//
//  Created by test on 2018/1/8.
//  Copyright © 2018年 loary. All rights reserved.
//

#import "OrderCenterController.h"
#import "UserManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderHistoryController.h"

@interface OrderCenterController ()<UIWebViewDelegate>{
    CGRect _frame;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation OrderCenterController

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:_frame];
    [self.view setBackgroundColor:UIColorRGB(248, 248, 248)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单列表";
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"历史账单"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(listHistoryOrders)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listHistoryOrders{
    OrderHistoryController *orderHistoryVC = [[OrderHistoryController alloc] init];
    [self.navigationController pushViewController:orderHistoryVC animated:YES];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    VFWeakSelf(self)
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:@"theOld" callback:^(NSDictionary *resultDic) {
        //处理支付结果
        NSLog(@"%@", resultDic);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([[resultDic objectForKey:@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = resultDic[@"returnUrl"];
            NSLog(@"****Alilpay****** urlStr=%@", urlStr);
            [weakself loadUWithURLStr:urlStr];;
        }
        
    }];
    
    if (isIntercepted) {
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}

- (void)loadUWithURLStr:(NSString *)urlStr{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - getter setter
/*
 UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
 webView.delegate = self;
 webView.scalesPageToFit = YES;
 [self.view addSubview:webView];
 NSString *urlStr = [NSString stringWithFormat:@"http://61.155.215.48:5000/api/order_index/?token=%@", token];
 NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
 [webView loadRequest:request];
 */
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/order_index/?token=%@",TESTHOST, [UserManager shareInstance].session];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [_webView loadRequest:request];
    }
    return _webView;
}


@end
