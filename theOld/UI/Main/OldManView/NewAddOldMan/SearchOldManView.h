//
//  SearchOldManView.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchOldManView : UIView

@property (weak, nonatomic) IBOutlet UITextField *identTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;



+ (SearchOldManView *)loadSearchOldManView;

@end
