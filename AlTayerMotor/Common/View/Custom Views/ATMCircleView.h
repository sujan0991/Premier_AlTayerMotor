//
//  ATMCircleView.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ATMCircleView : UIView
@property (nonatomic) IBInspectable UIColor *textColor;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable NSString *title;
@property (nonatomic) IBInspectable BOOL isBig;

- (void)setLabelTextColor:(UIColor *)color;
- (void)setLabelText:(NSString *)text;
@end
