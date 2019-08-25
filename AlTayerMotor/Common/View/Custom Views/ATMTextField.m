//
//  ATMTextField.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/18/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMTextField.h"
#import "ViewUtils.h"
#import "NSString+Color.h"
#import "CALayer+Utils.h"

#define kIconSizeDefault 15

@interface ATMTextField()
{
    UIButton *rightButton;
    BOOL selectedState;
}

@end

@implementation ATMTextField

- (void)awakeFromNib
{
    [self setupViews];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    AFFINE_TRANSFORM(self);
    TEXT_ALIGN(self);
}

- (void)prepareForInterfaceBuilder
{
    [self setupViews];
}

- (void)setupViews
{
    if (!rightButton) {
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:_rightIcon forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, 0, _iconSize, _iconSize);
        rightButton.hidden = YES;
    }
    
    self.backgroundColor = [UIColor clearColor];
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
    rightButton.top = (self.height - _iconSize)/2;
    if ([ATMGlobal isEnglish]) {
        rightButton.right = self.width - 8;
    } else {
        rightButton.left = 8;
    }
    
//    [self layoutByLanguage];
}

//- (CGRect)caretRectForPosition:(UITextPosition *)position {
//    if ([ATMGlobal isEnglish]) {
//        return [super caretRectForPosition:position];
//    }
//    CGRect frame = self.frame;
//    frame.origin.x = self.frame.size.width - 1.0;
//    frame.origin.y = 3.0;
//    frame.size.width = 2.0;
//    frame.size.height = self.frame.size.height - 6.0;
//    
//    return frame;
//}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    if ([ATMGlobal isEnglish]) {
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - (selectedState ? 30 : 0), bounds.size.height);
    } else {
        return CGRectMake(bounds.origin.x + 30, bounds.origin.y, bounds.size.width - 30, bounds.size.height);
    }
}
//
//- (CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    if ([ATMGlobal isEnglish]) {
//        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - (selectedState ? 30 : 0) , self.height);
//    } else {
//        return CGRectMake(selectedState ? 30 : 0, bounds.origin.y, self.width , self.height);
//    }
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds
//{
//    if ([ATMGlobal isEnglish]) {
//        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - (selectedState ? 30 : 0) , bounds.size.height);
//    } else {
//        return CGRectMake(selectedState ? 30 : 0, bounds.origin.y, bounds.size.width , bounds.size.height);
//    }
//}
//
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    CGSize textSize = [[self placeholder] sizeWithAttributes:@{NSFontAttributeName:self.font}];
//    float yPos = (rect.size.height - textSize.height) /2;
//    CGRect frame = CGRectMake(rect.origin.x, rect.origin.y + yPos, rect.size.width, rect.size.height);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, [ATMGlobal isEnglish] ? 0 : textSize.width, 0);
//    CGContextConcatCTM(context, LANGUAGE_TRANSFORM);
//    [[self placeholder]	drawInRect:frame withAttributes:@{ NSFontAttributeName : self.font, NSForegroundColorAttributeName : [@"ababab" representedColor]}];
//    
//    CGContextRestoreGState(context);
//}
//
//- (void)drawTextInRect:(CGRect)rect
//{
//    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    style.lineBreakMode = [ATMGlobal isEnglish] ? NSLineBreakByTruncatingTail : NSLineBreakByTruncatingHead;
//    
//    CGSize textSize = [self.text sizeWithAttributes:@{
//                                                      NSFontAttributeName : self.font,
//                                                      NSForegroundColorAttributeName : [@"002d6a" representedColor],
//                                                      NSParagraphStyleAttributeName: style}];
//    
//    float yPos = (rect.size.height - textSize.height) /2;
//    CGRect frame = CGRectMake(rect.origin.x, rect.origin.y + yPos, rect.size.width, rect.size.height);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, frame);
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, [ATMGlobal isEnglish] ? 0 : textSize.width, 1);
//    CGContextConcatCTM(context, CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1, 1));
//    [self.text drawInRect:frame withAttributes:@{
//                                                NSFontAttributeName : self.font,
//                                                NSForegroundColorAttributeName : [@"002d6a" representedColor],
//                                                NSParagraphStyleAttributeName: style} ];
//    CGContextRestoreGState(context);
//}

- (void)setSelectedState:(BOOL)selected
{
    selectedState = selected;
    if (selectedState) {
        rightButton.hidden = NO;
        [self setTextColor:[@"#002d6a" representedColor]];
        [self setFont:[UIFont boldSystemFontOfSize:17.f]];
//        if ([ATMGlobal isEnglish]) {
            [self setRightViewMode:UITextFieldViewModeAlways];
            [self setRightView:rightButton];
//        } else {
//            [self setLeftViewMode:UITextFieldViewModeAlways];
//            [self setLeftView:rightButton];
//        }
    } else {
        rightButton.hidden = YES;
        [self setTextColor:[@"#909090" representedColor]];
        [self setFont:[UIFont systemFontOfSize:17.f]];
//        if ([ATMGlobal isEnglish]) {
            [self setRightViewMode:UITextFieldViewModeWhileEditing];
            [self setRightView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
//        } else {
//            [self setLeftViewMode:UITextFieldViewModeWhileEditing];
//            [self setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]];
//        }
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (CGRect)rightButtonFrame
{
    // make the frame wider to touch on right icon easier
    return CGRectMake(rightButton.left - 2, rightButton.top - 2, rightButton.width + 4, rightButton.height + 4);
}

- (UIButton *)rightButton
{
    return rightButton;
}

@end
