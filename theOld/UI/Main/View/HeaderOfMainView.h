//
//  HeaderOfMainView.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderOfMainView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageV;

@property (weak, nonatomic) IBOutlet UIButton *resouseButton;

- (IBAction)resouseButtonClick:(id)sender;

+ (HeaderOfMainView *)loadHeaderOfMainView;

@end
