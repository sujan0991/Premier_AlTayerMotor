//
//  InsuranceConfirmationViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceConfirmationViewController.h"
#import "UIView+Border.h"

@interface InsuranceConfirmationViewController()

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *imvDescription;

@end

@implementation InsuranceConfirmationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE RENEW INSURANCE");
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    // Image
    self.imvDescription.image = IMAGE_MULTIPLE_LANGUAGE(@"text_insurance_confirmation");
    [_btnBack setImage:IMAGE_MULTIPLE_LANGUAGE(@"btn_back_to_preowned")
              forState:UIControlStateNormal];
    
    // setup Views
    [self.btnBack addBorder];
}

- (IBAction)backAction:(id)sender {
    [self.eventHandler backToPreowned];
}


@end
