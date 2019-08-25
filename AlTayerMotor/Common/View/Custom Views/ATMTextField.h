//
//  ATMTextField.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ATMTextField : UITextField

@property (nonatomic) IBInspectable NSInteger borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable UIImage *rightIcon;
@property (nonatomic) IBInspectable CGFloat iconSize;

- (void)setSelectedState:(BOOL)selected;
- (CGRect)rightButtonFrame;
- (UIButton *)rightButton;

@end
