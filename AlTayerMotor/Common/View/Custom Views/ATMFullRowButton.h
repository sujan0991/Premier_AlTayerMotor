//
//  ATMFullRowButton.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>



IB_DESIGNABLE
@interface ATMFullRowButton : UIButton
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable UIImage *rightIcon;
@property (nonatomic) IBInspectable CGFloat iconSize;
@property (nonatomic) IBInspectable CGFloat iconOffset;
@property (nonatomic) IBInspectable BOOL isLeft;
@property (nonatomic) IBInspectable BOOL isNotFlip;
- (UIImageView *)rightImageView;
@end
