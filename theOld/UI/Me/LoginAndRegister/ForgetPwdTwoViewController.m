//
//  ForgetPwdTwoViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ForgetPwdTwoViewController.h"
#import "UIView+RoundedCorner.h"
#import "VVConfig.h"
#import "UserManager.h"
#import "CommonResponseModel.h"
#import "LoginViewController.h"

@interface ForgetPwdTwoViewController ()<UITextFieldDelegate>{
    CGRect _frame;
}
@property (nonatomic, strong) UITextField *nnPasswordTextField;
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation ForgetPwdTwoViewController

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
    self.title = @"找回密码";
    
    //新密码
    self.nnPasswordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(12*ScreenWRatioBaseIphone6, 30*ScreenHRatioBaseIphone6, CGRectGetWidth(_frame)-2*12*ScreenWRatioBaseIphone6, 45*ScreenHRatioBaseIphone6)];
    self.nnPasswordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.nnPasswordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.nnPasswordTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.nnPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nnPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.nnPasswordTextField.placeholder = @"请设置新密码";
    self.nnPasswordTextField.delegate = self;
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.nnPasswordTextField.leftView = leftViewUser;
    self.nnPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nnPasswordTextField];
    
    //密码
    self.passWordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nnPasswordTextField.frame), CGRectGetMaxY(self.nnPasswordTextField.frame) + 10, CGRectGetWidth(self.nnPasswordTextField.frame), CGRectGetHeight(self.nnPasswordTextField.frame))];
    self.passWordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.passWordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.passWordTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.passWordTextField.placeholder = @"请确认您的新密码";
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
    
    //提交按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.passWordTextField.frame) + 30, 297*ScreenWRatioBaseIphone6, CGRectGetHeight(self.nnPasswordTextField.frame));
    [self.loginBtn jm_setCornerRadius:CGRectGetHeight(self.loginBtn.frame)/2 withBackgroundColor:baseColor];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.loginBtn.center.y);
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

- (void)loginBtnClick:(UIButton *)sender{
    if (![self.passWordTextField.text isEqualToString:self.nnPasswordTextField.text]) {
        [self showInfoMsg:@"两次输入的密码不一致！请重新输入！"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.username forKey:@"username"];
    [params setObject:self.code forKey:@"code"];
    [params setObject:self.passWordTextField.text forKey:@"new_password"];
    
    [[UserManager shareInstance  ]resetPassword:params commlication:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if (model.code.integerValue == 200) {
            [self showInfoMsg:@"修改成功！"];
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[LoginViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            
        }
        else{
            [self showInfoMsg:model.msg];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nnPasswordTextField) {
        [self.nnPasswordTextField resignFirstResponder];
        [self.passWordTextField becomeFirstResponder];
    }else if (textField == self.passWordTextField) {
        [self.nnPasswordTextField resignFirstResponder];
        [self.passWordTextField resignFirstResponder];
    }
    return YES;
}

@end
