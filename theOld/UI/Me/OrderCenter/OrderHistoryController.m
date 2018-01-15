//
//  OrderHistoryController.m
//  theOld
//
//  Created by test on 2018/1/9.
//  Copyright © 2018年 loary. All rights reserved.
//

#import "OrderHistoryController.h"
#import "UserManager.h"

@interface OrderHistoryController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation OrderHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"历史订单";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSString *urlStr = [NSString stringWithFormat:@"%@api/order-record/?token=%@",TESTHOST, [UserManager shareInstance].session];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [_webView loadRequest:request];
    }
    return _webView;
}


@end
