//
//  CarePackagesViewController.h
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarePackagesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenViewWidth;

@property (weak, nonatomic) IBOutlet UIView *grayView;

@property (weak, nonatomic) IBOutlet UILabel *startLab;

@property (weak, nonatomic) IBOutlet UILabel *endLab;

@end
