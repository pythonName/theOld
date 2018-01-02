//
//  MyAccountTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MyAccountTableViewCell.h"
//#import "UIImagev"
@implementation MyAccountTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI {
    
   self.backgroundColor = UIColorFromRGB(0xF5F8FC);
    //背景图片
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(18*ScreenHRatioBaseIphone6, 7, ScreenWidth-30*ScreenHRatioBaseIphone6, 100*ScreenHRatioBaseIphone6)];
    [self.contentView addSubview:imageV];
    self.imagebackView = imageV;
    //价格lab
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, CGRectGetHeight(imageV.frame), CGRectGetHeight(imageV.frame))];
    [imageV addSubview:self.priceLab];
    self.priceLab.textAlignment = NSTextAlignmentCenter;
    self.priceLab.textColor = [UIColor whiteColor];
    
    //现金券
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(100*ScreenHRatioBaseIphone6 +15, 15, CGRectGetWidth(imageV.frame), 25)];
    [imageV addSubview:self.nameLab];
    self.nameLab.font = [UIFont systemFontOfSize:15];
    
    //兑换日期
    self.changeDateLab = [[UILabel alloc] initWithFrame:CGRectMake(100*ScreenHRatioBaseIphone6 +15, CGRectGetHeight(imageV.frame)/2-4, CGRectGetWidth(imageV.frame), 20)];
    [imageV addSubview:self.changeDateLab];
    
    self.changeDateLab.textColor = UIColorFromRGB(0x666666);
    self.changeDateLab.font = [UIFont systemFontOfSize:11];
    //有效日期
    self.effectiveDateLab = [[UILabel alloc] initWithFrame:CGRectMake(100*ScreenHRatioBaseIphone6 +15,  CGRectGetHeight(imageV.frame)/2+17, CGRectGetWidth(imageV.frame), 20)];
    [imageV addSubview:self.effectiveDateLab];
 
    self.effectiveDateLab.textColor = UIColorFromRGB(0x666666);
    self.effectiveDateLab.font = [UIFont systemFontOfSize:11];
}

-(void)refreshUIViewWith:(CouponListData*)dataModel {
    
    self.nameLab.text = dataModel.type;//@"现金券";
    self.priceLab.text = [NSString stringWithFormat:@"%ld",dataModel.price];
    if(dataModel.available == 1){
        //未使用
        self.imagebackView.image= [UIImage imageNamed:@"counponImageNo.png"];

    }else{
        self.imagebackView.image= [UIImage imageNamed:@"counponImageUse.png"];
    }

    self.effectiveDateLab.text = [NSString stringWithFormat:@"有效日期:%@",dataModel.start_time]; //@"有效日期：2099-09-09";
    self.changeDateLab.text = [NSString stringWithFormat:@"兑换日期:%@",dataModel.end_time];//@"兑换日期：2099-09-09";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
