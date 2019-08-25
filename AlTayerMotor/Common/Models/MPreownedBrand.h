//
//  MPreownedBrand.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MBase.h"

@interface MPreownedBrand : MBase

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameAR;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSMutableArray *vehicleModels;
@property (nonatomic, strong) NSString *roadsideAssistance;
@property (nonatomic, strong) NSString *noPreownedMessage;
@property (nonatomic, strong) NSString *noPreownedMessageAR;
@property (nonatomic, assign) NSInteger oldestYear;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithId:(NSInteger)Id
                  withName:(NSString*)name
                withNameAR:(NSString*)nameAR
                  withLogo:(NSString *)logo
                   withUrl:(NSString *)url
              withRoadside:(NSString *)roadside
     withNoPreownedMessage:(NSString *)message
   withNoPreownedMessageAR:(NSString *)messageAR
            withOldestYear:(NSInteger)oldestYear;

@end
