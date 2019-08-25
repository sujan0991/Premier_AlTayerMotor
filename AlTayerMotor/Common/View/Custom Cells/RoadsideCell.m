//
//  RoadsideCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RoadsideCell.h"
#import "UIView+Roundify.h"

@implementation RoadsideCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Multiple language
    for (UIView *view in [self allSubviews]) {
        AFFINE_TRANSFORM(view);
    }
    
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
