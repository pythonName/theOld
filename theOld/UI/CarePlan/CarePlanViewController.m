

#import "CarePlanViewController.h"
#import "LeveyTabBarController.h"
//#import "FyCalendarView.h"
#import "CarePlanTableViewCell.h"
#import "PhysiologicalDataTableViewHeader.h"
#import "UserManager.h"

#import "JTCalendar.h"
#import "LXTCalenderView.h"
#import "LXTWeekMenuView.h"
#import "CarePlanModel.h"
#import "DateUtil.h"
#import "MainDataManager.h"
#import "CareOldManModel.h"

static NSString *headerIdent = @"PhysiologicalDataTableViewHeader";
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

static NSString  *cellIdent = @"CarePlanTableViewCell";
static NSString *calendarCell = @"calendarCell";
@interface CarePlanViewController ()<UITableViewDelegate,UITableViewDataSource,JTCalendarDelegate>{
    CGRect _frame;
    UILabel *_redLab;
}
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableSet *specialDateArr;

@property (nonatomic, strong) JTCalendarManager *calendarManager;
@property (nonatomic, strong) JTCalendarMenuView *menuView;
@property (nonatomic, strong) JTHorizontalCalendarView *calendarView;
@property (nonatomic, strong) LXTCalenderView *lxtCalendarView;

@property (nonatomic, strong) JTCalendarManager *weekManager;
@property (nonatomic, strong) JTHorizontalCalendarView *weekView;
@property (nonatomic, strong) LXTCalenderView *lxtWeekView;
@property (nonatomic, strong) NSDate *dateSelected;
@property (nonatomic) CGFloat showHiddenViewY;
@property (nonatomic, strong) NSArray *planArray;

//@property (strong, nonatomic) FyCalendarView *calendarView;
@property (nonatomic, strong) NSDate *date;


@end

static CGFloat lineH = 40;
@implementation CarePlanViewController

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
    
    self.title = @"照护计划";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
 //请求特殊日期
    [self requstDataMethod];
    //日历
    self.date = [NSDate date];
    
    [self loadMainViewUI];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataWithMoth) name:SELECT_OLDMAN_NOTIFICATION object:nil];
    
    if ([MainDataManager sharedInstance].selectModel) {
        [self loadDataWithMoth];
    }
   
    /*
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
     */
}

-(void) loadMainViewUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    //CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    CGFloat topMargin = 0 ; //statusFrame.size.height + 44;
    
    
    [self.view addSubview:self.mainTableView];
    self.calendarManager.delegate = self;
    _calendarView = self.lxtCalendarView.calendarView;
    [self.calendarManager setContentView:self.lxtCalendarView.calendarView];
    _dateSelected = [NSDate date];
    [self.calendarManager setDate:_dateSelected];
    [self updateShowHiddenVieY];    //更新展示一周日历的contentY
    
    
    self.weekManager.delegate = self;
    self.weekView = self.lxtWeekView.calendarView;
    [self.weekManager setContentView:self.lxtWeekView.calendarView];
    [self.weekManager setDate:_dateSelected];
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(topMargin, 0, 0, 0 ));
    }];
    
    [self.view addSubview:self.lxtWeekView];
    [self.lxtWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(topMargin);
        make.height.mas_equalTo(lineH * 2);
    }];
    
    
    
    LXTWeekMenuView *view = [[LXTWeekMenuView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(topMargin);
        make.height.mas_equalTo(lineH);
    }];

    //    self.mainTableView.tableHeaderView = self.calendarView;
    //    self.mainTableView.tableFooterView = [[UIView alloc] init];
    
    //    [self.mainTableView registerClass:[PhysiologicalDataTableViewHeader class] forHeaderFooterViewReuseIdentifier:headerIdent];
    //    NSArray *dateArr = [[NSString stringWithFormat:@"%@",self.date] componentsSeparatedByString:@" "];
    
    //    if (dateArr.count>1) {
    //        [self requstWithDate:dateArr[0]];
    //
    //    }
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


#pragma mark - UserAction
//请求特殊日期有哪些
-(void)requstDataMethod {
    TheCarePlanRequestModel *model = [[TheCarePlanRequestModel alloc] init];
    model.ID_number = @"350303199307132114";//[UserManager shareInstance].defaultSelectedOldID;
    [[DataInterface shareInstance] theCarePlanRequestWithModel:model toGetResult:^(TheCarePlanResponseModel *result, NSError *error) {
        for (DateModel *model in result.data) {
            
//           NSArray *arr =  [model.date componentsSeparatedByString:@"-"];
//            if (arr.count>2) {
//                NSInteger day = [arr[2] integerValue];
//                [self.specialDateArr addObject:[NSString stringWithFormat:@"%ld",day]];
//            }
        }
//        [self setupCalendarView];
//        [self loadMainViewUI];
    }];
}

- (void)loadDataWithMoth{
    VFWeakSelf(self)
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    if (!model) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:model.ID_number forKey:@"ID_number"];
    NSInteger month = [[DateUtil sharedInstance] mothFromDate:_dateSelected];
    NSInteger year = [[DateUtil sharedInstance] yearFromDate:_dateSelected];
    [params setObject:[NSString stringWithFormat:@"%ld", month] forKey:@"month"];
    [params setObject:[NSString stringWithFormat:@"%ld", year] forKey:@"year"];
    
    [DataInterface carePlanRequestWithMoth:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [weakself showNetworkError];
            return ;
        }
        
        if (model.code.integerValue == REQUEST_SUCCESS_CODE) {
            NSArray *array = [CarePlanModel covertToArrayWithDictArray:model.data];
            for (CarePlanModel *model in array) {
                [weakself.specialDateArr addObject:model.date];
            }
            [weakself.calendarManager reload];
            [weakself.weekManager reload];
        }
        else{
            [weakself showInfoMsg:model.msg];
        }
    }];
}

- (void)loadDataWithDate{
    VFWeakSelf(self)
    CareOldManModel *model = [MainDataManager sharedInstance].selectModel;
    if (!model) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:model.ID_number forKey:@"ID_number"];
    static NSString *formatter = @"yyyy-MM-dd";
    NSString *dateStr = [[DateUtil sharedInstance] stringFromDate:_dateSelected formatter:formatter];
    [params setObject:dateStr forKey:@"date"];
    
    [DataInterface carePlanRequestWithDate:params result:^(CommonResponseModel *model, NSError *error) {
        if (error) {
            [self showNetworkError];
            return ;
        }
        
        if (model.code.integerValue == REQUEST_SUCCESS_CODE) {
            weakself.planArray = [CarePlanModel covertToArrayWithDictArray:model.data];
            [weakself.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
        else{
            [self showInfoMsg:model.msg];
        }
    }];
}

-(void)infoButtonClick {
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.planArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:calendarCell];
        if (cell.contentView.subviews.count == 0) {
            [cell.contentView addSubview:self.lxtCalendarView];
            [self.lxtCalendarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
        }
        return cell;
    }
    CarePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CarePlanModel *model = [self.planArray objectAtIndex:indexPath.row];
    cell.model = model;

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return lineH * 7;
    }
    return 66;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    PhysiologicalDataTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdent];
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text =@"点击日期查看当天服务项目";
    infoLabel.textColor = UIColorFromRGB(0x8dc21f);
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont fontWithName:PingFang_SC_Medium size:12.0];
    [headerView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
    }];
    return headerView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
//监听滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /*
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
  */
    
    if (scrollView.contentOffset.y > _showHiddenViewY) {
        self.lxtWeekView.hidden = NO;
    }
    else{
        self.lxtWeekView.hidden = YES;
    }
}


#pragma mark - JTCalendarDelegate
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(UIView<JTCalendarDay> *)dayView{
    JTCalendarDayView *tmp = (JTCalendarDayView *)dayView;
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        tmp.circleView.hidden = NO;
        tmp.circleView.backgroundColor = UIColorFromRGB(0xff7b1f);
        tmp.dotView.backgroundColor = [UIColor whiteColor];
        tmp.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        tmp.circleView.hidden = NO;
        tmp.circleView.backgroundColor = UIColorFromRGB(0xa76cff);
        tmp.dotView.backgroundColor = [UIColor whiteColor];
        tmp.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:dayView.date]){
        tmp.circleView.hidden = YES;
        tmp.dotView.backgroundColor = [UIColor redColor];
        tmp.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        static NSString *formatter = @"yyyy-MM-dd";
        NSString *dateStr = [[DateUtil sharedInstance] stringFromDate:dayView.date formatter:formatter];
        if ([self.specialDateArr containsObject:dateStr]) {
            tmp.circleView.hidden = NO;
            tmp.circleView.backgroundColor = UIColorFromRGB(0xa76cff);
            tmp.dotView.backgroundColor = [UIColor whiteColor];
            tmp.textLabel.textColor = [UIColor whiteColor];
        }
        else{
            tmp.circleView.hidden = YES;
            tmp.dotView.backgroundColor = [UIColor redColor];
            tmp.textLabel.textColor = [UIColor blackColor];
        }
    }
    
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if ([calendar isEqual:self.weekManager]) {
        return;
    }
    if(![_calendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:dayView.date]){
        return;
    }
    _dateSelected = dayView.date;
    
    [self updateShowHiddenVieY];
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                        [_weekManager setDate:_dateSelected];
                    } completion:nil];
    
    //查询选中日期的照护数据
    [self loadDataWithDate];
}

- (void)updateShowHiddenVieY{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginDate = nil;
    double interval = 0;
    [calendar setFirstWeekday:2];
    NSDateComponents *coms = nil;
    NSInteger calendarFlag = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    BOOL result = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:_dateSelected];
    if (result) {
        coms = [calendar components:calendarFlag fromDate:beginDate];
        NSInteger weekday = [coms weekday] - 1;
        NSDateComponents *comps = [calendar components:calendarFlag fromDate:_dateSelected];
        NSInteger day = [comps day];
        float line = ceil((day - (7 - weekday) ) / 7.0) + 1;
        self.showHiddenViewY = lineH * (line - 1);
    }
}


#pragma mark - getter setter
-(NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableSet *)specialDateArr {
    if (!_specialDateArr) {
        _specialDateArr = [NSMutableSet set];
    }
    return _specialDateArr;
}

-(UITableView*)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource  =self;
        [_mainTableView registerNib:[UINib nibWithNibName:cellIdent bundle:nil] forCellReuseIdentifier:cellIdent];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:calendarCell];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


- (JTCalendarManager *)calendarManager{
    if (!_calendarManager) {
        _calendarManager = [JTCalendarManager new];
    }
    return _calendarManager;
}


- (JTCalendarManager *)weekManager{
    if (!_weekManager) {
        _weekManager = [JTCalendarManager new];
        _weekManager.settings.weekModeEnabled = YES;
    }
    return _weekManager;
}


- (LXTCalenderView *)lxtCalendarView{
    if (!_lxtCalendarView) {
        _lxtCalendarView = [[LXTCalenderView alloc] init];
    }
    
    return _lxtCalendarView;
}

- (LXTCalenderView *)lxtWeekView{
    if (!_lxtWeekView) {
        _lxtWeekView = [[LXTCalenderView alloc] init];
        _lxtWeekView.hidden = YES;
    }
    
    return _lxtWeekView;
}

/*
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
*/


@end


