//
//  OldManResourseViewController.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/14.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldManResourseViewController.h"
#import "OldManResourseTableViewCell.h"
#import "PhysiologicalDataTableViewHeader.h"
#import "HeaderOfMainView.h"

static NSString *headerIdent = @"PhysiologicalDataTableViewHeader";

static NSString *cellIdent = @"OldManResourseTableViewCell";
@interface OldManResourseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_sectionTitleArr;
    NSArray *_titleArr;
    HeaderOfMainView *_headerOfMainView;
}

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;


@end

@implementation OldManResourseViewController

-(NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UITableView*)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource  =self;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"老人资料卡";
    _sectionTitleArr = @[@"联系方式",@"居住地"];
    _titleArr = @[@[@"家庭固话",@"移动电话"],
                  @[@"家庭区位",@"家庭住址"]];
    
    [self.dataArr addObject:@"联系方式"];
    [self.dataArr addObject:@"居住地"];
    
    self.mainTableView.backgroundColor = UIColorFromRGB(0xF5F8FC);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"OldManResourseTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self.mainTableView registerClass:[PhysiologicalDataTableViewHeader class] forHeaderFooterViewReuseIdentifier:headerIdent];
    
//    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    
    //头部信息
    _headerOfMainView = [HeaderOfMainView loadHeaderOfMainView];
    _headerOfMainView.frame = CGRectMake(0, 0, ScreenWidth, 150);
    _headerOfMainView.resouseButton.hidden = YES;
    self.mainTableView.tableHeaderView = _headerOfMainView;
}

#pragma mark  tableView  delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionTitleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArr[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OldManResourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 1){
        cell.tellImageV.hidden = YES;
    }else{
         cell.tellImageV.hidden = NO;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PhysiologicalDataTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdent];
    
    headerView.dateLabel.text = [NSString stringWithFormat:@"%@",_sectionTitleArr[section]];
    headerView.dateLabel.textColor = UIColorFromRGB(0x8dc21f);
//    headerView.backgroundColor = UIColorFromRGB(0x)
    return headerView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
