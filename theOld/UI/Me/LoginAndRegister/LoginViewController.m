//
//  LoginViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "LoginViewController.h"
#import "PageTurningView.h"
#import "LeveyTabBarController.h"
#import "VVConfig.h"
#import "RegisterViewController.h"


@interface LoginViewController (){
    CGRect _frame;
    PageTurningView *_scrollComponent;
    UIButton *leftnButton;
}

@end

@implementation LoginViewController

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
    self.title = @"登录";
    
    NSString *plistFilePath = plistFilePath = [[NSBundle mainBundle] pathForResource:@"LoginSubViewControllersConfig" ofType:@"plist"];

    NSArray *viewControllers = [NSArray arrayWithContentsOfFile:plistFilePath];
    _scrollComponent = [[PageTurningView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), CGRectGetHeight(_frame)) withViewControllers:viewControllers delegate:self];
    [self.view addSubview:_scrollComponent];
    [_scrollComponent setCurrentVC:0];
    _scrollComponent.userInteractionEnabled = YES;
    
    //返回按钮
    leftnButton = [[UIButton alloc] initWithFrame:BACK_IMAGE_VFRAME];
    [leftnButton setImage:BACK_IMAGE forState:UIControlStateNormal];
    leftnButton.imageEdgeInsets = BACK_IMAGE_INSETS;
    [leftnButton addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbi=[[UIBarButtonItem alloc] initWithCustomView:leftnButton];
    self.navigationItem.leftBarButtonItem = bbi;
    
    //右侧注册按钮
    UIButton *registerBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,44)];//ios11 上此尺寸设置已无效，完全按图片的尺寸来 2x 3x这样
    [registerBtn setTitle:@"注册" forState: UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    registerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem = rightBI;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scrollComponent contentViewWillDisappear:animated];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scrollComponent contentViewWillAppear:animated];
    [self.leveyTabBarController hideTabBar:YES];
}

-(void)backbuttonclick{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)registerBtnClick{
    RegisterViewController *gegisterVC = [[RegisterViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
    [self.navigationController pushViewController:gegisterVC animated:YES];
}

@end
