//
//  PhysiologicalDataViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "PhysiologicalDataViewController.h"
#import "PhysiologicalDataTableViewCell.h"
#import "PhysiologicalDataTableViewHeader.h"
#import "NoNetDataView.h"
#import "DataInterface.h"
#import "UserManager.h"
#import "PhysiologyDataModel.h"
#import "MJRefresh.h"
#import "MainDataManager.h"

static NSString *headerIdent = @"PhysiologicalDataTableViewHeader";
static NSString *cellIdent = @"PhysiologicalDataTableViewCell";
@interface PhysiologicalDataViewController ()<UITableViewDataSource,UITableViewDelegate>  {
    NSArray *_titleArr;
}

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong)NoNetDataView *noDataView;
@property (nonatomic, strong) NSArray *keyArray;


@end

@implementation PhysiologicalDataViewController

-(NoNetDataView *)noDataView {
    if (!_noDataView) {
        _noDataView =  [NoNetDataView loadNoNetDataView];
//        _noDataView.hidden = YES;   //hidden属性失效了
        VFWeakSelf(self)
        _noDataView.reloadDataBlock = ^{
            [weakself loadDataMethod];
        };
    }
    return _noDataView;
}

-(NSMutableArray *)dataArr  {
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
   self.title = @"生理数据";
 
    _titleArr = @[
                  @{@"imageName":@"weight",@"title":@"体重"},
                  @{@"imageName":@"BodyTemperature",@"title":@"体温"},
                  @{@"imageName":@"HeartRate",@"title":@"心率"},
                  @{@"imageName":@"BloodPressure.png",@"title":@"血压"},
                  @{@"imageName":@"BloodSugar.png",@"title":@"血糖"},
                  @{@"imageName":@"BloodFat.png",@"title":@"血脂"}
                  ];
    _keyArray = @[@"weight",@"temperature",@"heart_rate",@"blood_pressure",@"blood_sugar",@"blood_fat"];
    
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"PhysiologicalDataTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self.mainTableView registerClass:[PhysiologicalDataTableViewHeader class] forHeaderFooterViewReuseIdentifier:headerIdent];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    VFWeakSelf(self)
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDataMethod];
    }];
    [self makeHeaderView];
    
    [self loadDataMethod];
}

#pragma mark 请求数据
-(void)loadDataMethod {
    
    NSDictionary *params = @{@"ID_number" : [MainDataManager sharedInstance].selectModel.ID_number};
    [DataInterface physiologicalDataRequest:params complication:^(CommonResponseModel *model, NSError *error) {
        [self.mainTableView.mj_header endRefreshing];
        [self.noDataView removeFromSuperview];
        if (error) {
            [self.view addSubview:self.noDataView];
            return ;
        }
        
        if (model.code.integerValue == REQUEST_SUCCESS_CODE) {
            NSArray *array = [model.data objectForKey:@"Physics"];
            if (array.count == 0) {
                [self.noDataView updateNoDataView];
                [self.view addSubview:self.noDataView];
            }
            else{
                self.dataArr = [PhysiologyDataModel covertToArrayWithDictArray:array];
                [self.mainTableView reloadData];
            }
            
        }
        else{
            [self.mainTableView.mj_header endRefreshing];
            [self showInfoMsg:model.msg];
        }
    }];
}

#pragma mark ------- tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataArr.count == 0) {
        self.noDataView.hidden = NO;
    }else{
        self.noDataView.hidden = YES;
    }
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhysiologicalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_noDataView removeFromSuperview];
    cell.imageV.image  = [UIImage imageNamed:_titleArr[indexPath.row][@"imageName"]];
    cell.titleLab.text  = _titleArr[indexPath.row][@"title"];
    PhysiologyDataModel *model = [self.dataArr objectAtIndex:indexPath.section];
    NSString *key = [_keyArray objectAtIndex:indexPath.row];
    cell.describeLab.text = [model valueForKey:key];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PhysiologicalDataTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdent];
    PhysiologyDataModel *model = [self.dataArr objectAtIndex:section];
    headerView.dateLabel.text = model.daytime;
    return headerView;
    
}

#pragma mark headerView
-(void)makeHeaderView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 190)];
    backView.backgroundColor = UIColorFromRGB(0x8DC21F);
    
    //图片
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-123)/2, 17, 123, 111)];
    imageV.image = [UIImage imageNamed:@"blueImage"];
    [backView addSubview:imageV];
    
    //分数
    UILabel *scoreLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 123, 111)];
    [imageV addSubview:scoreLab];
    scoreLab.textAlignment = NSTextAlignmentCenter;
    
    //l老人当天综合分值
    UILabel *currentScoreLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame)+12, ScreenWidth, 21)];
    [backView addSubview:currentScoreLab];
    currentScoreLab.textAlignment = NSTextAlignmentCenter;
    currentScoreLab.text = @"老人当天综合分值";
    currentScoreLab.textColor = [UIColor whiteColor];
    currentScoreLab.font = [UIFont systemFontOfSize:13];
    self.mainTableView.tableHeaderView = backView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
