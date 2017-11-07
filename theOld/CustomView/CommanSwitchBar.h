//
//  cop
//
//  Created by Simon Liu on 12/12/11.
//  Copyright (c) 2011 APPVV.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommanSwitchBarDelegate;
@interface CommanSwitchBar : UIScrollView {
    NSMutableArray *_btns;
}
@property (readwrite) NSInteger marginLeft;
@property (readwrite) NSInteger buttonWidth;
@property (readonly) NSInteger selectedButton;
@property (nonatomic, retain) UIImageView *slideBg;
@property (nonatomic, weak) id delegateC;

- (id)initWithInfo:(NSArray *)arr frame:(CGRect)frame;

- (void)selectTab:(NSInteger)tabID;

@end

@protocol CommanSwitchBarDelegate

-(void)switchBarClicked:(NSInteger) buttonIndex;


@end
