//
//  VehicleCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehicleCell.h"

@implementation VehicleCell

- (void)awakeFromNib {
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    self.lbBrand.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbPrice.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentRight : NSTextAlignmentLeft;
    self.lbModelYear.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *color = self.informationView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.informationView.backgroundColor = color;
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
}

@end
