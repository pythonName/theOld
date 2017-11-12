//
//  MainViewController.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTurningView.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) PageTurningView *scrollComponent;

@property (nonatomic, assign) NSInteger pageIndex;

- (id)initWithFrame:(CGRect)frame;


@end
