//
//  FTUserInformationCell.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ATMButton;

@interface FTUserInformationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet ATMButton *btnSelectCity;
@property (strong, nonatomic) IBOutlet UITextField *tfFirstName;
@property (strong, nonatomic) IBOutlet UITextField *tfLastName;
@property (strong, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet ATMButton *btnCode;

@end
