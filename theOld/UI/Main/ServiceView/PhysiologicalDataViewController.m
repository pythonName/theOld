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

static NSString *headerIdent = @"PhysiologicalDataTableViewHeader";
static NSString *cellIdent = @"PhysiologicalDataTableViewCell";
@interface PhysiologicalDataViewController ()<UITableViewDataSource,UITableViewDelegate>  {
    NSArray *_titleArr;
}

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation PhysiologicalDataViewController

-(NSMutableArray *)dataArr  {
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"生理数据";
    
    [self.dataArr addObject:@"dd"];
    [self.dataArr addObject:@"dd"];
    
    _titleArr = @[
                  @{@"imageName":@"weight",@"title":@"体重"},
                  @{@"imageName":@"BodyTemperature",@"title":@"体温"},
                  @{@"imageName":@"HeartRate",@"title":@"心率"},
                  @{@"imageName":@"BloodPressure.png",@"title":@"血压"},
                  @{@"imageName":@"BloodSugar.png",@"title":@"血糖"},
                  @{@"imageName":@"BloodFat.png",@"title":@"血脂"} 
                  ];
    
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"PhysiologicalDataTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self.mainTableView registerClass:[PhysiologicalDataTableViewHeader class] forHeaderFooterViewReuseIdentifier:headerIdent];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return _titleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   PhysiologicalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageV.image  = [UIImage imageNamed:_titleArr[indexPath.row][@"imageName"]];
    cell.titleLab.text  = _titleArr[indexPath.row][@"title"];
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
    
    headerView.dateLabel.text = @"nihao";
    return headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
