//
//  OFBrandCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OFBrandCell.h"
#import "MBrand.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Utils.h"
#import "OffersFilterDisplayData.h"


@implementation OFBrandCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    AFFINE_TRANSFORM(_lbModel);
    AFFINE_TRANSFORM(_imvLogo);
    AFFINE_TRANSFORM(_imvCheckmark);
    TEXT_ALIGN(_lbModel);
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (selected && _delegate) {
        [_delegate didSelectBrand:_brand];
    }
    
    // Remove checkmark system
//    self.imvCheckmark.hidden = !selected;
}

- (void)displayBrand:(MBrand *)brand
{
    self.brand = brand;
    NSString *brandName = [brand isValidString:brand.name] ? brand.name : @"";
    self.lbModel.text = [brandName uppercaseString];
    [self.imvLogo sd_setImageWithURL:[NSURL URLWithString:[brand.logo toImageLink]]
                    placeholderImage:[UIImage imageNamed:@"icon_placeholder_brand"]];
}

@end
