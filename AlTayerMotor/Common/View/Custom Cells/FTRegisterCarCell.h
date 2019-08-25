//
//  FTRegisterCarCell.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOtherString                    @"Other"
#define kOtherStringAR                  @"آخر"
#define kOtherLayoutConstraintHeight    30
#define kOtherLayoutConstraintTop       20

@protocol FTRegisterCarCellDelegate <NSObject>

- (void)didSetOtherBrand:(NSString *)otherBrand;
- (void)didSetOtherModel:(NSString *)otherModel;

@end


@class ATMButton;
@interface FTRegisterCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *tfRegistrationNumber;
@property (weak, nonatomic) IBOutlet ATMButton *btnBrand;
@property (weak, nonatomic) IBOutlet ATMButton *btnModel;
@property (weak, nonatomic) IBOutlet ATMButton *btnYear;
@property (weak, nonatomic) IBOutlet ATMButton *btnExpiry;
@property (weak, nonatomic) IBOutlet UIButton *btnAddVehicle;
@property (weak, nonatomic) IBOutlet UILabel *lbOther;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UILabel *lbAddAnother;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherBrand;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherBrandLayoutConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherBrandLayoutConstraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherModelLayoutConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherModelLayoutConstraintTop;

@property (weak, nonatomic) id<FTRegisterCarCellDelegate> delegate;

@end
