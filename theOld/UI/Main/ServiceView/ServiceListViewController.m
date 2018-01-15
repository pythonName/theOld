//
//  ServiceListViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ServiceListViewController.h"
#import "CarePackagesViewController.h"
#import "GuardiansViewController.h"
#import "PhysiologicalDataViewController.h"
#import "TheRemoteSupervisionViewController.h"
#import "CareOldManModel.h"
#import "MainDataManager.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "CustomNavigationController.h"
#import "MainViewController.h"
#import "LeveyTabBarController.h"

@interface ServiceListViewController (){
    CGRect _frame;
}

@property (nonatomic, strong) UILabel *serviceProgressLabel;
@property (nonatomic, strong) UILabel *guardianCountLabel;

@end

@implementation ServiceListViewController
- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:_frame];
    [self.view setBackgroundColor:UIColorRGB(241, 246, 252)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeUIView];
    
    [self selectOldMan:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectOldMan:) name:SELECT_OLDMAN_NOTIFICATION object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userLoginNotification:(NSNotification *)notification{
    [self selectOldMan:nil];
}

- (void)userLogoutNotification:(NSNotification *)notification{
    [[MainDataManager sharedInstance] clearData];
    [self selectOldMan:nil];
}

-(void)makeUIView {
    NSArray *titleArr = @[
                          @{@"image":@"carePackages.png",@"name":@"照护套餐",@"describe": @"服务进度0%"},
                          @{@"image":@"PhysiologicalData.png",@"name":@"生理数据",@"describe":@"人工测量"},
                          @{@"image":@"theRemoteSupervision.png",@"name":@"远程监护",@"describe":@"实时监控"},
                          @{@"image":@"guardians.png",@"name":@"监护人",@"describe":@"已有0名"}
                          ];
    
    CGFloat width = 153* ScreenHRatioBaseIphone6;
    CGFloat height = 114 * ScreenHRatioBaseIphone6;
    CGFloat topLeading = 10;
    if (ScreenHRatioBaseIphone6>=1) {
        topLeading = 30;
    }
    for(int i=0 ;i<titleArr.count;i++) {
        NSDictionary *dic = titleArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30*ScreenHRatioBaseIphone6+(i%2)*(9+width), topLeading*ScreenHRatioBaseIphone6+i/2*(9+height), width, height);
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 10;
        btn.tag = 1000+i;
        //图片
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((width-39* ScreenHRatioBaseIphone6)/2, 14*ScreenHRatioBaseIphone6, 39* ScreenHRatioBaseIphone6, 38* ScreenHRatioBaseIphone6)];
        [btn addSubview:imageV];
        imageV.image = [UIImage imageNamed:dic[@"image"]];
        
        //名称
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame)+10* ScreenHRatioBaseIphone6, CGRectGetWidth(btn.frame), 17)];
        [btn addSubview:nameLab];
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.font = [UIFont systemFontOfSize:13];
        nameLab.text = dic[@"name"];
        
        //描述
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLab.frame)+4* ScreenHRatioBaseIphone6, CGRectGetWidth(btn.frame), 17)];
        [btn addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.text = dic[@"describe"];
        lab.textColor = UIColorFromRGB(0x888888);
        if (i == 0) {
            _serviceProgressLabel = lab;
        }
        
        if (i == 3) {
            _guardianCountLabel = lab;
        }
    }
    
    
}


- (void)setupDelegate:(id)delegate {
    self.delegate = delegate;
}

- (void)selectOldMan:(NSNotification *)notification{
    CareOldManModel *model = [[MainDataManager sharedInstance] selectModel];
    if (model) {
        _serviceProgressLabel.text = [NSString stringWithFormat:@"服务进度%@%%", model.pack_progress];
        _guardianCountLabel.text = [NSString stringWithFormat:@"已有%ld名", model.count];
    }
    else{
        _serviceProgressLabel.text = @"服务进度0%";
        _guardianCountLabel.text = @"已有0名";
    }
}

-(void)buttonsClick:(UIButton*)btn  {
    NSInteger tag = btn.tag-1000;
    
    UIViewController *vc = (UIViewController *)self.delegate;
    if (![UserManager shareInstance].isLogined) {
        LoginViewController *vc = [[LoginViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        CustomNavigationController *navAppBrowserController=[[CustomNavigationController alloc] initWithRootViewController:vc];
        [vc.leveyTabBarController presentViewController:navAppBrowserController animated:YES completion:^{
            
        }];
        return;
    }
    
    if (![MainDataManager sharedInstance].selectModel) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请先关注老人" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    if (tag == 0) {
        //看护套餐
        CarePackagesViewController *vv = [[CarePackagesViewController alloc] init];
        [vc.navigationController pushViewController:vv animated:YES];
        
    }else if (tag == 1){
        //生理数据
        PhysiologicalDataViewController *vv = [[PhysiologicalDataViewController alloc] init];
        [vc.navigationController pushViewController:vv animated:YES];
    }else if (tag == 2){
        //远程
        TheRemoteSupervisionViewController *vv = [[TheRemoteSupervisionViewController alloc] init];
        [vc.navigationController pushViewController:vv animated:YES];
    }else {
        //监护人
        GuardiansViewController *vv = [[GuardiansViewController alloc] init];
        [vc.navigationController pushViewController:vv animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
