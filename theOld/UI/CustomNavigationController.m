//
//  CustomNavigationController.m
//  cop
//
//  Created by lizhenzhen on 15/5/7.
//
//

#import "CustomNavigationController.h"
#import "vvDefine.h"
#import "VVConfig.h"
 
@interface CustomNavigationController ()<UIGestureRecognizerDelegate>
 
@end

@implementation CustomNavigationController

- (id) initWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        rootViewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return [super initWithRootViewController:rootViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationBar setBarTintColor:baseColor];
    
    //自定义导航栏标题的颜色字体大小
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    //分割线
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationBar.frame) - 0.5, CGRectGetWidth(self.navigationBar.frame), 0.5)];
     vLine.backgroundColor = UIColorFromRGB(0x8dc21f);
    [self.navigationBar addSubview:vLine];
    
    __weak typeof (self) weakSelf = self;
    //解决因为自定义导航栏按钮,滑动返回失效的问题
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

#pragma mark - 重定义父类方法
//- (void)setTitle:(NSString *)title{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:20.0];
//    label.textAlignment = NSTextAlignmentCenter;
//
//    label.textColor = [UIColor blackColor];
//    label.shadowColor=[UIColor blackColor];
//    label.shadowOffset=CGSizeMake(0, -1);
//
//    label.text=title;
//    [label sizeToFit];
//    self.navigationItem.titleView = label;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //自定义返回按钮
    if (self.viewControllers.count > 0) {
        UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 18)];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
       
        UIBarButtonItem *bbi=[[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = bbi;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
