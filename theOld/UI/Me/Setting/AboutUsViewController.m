//
//  AboutUsViewController.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/14.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self.versionLab jm_setCornerRadius:10.5 withBorderColor:UIColorFromRGB(0x888888) borderWidth:1];
    
    self.iconImageV.image = [UIImage imageNamed:@"iconImage.png"];
    self.iconImageV.backgroundColor = [UIColor yellowColor];
    [self.iconImageV jm_setCornerRadius:10 withBorderColor:nil borderWidth:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
