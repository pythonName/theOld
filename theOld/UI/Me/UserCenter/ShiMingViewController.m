//
//  ShiMingViewController.m
//  theOld
//
//  Created by loary on 2017/11/3.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ShiMingViewController.h"
#import "VVConfig.h"
#import "UIView+RoundedCorner.h"

@interface ShiMingViewController ()<UITextFieldDelegate>{
    CGRect _frame;
}
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *sexTextField;
@property (nonatomic, strong) UITextField *idTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation ShiMingViewController

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
    self.title = @"实名信息";
    
    //顶部提示view
    UILabel *tipV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), 33)];
    tipV.backgroundColor = UIColorFromRGB(0xf4f8fd);
    tipV.text = @"   请务必填写真实信息，您的信息我们会严格保密";
    tipV.textColor = UIColorFromRGB(0xaaaaaa);
    tipV.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:tipV];
    
    //账号
    self.accountTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tipV.frame), CGRectGetWidth(_frame), 55*ScreenHRatioBaseIphone6)];
    self.accountTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.accountTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    self.accountTextField.textAlignment = NSTextAlignmentRight;
    self.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTextField.text = @"15567876543";
    self.accountTextField.delegate = self;
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.accountTextField.rightView = leftViewUser;
    self.accountTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.accountTextField];
    //左侧label
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, CGRectGetHeight(self.accountTextField.frame))];
    accountLabel.text = @"账号";
    accountLabel.textColor = UIColorFromRGB(0x333333);
    accountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0];
    [self.accountTextField addSubview:accountLabel];
    
    //分割线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.accountTextField.frame), CGRectGetWidth(self.accountTextField.frame), 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line1];
    
    //姓名
    self.nameTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.accountTextField.frame), CGRectGetWidth(self.accountTextField.frame), CGRectGetHeight(self.accountTextField.frame))];
    self.nameTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.nameTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    self.nameTextField.placeholder = @"请输入真实姓名";
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTextField.delegate = self;
    self.nameTextField.textAlignment = NSTextAlignmentRight;
    self.nameTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
    UIView *leftViewPWD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewPWD.backgroundColor = [UIColor clearColor];
    self.nameTextField.rightView = leftViewPWD;
    self.nameTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nameTextField];
    //左侧label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, CGRectGetHeight(self.accountTextField.frame))];
    nameLabel.text = @"姓名";
    nameLabel.textColor = UIColorFromRGB(0x333333);
    nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0];
    [self.nameTextField addSubview:nameLabel];
    
    //分割线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameTextField.frame), CGRectGetWidth(self.nameTextField.frame), 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line2];
    
    //性别
    self.sexTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameTextField.frame), CGRectGetWidth(self.nameTextField.frame), CGRectGetHeight(self.nameTextField.frame))];
    self.sexTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.sexTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    self.sexTextField.textAlignment = NSTextAlignmentRight;
    self.sexTextField.placeholder = @"请输入真实性别";
    self.sexTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.sexTextField.delegate = self;
    self.sexTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
    UIView *leftViewSEX = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewSEX.backgroundColor = [UIColor clearColor];
    self.sexTextField.rightView = leftViewSEX;
    self.sexTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.sexTextField];
    //左侧label
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, CGRectGetHeight(self.sexTextField.frame))];
    sexLabel.text = @"性别";
    sexLabel.textColor = UIColorFromRGB(0x333333);
    sexLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0];
    [self.sexTextField addSubview:sexLabel];
    
    //分割线
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sexTextField.frame), CGRectGetWidth(self.sexTextField.frame), 0.5)];
    line3.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line3];
    
    //身份证
    self.idTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sexTextField.frame), CGRectGetWidth(self.sexTextField.frame), CGRectGetHeight(self.sexTextField.frame))];
    self.idTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.idTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    self.idTextField.textAlignment = NSTextAlignmentRight;
    self.idTextField.placeholder = @"请输入真实身份证号";
    self.idTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.idTextField.delegate = self;
    self.idTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
    UIView *leftViewID = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewID.backgroundColor = [UIColor clearColor];
    self.idTextField.rightView = leftViewID;
    self.idTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.idTextField];
    //左侧label
    UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, CGRectGetHeight(self.idTextField.frame))];
    idLabel.text = @"身份证";
    idLabel.textColor = UIColorFromRGB(0x333333);
    idLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0];
    [self.idTextField addSubview:idLabel];
    
    //分割线
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.idTextField.frame), CGRectGetWidth(self.idTextField.frame), 0.5)];
    line4.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line4];
    
    //提交按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(line4.frame) + 40, 297*ScreenWRatioBaseIphone6, CGRectGetHeight(self.idTextField.frame));
    [self.loginBtn jm_setCornerRadius:CGRectGetHeight(self.loginBtn.frame)/2 withBackgroundColor:baseColor];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.loginBtn.center.y);
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

- (void)loginBtnClick:(UIButton *)sender{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountTextField) {
        [self.accountTextField resignFirstResponder];
        [self.nameTextField becomeFirstResponder];
    }else if (textField == self.nameTextField) {
        [self.nameTextField resignFirstResponder];
         [self.sexTextField becomeFirstResponder];
    }else if (textField == self.sexTextField) {
        [self.sexTextField resignFirstResponder];
        [self.idTextField becomeFirstResponder];
    }else if (textField == self.idTextField) {
        [self.idTextField resignFirstResponder];
        [self.sexTextField resignFirstResponder];
        [self.nameTextField resignFirstResponder];
        [self.accountTextField resignFirstResponder];
    }
    return YES;
}

@end
