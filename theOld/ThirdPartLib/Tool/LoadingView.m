//
//  LoadingView.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/21.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "LoadingView.h"


static LoadingView *loadView;

@implementation LoadingView

+ (LoadingView*)showCirleInView:(UIView *)view
{
    
   LoadingView *loadView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetWidth(view.frame))];
//    loadView.backgroundColor = [UIColor whiteColor];
    loadView.center = view.center;
    [view addSubview:loadView];
    return loadView;
}

+ (void)showCirleView
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    loadView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //    loadView.backgroundColor = [UIColor whiteColor];
  
    loadView.center = view.center;
    [view addSubview:loadView];
}

+(void)hideLoadingView {
    if (loadView) {
        [loadView removeFromSuperview];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self creatAnimation];
        [self loadTextView];
    }
    return self;
}

-(void)loadTextView {
    //文字
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y, self.frame.size.width, 20)];
    //                    [self addSubview:textLab];
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.text = @"加载中...";
    textLab.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    [self addSubview:textLab];
}

- (void)creatAnimation

{
    //这个是点点的背景
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds          = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius    = 10.0;
    replicatorLayer.position        =  CGPointMake(self.center.x, self.center.y-50);//self.center;
    //    replicatorLayer.backgroundColor = [UIColor yellowColor].CGColor;//[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    
    [self.layer addSublayer:replicatorLayer];
    
    //这个是点点
    CALayer *dot        = [CALayer layer];
    dot.bounds          = CGRectMake(0, 0, 10, 10);
    dot.position        = CGPointMake(50, 20);
    dot.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.6].CGColor;
    dot.cornerRadius    = 5;
    dot.masksToBounds   = YES;
    
    [replicatorLayer addSublayer:dot];
    
    
    CGFloat count                     = 10.0;
    replicatorLayer.instanceCount     = count;
    CGFloat angel                     = 2* M_PI/count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1);
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0.1;
    animation.repeatCount = MAXFLOAT;
    [dot addAnimation:animation forKey:nil];
    
    
    replicatorLayer.instanceDelay = 1.0/ count;
    
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}

@end
