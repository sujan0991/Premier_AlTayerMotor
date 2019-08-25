//
//  UIView+Border.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "UIView+Border.h"
#import "ViewUtils.h"
#import "NSString+Color.h"

@implementation UIView (Border)

- (void)addBottomLine
{
    [self addBottomLineWithColor:[UIColor colorWithRed:171/255.f green:171/255.f blue:171/255.f alpha:1.0]];
}

- (void)addBottomLineWithColor:(UIColor *)color
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

- (void)addBorder
{
    [self addBorderWithColor:[UIColor colorWithRed:0/255.f green:45/255.f blue:106/255.f alpha:1.0]];
}

- (void)addBorderWithColor:(UIColor *)color
{
    [self addBorderWithColor:color andWidth:2 andCornerRadius:4];
}

- (void)addBorderWithColor:(UIColor *)color andWidth:(CGFloat)width andCornerRadius:(CGFloat)radius
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}

- (void)addRightLine
{
    [self addRightLineWithColor:[@"939393" representedColor]];
}

- (void)addRightLineWithColor:(UIColor*)color
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = color.CGColor;
    border.frame = CGRectMake(self.width - borderWidth,0, borderWidth, self.height);
    border.borderWidth = borderWidth;
    border.shadowColor = [@"cccccc" representedColor].CGColor;
    border.shadowRadius = 0.5;
    border.shadowOffset = CGSizeMake(0.5, 1);
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

@end
