//
//  VFCategoriesCell.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VehicleCategoryDelegate <NSObject>

-(void)changeCagetory:(NSString*)category;

@end

@interface VFCategoriesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnSedan;
@property (weak, nonatomic) IBOutlet UIButton *btnSuv;
@property (weak, nonatomic) IBOutlet UIButton *btnTrucks;
@property (weak, nonatomic) IBOutlet UIButton *btnOthers;
@property (weak, nonatomic) id<VehicleCategoryDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lbTitleVehicle;


- (IBAction)selectCategoryAction:(id)sender;

@end
