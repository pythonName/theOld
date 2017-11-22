//
//  OldAccountDetailTableViewCell.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECListView.h"

@interface OldAccountDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLab;
//续费按钮
@property (weak, nonatomic) IBOutlet UIButton *renewalBtn;

@property (strong, nonatomic) ECListView *listView;

- (IBAction)renewalBtnClick:(id)sender;


-(void)refreshUIWithData:(id)data;

@end
