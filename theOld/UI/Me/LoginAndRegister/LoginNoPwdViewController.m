//
//  LoginNoPwdViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "LoginNoPwdViewController.h"
#import "UIView+RoundedCorner.h"
#import "VVConfig.h"
#import "DataInterface.h"
#import "UserManager.h"

@interface LoginNoPwdViewController ()<UITextFieldDelegate>{
    CGRect _frame;
    id _superDelegate;
}
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation LoginNoPwdViewController

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

- (void)setupDelegate:(id)dd {
    _superDelegate = dd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //手机号
    self.userNameTextField  = [[UITextField alloc] initWithFrame:CGRectMake(12*ScreenWRatioBaseIphone6, 30*ScreenHRatioBaseIphone6, CGRectGetWidth(_frame)-2*12*ScreenWRatioBaseIphone6, 45*ScreenHRatioBaseIphone6)];
    self.userNameTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.userNameTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.userNameTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    //self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTextField.placeholder = @"请输入手机号";
    self.userNameTextField.delegate = self;
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.userNameTextField.leftView = leftViewUser;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userNameTextField];
    
    //获取验证码按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetWidth(self.userNameTextField.frame)-80, 8*ScreenHRatioBaseIphone6, 80, CGRectGetHeight(self.userNameTextField.frame)-2*8*ScreenHRatioBaseIphone6);
    [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [btn setTitleColor:baseColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(getYanzhengma) forControlEvents:UIControlEventTouchUpInside];
    [self.userNameTextField addSubview:btn];
    //按钮左边框
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 0.5, CGRectGetHeight(btn.frame));
    leftBorder.backgroundColor = UIColorFromRGB(0xdddddd).CGColor;
    [btn.layer addSublayer:leftBorder];
    
    //验证密码
    self.passWordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.userNameTextField.frame) + 10, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
    self.passWordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.passWordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.passWordTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.passWordTextField.placeholder = @"请输入短信验证码";
    self.passWordTextField.secureTextEntry = YES;
    self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTextField.delegate = self;
    self.passWordTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
    UIView *leftViewPWD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewPWD.backgroundColor = [UIColor clearColor];
    self.passWordTextField.leftView = leftViewPWD;
    self.passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passWordTextField];
    
    //登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.passWordTextField.frame) + 30, 297*ScreenWRatioBaseIphone6, CGRectGetHeight(self.userNameTextField.frame));
    [self.loginBtn jm_setCornerRadius:CGRectGetHeight(self.loginBtn.frame)/2 withBackgroundColor:baseColor];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.loginBtn.center.y);
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

- (void)loginBtnClick:(UIButton *)sender{
    NSDictionary *dic = @{@"username":self.userNameTextField.text,
                          @"password":self.passWordTextField.text,
                          @"logintype":@"code"
                          };
    //用户登录请求
    [[UserManager shareInstance] loginRequest:dic complication:^(NSDictionary *resultDic) {
        if([UserManager shareInstance].isLogined) {
            [[Toast makeText:@"登录成功"] show];
            if(nil != _superDelegate && [_superDelegate respondsToSelector:@selector(backbuttonclick)]) {
                [_superDelegate performSelector:@selector(backbuttonclick)];
            }
        }
    }];
}

//获取验证码请求
- (void)getYanzhengma {
    [[DataInterface shareInstance] getMessageCodeRequest:@{@"username":self.userNameTextField.text} complication:^(NSDictionary *resultDic) {
        NSLog(@"resultDic = %@",resultDic);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userNameTextField) {
        [self.userNameTextField resignFirstResponder];
        [self.passWordTextField becomeFirstResponder];
    }else if (textField == self.passWordTextField) {
        [self.userNameTextField resignFirstResponder];
        [self.passWordTextField resignFirstResponder];
    }
    return YES;
}

@end
