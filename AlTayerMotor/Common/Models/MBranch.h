//
//  MBranch.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@interface MBranch : MBase

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *openingHours;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

- (instancetype)initWithId:(NSInteger)id withName:(NSString *)name withOpeningHours:(NSString *)openingHours withType:(NSString *)type withLatitude:(NSNumber*)latitude withLongitude:(NSNumber*)longigtude;

@end
