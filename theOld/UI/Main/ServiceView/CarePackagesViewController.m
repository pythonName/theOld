//
//  CarePackagesViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "CarePackagesViewController.h"
#import "ECListView.h"
#import "MainDataManager.h"
#import "CareOldManModel.h"
#import "CarePackageModel.h"
#import "CarePackagesTableViewCell.h"


@interface CarePackagesViewController ()<UITableViewDelegate,UITableViewDataSource> {
    CGFloat textLeading;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightTrailing;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;


@end

static NSString *identifier = @"cell";
@implementation CarePackagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照护套餐";
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
//    textLeading = [self loadTextHeightWithData:items];
//
//    // numeric list view
//    ECListView *listView = [[ECListView alloc] initWithFrame:CGRectMake(12, 67.0, ScreenWidth-24, 0.0)
//                                                   textItems:items
//                                                   listStyle:ListStyleNumbered];
//
//    // optional configuration
//    listView.indentation = 8.0;
//    listView.itemsSpacing = 10.0;
//    listView.textColor = [UIColor darkGrayColor];
//    listView.font = [UIFont systemFontOfSize:18.0];
////    [self.view addSubview:listView];
//
//    [self.mainScrollView addSubview:listView];
//     self.textHeight.constant = textLeading+25;
//
//    CGFloat jinDu = 100;
//    self.greenViewWidth.constant = jinDu+6;
//    self.leftLeading.constant = jinDu;
//    self.rightTrailing.constant = ScreenWidth-jinDu-38;
//    self.grayView.layer.cornerRadius = 3;
//     self.greenView.layer.cornerRadius = 3;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self loadData];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置contentSize
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, 200+textLeading);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载老人套餐数据
- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    [params setObject:model.ID_number forKey:@"ID_number"];
    [DataInterface carePackagesRequest:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if (model.code.integerValue == REQUEST_SUCCESS_CODE) {
            self.dataArray = [CarePackageModel covertToArrayWithDictArray:model.data];
            [self.tableView reloadData];
        }
        else{
            [self showInfoMsg:model.msg];
        }
        
    }];
}

//计算高度
-(CGFloat )loadTextHeightWithData:(NSArray*)dataArr {
    CGFloat height = 0;
    for (NSString *str in dataArr) {
       CGFloat hh = [AttributedStringAndImage heightForString:str andWidth:ScreenWidth-32];
        height = height+hh+24;
    }
    
    return height;
}

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarePackagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarePackageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return 122.5 + [self loadTextHeightWithData:@[model.content]];
}

- (float)textHeight:(NSString *)value width:(float)width{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}

#pragma mark - getter setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CarePackagesTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    }
    
    return _tableView;
}
 

@end
