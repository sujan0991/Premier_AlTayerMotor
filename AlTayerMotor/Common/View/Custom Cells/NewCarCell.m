//
//  NewCarCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NewCarCell.h"
#import "UIView+Roundify.h"

@implementation NewCarCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Multiple language
    AFFINE_TRANSFORM(_imvBrand);
    AFFINE_TRANSFORM(_lbBrand);
    TEXT_ALIGN(_lbBrand);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.lastRow) {
        [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                         withRadii:CGSizeMake(8, 8)];
    } else {
        [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                         withRadii:CGSizeMake(0, 0)];
    }
}

@end
