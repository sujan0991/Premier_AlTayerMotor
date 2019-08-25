//
//  UIView+Border.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

- (void)addBottomLine;
- (void)addBottomLineWithColor:(UIColor *)color;
- (void)addBorder;
- (void)addBorderWithColor:(UIColor *)color;
- (void)addBorderWithColor:(UIColor *)color andWidth:(CGFloat)width andCornerRadius:(CGFloat)radius;
- (void)addRightLine;
- (void)addRightLineWithColor:(UIColor*)color;

@end
