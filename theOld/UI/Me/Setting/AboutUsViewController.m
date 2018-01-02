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
    [self.versionLab jm_setCornerRadius:10.5 withBorderColor:UIColorFromRGB(0x888888) borderWidth:1];
//    self.versionLab.backgroundColor = [UIColor yellowColor];
    self.iconImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
//    self.iconImageV.backgroundColor = [UIColor redColor];
    self.versionLab.layer.cornerRadius = 10.5;
    self.versionLab.layer.masksToBounds = YES;
    self.versionLab.layer.borderWidth = 0.5;
    self.versionLab.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
    self.headerViewHeight.constant = 250*ScreenHRatioBaseIphone6;
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
      NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLab.text = [NSString stringWithFormat:@"V%@",app_Version];
    NSString *str = @"公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：公司简介：";
    self.descriptionLab.text = str;
      heigth = [AttributedStringAndImage heightForString:str andWidth:ScreenWidth-40 fontSize:14];
    
    self.descLabHeight.constant =heigth-70;
   
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, 250*ScreenHRatioBaseIphone6+40+heigth);
}


//-(void)viewDidLayoutSubviews
//{
//    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, 250*ScreenHRatioBaseIphone6+40+1000);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
