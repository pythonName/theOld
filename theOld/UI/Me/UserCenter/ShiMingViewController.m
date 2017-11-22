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
@property (nonatomic, strong) UIView *sexView;
@property (nonatomic, strong) UITextField *idTextField;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womanBtn;
@property (nonatomic, strong) UIImageView *womanBtnImageV;
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
    self.sexView  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameTextField.frame), CGRectGetWidth(self.nameTextField.frame), CGRectGetHeight(self.nameTextField.frame))];
    
//    self.sexTextField.textColor = UIColorFromRGB(0xaaaaaa);
//    self.sexTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
//    self.sexTextField.textAlignment = NSTextAlignmentRight;
//    self.sexTextField.placeholder = @"请输入真实性别";
//    self.sexTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.sexTextField.delegate = self;
//    self.sexTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
//    UIView *leftViewSEX = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
//    leftViewSEX.backgroundColor = [UIColor clearColor];
//    self.sexTextField.rightView = leftViewSEX;
//    self.sexTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.sexView];
    //左侧label
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, CGRectGetHeight(self.sexView.frame))];
    sexLabel.text = @"性别";
    sexLabel.textColor = UIColorFromRGB(0x333333);
    sexLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0];
    [self.sexView addSubview:sexLabel];
    
    //性别男
    self.manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.manBtn.frame = CGRectMake(ScreenWidth-142, 15*ScreenHRatioBaseIphone6, 61, 21*ScreenHRatioBaseIphone6);
    [self.sexView addSubview:self.manBtn];
    [self.manBtn setTitle:@"男" forState:UIControlStateNormal];
    [self.manBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
    [self.manBtn addTarget:self action:@selector(manButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.manBtn.layer.borderWidth = 0.5;
    self.manBtn.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
    self.manBtn.layer.cornerRadius = 3;
    self.manBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.manBtn.userInteractionEnabled = YES;
    //性别女
    self.womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.womanBtn.frame = CGRectMake(ScreenWidth-71, 15*ScreenHRatioBaseIphone6, 61, 21*ScreenHRatioBaseIphone6);
    [self.sexView addSubview:self.womanBtn];
    [self.womanBtn setTitle:@"女" forState:UIControlStateNormal];
    [self.womanBtn setTitleColor:baseColor forState:UIControlStateNormal];
    [self.womanBtn addTarget:self action:@selector(womanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.womanBtn.layer.borderWidth = 0.5;
    self.womanBtn.layer.borderColor = baseColor.CGColor;
    self.womanBtn.layer.cornerRadius = 3;
    self.womanBtn.selected = YES;
    self.womanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.womanBtn.userInteractionEnabled = YES;
    //选中图片
    self.womanBtnImageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-23, 25*ScreenHRatioBaseIphone6, 12, 12)];
    [self.sexView addSubview:self.womanBtnImageV];
    self.womanBtnImageV.image = [UIImage imageNamed:@"selectedSex.png"];
    //分割线
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sexView.frame), CGRectGetWidth(self.sexView.frame), 0.5)];
    line3.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line3];
    
    //身份证
    self.idTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sexView.frame), CGRectGetWidth(self.sexView.frame), CGRectGetHeight(self.sexView.frame))];
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
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.frame = CGRectMake(0, CGRectGetMaxY(line4.frame) + 40, 297*ScreenWRatioBaseIphone6, 45);
    [self.submitBtn jm_setCornerRadius:CGRectGetHeight(self.submitBtn.frame)/2 withBackgroundColor:baseColor];
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.submitBtn.center.y);
    [self.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
}

//提交按钮事件
- (void)submitBtnClick:(UIButton *)sender{
    
}

-(void)manButtonClick {
//
    self.manBtn.selected = YES;
    self.womanBtn.selected = NO;
    
    self.womanBtn.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
    self.manBtn.layer.borderColor = baseColor.CGColor;
    
    [self.manBtn setTitleColor:baseColor forState:UIControlStateNormal];
    [self.womanBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];

    self.womanBtnImageV.frame = CGRectMake(ScreenWidth-93, 25*ScreenHRatioBaseIphone6, 12, 12);
}

-(void)womanButtonClick {
    self.manBtn.selected = NO;
    self.womanBtn.selected = YES;
    
    self.womanBtn.layer.borderColor = baseColor.CGColor;
    self.manBtn.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
    
    self.womanBtnImageV.frame = CGRectMake(ScreenWidth-23, 25*ScreenHRatioBaseIphone6, 12, 12);
    
    [self.womanBtn setTitleColor:baseColor forState:UIControlStateNormal];
    [self.manBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountTextField) {
        [self.accountTextField resignFirstResponder];
        [self.nameTextField becomeFirstResponder];
    }else if (textField == self.nameTextField) {
        [self.nameTextField resignFirstResponder];
         [self.idTextField becomeFirstResponder];
    }
//    else if (textField == self.sexTextField) {
//        [self.sexTextField resignFirstResponder];
//        [self.idTextField becomeFirstResponder];
//    }
    else if (textField == self.idTextField) {
        [self.idTextField resignFirstResponder];
//        [self.sexTextField resignFirstResponder];
        [self.nameTextField resignFirstResponder];
        [self.accountTextField resignFirstResponder];
    }
    return YES;
}

@end
