//
//  DeleteVehicleViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "DeleteVehicleViewController.h"
#import "UIView+Border.h"

@interface DeleteVehicleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lbMessage;
@end

@implementation DeleteVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnCancel addBorder];
    [self.btnSubmit addBorder];
    
    [_btnCancel setTitle:LOCALIZED(@"TEXT CANCEL CAPITALIZE") forState:UIControlStateNormal];
    [_btnSubmit setTitle:LOCALIZED(@"TEXT DELETE") forState:UIControlStateNormal];
    _lbMessage.text = LOCALIZED(@"TEXT ARE YOU SURE YOU WANT TO DELETE THIS CAR");
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
