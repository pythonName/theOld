

#import "CarePlanViewController.h"
#import "LeveyTabBarController.h"
#import "FyCalendarView.h"
#import "CarePlanTableViewCell.h"
#import "PhysiologicalDataTableViewHeader.h"
#import "UserManager.h"

static NSString *headerIdent = @"PhysiologicalDataTableViewHeader";
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

static NSString  *cellIdent = @"CarePlanTableViewCell";
@interface CarePlanViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CGRect _frame;
    UILabel *_redLab;
}
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *specialDateArr;

@property (strong, nonatomic) FyCalendarView *calendarView;
@property (nonatomic, strong) NSDate *date;


@end

@implementation CarePlanViewController
-(NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableArray*)specialDateArr {
    if (!_specialDateArr) {
        _specialDateArr = [NSMutableArray array];
    }
    return _specialDateArr;
}

-(UITableView*)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarView.frame), ScreenWidth, CGRectGetHeight(_frame)-CGRectGetMaxY(self.calendarView.frame)) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource  =self;
    }
    return _mainTableView;
}
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

- (void)viewDidLoad {
    [super viewDidLoad];
 //请求特殊日期
    [self requstDataMethod];
    //日历
    self.date = [NSDate date];
 
   
    
    //消息按钮
    //    infoImage
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame = CGRectMake(0, 0, 38, 30);
    [infoBtn setImage:[UIImage imageNamed:@"infoImage"] forState:UIControlStateNormal];
    [infoBtn setImage:[UIImage imageNamed:@"infoImage"] forState:UIControlStateHighlighted];
    [infoBtn addTarget:self action:@selector(infoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI=[[UIBarButtonItem alloc] initWithCustomView:infoBtn];
    self.navigationItem.rightBarButtonItem = rightBI;
    _redLab = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 18, 18)];
    [infoBtn addSubview:_redLab];
    //    _redLab.backgroundColor = [UIColor redColor];
    _redLab.textAlignment = NSTextAlignmentCenter;
    _redLab.textColor = [UIColor whiteColor];
    _redLab.font = [UIFont systemFontOfSize:10];
    _redLab.text = @"10";
    [_redLab jm_setCornerRadius:9 withBackgroundColor:[UIColor redColor]];
}

//请求特殊日期有哪些
-(void)requstDataMethod {
    TheCarePlanRequestModel *model = [[TheCarePlanRequestModel alloc] init];
    model.ID_number = @"350303199307132114";//[UserManager shareInstance].defaultSelectedOldID;
    [[DataInterface shareInstance] theCarePlanRequestWithModel:model toGetResult:^(TheCarePlanResponseModel *result, NSError *error) {
        for (DateModel *model in result.data) {
           NSArray *arr =  [model.date componentsSeparatedByString:@"-"];
            if (arr.count>2) {
                NSInteger day = [arr[2] integerValue];
                [self.specialDateArr addObject:[NSString stringWithFormat:@"%ld",day]];
            }
        }
        [self setupCalendarView];
        [self loadMainViewUI];
    }];
}

-(void) loadMainViewUI {
    //tableview
    [self.view addSubview:self.mainTableView];
    //    self.mainTableView.tableHeaderView = self.calendarView;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"CarePlanTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self.mainTableView registerClass:[PhysiologicalDataTableViewHeader class] forHeaderFooterViewReuseIdentifier:headerIdent];
    NSArray *dateArr = [[NSString stringWithFormat:@"%@",self.date] componentsSeparatedByString:@" "];
    
    if (dateArr.count>1) {
        [self requstWithDate:dateArr[0]];

    }
}

-(void)infoButtonClick {
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.nameLab.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    DateModel *model = self.dataArr[indexPath.row];
    cell.nameLab.text = model.content;
    cell.timeLab.text = [NSString stringWithFormat:@"%@ - %@",model.start_time,model.end_time];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PhysiologicalDataTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdent];
    
    headerView.dateLabel.text =@"点击日期查看当天服务项目";
    headerView.dateLabel.textColor = UIColorFromRGB(0x8dc21f);
    headerView.dateLabel.frame = CGRectMake(15, 0,ScreenWidth-30, 40);
    headerView.dateLabel.textAlignment = NSTextAlignmentCenter;
    return headerView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
//监听滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y>10) {
        //修改日历的布局  
        self.calendarView.frame =  CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.width/7+37);
        [self.calendarView refreshViewWhenContentYBig];
        
    }else{
        self.calendarView.frame =  CGRectMake(0, 0, self.view.frame.size.width ,self.view.frame.size.width - 20);
        [self.calendarView refreshViewWhenContentYSmall];
        
    }
    _mainTableView.frame =  CGRectMake(0, CGRectGetMaxY(self.calendarView.frame), ScreenWidth, CGRectGetHeight(_frame)-CGRectGetMaxY(self.calendarView.frame));
  
}

- (void)setupCalendarView {
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.width - 20)];
    self.calendarView.backgroundColor = [UIColor whiteColor];
    //日期状态
    self.calendarView.allDaysArr = self.specialDateArr;//[NSArray arrayWithObjects: @"5", @"8", @"9", @"17",  @"30", nil];
//    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"12",@"15", @"19",nil];
    [self.view addSubview:self.calendarView];
        self.calendarView.isShowOnlyMonthDays = YES;
    self.calendarView.date = [NSDate date];
    __weak typeof (self) weakSelf = self;
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
        NSString *monthStr = [NSString stringWithFormat:@"%ld",month];
        NSString *dayStr = [NSString stringWithFormat:@"%ld",day];

        if (monthStr.length==1) {
            monthStr = [NSString stringWithFormat:@"0%@",monthStr];
        }
        if (dayStr.length==1) {
            dayStr = [NSString stringWithFormat:@"0%@",dayStr];
        }
        [weakSelf requstWithDate: [NSString stringWithFormat:@"%ld-%@-%@",year,monthStr,dayStr]];
    };
     self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
}

//请求点击了某一个日期改动显示内容
-(void)requstWithDate:(NSString*)date {
    TheCarePlanRequestModel *model = [[TheCarePlanRequestModel alloc] init];
    model.ID_number = @"350303199307132114";//[UserManager shareInstance].defaultSelectedOldID;
    model.date =  @"2017-01-01";//date;
    [[DataInterface shareInstance] theCarePlanContentRequestWithModel:model toGetResult:^(TheCarePlanResponseModel *result, NSError *error) {
        if (result.code == 200) {
            self.dataArr = [NSMutableArray arrayWithArray: result.data];
            [self.mainTableView reloadData];

        }else{
            [self showInfoMsg:result.msg];
        }
        
    }];
}
//下一月
- (void)setupNextMonth {
    [self.calendarView removeFromSuperview];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    [self.view addSubview:self.calendarView];
    self.calendarView.allDaysArr = [NSArray arrayWithObjects:  @"17",  @"21", @"25",  @"30", nil];
    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"19",nil];
    self.date = [self.calendarView nextMonth:self.date];
    [self.calendarView createCalendarViewWith:self.date];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    
    WS(weakSelf)
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
}

//上一月
- (void)setupLastMonth {
    [self.calendarView removeFromSuperview];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    [self.view addSubview:self.calendarView];
    self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"3", @"13", @"23", @"30", nil];
    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"18", @"19",nil];
    self.date = [self.calendarView lastMonth:self.date];
    [self.calendarView createCalendarViewWith:self.date];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.leveyTabBarController.tabBarHidden) {
        [self.leveyTabBarController hideTabBar:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.leveyTabBarController showTabBar:YES];
}

@end


