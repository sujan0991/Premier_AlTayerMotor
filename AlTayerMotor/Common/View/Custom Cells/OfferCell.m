//
//  OfferCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OfferCell.h"

@implementation OfferCell

- (void)awakeFromNib {
    // Initialization code
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] || [subview isKindOfClass:[UIImageView class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
    [@[_lbContent, _lbDescription, _lbTitle] enumerateObjectsUsingBlock:^(UILabel *tf, NSUInteger idx, BOOL * _Nonnull stop) {
        TEXT_ALIGN(tf);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
