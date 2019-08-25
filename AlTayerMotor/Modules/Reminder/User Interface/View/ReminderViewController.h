//
//  ReminderViewController.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BaseViewController.h"

@class ATMFullRowButton;

@interface ReminderViewController : BaseViewController

@property (strong, nonatomic) NSString *dateStr;
@property (weak, nonatomic) IBOutlet UILabel *tfExpiredDate;
@property (weak, nonatomic) IBOutlet UILabel *lbHeadline;
@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnClose;

@end
