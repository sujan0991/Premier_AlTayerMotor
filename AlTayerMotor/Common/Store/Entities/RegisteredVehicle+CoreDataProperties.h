//
//  RegisteredVehicle+CoreDataProperties.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RegisteredVehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisteredVehicle (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *brand_id;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *model;
@property (nullable, nonatomic, retain) NSNumber *model_year;
@property (nullable, nonatomic, retain) NSString *registration_expiry;
@property (nullable, nonatomic, retain) NSString *registration_number;
@property (nullable, nonatomic, retain) NSString *other_brand;
@property (nullable, nonatomic, retain) NSString *other_model;

@end

NS_ASSUME_NONNULL_END
