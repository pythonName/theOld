//
//  MyAccountTableViewCell.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView *imagebackView;

@property(nonatomic, strong)UILabel *priceLab;

@property(nonatomic, strong)UILabel *nameLab;

@property(nonatomic, strong)UILabel *changeDateLab;

@property(nonatomic, strong)UILabel *effectiveDateLab;


-(void)refreshUIViewWith:(CouponListData*)dataModel;


@end
