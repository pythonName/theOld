//
//  ServiceListViewController.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ServiceListViewController.h"

@interface ServiceListViewController (){
    CGRect _frame;
}

@end

@implementation ServiceListViewController
- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:_frame];
    [self.view setBackgroundColor:UIColorRGB(241, 246, 252)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeUIView];
}

-(void)makeUIView {
    
    NSArray *titleArr = @[
                          @{@"image":@"carePackages.png",@"name":@"照护套餐",@"describe":@"服务进度50%"},
                          @{@"image":@"PhysiologicalData.png",@"name":@"生理数据",@"describe":@"人工测量"},
                          @{@"image":@"theRemoteSupervision.png",@"name":@"远程监护",@"describe":@"实时监控"},
                          @{@"image":@"guardians.png",@"name":@"监护人",@"describe":@"监护人"}
                          ];
    
    CGFloat width = 153* ScreenHRatioBaseIphone6;
    CGFloat height = 114 * ScreenHRatioBaseIphone6;
    for(int i=0 ;i<titleArr.count;i++) {
        NSDictionary *dic = titleArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30* ScreenHRatioBaseIphone6+(i%2)*(9+width), 37+i/2*(9+height), width, height);
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 10;
        
        //图片
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((width-39)/2, 18, 39, 38)];
        [btn addSubview:imageV];
        imageV.image = [UIImage imageNamed:dic[@"image"]];
        
        //名称
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame)+12, CGRectGetWidth(btn.frame), 17)];
        [btn addSubview:nameLab];
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.font = [UIFont systemFontOfSize:13];
        nameLab.text = dic[@"name"];
        
        //描述
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLab.frame)+7, CGRectGetWidth(btn.frame), 17)];
        [btn addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.text = dic[@"name"];
        lab.textColor = UIColorFromRGB(0x888888);
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
