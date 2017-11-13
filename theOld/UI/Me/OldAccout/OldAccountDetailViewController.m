//
//  OldAccountDetailViewController.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldAccountDetailViewController.h"
#import "OldAccountDetailTableViewCell.h"

static NSString *cellIdent = @"OldAccountDetailTableViewCell";
@interface OldAccountDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation OldAccountDetailViewController
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
   self.title = @"xx老人的账户";
    
    [self.dataArr addObject:@"1"];
    [self.dataArr addObject:@"1"];
    self.mainTableView.backgroundColor = UIColorFromRGB(0xF5F8FC);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"OldAccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OldAccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 188;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
