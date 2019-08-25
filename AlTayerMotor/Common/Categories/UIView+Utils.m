//
//  UIView+Utils.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/11/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (NSArray *)allSubviews
{
    NSMutableArray *arr = [@[] mutableCopy];
    for (UIView *subview in self.subviews) {
        [arr addObject:subview];
        [arr addObjectsFromArray:[subview allSubviews]];
    }
    return arr;
}

- (void)setBackGroundGradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[fromColor CGColor], (id)[toColor CGColor], nil];
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
