//
//  AddOldManAlterView.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/17.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+NIB.h"
@interface AddOldManAlterView : UIView<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_mainTableView;
    NSArray *_dataArr;
}

@property (weak, nonatomic) IBOutlet UIButton *backView;

@property (weak, nonatomic) IBOutlet UIView *whiterView;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

+(AddOldManAlterView*)loadAddOldManAlterView;

- (IBAction)selectButtonClick:(id)sender;

@end
