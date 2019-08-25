//
//  ServicesViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicesViewController.h"

#import "ServicesVehicleCell.h"
#import "ServicesNewVehicleCell.h"
#import "MRegisteredVehicle.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CoreDataStore.h"
#import "NSString+Utils.h"

#define kHeightTitle    160.0f
#define kHeightVehicle  125.0f

#define TitleCellIdentifier           @"TitleCell"
#define RegisteredCarCellIdentifier   @"RegisteredCarCell"
#define NewVehicleCellIdentifier      @"NewVehicleCell"

@interface ServicesViewController() <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *registeredVehicles;
@property (assign, nonatomic) CGFloat vehicleRowHeight;
@end

@implementation ServicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // compute row height
    _vehicleRowHeight = [ATMGlobal vehicleServicesRowHeight];
    
    // Navigation
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE SERVICE");
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    // TableView
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 20, 0.0);
    
    [self layoutByLanguage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler findRegisteredVehicles];
}

#pragma mark - View Interface
- (void)layoutByLanguage
{
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE SERVICE");
    [_tableView.layer setAffineTransform:LANGUAGE_TRANSFORM];
    [self.navigationController.navigationBar.layer setAffineTransform:LANGUAGE_TRANSFORM];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview.layer setAffineTransform:LANGUAGE_TRANSFORM];
        }
    }
}

- (void)updateRegisteredVehicles:(NSArray *)vehicles
{
    self.registeredVehicles = vehicles;
    [self.tableView reloadData];
    
    if (!vehicles || vehicles.count == 0) {
        [self.eventHandler showBookingServiceByNavigationController:self.navigationController
                                              withRegisteredVehicle:nil];
    }
}

#pragma mark - TableView Delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.registeredVehicles.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kHeightTitle;
    }
    
    DLog(@"-> %f", _vehicleRowHeight);
    return _vehicleRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleCellIdentifier
                                                                forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == self.registeredVehicles.count + 1) {
        ServicesNewVehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:NewVehicleCellIdentifier
                                                                       forIndexPath:indexPath];
        return cell;
    } else {
        MRegisteredVehicle *vehicle = self.registeredVehicles[indexPath.row - 1];
        ServicesVehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:RegisteredCarCellIdentifier
                                                                    forIndexPath:indexPath];
        if (vehicle.model && vehicle.model.model && (![vehicle.model.model.lowercaseString isEqualToString:@"other"] && ![vehicle.model.model.lowercaseString isEqualToString:@"آخر"])) {
            cell.lbModel.text = [NSString stringWithFormat:@"%@ %ld", vehicle.model.model, (long)vehicle.year];
        } else {
            cell.lbModel.text = [NSString stringWithFormat:@"%@ %ld", vehicle.otherModel, (long)vehicle.year];
        }
        [cell.imvVehicle sd_setImageWithURL:[NSURL URLWithString:[vehicle.model.image toImageLink]]
                           placeholderImage:[UIImage imageNamed:@"placeholder_car"]];

        cell.btnDelete.tag = indexPath.row - 1;
        [cell.btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if (index > 0) {
        MRegisteredVehicle *vehicle = nil;
        if (index < self.registeredVehicles.count + 1)
            vehicle = self.registeredVehicles[index - 1];
        
        [self.eventHandler showBookingServiceByNavigationController:self.navigationController
                                              withRegisteredVehicle:vehicle];
    }
    
}

#pragma mark - Actions
- (IBAction)deleteAction:(id)sender
{
    MRegisteredVehicle *vehicle = self.registeredVehicles[[sender tag]];
    [self.eventHandler showDeletePopupWithRegisteredVehicle:vehicle];
}

@end
