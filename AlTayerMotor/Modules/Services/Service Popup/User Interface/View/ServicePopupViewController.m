//
//  ServicePopupViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicePopupViewController.h"
#import "UIView+Border.h"

@interface ServicePopupViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIImageView *imvTitleEN;
@property (weak, nonatomic) IBOutlet UIImageView *imvContentEN;
@property (weak, nonatomic) IBOutlet UIImageView *imvTitleAR;
@property (weak, nonatomic) IBOutlet UIImageView *imvContentAR;
@end

@implementation ServicePopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // LANGUAGE
    _imvTitleEN.hidden = ![ATMGlobal isEnglish];
    _imvContentEN.hidden = ![ATMGlobal isEnglish];
    _imvTitleAR.hidden = [ATMGlobal isEnglish];
    _imvContentAR.hidden = [ATMGlobal isEnglish];
    [_btnCancel setTitle:LOCALIZED(@"TEXT NO") forState:UIControlStateNormal];
    [_btnSubmit setTitle:LOCALIZED(@"TEXT YES") forState:UIControlStateNormal];
    
    // BORDER
    [self.btnCancel addBorder];
    [self.btnSubmit addBorder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)cancelAction:(id)sender {
    [self.eventHandler cancelAction];
}

- (IBAction)submitAction:(id)sender {
    [self.eventHandler submitAction];
}

@end
