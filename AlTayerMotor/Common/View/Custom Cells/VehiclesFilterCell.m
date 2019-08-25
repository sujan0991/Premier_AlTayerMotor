//
//  VehiclesFilterCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesFilterCell.h"

@implementation VehiclesFilterCell

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
    
//    self.lbFilter.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbDisclaimerMsg.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
//    self.lbFilterType.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
    self.lbFilter.text = LOCALIZED(@"TEXT FILTER");
    [self setIsOffer:_isOffer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
//    UIColor *color = self.contentView.backgroundColor;
    UIColor *lineColor = self.line.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.line.backgroundColor = lineColor;
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
}

- (void)setIsOffer:(BOOL)isOffer
{
    _isOffer = isOffer;
    if (_isOffer) {
        self.lbFilterType.text = LOCALIZED(@"TEXT ALL OFFERS");
    } else {
        self.lbFilterType.text = LOCALIZED(@"TEXT ALL VEHICLES");
    }
}

@end
