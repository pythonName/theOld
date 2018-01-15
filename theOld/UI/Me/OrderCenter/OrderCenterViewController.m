//
//  OrderCenterViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OrderCenterViewController.h"

@interface OrderCenterViewController (){
     CGRect _frame;
}

@end

//handler name
static NSString *OrderCenterMessagehandler = @"OrderCenterMessagehandler";

//implemented method list
static NSString *business1 = @"business1";

@implementation OrderCenterViewController

- (id)initWithFrame:(CGRect)frame withURLString:(NSString *)urlString{
    self = [super initWithURLString:urlString];
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
    // Do any additional setup after loading the view.
    self.title = @"订单列表";
}

- (void)registerMessageHandler
{
    [super registerMessageHandler];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:OrderCenterMessagehandler];
}

- (BOOL)dealWithMessage:(WKScriptMessage *)message
{
    BOOL deal = [super dealWithMessage:message];
    if (deal) {
        return deal;
    }
    
    if ([message.name isEqualToString:OrderCenterMessagehandler] && [self.message.methodName isEqualToString:business1]) {
        [self business1];
        deal = YES;
        if (self.message.callbackMethod.length > 0) {
            [self.webView evaluateJavaScript:[NSString stringWithFormat:@"%@('test')",self.message.callbackMethod] completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                
            }];
        }
    }
    
    return deal;
}


- (void)business1
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.message.params
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!error) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"js传给oc的参数是：%@", jsonString);
    }
}



@end
