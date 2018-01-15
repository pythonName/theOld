//
//  MainViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderOfMainView.h"
#import "OldManResourseViewController.h"
#import "LeveyTabBarController.h"
#import "InfoViewController.h"
#import "UserManager.h"
#import "CareOldManModel.h"
#import "UIAlertController+Custom.h"
#import "UIAlertAction+Custom.h"
#import "OldManListViewController.h"
#import "MainDataManager.h"
#import "ShiMingViewController.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
//#import "LeveyTabBarController.h"



@interface MainViewController ()<PageTurningViewDelegate>{
    CGRect _frame;
    HeaderOfMainView *_headerOfMainView;
    UILabel *_redLab;
}
//@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MainViewController

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

-(void)viewDidAppear:(BOOL)animated {
    if (self.pageIndex == 1) {
        [_scrollComponent setCurrentVC:self.pageIndex];
    }else{
         [_scrollComponent setCurrentVC:0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //头部信息
    _headerOfMainView = [HeaderOfMainView loadHeaderOfMainView];
    [self.view addSubview:_headerOfMainView];
    _headerOfMainView.model = [MainDataManager sharedInstance].selectModel;
    _headerOfMainView.frame = CGRectMake(0, 0, ScreenWidth, 190 );
   [_headerOfMainView.gotoResouseBtn addTarget:self action:@selector(gotoResourseView) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    //下半部分
    NSString *plistFilePath = plistFilePath = [[NSBundle mainBundle] pathForResource:@"MainSubViewControllersConfig" ofType:@"plist"];
    
    NSArray *viewControllers = [NSArray arrayWithContentsOfFile:plistFilePath];
    self.scrollComponent = [[PageTurningView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerOfMainView.frame), CGRectGetWidth(_frame), ScreenHeight-64-49-CGRectGetHeight(_headerOfMainView.frame)) withViewControllers:viewControllers delegate:self];
    [self.view addSubview:_scrollComponent];
   
    _scrollComponent.userInteractionEnabled = YES;
    

    /*
    //消息按钮
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame = CGRectMake(0, 0, 38, 30);
    [infoBtn setImage:[UIImage imageNamed:@"infoImage"] forState:UIControlStateNormal];
    [infoBtn setImage:[UIImage imageNamed:@"infoImage"] forState:UIControlStateHighlighted];
     [infoBtn addTarget:self action:@selector(infoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithCustomView:infoBtn];
    self.navigationItem.rightBarButtonItem = rightBI;
    _redLab = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 14, 14)];
    [infoBtn addSubview:_redLab];
    _redLab.textAlignment = NSTextAlignmentCenter;
    _redLab.textColor = [UIColor whiteColor];
    _redLab.font = [UIFont systemFontOfSize:10];
    _redLab.text = @"10";
    [_redLab jm_setCornerRadius:7 withBackgroundColor:[UIColor redColor]];
     */
    
//    [LoadingView showCirleView];
//    [self performSelector:@selector(infoButtonClick) withObject:nil afterDelay:8];
    
//    if ([UserManager shareInstance].isLogined) {
//        [self loadData];
//    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:USER_LOGIN_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectOldMan:) name:SELECT_OLDMAN_NOTIFICATION object:nil];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)selectOldMan:(NSNotification *)notification{
    _headerOfMainView.model = [[MainDataManager sharedInstance] selectModel];
}

- (void)userLogout:(NSNotification *)notification{
    [[MainDataManager sharedInstance] clearData];
    _headerOfMainView.model = nil;
    
}

- (void)loadData{
    [DataInterface careOldManListRequest:nil result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            return ;
        }
        
        if ([model.code integerValue] == 200) {
            MainDataManager *dataManager = [MainDataManager sharedInstance];
            dataManager.dataArray = [CareOldManModel covertToArrayWithDictArray:model.data[@"focus_list"]];
            _headerOfMainView.model = [dataManager selectModel];
        }
        
    }];
}

-(void)infoButtonClick {
//    [LoadingView hideLoadingView];
    InfoViewController *info = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:info animated:YES];
}

-(void)gotoResourseView {
    UserManager *userManager = [UserManager shareInstance];
    
    if (!userManager.isLogined) {
        LoginViewController *vc = [[LoginViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        CustomNavigationController *navAppBrowserController=[[CustomNavigationController alloc] initWithRootViewController:vc];
        [self.leveyTabBarController presentViewController:navAppBrowserController animated:YES completion:^{
            
        }];
        return;
    }
    
    if ([userManager.complete isEqualToString:@"yes"]) {
        OldManResourseViewController *vv =[[OldManResourseViewController alloc] init];
        [self.navigationController pushViewController:vv animated:YES];
    }
    else{
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"关注老人"
                                                                           message:@"请先完善您的个人信息"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
        [alertView setTitleFont:[UIFont systemFontOfSize:14.0] color:[UIColor blackColor]];
        [alertView setmessageFont:[UIFont systemFontOfSize:14.0] color:[UIColor blackColor]];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [cancelAction setTitleColor:[UIColor grayColor]];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"立即完善"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               ShiMingViewController *controller = [[ShiMingViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
                                                               [self.navigationController pushViewController:controller animated:YES];
                                                           }];
        [sureAction setTitleColor:baseColor];
        [alertView addAction:cancelAction];
        [alertView addAction:sureAction];
        [self presentViewControllerFromRootController:alertView animated:YES completion:nil];
    }
    
}

//PageTurningViewDelegate
-(void)switchBarClicked:(NSInteger)buttonIndex {
    self.pageIndex = buttonIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.leveyTabBarController.tabBarHidden) {
        [self.leveyTabBarController hideTabBar:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.leveyTabBarController showTabBar:YES];
}

@end
