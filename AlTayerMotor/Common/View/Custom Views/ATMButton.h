//
//  ATMButton.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/19/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ATMButton : UIButton

@property (nonatomic) IBInspectable NSInteger borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable UIColor *backgroundColor;
@property (nonatomic) IBInspectable UIImage *rightIcon;
@property (nonatomic) IBInspectable CGFloat iconSize;

- (void)setSelectedState:(BOOL)selected;
- (BOOL)isSelectedState;
- (CGRect)rightImageFrame;
- (UIImageView *)rightImage;
@end
