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
#import "VerifyIdentityCard.h"
#import "ForgetPwdOneViewController.h"

@interface LoginNoPwdViewController ()<UITextFieldDelegate>{
    CGRect _frame;
    UIButton *_getCodeBtn;
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
    
//    //获取验证码按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(CGRectGetWidth(self.userNameTextField.frame)-80,  0, 80, CGRectGetHeight(self.userNameTextField.frame) );
//    [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
//    [btn setTitleColor:baseColor forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [btn addTarget:self action:@selector(getYanzhengma) forControlEvents:UIControlEventTouchUpInside];
//    [self.userNameTextField addSubview:btn];
//    _getCodeBtn =btn;
//    //按钮左边框
//    CALayer *leftBorder = [CALayer layer];
//    leftBorder.frame = CGRectMake(0.0f, 0.0f, 0.5, CGRectGetHeight(btn.frame));
//    leftBorder.backgroundColor = UIColorFromRGB(0xdddddd).CGColor;
//    [btn.layer addSublayer:leftBorder];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [btn setTitleColor:baseColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(getYanzhengma) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userNameTextField);
        make.top.equalTo(self.userNameTextField);
        make.bottom.equalTo(self.userNameTextField);
        make.width.mas_equalTo(80);
    }];
    _getCodeBtn =btn;
    //按钮左边框
    UIView *leftBorder = [[UIView alloc] init];
    leftBorder.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:leftBorder];
    [leftBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left);
        make.centerY.equalTo(btn);
        make.height.equalTo(btn);
        make.width.mas_equalTo(0.5);
    }];
    
    
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
        [[Toast makeText:@"验证码不能为空"] show];
        return;
    }
   
    NSDictionary *dic = @{@"username":self.userNameTextField.text,
                          @"logintype":@"code",
                          @"password" : @"",
                          @"code":self.passWordTextField.text,
                          
                          };
    //用户登录请求
    [[UserManager shareInstance] loginRequest:dic complication:^(NSDictionary *resultDic) {
        if([UserManager shareInstance].isLogined) {
            [[Toast makeText:@"登录成功"] show];
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USER_INFO object:nil];
            if(nil != _superDelegate && [_superDelegate respondsToSelector:@selector(backbuttonclick)]) {
                [_superDelegate performSelector:@selector(backbuttonclick)];
            }
        }else{
            [[Toast makeText:@"账号或验证码错误!"] show];
        }
    }];
}

//获取验证码请求
- (void)getYanzhengma {
    
    if (self.userNameTextField.text != nil && [VerifyIdentityCard isPhoneNumber:self.userNameTextField.text]) {
        [self startTime];
        NSMutableDictionary *parmams = [NSMutableDictionary dictionary];
        [parmams setObject:self.userNameTextField.text forKey:@"username"];
        [parmams setObject:@"login" forKey:@"type"];
        [[DataInterface shareInstance] getMessageCodeRequest:parmams complication:^(NSDictionary *resultDic) {
            NSLog(@"resultDic = %@",resultDic);
            [[Toast makeText:@"验证码发送成功"] show];
        }];
    }else{
        [[Toast makeText:@"请输入正确的手机号"] show];
    }
    
//    [[DataInterface shareInstance] getMessageCodeRequest:@{@"username":self.userNameTextField.text} complication:^(NSDictionary *resultDic) {
//        NSLog(@"resultDic = %@",resultDic);
//    }];
}

-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                //设置不可点击
                _getCodeBtn.userInteractionEnabled = YES;
                
                [_getCodeBtn setTitleColor:baseColor forState:UIControlStateNormal];
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [_getCodeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //设置不可点击
                _getCodeBtn.userInteractionEnabled = NO;
                
                [_getCodeBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
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
