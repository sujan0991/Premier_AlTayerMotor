//
//  MPreownedBrand.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "MPreownedBrand.h"
#import "MPreownedVehicleModel.h"

@implementation MPreownedBrand

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _id = [dict[@"id"] integerValue];
        _logo = dict[@"logo"];
        _name = dict[@"name"];
        _nameAR = dict[@"name_ar"];
        _url = dict[@"brand_url"];
        _roadsideAssistance = dict[@"roadside_assistance"];
        _oldestYear = [dict[@"oldest_year"] integerValue];
        _noPreownedMessage = dict[@"no_preowned_message"];
        if (!_noPreownedMessage || [_noPreownedMessage isEqual:[NSNull null]]) {
            _noPreownedMessage = @"";
        }
        
        _noPreownedMessageAR = dict[@"no_preowned_message_ar"];
        if (!_noPreownedMessageAR || [_noPreownedMessageAR isEqual:[NSNull null]]) {
            _noPreownedMessageAR = @"";
        }
        _vehicleModels = [@[] mutableCopy];
        
        NSArray* vehicleModelsArr = dict[@"vehicle_models"];
        if (vehicleModelsArr && ![vehicleModelsArr isEqual:[NSNull null]]) {
            [vehicleModelsArr enumerateObjectsUsingBlock:^(NSDictionary *modelDict, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray *categories = modelDict[@"vehicle_categories"];
                if (categories && ![categories isEqual:[NSNull null]] && [categories isKindOfClass:[NSArray class]] && categories.count > 0) {
                    [categories enumerateObjectsUsingBlock:^(NSString *category, NSUInteger idx, BOOL * _Nonnull stop) {
                        MPreownedVehicleModel *model = [[MPreownedVehicleModel alloc] initWithDict:modelDict andCategory:category];
                        [_vehicleModels addObject:model];
                    }];
                }
//                else {
//                    MPreownedVehicleModel *model = [[MPreownedVehicleModel alloc] initWithDict:modelDict andCategory:@"other"];
//                    [_vehicleModels addObject:model];
//                }
            }];
        }
    }
    
    return self;
}

- (instancetype)initWithId:(NSInteger)Id
                  withName:(NSString*)name
                withNameAR:(NSString*)nameAR
                  withLogo:(NSString *)logo
                   withUrl:(NSString *)url
              withRoadside:(NSString *)roadside
     withNoPreownedMessage:(NSString *)message
   withNoPreownedMessageAR:(NSString *)messageAR
            withOldestYear:(NSInteger)oldestYear
{
    if (self = [self init]){
        self.id = Id;
        self.name = name;
        self.nameAR = nameAR;
        self.logo = logo;
        self.url = url;
        self.roadsideAssistance = roadside;
        self.noPreownedMessage = message;
        self.noPreownedMessageAR = messageAR;
        self.oldestYear = oldestYear;
    }
    return self;
}

- (NSString *)name
{
    return [ATMGlobal isEnglish] ? _name : _nameAR;
}

- (NSString *)noPreownedMessage
{
    if ([ATMGlobal isEnglish]) {
        if (!_noPreownedMessage || [_noPreownedMessage isEqual:[NSNull null]] || _noPreownedMessage.length == 0) {
            return [NSString stringWithFormat:@"<div>%@</div>", LOCALIZED(@"TEXT NO PRE-OWNED ITEMS")];
        }
    } else {
        if (!_noPreownedMessageAR || [_noPreownedMessageAR isEqual:[NSNull null]] || _noPreownedMessageAR.length == 0) {
            return [NSString stringWithFormat:@"<div style=\"text-align: right\">%@</div>", LOCALIZED(@"TEXT NO PRE-OWNED ITEMS")];
        }
    }
    
    return [ATMGlobal isEnglish] ? _noPreownedMessage : [NSString stringWithFormat:@"<div style=\"text-align: right\">%@</div>", _noPreownedMessageAR];
}

@end
