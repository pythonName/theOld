//
//  CarePackagesViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "CarePackagesViewController.h"
#import "ECListView.h"
@interface CarePackagesViewController () {
    CGFloat textLeading;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightTrailing;

@end

@implementation CarePackagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照护套餐";
    NSArray *items = [NSArray arrayWithObjects:
                      @"This is the first list view item. ",
                      @"This is the second one that will trigger a line break.",
                      @"Code4App.com",
                      @"This is the first list view item. ",
                      @"This is the second one that will trigger a line break.",
                      @"Code4App.com",
                      @"This is the first list view item. ",
                      @"This is the second one that will trigger a line break.",
                      @"Code4App.com",
                      nil];
    textLeading = [self loadTextHeightWithData:items];
   
    // numeric list view
    ECListView *listView = [[ECListView alloc] initWithFrame:CGRectMake(12, 67.0, ScreenWidth-24, 0.0)
                                                   textItems:items
                                                   listStyle:ListStyleNumbered];
    
    // optional configuration
    listView.indentation = 8.0;
    listView.itemsSpacing = 10.0;
    listView.textColor = [UIColor darkGrayColor];
    listView.font = [UIFont systemFontOfSize:18.0];
//    [self.view addSubview:listView];
  
    [self.mainScrollView addSubview:listView];
     self.textHeight.constant = textLeading+25;
    
    CGFloat jinDu = 100;
    self.greenViewWidth.constant = jinDu+6;
    self.leftLeading.constant = jinDu;
    self.rightTrailing.constant = ScreenWidth-jinDu-38;
    self.grayView.layer.cornerRadius = 3;
     self.greenView.layer.cornerRadius = 3;
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置contentSize
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, 200+textLeading);
}

//计算高度
-(CGFloat )loadTextHeightWithData:(NSArray*)dataArr {
    CGFloat height = 0;
    for (NSString *str in dataArr) {
       CGFloat hh = [AttributedStringAndImage heightForString:str andWidth:ScreenWidth-24 fontSize:14];
        height = height+hh+24;
    }
    
    return height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
