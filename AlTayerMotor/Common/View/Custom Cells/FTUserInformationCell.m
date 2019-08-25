//
//  FTUserInformationCell.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FTUserInformationCell.h"
#import "ATMButton.h"
#import "NumberPadToolbar.h"
#import "UIView+Border.h"

@interface FTUserInformationCell() <NumberPadToolbarDelegate>

@end

@implementation FTUserInformationCell

- (void)awakeFromNib {
    // Initialization code
    [self setupViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    
    [self layoutByLanguage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews
{
    NSArray *views = @[self.tfFirstName, self.tfLastName, self.phoneView, self.btnSelectCity];
    
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addBottomLine];
    }];
    
    // NumberPad
    NumberPadToolbar *toolbar = [[NumberPadToolbar alloc] initWithTextField:_tfPhoneNumber];
    toolbar.numberPadDelegate = self;
    _tfPhoneNumber.inputAccessoryView = toolbar;
}

- (void)layoutByLanguage
{
    for (UIView *subview in [self.contentView allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]] ||
            [subview isKindOfClass:[UITextField class]] ||
            [subview isKindOfClass:[UIImageView class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
    AFFINE_TRANSFORM(_btnSelectCity.titleLabel);
    AFFINE_TRANSFORM(_btnCode.titleLabel);
    
    TEXT_ALIGN(_tfFirstName);
    TEXT_ALIGN(_tfLastName);
    TEXT_ALIGN(_tfPhoneNumber);
    
    _lbTitle.text = LOCALIZED(@"TEXT TELL US ABOUT YOURSELF");
    self.tfFirstName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER FIRST NAME");
    self.tfLastName.placeholder = LOCALIZED(@"TEXT PLACEHOLDER LAST NAME");
    self.tfPhoneNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER PHONE NUMBER");
}

#pragma mark - Number Pad Delegate

- (void)numberPadToolbar:(NumberPadToolbar *)toolbar didClickDone:(UITextField *)textField
{
    [textField resignFirstResponder];
}

@end
