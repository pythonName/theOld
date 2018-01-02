//
//  OldAccountViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldAccountViewController.h"
#import "OldAccountTableViewCell.h"
#import "OldAccountDetailViewController.h"
#import "UserManager.h"
#import "UIImageView+WebCache.h"
#import "CareOldManModel.h"
static NSString *cellIdent = @"OldAccountTableViewCell";
@interface OldAccountViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGRect _frame;
}

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation OldAccountViewController

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
    self.title = @"老人账户";
//    [self.dataArr addObject:@"1"];
//    [self.dataArr addObject:@"1"];
    [self loadOldManAccountList];
    self.mainTableView.backgroundColor = UIColorFromRGB(0xF5F8FC);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"OldAccountTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
}

-(void)loadOldManAccountList  {
   
        [DataInterface careOldManListRequest:nil result:^(CommonResponseModel *model, NSError *error) {
//            [self.collectionView.mj_header endRefreshing];
            if (error) {
                [self showNetworkError];
                return ;
            }
            
            if ([model.code integerValue] == 200) {
 
                self.dataArr = [CareOldManModel covertToArrayWithDictArray:model.data[@"focus_list"]];
                [self.mainTableView reloadData];
            }
            
        }];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OldAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CareOldManModel *dataModel =self.dataArr[indexPath.row];
    [cell.iconImageV sd_setImageWithURL:[NSURL URLWithString:dataModel.photo] placeholderImage:[UIImage imageNamed:@"accountIconDefault.png"]];
cell.nameLab.text = dataModel.name;

    cell.ageLab.text = [NSString stringWithFormat:@"%@ %ld",dataModel.sex,(long)dataModel.age];
//    cell.s
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OldAccountDetailViewController *vv = [[OldAccountDetailViewController alloc] init];
    CareOldManModel *dataModel =self.dataArr[indexPath.row];
    vv.ID_number = dataModel.ID_number;
    [self.navigationController pushViewController:vv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
@end
