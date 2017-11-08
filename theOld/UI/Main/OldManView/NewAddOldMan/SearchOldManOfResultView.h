//
//  SearchOldManOfResultView.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchOldManOfResultView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *personImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;


@property (weak, nonatomic) IBOutlet UILabel *ageLab;

@property (weak, nonatomic) IBOutlet UILabel *sexLba;

@property (weak, nonatomic) IBOutlet UILabel *identLab;

@property (weak, nonatomic) IBOutlet UIButton *addAttentionBtn;

- (IBAction)addAttentionBtnClick:(id)sender;

+ (SearchOldManOfResultView *)loadSearchOldManOfResultView;

@end
