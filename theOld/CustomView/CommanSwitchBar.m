//
//  cop
//
//  Created by Simon Liu on 12/12/11.
//  Copyright (c) 2011 APPVV.COM. All rights reserved.
//

#import "CommanSwitchBar.h"
#import "VVGlobalDefine.h"
#import "vvDefine.h"

#define Tag 1000

@interface CommanSwitchBar() {
    NSArray *_arrInfo;
}

@end

@implementation CommanSwitchBar

- (id)initWithInfo:(NSArray *)arr frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *bgView=[[UIImageView alloc]init];
        [bgView setFrame: CGRectMake(0, 0, frame.size.width, frame.size.height )];
//        if (IS_IPAD) {
//            [bgView setBackgroundColor:UIColorRGB(250, 250, 250)];
//        }else{
            [bgView setBackgroundColor:UIColorRGB(248, 248, 248)];//UIColorRGB(235, 235, 235)
//        }
        
        [self addSubview:bgView];
//
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height-0.5, frame.size.width, 0.5)];
        [lineV setBackgroundColor:UIColorFromRGB(0xdddddd)];
        [bgView addSubview:lineV];
        
        _slideBg=[[UIImageView alloc] initWithFrame:CGRectZero];
        CGSize slideimagesize=CGSizeMake(frame.size.width, 3);
        UIColor *slideColor=baseColor;
        UIGraphicsBeginImageContextWithOptions(slideimagesize, YES, 0);
        CGContextRef slidecontext= UIGraphicsGetCurrentContext();
        [slideColor setFill];
        CGContextFillRect(slidecontext, CGRectMake(0, 0, slideimagesize.width, slideimagesize.height));
        UIImage *slideImage=UIGraphicsGetImageFromCurrentImageContext();
        
        _slideBg.layer.masksToBounds = YES;
        [_slideBg setImage:[slideImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];

         [self addSubview:_slideBg];
        _slideBg.backgroundColor = [UIColor redColor];
        _buttonWidth=frame.size.width/[arr count];
        _arrInfo = arr;
        
        UIColor *selectedColor= baseColor;
        UIColor *normalColor=UIColorFromRGB(0x555555);
        
        _btns = [NSMutableArray array];
        for(NSInteger index=0; index < [arr count]; index++) {
            NSDictionary *dicViewInfo = [arr objectAtIndex:index];
            NSString *title = [dicViewInfo objectForKey:@"Title"];
            NSString *s_title = [dicViewInfo objectForKey:@"S_Title"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(_buttonWidth*index, 0, _buttonWidth, frame.size.height)];
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
            [btn setTitleColor:selectedColor forState:UIControlStateSelected];
            [btn setTitleColor:normalColor forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTag:index+Tag];
//            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, frame.size.height/3,0)];
            
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.adjustsImageWhenHighlighted = NO;
            [_btns addObject:btn];
        }
        
        //[self selectTab:0];
        
        CGSize imageSize = CGSizeMake(frame.size.width, 1);
        UIColor *fillColor = UIColorRGB(240, 240, 240);
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [fillColor setFill];
        CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *bottomLineImage = UIGraphicsGetImageFromCurrentImageContext();
        UIImageView *bottomImageView=[[UIImageView alloc]initWithImage:bottomLineImage];
        bottomImageView.frame=CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5);
    }
    
    return self;
}

- (void)buttonClicked:(id)sender{
    NSInteger tagNum = [sender tag];
    [self selectTab:tagNum - Tag];
}

- (void)selectTab:(NSInteger)tabID{
    UIButton *btn = (UIButton *)[self viewWithTag:(tabID + Tag)];
    for(UIButton *bb in _btns) {
        bb.selected = NO;
    }
    btn.selected = YES;
    [self slideTabBg:btn];
    
    if ( _delegateC != nil && [_delegateC respondsToSelector:@selector(switchBarClicked:)]) {
        [_delegateC switchBarClicked:tabID];
    }
}

- (void)slideTabBg:(UIButton *)btn{
    //for ios7
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [btn.currentTitle boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    CGFloat titleWidth=rect.size.width+20;
    CGFloat newFrameX= (btn.bounds.size.width-titleWidth)/2.0+ btn.frame.origin.x;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationDelegate:self];
 
     _slideBg.frame = CGRectMake(newFrameX ,kSegmentedControlHeight*ScreenHRatioBaseIphone6 -4,titleWidth, 2);
    [UIView commitAnimations];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
}

- (void)slideToIndex:(NSInteger)toIndex{
 
}

- (void)dealloc{
    
}

@end
