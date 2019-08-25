//
//  ServicesVehicleCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicesVehicleCell.h"

@implementation ServicesVehicleCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *color = self.contentView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.selectedBackgroundView.backgroundColor = color;
        self.contentView.backgroundColor = [UIColor colorWithRed:246/255.f green:245/255.f blue:245/255.f alpha:1.0f];
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
}

@end
