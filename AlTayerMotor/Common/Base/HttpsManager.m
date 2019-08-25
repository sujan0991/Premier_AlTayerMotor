
//
//  HttpsManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "HttpsManager.h"
#import "AFNetworking.h"
#import "RequestUtils.h"
#import "MToken.h"
#import "LocalDataManager.h"
#import "DateManager.h"
#import "VehiclesFilterDisplayData.h"

#import "MResponse.h"
#import "MServiceRequest.h"
#import "MBookingTestRequest.h"
#import "MVehicleModel.h"
#import "MBrand.h"
#import "MBranch.h"
#import "MInsuranceRequest.h"
#import "MDrivingExperience.h"
#import "MPreownedBrand.h"
#import "MPreownedVehicleModel.h"
#import "MEnquiryRequest.h"
#import "MGlobalSetting.h"
#import "MOffer.h"

@interface HttpsManager()

@property (nonatomic, strong) AFSecurityPolicy* policy;
@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@end

@implementation HttpsManager

+ (id)sharedManager {
    static HttpsManager *sharedHttpsManager = nil;
    @synchronized(self) {
        if (sharedHttpsManager == nil)
            sharedHttpsManager = [[self alloc] init];
    }
    return sharedHttpsManager;
}

#pragma mark - Utility

- (id)payload:(id)dict
{
    return dict ? dict[@"payload"] : nil;
}

- (MResponse *)responseWithoutPayload:(NSDictionary *)responseDict
{
    MResponse *response = [[MResponse alloc] initWithDict:responseDict];
    return response;
}

- (BOOL)isDictionary:(id)dict
{
    return dict && ![dict isEqual:[NSNull null]] && [dict isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArray:(id)array
{
    return array && ![array isEqual:[NSNull null]] && [array isKindOfClass:[NSArray class]];
}

- (BOOL)isString:(id)string
{
    return string && ![string isEqual:[NSNull null]] && [string isKindOfClass:[NSString class]];
}



#pragma mark - Network

- (AFSecurityPolicy *)policy
{
    if (!_policy) {
        _policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        [_policy setValidatesDomainName:NO];
        [_policy setAllowInvalidCertificates:YES];
        NSString *sslPublicKeyPath = [[NSBundle mainBundle] pathForResource:@"pm" ofType:@"cer"];
        NSData *sslPublicKey = [NSData dataWithContentsOfFile:sslPublicKeyPath];
        [_policy setPinnedCertificates:@[sslPublicKey]];
    }
    
    return _policy;
}

- (AFURLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration ];
        AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *jsonAcceptableContentTypes = [NSMutableSet setWithSet:jsonResponseSerializer.acceptableContentTypes];
        [jsonAcceptableContentTypes addObject:@"text/plain"];
        jsonResponseSerializer.acceptableContentTypes = jsonAcceptableContentTypes;
        _sessionManager.responseSerializer = jsonResponseSerializer;
        //_sessionManager.securityPolicy = self.policy;

//        [_sessionManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition (NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential) {
//            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
//                DLog(@"challenge.protectionSpace.host");
//                if([challenge.protectionSpace.host isEqualToString:@"stg.altayermotors.com"]){
//                    *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//                    return NSURLSessionAuthChallengeUseCredential;
//                }
//            }
//            return NSURLSessionAuthChallengePerformDefaultHandling;
//        }];
    }
    
    return _sessionManager;
}



- (void)get:(NSString *)url params:(NSDictionary *)dictionary completion:(CompletionBlock)completion
{
    MToken *token = [[LocalDataManager sharedManager] token];
    if (!token || !token.accessToken || [token.accessToken isEqual:[NSNull null]] || token.accessToken.length == 0 ||
        [token needUpdate]) {
        [self generateTokenWithCompletion:^(NSDictionary *response, NSError *error) {
            if (!error) {
                MToken *token = [[MToken alloc] initWithDict:response];
                [[LocalDataManager sharedManager] setToken:token];
            }
            [self get:url params:dictionary completion:completion];
        }];
        return;
    }
    
    NSMutableDictionary *params = dictionary ? [dictionary mutableCopy] : [@{} mutableCopy];
    params[@"language"] = [ATMGlobal isEnglish] ? @"en" : @"ar";
    
    NSString *queryPath = [NSString URLQueryWithParameters:params];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, queryPath]];
    DLog(@"%@", [URL absoluteString]);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    // Add header
    NSString *tokenStr = [NSString stringWithFormat:@"bearer %@", token.accessToken];
    [request setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    request.timeoutInterval = 5;
    
    DLog(@"tokenStr: %@", tokenStr);
    
    // Configure Manager
    NSURLSessionDataTask *downloadTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        DLog(@"----");
        DLog(@"%@", request.URL);
        DLog(@"%@", responseObject);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
        completion(responseObject, error);
    }];
    [downloadTask resume];
}

- (void)postDict:(NSString *)url params:(NSDictionary *)params completion:(CompletionBlock)completion
{
    MToken *token = [[LocalDataManager sharedManager] token];
    if (!token || !token.accessToken || [token.accessToken isEqual:[NSNull null]] || token.accessToken.length == 0 ||
        [token needUpdate]) {
        [self generateTokenWithCompletion:^(NSDictionary *response, NSError *error) {
            if (!error) {
                DLog(@"%@", error);
                MToken *token = [[MToken alloc] initWithDict:response];
                [[LocalDataManager sharedManager] setToken:token];
            }
            [self postDict:url params:params completion:completion];
        }];
        return;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:0
                                                         error:&error];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = jsonData;
    request.timeoutInterval = 5;
    
    NSString* newStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@", newStr);
    
    // Add header
    NSString *tokenStr = [NSString stringWithFormat:@"bearer %@", token.accessToken];
    [request setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *downloadTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        completion(responseObject, error);
    }];
    [downloadTask resume];
}

- (void)postString:(NSString *)url params:(NSDictionary *)dictionary completion:(CompletionBlock)completion
{
//    MToken *token = [[LocalDataManager sharedManager] token];
//    if (!token || !token.accessToken || [token.accessToken isEqual:[NSNull null]] || token.accessToken.length == 0 ||
//        [token needUpdate]) {
//        [self generateTokenWithCompletion:^(NSDictionary *response, NSError *error) {
//            if (!error) {
//                MToken *token = [[MToken alloc] initWithDict:response];
//                [[LocalDataManager sharedManager] setToken:token];
//            }
//            [self postDict:url params:dictionary completion:completion];
//        }];
//        return;
//    }
    
    NSURL *URL = [NSURL URLWithString:url];
    NSString *queryPath = [NSString URLQueryWithParameters:dictionary];
    NSData *data = [queryPath dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    request.timeoutInterval = 5;
    
    NSURLSessionDataTask *downloadTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        completion(responseObject, error);
    }];
    [downloadTask resume];
}

- (void)postMultipart:(NSString *)url params:(NSDictionary *)params completion:(CompletionBlock)completion
{
    MToken *token = [[LocalDataManager sharedManager] token];
    if (!token || !token.accessToken || [token.accessToken isEqual:[NSNull null]] || token.accessToken.length == 0 ||
        [token needUpdate]) {
        [self generateTokenWithCompletion:^(NSDictionary *response, NSError *error) {
            if (!error) {
                MToken *token = [[MToken alloc] initWithDict:response];
                [[LocalDataManager sharedManager] setToken:token];
            }
            [self postMultipart:url params:params completion:completion];
        }];
        return;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (params && params.allKeys) {
            [params.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([params[key] isKindOfClass:[UIImage class]]) {
                    NSData* data = UIImageJPEGRepresentation(params[key], 0.9);
                    DLog(@"[%@]",[NSByteCountFormatter stringFromByteCount:data.length countStyle:NSByteCountFormatterCountStyleFile]);
                    [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
                } else if ([params[key] isKindOfClass:[NSNumber class]]) {
                    NSString *value = [NSString stringWithFormat:@"%@", params[key]];
                    NSData* data=[value dataUsingEncoding:NSUTF8StringEncoding];
                    [formData appendPartWithFormData:data name:key];
                } else {
                    NSData* data=[params[key] dataUsingEncoding:NSUTF8StringEncoding];
                    [formData appendPartWithFormData:data name:key];
                }
            }];
        }
    } error:nil];
    
    // Add header
//    MToken *token = [[LocalDataManager sharedManager] token];
    NSString *tokenStr = [NSString stringWithFormat:@"bearer %@", token.accessToken];
    [request setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [self.sessionManager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        completion(responseObject, error);
    }];
    
    [uploadTask resume];
}



#pragma mark - APIS
- (void)generateTokenWithCompletion:(CompletionBlock)completion
{
    NSDictionary *params = @{ @"grant_type" : @"password",
                             @"username" : kSystemUserName,
                             @"password" : kSystemPassword };
    [self postString:kEndpointToken params:params completion:^(id responseObject, NSError *error) {
        completion(responseObject, error);
    }];
}

- (void)getBrandsSince:(NSString *)date withCompletion:(CompletionBlock)completion
{
    NSDictionary *params = date ? @{ @"since" : date} : nil;
    
    [self get:kAPIBrands params:params completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadBrandsList *payload = [MPayloadBrandsList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *brands = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *brandDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MBrand *brand =[[MBrand alloc] initWithDict:brandDict];
                [brands addObject:brand];
            }];
            payload.brands = brands;
        }
        
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getPreownedBrandsSince:(NSString *)date
                withCompletion:(CompletionBlock)completion
{
    NSDictionary *params = date ? @{ @"since" : date} : nil;
    
    [self get:kAPIPreownedBrands params:params completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadBrandsList *payload = [MPayloadBrandsList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *brands = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *brandDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MPreownedBrand *brand =[[MPreownedBrand alloc] initWithDict:brandDict];
                [brands addObject:brand];
            }];
            payload.brands = brands;
        }
        
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getVehiclesInPage:(NSInteger)page
                  inBrand:(NSInteger)brandId
               withFilter:(VehiclesFilterDisplayData *)filter
           withCompletion:(CompletionBlock)completion
{
    NSDictionary *params = nil;
    
    if (filter.selectedModel ||
        filter.lowerPrice > 0 || filter.upperPrice > 0 ||
        filter.upperMileage > 0 ||
        filter.lowerYear > 0 || filter.upperPrice > 0)
    {
        NSDate *currentDate = [NSDate date];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:currentDate];
        NSInteger currentMonth = [components month];
        NSString *yearString = [[[DateManager sharedManager] yearFormatter] stringFromDate:currentDate];
        NSInteger currentYear = [yearString integerValue] + (currentMonth > 3 ? 1 : 0);
        NSInteger minYear = filter.oldestYear == 0 ? currentYear - 30 : filter.oldestYear;
        
        if (filter.selectedModel && ([filter.selectedModel.type isEqualToString:@"others"] || [filter.selectedModel.type isEqualToString:@"other"])) {
            filter.selectedModel.type = @"";
        }
        
        params = @{
                   @"page" : @(page),
                   @"lower_price" : @(MAX(0, filter.lowerPrice)*1000),
                   @"upper_price" : @(MIN(300, MAX(0, filter.upperPrice))*1000),
                   @"mileage" : @(MIN(200000, filter.upperMileage)),
                   @"lower_year" : @(MAX(minYear, filter.lowerYear)),
                   @"upper_year" : @(MIN(currentYear, filter.upperYear)),
                   @"model_id" : @(filter.selectedModel ? filter.selectedModel.id : 0),
                   @"vehicle_category" : [(filter.selectedModel ? filter.selectedModel.type : @"") lowercaseString]
                   };
    } else {
        params = @{
                   @"page" : @(page)
                   };
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%ld/vehicles", kAPIBrands, (long)brandId];
    [self get:url params:params completion:^(id response, NSError *error) {
        completion(response, error);
    }];
}

- (void)getCitiesWithCompletion:(CompletionBlock)completion
{
    NSString *url = [NSString stringWithFormat:@"%@", kAPICities];
    [self get:url params:@{} completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadCitiesList *payload = [MPayloadCitiesList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *cities = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *cityDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MCity *city =[[MCity alloc] initWithDict:cityDict];
                [cities addObject:city];
            }];
            payload.cities = cities;
        }
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getGlobalSettingsWithCompletion:(CompletionBlock)completion
{
    [self get:kAPIGlobalSetting params:@{} completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadGlobalSettingsList *payload = [MPayloadGlobalSettingsList new];
        
        NSDictionary *payloadDict = [self payload:responseDict];
        if ([self isDictionary:payloadDict]) {
            NSMutableArray *globalSettings = [@[] mutableCopy];
            
            NSArray *enquiries = payloadDict[@"enquiry"];
            if ([self isArray:enquiries]) {
                [enquiries enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MGlobalSetting *setting = [[MGlobalSetting alloc] initWithDict:obj withParentKey:@"enquiry" atIndex:idx];
                    [globalSettings addObject:setting];
                }];
            }
            
            enquiries = payloadDict[@"vehicle_enquiry"];
            if ([self isArray:enquiries]) {
                [enquiries enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MGlobalSetting *setting = [[MGlobalSetting alloc] initWithDict:obj withParentKey:@"vehicle_enquiry" atIndex:idx];
                    [globalSettings addObject:setting];
                }];
            }
            
            NSArray *offers = payloadDict[@"offer"];
            if ([self isArray:offers]) {
                [offers enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MGlobalSetting *setting = [[MGlobalSetting alloc] initWithDict:obj withParentKey:@"offer" atIndex:idx];
                    [globalSettings addObject:setting];
                }];
            }
            
            NSDictionary *motors800 = payloadDict[@"phone"];
            if ([self isDictionary:motors800]) {
                MGlobalSetting *setting = [[MGlobalSetting alloc] initWithDict:motors800 withParentKey:@"phone" atIndex:0];
                [globalSettings addObject:setting];
            }

            // Handle Disclaimer Message
            NSDictionary* messageDict = payloadDict[@"preowned_disclaimer_message"];
            if ([self isDictionary:messageDict]) {
                MGlobalSetting *setting = [[MGlobalSetting alloc] initWithDict:messageDict withParentKey:@"preowned_disclaimer_message" atIndex:0];
                setting.key = @"preowned_disclaimer_message";
                [globalSettings addObject:setting];
            }
            
            payload.globalSettings = globalSettings;
            
            // HANDLE IMAGE LINK
            NSString* imageLink = payloadDict[@"domain"];
            if ([self isString:imageLink]) {
                [ATMGlobal setImageLink:imageLink];
            }
        }
        
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getLocationsWithCompletion:(CompletionBlock)completion
{
    NSString *url = [NSString stringWithFormat:@"%@", kAPILocations];
    [self get:url params:@{} completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadLocationsList *payload = [MPayloadLocationsList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *locations = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *locationDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MLocation *location =[[MLocation alloc] initWithDict:locationDict];
                [locations addObject:location];
            }];
            payload.locations = locations;
        }
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getDrivingExperiencesWithCompletion:(CompletionBlock)completion
{
    NSString *url = [NSString stringWithFormat:@"%@", kAPIDrivingExp];
    [self get:url params:@{} completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadDrivingExperiencesList *payload = [MPayloadDrivingExperiencesList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *drivingExperiences = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *drivingExperienceDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MDrivingExperience *drivingExperience =[[MDrivingExperience alloc] initWithDict:drivingExperienceDict];
                [drivingExperiences addObject:drivingExperience];
            }];
            payload.drivingExperiences = drivingExperiences;
        }
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)postBookService:(MServiceRequest *)request
         withCompletion:(CompletionBlock)completion
{
    NSDictionary *params = @{};
    if (request.otherBrand && request.otherBrand.length > 0) {
        if (request.otherModel && request.otherModel.length > 0) {
            params = @{
                       @"other_brand" : request.otherBrand,
                       @"other_model" : request.otherModel,
                       @"year" : @(request.year),
                       @"registration_number" : request.registrationNumber,
                       @"mileage" : @(request.mileage),
                       @"branch_id" : @(request.location.Id),
                       @"first_name" : request.firstName,
                       @"last_name" : request.lastName,
                       @"phone_number" : [NSString stringWithFormat:@"%@ %@", request.phoneCode, request.phoneNumber],
                       @"email" : request.email
                       };
        } else {
            params = @{
                       @"other_brand" : request.otherBrand,
                       @"year" : @(request.year),
                       @"registration_number" : request.registrationNumber,
                       @"mileage" : @(request.mileage),
                       @"branch_id" : @(request.location.Id),
                       @"first_name" : request.firstName,
                       @"last_name" : request.lastName,
                       @"phone_number" : [NSString stringWithFormat:@"%@ %@", request.phoneCode, request.phoneNumber],
                       @"email" : request.email
                       };
        }
    } else {
        if (request.otherModel && request.otherModel.length > 0) {
            params = @{
                       @"brand_id" : @(request.brand.id),
                       @"other_model" : request.otherModel,
                       @"year" : @(request.year),
                       @"registration_number" : request.registrationNumber,
                       @"mileage" : @(request.mileage),
                       @"branch_id" : @(request.location.Id),
                       @"first_name" : request.firstName,
                       @"last_name" : request.lastName,
                       @"phone_number" : [NSString stringWithFormat:@"%@ %@", request.phoneCode, request.phoneNumber],
                       @"email" : request.email
                       };
        } else {
            params = @{
                       @"brand_id" : @(request.brand.id),
                       @"model_id" : @(request.model.id),
                       @"year" : @(request.year),
                       @"registration_number" : request.registrationNumber,
                       @"mileage" : @(request.mileage),
                       @"branch_id" : @(request.location.Id),
                       @"first_name" : request.firstName,
                       @"last_name" : request.lastName,
                       @"phone_number" : [NSString stringWithFormat:@"%@ %@", request.phoneCode, request.phoneNumber],
                       @"email" : request.email
                       };
        }
    }
    
    [self postDict:kAPIBookingService params:params completion:^(id response, NSError *error) {
        if (error) {
            DLog(@"%@", error);
            completion(nil, error);
            return ;
        }

        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadResult *payload = [MPayloadResult new];
        if (response[@"payload"]) {
            payload.success = [response[@"payload"] boolValue];
        }
        mResponse.payload = payload;
        
        completion(mResponse, error);
    }];
}

- (void)postBookTest:(MBookingTestRequest *)request
      withCompletion:(CompletionBlock)completion
{
    NSDictionary *params = @{ @"brand_id" : @(request.brand.id),
                              @"model_id" : @(request.model.id),
                              @"branch_id" : @(request.location.Id),
                              @"first_name" : request.firstName,
                              @"last_name" : request.lastName,
                              @"phone_number" : request.phoneNumber,
                              @"city" : request.city.key,
                              @"email" : request.email,
                              @"dob" : [[[DateManager sharedManager] postFormatter] stringFromDate:request.birthday],
                              @"is_subscribe" : @(request.isReceivedInfor)
                              };
    
    [self postDict:kAPIBookingTest params:params completion:^(id response, NSError *error) {
        if (error) {
            DLog(@"%@", error);
            completion(nil, error);
            return ;
        }
        DLog(@"%@", response);
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadResult *payload = [MPayloadResult new];
        if (response[@"payload"]) {
            payload.success = [response[@"payload"] boolValue];
        }
        mResponse.payload = payload;
        
        completion(mResponse, error);
    }];
}

- (void)postInsuranceRequest:(MInsuranceRequest *)request
              withCompletion:(CompletionBlock)completion
{
    NSMutableDictionary *params = [@{
                            @"first_name" : request.firstName,
                            @"last_name" : request.lastName,
                            @"birthday" : [[[DateManager sharedManager] dateFormatter] stringFromDate:request.birthday],
                            @"city" : request.city.key,
                            @"phone_number" : [NSString stringWithFormat:@"%@ %@", request.phoneCode, request.phoneNumber],
                            @"driving_experience" : request.drivingExperience
                            } mutableCopy];
    
    if (request.frontCard) {
        params[@"card_front"] = request.frontCard;
    }
    
    if (request.backCard) {
        params[@"card_back"] = request.backCard;
    }
    
    DLog(@"%@", params);
    [self postMultipart:kAPIInsurance params:params completion:^(id response, NSError *error) {
        if (error) {
            DLog(@"%@", error);
            completion(nil, error);
            return ;
        }
        DLog(@"%@", response);
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadResult *payload = [MPayloadResult new];
        if (response[@"payload"]) {
            payload.success = [response[@"payload"] boolValue];
        }
        mResponse.payload = payload;
        
        completion(mResponse, error);
    }];
}

- (void)postEnquiryRequest:(MEnquiryRequest *)request
            withCompletion:(CompletionBlock)completion
{
    NSMutableDictionary *params = [@{
                             @"first_name" : request.firstName,
                             @"last_name" : request.lastName,
                             @"phone_number" : [NSString stringWithFormat:@"%@ %@", request.phoneCode, request.phoneNumber],
                             @"enquiry" : request.enquiry,
                             @"message" : request.message
                              } mutableCopy];
    
    if ([request.enquiry isEqualToString:@"Vehicle Enquiry"]) {
        params[@"vehicle_enquiry"] = request.type;
        
        if ([[request.type lowercaseString] isEqualToString:@"pre-owned"]) {
            params[@"brand_id"] = @(request.preownedBrand.id);
            
            if (request.preownedModel) {
                params[@"model_id"] = @(request.preownedModel.id);
            }
        } else {
            params[@"brand_id"] = @(request.brand.id);
            
            if (request.model) {
                params[@"model_id"] = @(request.model.id);
            }
        }
    }
    
    [self postDict:kAPIEnquiry params:params completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadResult *payload = [MPayloadResult new];
        if (response[@"payload"]) {
            payload.success = [response[@"payload"] boolValue];
        }
        mResponse.payload = payload;
        
        completion(mResponse, error);
    }];
}

- (void)getBrandOffers:(NSInteger)brandId
        withCompletion:(CompletionBlock)completion
{
    NSString *url = [NSString stringWithFormat:@"%@/%ld/latest", kAPIOffersBrands, (long)brandId];
    [self get:url params:nil completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadOffersList *payload = [MPayloadOffersList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *offers = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *offerDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MOffer *offer =[[MOffer alloc] initWithDict:offerDict];
                [offers addObject:offer];
            }];
            payload.offers = offers;
        }
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getLatestOffersWithCompletion:(CompletionBlock)completion
{
    NSString *url = [NSString stringWithFormat:@"%@", kAPIOffersLatest];
    [self get:url params:nil completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadOffersList *payload = [MPayloadOffersList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *offers = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *offerDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MOffer *offer =[[MOffer alloc] initWithDict:offerDict];
                [offers addObject:offer];
            }];
            payload.offers = offers;
        }
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

- (void)getOffersWithCompletion:(CompletionBlock)completion
{
    NSString *url = [NSString stringWithFormat:@"%@", kAPIOffersAll];
    [self get:url params:nil completion:^(id response, NSError *error) {
        if (error) {
            completion(nil, error);
            return ;
        }
        
        NSDictionary *responseDict = (NSDictionary *)response;
        MResponse *mResponse = [self responseWithoutPayload:responseDict];
        MPayloadOffersList *payload = [MPayloadOffersList new];
        
        NSArray *payloadArr = [self payload:responseDict];
        if ([self isArray:payloadArr]) {
            NSMutableArray *offers = [@[] mutableCopy];
            [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *offerDict, NSUInteger idx, BOOL * _Nonnull stop) {
                MOffer *offer =[[MOffer alloc] initWithDict:offerDict];
                [offers addObject:offer];
            }];
            payload.offers = offers;
        }
        mResponse.payload = payload;
        completion(mResponse, nil);
    }];
}

@end
