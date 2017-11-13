//
//  UserCenterTableViewCell.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/10.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, strong)UIImageView *iconImageView;

@property (nonatomic, strong)UILabel *accountLabel;

@property (nonatomic, strong)UIImageView *gotoImageView;

@property (nonatomic, strong)UILabel *factNameView;

-(void)refreshCellViewWithData:(id)data indexPath:(NSIndexPath*)indexPath;

@end
