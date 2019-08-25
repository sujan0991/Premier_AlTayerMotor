//
//  VFBlankCell.m
//  AlTayerMotors
//
//  Created by Lucas Nguyen on 12/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VFBlankCell.h"
#import "UIView+Roundify.h"

@implementation VFBlankCell

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
    
    self.lbBLank.textAlignment = [ATMGlobal isEnglish] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [_bgView addRoundedCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft
                     withRadii:CGSizeMake(4, 4)];
}

@end
