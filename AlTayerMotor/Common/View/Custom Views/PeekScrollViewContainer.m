//
//  PeekScrollViewContainer.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "PeekScrollViewContainer.h"

@implementation PeekScrollViewContainer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return _scrollView;
    }
    return view;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    DLog(@"%@", NSStringFromCGRect(self.scrollView.frame));
}

@end
