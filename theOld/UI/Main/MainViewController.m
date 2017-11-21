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


@interface MainViewController ()<PageTurningViewDelegate>{
    CGRect _frame;
    HeaderOfMainView *_headerOfMainView;
    UILabel *_redLab;
}


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
    _headerOfMainView.frame = CGRectMake(0, 0, ScreenWidth, 190 );
   [_headerOfMainView.gotoResouseBtn addTarget:self action:@selector(gotoResourseView) forControlEvents:UIControlEventTouchUpInside];
    //下半部分
    NSString *plistFilePath = plistFilePath = [[NSBundle mainBundle] pathForResource:@"MainSubViewControllersConfig" ofType:@"plist"];
    
    NSArray *viewControllers = [NSArray arrayWithContentsOfFile:plistFilePath];
    self.scrollComponent = [[PageTurningView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerOfMainView.frame), CGRectGetWidth(_frame), ScreenHeight-64-49-CGRectGetHeight(_headerOfMainView.frame)) withViewControllers:viewControllers delegate:self];
    [self.view addSubview:_scrollComponent];
   
    _scrollComponent.userInteractionEnabled = YES;
    
    //消息按钮
//    infoImage
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame = CGRectMake(0, 0, 38, 30);
    [infoBtn setImage:[UIImage imageNamed:@"infoImage"] forState:UIControlStateNormal];
    [infoBtn setImage:[UIImage imageNamed:@"infoImage"] forState:UIControlStateHighlighted];
     [infoBtn addTarget:self action:@selector(infoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithCustomView:infoBtn];
    self.navigationItem.rightBarButtonItem = rightBI;
    _redLab = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 18, 18)];
    [infoBtn addSubview:_redLab];
//    _redLab.backgroundColor = [UIColor redColor];
    _redLab.textAlignment = NSTextAlignmentCenter;
    _redLab.textColor = [UIColor whiteColor];
    _redLab.font = [UIFont systemFontOfSize:10];
    _redLab.text = @"10";
    [_redLab jm_setCornerRadius:9 withBackgroundColor:[UIColor redColor]];
}

-(void)infoButtonClick {
    InfoViewController *info = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:info animated:YES];
}

-(void)gotoResourseView {
    OldManResourseViewController *vv =[[OldManResourseViewController alloc] init];
    [self.navigationController pushViewController:vv animated:YES];
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
