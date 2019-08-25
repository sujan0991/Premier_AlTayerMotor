//
//  MBrand.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@interface MBrand : MBase

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameAR;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSMutableArray *vehicleModels;
@property (nonatomic, strong) NSString *roadsideAssistance;

@property (nonatomic, strong) NSString *offerCategory; // FOR OFFER FILTER ONLY

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithId:(NSInteger)Id
                  withName:(NSString*)name
                withNameAR:(NSString*)nameAR
                  withLogo:(NSString *)logo
                   withUrl:(NSString *)url
              withRoadside:(NSString *)roadside;

@end
