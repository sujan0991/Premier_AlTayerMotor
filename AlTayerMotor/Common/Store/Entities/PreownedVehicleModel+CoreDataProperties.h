//
//  PreownedVehicleModel+CoreDataProperties.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PreownedVehicleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PreownedVehicleModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *brand_id;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) NSNumber *model_year;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
