//
//  GuardiansTableViewCell.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/9.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuardianModel.h"

@interface GuardiansTableViewCell : UITableViewCell

@property (nonatomic, weak) GuardianModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *personImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *sonLab;

@property (weak, nonatomic) IBOutlet UILabel *telNumberLab;





@end
