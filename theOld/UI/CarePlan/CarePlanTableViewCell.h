//
//  CarePlanTableViewCell.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/20.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarePlanModel.h"

@interface CarePlanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (nonatomic, weak) CarePlanModel *model;

@end
