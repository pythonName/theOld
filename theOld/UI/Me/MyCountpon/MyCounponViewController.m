//
//  MyCounponViewController.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MyCounponViewController.h"
#import "MyAccountTableViewCell.h"

static NSString *cellIdent = @"MyAccountTableViewCell";
@interface MyCounponViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGRect _frame;
    UITextField *_textFiledView;
}

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation MyCounponViewController

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
    
    [self initHeaderView];
    [self.dataArr addObject:@"1"];
    [self.dataArr addObject:@"1"];
    self.mainTableView.backgroundColor = UIColorFromRGB(0xF5F8FC);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerClass:[MyAccountTableViewCell class] forCellReuseIdentifier:cellIdent];
     
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)initHeaderView {
    UIView *whiterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110+15)];
    whiterView.backgroundColor = [UIColor whiteColor];
   
    
    _textFiledView = [[UITextField alloc] initWithFrame:CGRectMake(20, (110-40*ScreenHRatioBaseIphone6)/2, 231*ScreenHRatioBaseIphone6,40*ScreenHRatioBaseIphone6 )];
    [whiterView addSubview:_textFiledView];
    _textFiledView.borderStyle = UITextBorderStyleLine;
    _textFiledView.layer.borderWidth = 0.5;
    _textFiledView.layer.borderColor = [UIColor lightTextColor].CGColor;
    _textFiledView.placeholder = @"请输入优惠码";
    _textFiledView.font = [UIFont systemFontOfSize:13];
    //缩进
    UIView *leftViewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    leftViewUser.backgroundColor = [UIColor clearColor];
    _textFiledView.leftView = leftViewUser;
    _textFiledView.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMaxX(_textFiledView.frame)-1, (110-40*ScreenHRatioBaseIphone6)/2, 110*ScreenHRatioBaseIphone6,CGRectGetHeight(_textFiledView.frame));
    [btn setTitle:@"兑换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = UIColorFromRGB(0x8dc21f);
    [btn addTarget:self action:@selector(exchangeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [whiterView addSubview:btn];
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(whiterView.frame)-15, CGRectGetWidth(whiterView.frame), 15)];
    vv.backgroundColor =UIColorFromRGB(0xF5F8FC);
    [whiterView addSubview:vv];
     self.mainTableView.tableHeaderView = whiterView;
}

-(void)exchangeButtonClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
