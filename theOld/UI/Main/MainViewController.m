//
//  MainViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderOfMainView.h"
#import "PageTurningView.h"

@interface MainViewController ()<PageTurningViewDelegate>{
    CGRect _frame;
    HeaderOfMainView *_headerOfMainView;
    PageTurningView *_scrollComponent;
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

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //头部信息
    _headerOfMainView = [HeaderOfMainView loadHeaderOfMainView];
    [self.view addSubview:_headerOfMainView];
    _headerOfMainView.frame = CGRectMake(0, 0, ScreenWidth, 200* ScreenHRatioBaseIphone6);
    
    //下半部分
    NSString *plistFilePath = plistFilePath = [[NSBundle mainBundle] pathForResource:@"MainSubViewControllersConfig" ofType:@"plist"];
    
    NSArray *viewControllers = [NSArray arrayWithContentsOfFile:plistFilePath];
    _scrollComponent = [[PageTurningView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerOfMainView.frame), CGRectGetWidth(_frame), ScreenHeight-64-49-CGRectGetHeight(_headerOfMainView.frame)) withViewControllers:viewControllers delegate:self];
    [self.view addSubview:_scrollComponent];
    [_scrollComponent setCurrentVC:0];
    _scrollComponent.userInteractionEnabled = YES;
}

//PageTurningViewDelegate
-(void)switchBarClicked:(NSInteger)buttonIndex {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
