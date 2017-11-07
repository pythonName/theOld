//
//  LoginPwdViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "LoginPwdViewController.h"
#import "UIView+RoundedCorner.h"
#import "VVConfig.h"

@interface LoginPwdViewController ()<UITextFieldDelegate>{
    CGRect _frame;
}
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation LoginPwdViewController

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
    // Do any additional setup after loading the view.
    
    //手机号
    self.userNameTextField  = [[UITextField alloc] initWithFrame:CGRectMake(12*ScreenWRatioBaseIphone6, 30*ScreenHRatioBaseIphone6, CGRectGetWidth(_frame)-2*12*ScreenWRatioBaseIphone6, 45*ScreenHRatioBaseIphone6)];
    self.userNameTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.userNameTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.userNameTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTextField.placeholder = @"请输入手机号";
    self.userNameTextField.delegate = self;
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.userNameTextField.leftView = leftViewUser;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userNameTextField];
    
    //密码
    self.passWordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.userNameTextField.frame) + 10, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
    self.passWordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.passWordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.passWordTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.passWordTextField.placeholder = @"请输入密码";
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
