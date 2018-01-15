//
//  RegisterViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIView+RoundedCorner.h"
#import "VVConfig.h"
#import "ForgetPwdOneViewController.h"
#import "DataInterface.h"
#import "VerifyIdentityCard.h"

@interface RegisterViewController ()<UITextFieldDelegate>{
    CGRect _frame;
    UIButton *_getCodeBtn;
}
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation RegisterViewController

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
    self.title = @"注册";
    
    //右侧忘记密码按钮
    UIButton *forgetPWDBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 28)];//ios11 上此尺寸设置已无效，完全按图片的尺寸来 2x 3x这样
    [forgetPWDBtn setTitle:@"忘记密码" forState: UIControlStateNormal];
    [forgetPWDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPWDBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    forgetPWDBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [forgetPWDBtn addTarget:self action:@selector(forgetPWDBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithCustomView:forgetPWDBtn];
    self.navigationItem.rightBarButtonItem = rightBI;
    
    //手机号
    self.userNameTextField  = [[UITextField alloc] initWithFrame:CGRectMake(12*ScreenWRatioBaseIphone6, 30*ScreenHRatioBaseIphone6, CGRectGetWidth(_frame)-2*12*ScreenWRatioBaseIphone6, 45*ScreenHRatioBaseIphone6)];
    self.userNameTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.userNameTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.userNameTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
//    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTextField.placeholder = @"请输入手机号";
    self.userNameTextField.delegate = self;
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    self.userNameTextField.leftView = leftViewUser;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userNameTextField];
    
    //短信验证码输入框
    self.codeTextField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.userNameTextField.frame) + 10, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
    self.codeTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.codeTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.codeTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.placeholder = @"请输入短信验证码";
    self.codeTextField.delegate = self;
    //缩进
    UIView *leftViewCode = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    leftViewCode.backgroundColor = [UIColor clearColor];
    self.codeTextField.leftView = leftViewCode;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.codeTextField];
    
    /*
    //获取验证码按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetWidth(self.userNameTextField.frame)-80, 0, 80, CGRectGetHeight(self.userNameTextField.frame));
    [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [btn setTitleColor:baseColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(getYanzhengma:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeTextField addSubview:btn];
    _getCodeBtn =btn;
    //按钮左边框
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 0.5, CGRectGetHeight(btn.frame));
    leftBorder.backgroundColor = UIColorFromRGB(0xdddddd).CGColor;
    [btn.layer addSublayer:leftBorder];
     */
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [btn setTitleColor:baseColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(getYanzhengma:) forControlEvents:UIControlEventTouchUpInside];
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
    
    //设置密码输入框
    self.passWordTextField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.codeTextField.frame), CGRectGetMaxY(self.codeTextField.frame) + 10, CGRectGetWidth(self.codeTextField.frame), CGRectGetHeight(self.codeTextField.frame))];
    self.passWordTextField.textColor = UIColorFromRGB(0xaaaaaa);
    self.passWordTextField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0];
    [self.passWordTextField jm_setCornerRadius:6.0 withBorderColor:UIColorFromRGB(0xdddddd) borderWidth:0.5];
    self.passWordTextField.placeholder = @"请设置您的密码";
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
    
    //注册按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.passWordTextField.frame) + 30, 297*ScreenWRatioBaseIphone6, CGRectGetHeight(self.userNameTextField.frame));
    [self.loginBtn jm_setCornerRadius:CGRectGetHeight(self.loginBtn.frame)/2 withBackgroundColor:baseColor];
    [self.loginBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(CGRectGetWidth(_frame)/2, self.loginBtn.center.y);
    [self.loginBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

- (void)registerBtnClick:(UIButton *)sender{
    if(self.userNameTextField.text.length==0){
        [[Toast makeText:@"用户名不能为空"] show];
        return;
    }
    if (![VerifyIdentityCard isPhoneNumber:self.userNameTextField.text]) {
        [[Toast makeText:@"请输入正确的手机号"] show];
        return;
    }
    
    if (self.codeTextField.text.length==0) {
        [[Toast makeText:@"请输入验证码"] show];
        return;
    }
    if (self.passWordTextField.text.length==0) {
        [[Toast makeText:@"密码不能为空"] show];
        return;
    }
    NSDictionary *dic = @{@"username":self.userNameTextField.text,
                          @"password":self.passWordTextField.text,
                          @"code":self.codeTextField.text
                          };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //用户注册请求
        [[DataInterface shareInstance] registerRequest:dic complication:^(NSDictionary *resultDic) {
            if (resultDic == nil) {
                [[Toast makeText:@"请检查您的网络！"] show];
                return;
            }
            int code = [[resultDic objectForKey:@"code"] intValue];
            if(200 == code){
                [[Toast makeText:@"注册成功!"] show];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSString *message = [resultDic objectForKey:@"msg"];
                [[Toast makeText:message] show];
            }
        }];
    });
}

//获取验证码请求
- (void)getYanzhengma:(UIButton*)btn {
    
    if (self.userNameTextField.text != nil && [VerifyIdentityCard isPhoneNumber:self.userNameTextField.text]) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.userNameTextField.text forKey:@"username"];
        [params setObject:@"regist" forKey:@"type"];
        [[DataInterface shareInstance] getMessageCodeRequest:params completeBlock:^(CommonResponseModel *model, NSError *error) {
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
                NSLog(@"____%@",strTime);
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

- (void)forgetPWDBtnClick {
    ForgetPwdOneViewController *gegisterVC = [[ForgetPwdOneViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
    [self.navigationController pushViewController:gegisterVC animated:YES];
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
