//
//  ChangePwdViewController.m
//  theOld
//
//  Created by loary on 2017/11/3.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "VVConfig.h"
#import "UIView+RoundedCorner.h"

@interface ChangePwdViewController ()<UITextFieldDelegate>{
    CGRect _frame;
}
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UITextField *nnPassWordTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation ChangePwdViewController

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
    self.title = @"修改密码";
    
    //旧密码
    self.passWordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), 55*ScreenHRatioBaseIphone6)];
    self.passWordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.passWordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    //[self.passWordTextField jm_setCornerRadius:0.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordTextField.keyboardType = UIKeyboardTypeDefault;
    self.passWordTextField.placeholder = @"旧密码";
    self.passWordTextField.delegate = self;
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.passWordTextField.leftView = leftViewUser;
    self.passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passWordTextField];
    
    //分割线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.passWordTextField.frame), CGRectGetWidth(self.passWordTextField.frame), 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line1];
    
    //新密码
    self.nnPassWordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.passWordTextField.frame), CGRectGetWidth(self.passWordTextField.frame), CGRectGetHeight(self.passWordTextField.frame))];
    self.nnPassWordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.nnPassWordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
   // [self.nnPassWordTextField jm_setCornerRadius:0.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.nnPassWordTextField.placeholder = @"新密码";
    self.nnPassWordTextField.secureTextEntry = YES;
    self.nnPassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nnPassWordTextField.delegate = self;
    self.nnPassWordTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
    UIView *leftViewPWD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewPWD.backgroundColor = [UIColor clearColor];
    self.nnPassWordTextField.leftView = leftViewPWD;
    self.nnPassWordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nnPassWordTextField];
    
    //分割线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nnPassWordTextField.frame), CGRectGetWidth(self.nnPassWordTextField.frame), 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line2];
    
    //确认修改按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(line2.frame) + 40, 297*ScreenWRatioBaseIphone6, CGRectGetHeight(self.passWordTextField.frame));
    [self.loginBtn jm_setCornerRadius:CGRectGetHeight(self.loginBtn.frame)/2 withBackgroundColor:baseColor];
    [self.loginBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.loginBtn.center.y);
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

- (void)loginBtnClick:(UIButton *)sender{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passWordTextField) {
        [self.passWordTextField resignFirstResponder];
        [self.nnPassWordTextField becomeFirstResponder];
    }else if (textField == self.nnPassWordTextField) {
        [self.passWordTextField resignFirstResponder];
        [self.nnPassWordTextField resignFirstResponder];
    }
    return YES;
}

@end
