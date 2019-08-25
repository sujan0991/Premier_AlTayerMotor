//
//  EnquiryConfirmationViewCtroller.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryConfirmationViewCtroller.h"
#import "UIView+Border.h"

@interface EnquiryConfirmationViewCtroller()
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *imvConfirmation;
@end

@implementation EnquiryConfirmationViewCtroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = LOCALIZED(@"MENU SEND AN ENQUIRY");
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    // setup Views
    [self.btnBack addBorder];
    _imvConfirmation.image = IMAGE_MULTIPLE_LANGUAGE(@"enquiry_confirmation");
    [_btnBack setImage:IMAGE_MULTIPLE_LANGUAGE(@"btn_back_to_preowned")
              forState:UIControlStateNormal];
}

- (IBAction)backAction:(id)sender {
    [self.eventHandler backToPreowned];
}

@end
