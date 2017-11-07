

#import "CarePlanViewController.h"
#import "LeveyTabBarController.h"


@interface CarePlanViewController (){
    CGRect _frame;

}

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
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    if (!self.leveyTabBarController.tabBarHidden) {
//        [self.leveyTabBarController hideTabBar:YES];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.leveyTabBarController showTabBar:YES];
}

@end
