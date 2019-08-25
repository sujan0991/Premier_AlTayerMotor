//
//  ATMCircleView.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMCircleView.h"
#import "ViewUtils.h"
#import <QuartzCore/QuartzCore.h>

@interface ATMCircleView()
@property (strong, nonatomic)UILabel *label;
@end

@implementation ATMCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = _textColor ?: [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:16.f];
        [self addSubview:_label];
    }
    
    AFFINE_TRANSFORM(_label);
    _label.text = _title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.isBig) {
        CGPoint center = self.center;
        self.width = 25;
        self.height = 25;
        self.center = center;
        _label.frame = self.bounds;
    } else {
        CGPoint center = self.center;
        self.width = 13;
        self.height = 13;
        self.center = center;
        _label.frame = self.bounds;
    }
    
    if (self.frame.size.width < 15) {
        _label.hidden = YES;
        self.borderWidth = MAX(self.borderWidth, 2);
    } else {
        _label.hidden = NO;
        self.borderWidth = 0;
    }
    
    self.layer.cornerRadius = self.width / 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor ? self.borderColor.CGColor : [UIColor clearColor].CGColor;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)setLabelTextColor:(UIColor *)color
{
    if (_label) {
        _label.textColor = color;
    }
}

- (void)setLabelText:(NSString *)text
{
    if (_label) {
        _label.text = text;
        [self bringSubviewToFront:_label];
    }
}

@end
