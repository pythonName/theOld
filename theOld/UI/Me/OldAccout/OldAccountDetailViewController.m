//
//  OldAccountDetailViewController.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldAccountDetailViewController.h"
#import "OldAccountDetailTableViewCell.h"
#import "YKNetworkBaseModel.h"

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
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource  =self;
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"xx老人的账户";
//    NSArray *items = [NSArray arrayWithObjects:
//                      @"This is the first list view item. ",
//                      @"This is the second one that will trigger a line break.",
//                      @"Code4App.com",
//                      @"This is the first list view item. ",
//                      @"This is the second one that will trigger a line break.",
//                      @"Code4App.com",
//                      @"This is the first list view item. ",
//                      @"This is the second one that will trigger a line break.",
//                      @"Code4App.com",
//                      nil];
//    [self.dataArr addObject:items];
//    [self.dataArr addObject:items];
    self.mainTableView.backgroundColor = UIColorFromRGB(0xF5F8FC);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"OldAccountDetailTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    
    [self loadOldAccountDetailData];

}

-(void)loadOldAccountDetailData {
    TheOldAccountDetailRequestModel *model = [[TheOldAccountDetailRequestModel alloc] init];
    model.ID_number = self.ID_number;
    [[DataInterface shareInstance] theOldAccountDetailRequestWithModel:model toGetResult:^(TheOldAccountDetailResponseModel *result, NSError *error) {
        if (result.code == 200) {
            self.dataArr = [NSMutableArray arrayWithArray:result.data];
             [self.mainTableView reloadData];
        }
        else{
//            [];
        }
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OldAccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refreshUIWithData:self.dataArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *arr = self.dataArr[indexPath.row];
    OldAccountDataList *modelData = self.dataArr[indexPath.row];
    NSArray *arr = [modelData.content componentsSeparatedByString:@"\n"];

    return [self loadTextHeightWithData:arr]+110;
}

//计算高度/Users/zhanghuanhuan/Desktop/老人/我的 设计/我的-老人账户2.jpg
-(CGFloat )loadTextHeightWithData:(NSArray*)dataArr {
    CGFloat height = 0;
    for (NSString *str in dataArr) {
        CGFloat hh = [AttributedStringAndImage heightForString:str andWidth:ScreenWidth-24*ScreenHRatioBaseIphone6 fontSize:14];
        height = height+hh+6;
    }
    
    return height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
