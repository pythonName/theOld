
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
#import "UserManager.h"
#import "ForgetPwdOneViewController.h"

@interface LoginPwdViewController ()<UITextFieldDelegate>{
    CGRect _frame;
    id _superDelegate;
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
    
//    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [forgetPwdBtn setTitleColor:baseColor forState:UIControlStateNormal];
//    forgetPwdBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0];
//    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:forgetPwdBtn];
//    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.loginBtn);
//        make.top.equalTo(self.loginBtn.mas_bottom);
//        make.height.mas_equalTo(40);
//    }];
}

//- (void)forgetPwdBtnClick:(UIButton *)sender{
//    ForgetPwdOneViewController *forgetVC = [[ForgetPwdOneViewController alloc] init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
//}

- (void)loginBtnClick:(UIButton *)sender{
    if(self.userNameTextField.text.length==0){
        [[Toast makeText:@"用户名不能为空"] show];
        return;
    }
    if (self.passWordTextField.text.length==0) {
        [[Toast makeText:@"密码不能为空"] show];
        return;
    }
    NSDictionary *dic = @{@"username":self.userNameTextField.text,
                          @"password":self.passWordTextField.text,
                          @"logintype":@"pwd",
                          @"code" : @""
                          };
    //用户登录请求
    [[UserManager shareInstance] loginRequest:dic complication:^(NSDictionary *resultDic) {
        if([[resultDic objectForKey:@"code"] integerValue] == 200) {
            [[Toast makeText:@"登录成功"] show];
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USER_INFO object:nil];
            if(nil != _superDelegate && [_superDelegate respondsToSelector:@selector(backbuttonclick)]) {
                [_superDelegate performSelector:@selector(backbuttonclick)];
            }
        }else{
            [[Toast makeText:@"账号或密码错误!"] show];
        }
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
