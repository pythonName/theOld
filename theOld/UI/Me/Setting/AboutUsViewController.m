//
//  AboutUsViewController.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/14.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController (){
    CGFloat heigth;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
//     [ jm_setCornerRadius:10 withBorderColor:[UIColor whiteColor] borderWidth:0.1];
    self.iconImageV.layer.cornerRadius = 10;
    self.iconImageV.layer.masksToBounds = YES;
    self.iconImageV.image = [UIImage imageNamed:@"about"];
    
    [self.versionLab jm_setCornerRadius:10.5 withBorderColor:UIColorFromRGB(0x888888) borderWidth:1];
    self.versionLab.layer.cornerRadius = 10.5;
    self.versionLab.layer.masksToBounds = YES;
    self.versionLab.layer.borderWidth = 0.5;
    self.versionLab.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
      NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLab.text = [NSString stringWithFormat:@"V%@",app_Version];
    
    
    NSString *str = @"维维网(appvv.com)是目前国内热门的苹果用户交流平台，我们致力于为网友们提供苹果及整个通信科技行业即时新闻讯息、优质iPhone、iPad资源，更在CDMA技术与用户群方面都处于国际领先地位！截止至今维维网整站每天访问用户超过40万PV，整站用户数量已超过20万！目前在APP应用资源数量上更是领先整个行业！\n在这里你可以第一时间看到最烫手的行业新闻讯息；\n在这里你可以分享你心仪已久的iPhone、iPad游戏和软件；\n在这里你可以了解到维维网自主研发的核心技术，从菜鸟磨练成为达人，刷机、写号都不在话下；\n在这里还有网友分享的海量的铃声、壁纸和影视资源。";
    self.descriptionLab.text = str;
//      heigth = [AttributedStringAndImage heightForString:str andWidth:ScreenWidth-40 fontSize:14];
//
//    self.descLabHeight.constant =heigth-70;
   
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, 250*ScreenHRatioBaseIphone6+40+heigth);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
