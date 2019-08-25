//
//  City+CoreDataProperties.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *key;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *nameAR;

@end

NS_ASSUME_NONNULL_END
