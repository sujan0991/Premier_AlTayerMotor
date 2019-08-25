//
//  ATMButton.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/19/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMButton.h"
#import "ViewUtils.h"
#import "NSString+Color.h"

#define kIconSizeDefault 15

@interface ATMButton()
{
    UIImageView *rightIconImageView;
    BOOL selectedState;
}

@end

@implementation ATMButton

- (void)awakeFromNib
{
    [self setupViews];
}

- (void)prepareForInterfaceBuilder
{
    [self setupViews];
}

- (void)setupViews
{
    if (!rightIconImageView) {
        rightIconImageView = [[UIImageView alloc] initWithImage:_rightIcon];
        rightIconImageView.frame = CGRectMake(0, 0, _iconSize+4, _iconSize+4);
        rightIconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:rightIconImageView];
    }
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightIconImageView.width*1.5)];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGRect myFrame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    CGContextSetStrokeColorWithColor(context, (selectedState ? [UIColor clearColor].CGColor : [_borderColor ?: [@"ababab" representedColor] CGColor]));
    CGContextSetLineWidth(context, 0.5);
    CGContextStrokeRect(context, myFrame);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // imageview
    _iconSize = _iconSize > 0 ? _iconSize : kIconSizeDefault;
    rightIconImageView.top = (self.height - _iconSize)/2;
    rightIconImageView.right = self.width - 8;
}

- (void)setSelectedState:(BOOL)selected
{
    selectedState = selected;
    if (selected) {
        rightIconImageView.image = [UIImage imageNamed:@"icon_close"];
        [self setTitleColor:[@"#002d6a" representedColor]
                   forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.f]];
    } else {
        rightIconImageView.image = _rightIcon;
        [self setTitleColor:[@"#909090" representedColor]
                   forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
    }
    
    // add animation when change ui
    CATransition *transition = [CATransition animation];
    transition.duration = 0.33f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFromTop;
    [rightIconImageView.layer addAnimation:transition forKey:nil];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (BOOL)isSelectedState
{
    return selectedState;
}

- (CGRect)rightImageFrame
{
    // make the frame wider to touch on right icon easier
    return CGRectMake(rightIconImageView.left - 2, rightIconImageView.top - 2, rightIconImageView.width + 4, rightIconImageView.height + 4);
}

- (UIImageView *)rightImage
{
    if (!rightIconImageView) {
        rightIconImageView = [[UIImageView alloc] initWithImage:_rightIcon];
        rightIconImageView.frame = CGRectMake(0, 0, _iconSize+4, _iconSize+4);
        rightIconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:rightIconImageView];
    }
    
    return rightIconImageView;
}

@end
