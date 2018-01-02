

#import "MeViewController.h"
#import "LeveyTabBarController.h"
#import "VVConfig.h"
#import "OrderCenterViewController.h"
#import "OldAccountViewController.h"
#import "MyCounponViewController.h"
#import "SettingViewController.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "CustomNavigationController.h"
#import "UserCenterViewController.h"
#import "ShiMingViewController.h"
#import "ImageViewUtil.h"


@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGRect _frame;
    UITableView *_mainTableView;
}
@property (nonatomic, strong) NSArray *labelNameArr;
@property (nonatomic, strong) NSArray *labelImageNameArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *centerButton;

@end

static CGFloat CellH = 50;

@implementation MeViewController

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
    self.title = @"我的";
    
    //header view
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), 180*ScreenHRatioBaseIphone6)];
    headerV.backgroundColor = UIColorFromRGB(0x8DC21F);
    
    //中心按钮
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerButton = centerBtn;
    [self updateUserInfo];
    centerBtn.frame = CGRectMake(CGRectGetWidth(headerV.frame)/2-40, 40*ScreenHRatioBaseIphone6, 80, 80);
    centerBtn.layer.cornerRadius = 40;
    centerBtn.clipsToBounds = YES;
    //centerBtn.center = CGPointMake(CGRectGetWidth(headerV.frame)/2, CGRectGetHeight(headerV.frame)/2);
    [centerBtn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:centerBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:UPDATE_USER_INFO object:nil];
    
    
    UILabel *tt = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(centerBtn.frame)+13, CGRectGetWidth(headerV.frame), 20)];
    tt.text = @"个人中心";
    [tt setTextColor:[UIColor whiteColor]];
    tt.textAlignment = NSTextAlignmentCenter;
    tt.font = [UIFont boldSystemFontOfSize:15.0];
    [headerV addSubview:tt];
    
    self.labelNameArr = @[@"订单中心",@"老人账户",@"我的优惠券",@"系统设置"];
    self.labelImageNameArr = @[@"orderCell",@"oldAccountCell",@"couponCell",@"settingCell"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.backgroundColor = UIColorRGB(242, 242, 242);
    //    [self.tableView setSeparatorColor:UIColorRGB(235, 235, 235)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = headerV;
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)centerBtnClick {
    UIViewController *vc = nil;
    if ([UserManager shareInstance].isLogined) {
        vc = [[UserCenterViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        vc = [[LoginViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        CustomNavigationController *navAppBrowserController=[[CustomNavigationController alloc] initWithRootViewController:vc];
        NSLog(@"ling VC frame --%@", NSStringFromCGRect(CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)));
        [self.leveyTabBarController presentViewController:navAppBrowserController animated:YES completion:^{
            
        }];

    }
    
}

- (void)updateUserInfo{
    UserManager *userManager = [UserManager shareInstance];
    if (userManager.photo.length > 0) {
        NSString *imageURL = userManager.photo;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        [self.centerButton setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }
    else{
        [self.centerButton setImage:[UIImage imageNamed:@"userCenterMid"] forState:UIControlStateNormal];
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = CellH*ScreenWRatioBaseIphone6;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, CellH*ScreenWRatioBaseIphone6 -0.5, ScreenWidth, 0.5);
    [lineLayer setBackgroundColor:UIColorFromRGB(0xf0f0f0).CGColor];
    [cell.layer addSublayer:lineLayer];
    //    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    //    cell.layoutMargins = UIEdgeInsetsZero;
    cell.imageView.image = [UIImage imageNamed:self.labelImageNameArr[indexPath.row]];
    cell.textLabel.text = self.labelNameArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UserManager *userManager = [UserManager shareInstance];
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userManagerKey"];
    if (![UserManager shareInstance].isLogined) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        CustomNavigationController *navAppBrowserController=[[CustomNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navAppBrowserController animated:YES completion:nil];
        return;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            OrderCenterViewController *orderVC=[[OrderCenterViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationBarHeight-StatusBarHeight) withURLString:@"https://www.baidu.com"];
            [self.navigationController pushViewController:orderVC animated:YES];
         
        }
            
            break;
        case 1:
        {
            OldAccountViewController *oldVC = [[OldAccountViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationBarHeight-StatusBarHeight)];
            [self.navigationController pushViewController:oldVC animated:YES];
        }
            
            break;
        case 2:
        {
            MyCounponViewController *ccVC = [[MyCounponViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationBarHeight-StatusBarHeight)];
            [self.navigationController pushViewController:ccVC animated:YES];
        }
            
            break;
        case 3:
        {
            SettingViewController *ssVC = [[SettingViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationBarHeight-StatusBarHeight)];
            [self.navigationController pushViewController:ssVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
