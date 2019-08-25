//
//  ATMFullRowButton.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMFullRowButton.h"
#import "ViewUtils.h"
#import "NSString+Color.h"
#import "UIView+Border.h"

#define kIconSizeDefault 15
#define kIconOffsetDefault 15
#define TITLE_EDGE_INSETS UIEdgeInsetsMake(0, 10, 0, 10)
@interface ATMFullRowButton()
{
    UIImageView *rightIconImageView;
}

@end

@implementation ATMFullRowButton

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)prepareForInterfaceBuilder
{
    [self setupViews];
}

- (void)layoutByLanguage
{
    [self setTitleEdgeInsets:TITLE_EDGE_INSETS];
    
    if (![ATMGlobal isEnglish]) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
    }
    if (!_isNotFlip) {
        AFFINE_TRANSFORM(rightIconImageView);
    }
}

- (void)setupViews
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
    
    if (!rightIconImageView) {
        rightIconImageView = [[UIImageView alloc] initWithImage:_rightIcon];
        rightIconImageView.frame = CGRectMake(0, 0, _iconSize, _iconSize);
        [self addSubview:rightIconImageView];
    }
    
    [self setBackgroundImage:[ATMFullRowButton imageWithColor:[@"a6a5a5" representedColor]]
                    forState:UIControlStateHighlighted];
    
    [self setTitleEdgeInsets:TITLE_EDGE_INSETS];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BOOL left = ([ATMGlobal isEnglish] || _isNotFlip) ? _isLeft : !_isLeft;
    
    // imageview
    _iconSize = _iconSize > 0 ? _iconSize : kIconSizeDefault;
    rightIconImageView.top = (self.height - _iconSize)/2;
    rightIconImageView.image = _rightIcon;
    if (left) {
        rightIconImageView.left = (_iconOffset > 0 ? _iconOffset : kIconOffsetDefault);
        if (rightIconImageView.right > self.titleLabel.left && self.titleLabel.left > 0) {
            rightIconImageView.left = self.titleLabel.left/2 - self.iconSize/2;
        }
    } else {
        rightIconImageView.right = self.width - (_iconOffset > 0 ? _iconOffset : kIconOffsetDefault);
        if (rightIconImageView.left < self.titleLabel.right) {
            rightIconImageView.right = self.titleLabel.right + (self.width - self.titleLabel.right)/2 + self.iconSize/2;
        }
    }
    [self addBorderWithColor:[@"002d6a" representedColor] andWidth:2 andCornerRadius:4];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImageView *)rightImageView
{
    return rightIconImageView;
}

@end
