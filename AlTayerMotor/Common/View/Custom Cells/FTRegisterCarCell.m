//
//  FTRegisterCarCell.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FTRegisterCarCell.h"
#import "ATMButton.h"

@interface FTRegisterCarCell() <UITextFieldDelegate>

@end

@implementation FTRegisterCarCell 

- (void)awakeFromNib {
    // Initialization code
    [self setupViews];
    [self layoutByLanguage];
    self.otherBrandLayoutConstraintTop.constant = 0;
    self.otherBrandLayoutConstraintHeight.constant = 0;
    self.otherModelLayoutConstraintTop.constant = 0;
    self.otherModelLayoutConstraintHeight.constant = 0;
}

- (void)layoutByLanguage
{
    [@[_btnBrand, _btnExpiry, _btnModel, _btnYear] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        AFFINE_TRANSFORM(button.titleLabel);
    }];
    
    AFFINE_TRANSFORM(_btnExpiry.rightImage);
    
    AFFINE_TRANSFORM(_tfRegistrationNumber);
    TEXT_ALIGN(_tfRegistrationNumber);
    
    AFFINE_TRANSFORM(_lbAddAnother);
    AFFINE_TRANSFORM(_lbOther);
    
    AFFINE_TRANSFORM(_tfOtherBrand);
    TEXT_ALIGN(_tfOtherBrand);
    AFFINE_TRANSFORM(_tfOtherModel);
    TEXT_ALIGN(_tfOtherModel);
    
    _tfRegistrationNumber.placeholder = LOCALIZED(@"TEXT PLACEHOLDER REGISTRATION NUMBER");
    _lbAddAnother.text = LOCALIZED(@"TEXT ADD ANOTHER VEHICLE");
    _lbOther.text = LOCALIZED(@"TEXT OTHER VEHICLE");
    _tfOtherBrand.placeholder = LOCALIZED(@"TEXT OTHER BRAND");
    _tfOtherModel.placeholder = LOCALIZED(@"TEXT OTHER MODEL");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews
{
    NSArray *views = @[self.tfOtherBrand, self.tfOtherModel, self.tfRegistrationNumber, self.btnBrand, self.btnExpiry, self.btnModel, self.btnYear];
    for (UIView *view in views) {
        CALayer *border = [CALayer layer];
        CGFloat borderWidth = 1.0;
        border.borderColor = [UIColor colorWithRed:171/255.f green:171/255.f blue:171/255.f alpha:1.0].CGColor;
        border.frame = CGRectMake(0, view.frame.size.height - borderWidth, view.frame.size.width, view.frame.size.height);
        border.borderWidth = borderWidth;
        [view.layer addSublayer:border];
        view.layer.masksToBounds = YES;
    }
    
    [_tfOtherBrand addTarget:self
                      action:@selector(otherBrandDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    [_tfOtherModel addTarget:self
                      action:@selector(otherModelDidChange:)
            forControlEvents:UIControlEventEditingChanged];    
}

#pragma mark -
#pragma mark - Actions Handle

- (IBAction)otherBrandDidChange:(id)sender {
    if (_tfOtherBrand.text.length > 0 && _delegate) {
        [_delegate didSetOtherBrand:_tfOtherBrand.text];
    }
}

- (IBAction)otherModelDidChange:(id)sender {
    if (_tfOtherModel.text.length > 0 && _delegate) {
        [_delegate didSetOtherModel:_tfOtherModel.text];
    }
}

@end
