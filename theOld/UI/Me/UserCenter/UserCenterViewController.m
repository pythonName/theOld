//
//  UserCenterViewController.m
//  theOld
//
//  Created by loary on 2017/11/2.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "UserCenterViewController.h"
#import "VVConfig.h"
#import "UIView+RoundedCorner.h"
#import "UserManager.h"
#import "ShiMingViewController.h"
#import "ChangePwdViewController.h"
#import "ChangeIphoneViewController.h"
#import "CustomNavigationController.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGRect _frame;
    UITableView *_mainTableView;
    UIImageView *_iconImageView;
    UILabel *_accountLabel;
    UILabel *_changePhoneNumLabel;
    UIView *_buttonCellView;
    UILabel *_factNameView;
}
@property (nonatomic, strong) NSArray *labelNameArr;
@property (nonatomic, strong) NSArray *labelImageNameArr;
@property (nonatomic, strong) UITableView *tableView;

@end

//static CGFloat CellH = 50;

@implementation UserCenterViewController

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
    self.title = @"个人中心";
    
    //返回按钮
    UIButton *leftnButton = [[UIButton alloc] initWithFrame:BACK_IMAGE_VFRAME];
    [leftnButton setImage:BACK_IMAGE forState:UIControlStateNormal];
    [leftnButton addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbi=[[UIBarButtonItem alloc] initWithCustomView:leftnButton];
    self.navigationItem.leftBarButtonItem = bbi;
    
    self.labelNameArr = @[@[@"头像",@"账号",@"实名信息"],@[@"更换手机",@"修改密码"]];
    //头像图标
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-40, 13, 40, 40)];
    _iconImageView.userInteractionEnabled = YES;
    _iconImageView.image = [UIImage imageNamed:@"accountIconDefault.png"];
    //账号label
    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-150, 13, 150, 30)];
    _accountLabel.text = @"15817297889";
    _accountLabel.textColor = UIColorFromRGB(0x999999);
    _accountLabel.textAlignment = NSTextAlignmentRight;
    _accountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:28.0];
    //更好手机label
    _changePhoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-150, 13, 150, 30)];
    _changePhoneNumLabel.text = @"15817297889";
    _changePhoneNumLabel.textColor = UIColorFromRGB(0x999999);
    _changePhoneNumLabel.textAlignment = NSTextAlignmentRight;
    _changePhoneNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:28.0];
    //实名信息完善与否视图
    _factNameView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-66, 20, 66, 19)];
    //_factNameView.backgroundColor = UIColorFromRGB(0xff9c31);
    _factNameView.textAlignment = NSTextAlignmentCenter;
    _factNameView.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0];
    [_factNameView jm_setCornerRadius:CGRectGetHeight(_factNameView.frame)/2 withBackgroundColor:UIColorFromRGB(0xff9c31)];
    _factNameView.text = @"未完善";
    _factNameView.textColor = UIColorFromRGB(0xffffff);
    //底部cell视图
    _buttonCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frame), 102)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 11, 0.5, 80)];
    line.backgroundColor = UIColorFromRGB(0xcccccc);
    line.center = CGPointMake(CGRectGetWidth(_frame)/2, line.center.y);
    [_buttonCellView addSubview:line];
    //左边关注老人按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 10, 160, 80);
    leftBtn.center = CGPointMake(CGRectGetWidth(_frame)/4, leftBtn.center.y);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
    leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
     [leftBtn setTitle:@"3" forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColorFromRGB(0xff9c31) forState:UIControlStateNormal];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
    [_buttonCellView addSubview:leftBtn];
    //左边关注老人文字
    UILabel *leftll = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(leftBtn.frame) - 30, CGRectGetWidth(leftBtn.frame), 30)];
    leftll.text = @"关注老人";
    leftll.textColor = UIColorFromRGB(0x666666);
    leftll.textAlignment = NSTextAlignmentCenter;
    leftll.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:22.0];
    [leftBtn addSubview:leftll];
    
    //右边邀请监护人按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = leftBtn.frame;
    rightBtn.center = CGPointMake(3*CGRectGetWidth(_frame)/4, rightBtn.center.y);
    
    [rightBtn setTitleColor:UIColorFromRGB(0xff9c31) forState:UIControlStateNormal];
    [rightBtn setTitle:@"1" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = leftBtn.titleLabel.font;
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
    [_buttonCellView addSubview:rightBtn];
    //右边邀请监护人文字
    UILabel *rightll = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(rightBtn.frame) - 30, CGRectGetWidth(rightBtn.frame), 30)];
    rightll.text = @"邀请监护人";
    rightll.textColor = UIColorFromRGB(0x666666);
    rightll.textAlignment = NSTextAlignmentCenter;
    rightll.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:22.0];
    [rightBtn addSubview:rightll];
    

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.backgroundColor = UIColorRGB(242, 242, 242);
    //    [self.tableView setSeparatorColor:UIColorRGB(235, 235, 235)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];

}

-(void)backbuttonclick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.section == 0 && indexPath.row == 0) {//头像cell高度
        height = 66.0;
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        //底部cell
        height = 102.0;
    }else {
        height = 51.0;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CALayer *lineLayer = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        lineLayer = [CALayer layer];
        [lineLayer setBackgroundColor:UIColorFromRGB(0xf0f0f0).CGColor];
        [cell.layer addSublayer:lineLayer];
        //    cell.preservesSuperviewLayoutMargins = NO;
        cell.separatorInset = UIEdgeInsetsZero;
        //    cell.layoutMargins = UIEdgeInsetsZero;
        cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:28.0];
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    CGFloat cellHeight = 0.0;
    if (2 != indexPath.section) {
        NSArray *arr = self.labelNameArr[indexPath.section];
        cell.textLabel.text = arr[indexPath.row];
        cellHeight = 51.0;
        if (0 == indexPath.section) {
            if (0 == indexPath.row) {
                cellHeight = 66.0;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell.contentView addSubview:_iconImageView];
            }else if (1 == indexPath.row) {
                [cell.contentView addSubview:_changePhoneNumLabel];
            }else if (2 == indexPath.row) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell.contentView addSubview:_factNameView];
            }
        }else if (1 == indexPath.section) {
            if (0 == indexPath.row) {
                [cell.contentView addSubview:_accountLabel];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else {
        cellHeight = 102.0;
        [cell.contentView addSubview:_buttonCellView];
    }
    
    lineLayer.frame = CGRectMake(0, cellHeight -0.5, ScreenWidth, 0.5);
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            
        }else if (1 == indexPath.row) {
            
        }else if (2 == indexPath.row) {
            ShiMingViewController *gegisterVC = [[ShiMingViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
            [self.navigationController pushViewController:gegisterVC animated:YES];
        }
    }else if (1 == indexPath.section) {
        UIViewController *vc = nil;
        if (0 == indexPath.row) {
            vc = [[ChangeIphoneViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        }else if (1 == indexPath.row) {
            vc = [[ChangePwdViewController alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight)];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
