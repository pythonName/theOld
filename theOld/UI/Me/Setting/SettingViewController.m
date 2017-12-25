//
//  SettingViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "AboutUsViewController.h"
#import "HelpCenterViewController.h"
#import "UserManager.h"
static NSString *tellStr =@"13691850416";
static NSString *cellIdent = @"SettingTableViewCell";
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    CGRect _frame;
}
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation SettingViewController

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

-(NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UITableView*)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame)) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource  =self;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    
    [self.dataArr addObject:@"关于我们"];
//    [self.dataArr addObject:@"意见反馈"];
    [self.dataArr addObject:@"帮助中心"];
    [self.dataArr addObject:@"客服热线"];

    

    self.mainTableView.backgroundColor = UIColorFromRGB(0xF5F8FC);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
//    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    [self initHeaderView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLab.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    if (self.dataArr.count-1 == indexPath.row) {
        cell.imageV.hidden = YES;
        cell.tellLab.hidden = NO;
        NSString *tellString = [NSString stringWithFormat:@"  %@",tellStr];
        NSMutableAttributedString *attributed = [AttributedStringAndImage initNSMutableAttributedString:tellString withFont1:12 withColor1:UIColorFromRGB(0x8DC21F) withRange1:NSMakeRange(0, tellString.length) withImage:@"tellImage" withImagePrefix:YES];
        cell.tellLab.attributedText = attributed;
//        tellImage
    }else{
        cell.imageV.hidden = NO;
        cell.tellLab.hidden = YES;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0){
        //关于我们
        AboutUsViewController *vv = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:vv animated:YES];
    }else if (indexPath.row == 1){
        //帮助中心
        HelpCenterViewController *vv = [[HelpCenterViewController alloc] initWithFrame:self.view.bounds withURLString:@"http://www.baidu.com"];
        [self.navigationController pushViewController:vv animated:YES];
        
    }else if (indexPath.row == 2) {
        //打电话
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13691850416"];
        // NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(void)initHeaderView {
    UIView *whiterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 270*ScreenHRatioBaseIphone6)];
    whiterView.backgroundColor = UIColorFromRGB(0xF5F8FC);
 
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake( 45*ScreenHRatioBaseIphone6, 200*ScreenHRatioBaseIphone6, ScreenWidth-90*ScreenHRatioBaseIphone6 ,40);
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0x8dc21f) forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(unloginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [whiterView addSubview:btn];
    btn.layer.cornerRadius = 20;
    [btn jm_setCornerRadius:20 withBorderColor:UIColorFromRGB(0x8dc21f) borderWidth:0.5];
    
    self.mainTableView.tableFooterView = whiterView;
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 6)];
    headerV.backgroundColor = UIColorFromRGB(0xF5F8FC);
    self.mainTableView.tableHeaderView = headerV;
}

//退出登录
-(void)unloginButtonClick {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出后不会删除历史数据" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
 
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        NSLog(@"点击了确定按钮");
        
        [UserManager shareInstance].isLogined = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isLogined"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[Toast makeText:@"您已退出登录"] show];
        [self.navigationController popViewControllerAnimated:YES];
        
//        [[DataInterface shareInstance] logoutRequest:nil complication:^(NSDictionary *resultDic) {
//            if([resultDic[@"code"] integerValue] == 200) {
//                [UserManager shareInstance].isLogined = NO;
//                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isLogined"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                [[Toast makeText:@"您已退出登录"] show];
//            }else{
//                [[Toast makeText:@"请检查您的网络"] show];
//
//            }
//        }];
    
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
 
    [self presentViewController:alertController animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
