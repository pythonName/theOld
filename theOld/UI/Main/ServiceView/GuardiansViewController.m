//
//  GuardiansViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "GuardiansViewController.h"
#import "GuardiansTableViewCell.h"
#import "GuardianModel.h"
#import "NoNetDataView.h"
#import "MainDataManager.h"
#import "CareOldManModel.h"


static NSString *cellIdent = @"GuardiansTableViewCell";
@interface GuardiansViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong) NoNetDataView *noNetDataView;

@end

@implementation GuardiansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"监护人";
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"GuardiansTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.noNetDataView];
    [self.noNetDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuardiansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


#pragma mark - LoadData
- (void)loadData{
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    if (!model.ID_number.length > 0) {
        return;
    }
    NSDictionary *params = @{@"ID_number" : model.ID_number};
    [DataInterface guardianListRequest:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if (REQUEST_SUCCESS_CODE == model.code.integerValue) {
            if ([(NSArray *)model.data count] == 0) {
                self.noNetDataView.hidden = NO;
            }else{
                self.noNetDataView.hidden = YES;
                self.dataArr = [GuardianModel covertToArrayWithDictArray:model.data];
                [self.mainTableView reloadData];
            }
            
        }
        else{
            self.noNetDataView.hidden = NO;
        }
    }];
}

#pragma mark - getter setter
-(NSMutableArray *)dataArr  {
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}

- (NoNetDataView *)noNetDataView{
    if (!_noNetDataView) {
        _noNetDataView = [[NoNetDataView alloc] init];
        _noNetDataView.hidden = YES;
    }
    
    return _noNetDataView;
}

@end
