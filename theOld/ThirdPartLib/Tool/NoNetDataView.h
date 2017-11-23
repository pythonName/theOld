//
//  NoNetDataView.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/21.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoNetDataView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;

+ (NoNetDataView *)loadNoNetDataView;

+ (NoNetDataView *)loadNoDataViewWithSuccess;
@end
