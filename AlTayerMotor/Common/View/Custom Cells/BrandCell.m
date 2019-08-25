//
//  BrandCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandCell.h"
#import "UIView+Roundify.h"
#import "NSString+Color.h"

@implementation BrandCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    for (UIView *subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            [subview.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1,1)];
        }
    }
    
    self.lbName.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *color = [@"1F3D65" representedColor];
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.selectedBackgroundView.backgroundColor = color;
        self.contentView.backgroundColor = color;
        self.bgView.backgroundColor = [@"cccccc" representedColor];
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.lastRow) {
        [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                         withRadii:CGSizeMake(6, 6)];
    } else {
        [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                         withRadii:CGSizeMake(0, 0)];
    }
}
@end
