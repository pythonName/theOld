//
//  ChangeIphoneViewController.m
//  theOld
//
//  Created by loary on 2017/11/3.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ChangeIphoneViewController.h"
#import "VVConfig.h"
#import "UIView+RoundedCorner.h"
#import "VerifyIdentityCard.h"
#import "UserManager.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"

@interface ChangeIphoneViewController ()<UITextFieldDelegate>{
    CGRect _frame;
}
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *nnphoneNumberTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation ChangeIphoneViewController

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
    self.title = @"绑定新手机号";
    
    //顶部提示view
    UILabel *tipV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), 33)];
    tipV.backgroundColor = UIColorFromRGB(0xf4f8fd);
    tipV.text = @"   更换手机后，将使用新的手机号登录";
    tipV.textColor = UIColorFromRGB(0xaaaaaa);
    tipV.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:tipV];
    
    //请输入新手机号
    self.phoneNumberTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tipV.frame), CGRectGetWidth(_frame)-80, 55*ScreenHRatioBaseIphone6)];
    self.phoneNumberTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.phoneNumberTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    //[self.phoneNumberTextField jm_setCornerRadius:0.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.placeholder = @"请输入新手机号";
    self.phoneNumberTextField.delegate = self;
    
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.phoneNumberTextField.leftView = leftViewUser;
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.phoneNumberTextField];
    
    //获取验证码按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetWidth(self.phoneNumberTextField.frame), CGRectGetMaxY(tipV.frame)+8*ScreenHRatioBaseIphone6, 80, CGRectGetHeight(self.phoneNumberTextField.frame)-2*8*ScreenHRatioBaseIphone6);
    [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [btn setTitleColor:baseColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(getYanzhengma) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //按钮左边框
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 0.5, CGRectGetHeight(btn.frame));
    leftBorder.backgroundColor = UIColorFromRGB(0xdddddd).CGColor;
    [btn.layer addSublayer:leftBorder];
    
    //分割线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumberTextField.frame), CGRectGetWidth(_frame), 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line1];
    
    //请输入短信验证码
    self.nnphoneNumberTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumberTextField.frame),CGRectGetWidth(_frame), CGRectGetHeight(self.phoneNumberTextField.frame))];
    self.nnphoneNumberTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.nnphoneNumberTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    // [self.nnphoneNumberTextField jm_setCornerRadius:0.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.nnphoneNumberTextField.placeholder = @"请输入短信验证码";
    self.nnphoneNumberTextField.secureTextEntry = YES;
    self.nnphoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nnphoneNumberTextField.delegate = self;
    self.nnphoneNumberTextField.keyboardType = UIKeyboardTypeDefault;
    //缩进
    UIView *leftViewPWD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewPWD.backgroundColor = [UIColor clearColor];
    self.nnphoneNumberTextField.leftView = leftViewPWD;
    self.nnphoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nnphoneNumberTextField];
    
    //分割线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nnphoneNumberTextField.frame), CGRectGetWidth(self.nnphoneNumberTextField.frame), 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:line2];
    
    //提交按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(line2.frame) + 40, 297*ScreenWRatioBaseIphone6, 45);
    [self.loginBtn jm_setCornerRadius:CGRectGetHeight(self.loginBtn.frame)/2 withBackgroundColor:baseColor];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.loginBtn.center.y);
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

#pragma mark 提交按钮
- (void)loginBtnClick:(UIButton *)sender{
    NSDictionary *params = @{
                             @"new_username" : self.phoneNumberTextField.text,
                             @"code" : self.nnphoneNumberTextField.text
                             
                             };
    VFWeakSelf(self)
    [DataInterface changePhoneRequest:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [weakself showNetworkError];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popToRootViewControllerAnimated:NO];
        });
        
        
        if (model.code.integerValue == 200) {
            [weakself showInfoMsg:@"绑定手机号码成功！"];
            [[UserManager shareInstance] logout];
            
            LoginViewController *loginVC = [[LoginViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
            CustomNavigationController *navAppBrowserController=[[CustomNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:navAppBrowserController animated:YES completion:nil];

        }
        else{
            [weakself showInfoMsg:model.msg];
        }
    }];
}

#pragma mark 获取验证码
- (void)getYanzhengma {
    if (self.phoneNumberTextField.text != nil && [VerifyIdentityCard isPhoneNumber:self.phoneNumberTextField.text]) {
//        [self startTime];
        NSMutableDictionary *parmams = [NSMutableDictionary dictionary];
        [parmams setObject:self.phoneNumberTextField.text forKey:@"username"];
        [parmams setObject:@"telchange" forKey:@"type"];
        [[DataInterface shareInstance] getMessageCodeRequest:parmams completeBlock:^(CommonResponseModel *model, NSError *error) {
            if (error) {
                [self showNetworkError];
                return ;
            }
            
            [self showInfoMsg:model.msg];
        }];
    }else{
        [[Toast makeText:@"请输入正确的手机号"] show];
    }
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
                [_loginBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                //设置不可点击
                _loginBtn.userInteractionEnabled = YES;
                
                [_loginBtn setTitleColor:baseColor forState:UIControlStateNormal];
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                [_loginBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                //设置不可点击
                _loginBtn.userInteractionEnabled = NO;
                
                [_loginBtn setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.phoneNumberTextField) {
        [self.phoneNumberTextField resignFirstResponder];
        [self.nnphoneNumberTextField becomeFirstResponder];
    }else if (textField == self.nnphoneNumberTextField) {
        [self.phoneNumberTextField resignFirstResponder];
        [self.nnphoneNumberTextField resignFirstResponder];
    }
    return YES;
}

@end
