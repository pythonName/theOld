//
//  NoNetDataView.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/21.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadDataBlock)(void);

@interface NoNetDataView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;

@property (nonatomic, copy) ReloadDataBlock reloadDataBlock;

+ (NoNetDataView *)loadNoNetDataView;

+ (NoNetDataView *)loadNoDataViewWithSuccess;

-(void)updateNoDataView;

@end
