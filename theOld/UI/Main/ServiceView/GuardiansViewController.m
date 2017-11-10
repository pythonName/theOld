//
//  GuardiansViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "GuardiansViewController.h"
#import "GuardiansTableViewCell.h"


static NSString *cellIdent = @"GuardiansTableViewCell";
@interface GuardiansViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation GuardiansViewController

-(NSMutableArray *)dataArr  {
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"监护人";
    
    [self.dataArr addObject:@"dd"];
    [self.dataArr addObject:@"dd"];

    [self.mainTableView registerNib:[UINib nibWithNibName:@"GuardiansTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuardiansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
