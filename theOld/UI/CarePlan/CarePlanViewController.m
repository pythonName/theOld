

#import "CarePlanViewController.h"
#import "LeveyTabBarController.h"
#import "FyCalendarView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface CarePlanViewController (){
    CGRect _frame;
    UILabel *_redLab;
}
@property (strong, nonatomic) FyCalendarView *calendarView;
@property (nonatomic, strong) NSDate *date;
@end

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
    self.date = [NSDate date];
    [self setupCalendarView];
    
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

-(void)infoButtonClick {
    
}

- (void)setupCalendarView {
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.width - 20)];
    self.calendarView.backgroundColor = [UIColor whiteColor];
    //日期状态
    self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"5", @"8", @"9", @"17",  @"30", nil];
    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"12",@"15", @"19",nil];
    [self.view addSubview:self.calendarView];
        self.calendarView.isShowOnlyMonthDays = YES;
    self.calendarView.date = [NSDate date];
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
