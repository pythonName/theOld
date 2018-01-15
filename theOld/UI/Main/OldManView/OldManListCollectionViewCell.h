//
//  OldManListCollectionViewCell.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CareOldManModel.h"

@interface OldManListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *personImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic, weak) CareOldManModel *model;

//@property (nonatomic , strong) 


@end
