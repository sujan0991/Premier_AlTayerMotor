//
//  GTMHelper.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/6/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "GTMHelper.h"
#import "TAGManager.h"
#import "TAGContainerOpener.h"
#import "TAGContainer.h"
#import "TAGDataLayer.h"

@interface GTMHelper() <TAGContainerOpenerNotifier, TAGContainerCallback>
@property (nonatomic, strong) TAGContainer *container;
@end

@implementation GTMHelper

#pragma mark - Init functions
+ (instancetype)sharedInstance {
    static GTMHelper *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startApplicationEvent {
    if (kGTMEnable) {
        
        // Optional: Change the LogLevel to Verbose to enable logging at VERBOSE and higher levels.
        [[[TAGManager instance] logger] setLogLevel:kTAGLoggerLogLevelNone];
        
        // set interval to report to GTM
        [[TAGManager instance] setDispatchInterval:10.0];
        
        /*
         * Opens a container.
         *
         * @param containerId The ID of the container to load.
         * @param tagManager The TAGManager instance for getting the container.
         * @param openType The choice of how to open the container.
         * @param timeout The timeout period (default is 2.0 seconds).
         * @param notifier The notifier to inform on container load events.
         */
        
        /*
         *  kGTMGContainerID is GTM-TFK4DX in production mode (DN's container)
         *  kGTMGContainerID is GTM-K53XPL in devlopment mode (Mobility's container) or
         *
         */
        // kGTMGContainerID is
        [TAGContainerOpener openContainerWithId:kGTMGContainerID
                                     tagManager:[TAGManager instance]
                                       openType:kTAGOpenTypePreferFresh
                                        timeout:nil
                                       notifier:self];
        
    }
}

- (void)logEvent:(NSString *)event
{
    [self logEvent:event inScreenName:nil withAdditionalData:nil];
}

- (void)logEvent:(NSString *)event inScreenName:(NSString *)screenName
{
    [self logEvent:event inScreenName:screenName withAdditionalData:nil];
}

- (void)logEvent:(NSString *)event inScreenName:(NSString *)screenName withAdditionalData:(NSDictionary *)data
{
    if (kGTMEnable) {
        NSMutableDictionary *gtmDict = [@{} mutableCopy];
        
        if (event && event.length > 0) {
            gtmDict[@"event"] = event;
        }
        
        if (screenName && screenName.length > 0) {
            gtmDict[@"screenName"] = screenName;
        }
        
        if (data) {
            for (NSString *key in [data allKeys]) {
                if ([key isEqualToString:@"event"] || [key isEqualToString:@"screenName"] ) {
                    continue;
                }
                
                gtmDict[key] = data[key];
            }
        }
        

        gtmDict[@"appName"] = @"Al Tayer Motors";
        NSLog(@"send GTM:%@", gtmDict);
        [[TAGManager instance].dataLayer push:gtmDict];
        
        for (NSString *key in [gtmDict allKeys]) {
            gtmDict[key] = [NSNull null];
        }
        [[TAGManager instance].dataLayer push:gtmDict];
        
    }
}

#pragma mark - Container Opener Notifier

// TAGContainerOpenerNotifier callback.
- (void)containerAvailable:(TAGContainer *)container {
    // Note that containerAvailable may be called on any thread, so you may need to dispatch back to
    // your main thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.container = container;
        DLog(@"Updated Container!");
        [[GTMHelper sharedInstance] logEvent:kEventAppLaunch];
        // Get the configuration value by key.
    });
}

#pragma mark - Callback Helper

/**
 * Called before the refresh is about to begin.
 *
 * @param container The container being refreshed.
 * @param refreshType The type of refresh which is starting.
 */
- (void)containerRefreshBegin:(TAGContainer *)container
                  refreshType:(TAGContainerCallbackRefreshType)refreshType {
    // Notify UI that container refresh is beginning.
    NSLog(@"---> Begin refreshing new container");
}

/**
 * Called when a refresh has successfully completed for the given refresh type.
 *
 * @param container The container being refreshed.
 * @param refreshType The type of refresh which completed successfully.
 */
- (void)containerRefreshSuccess:(TAGContainer *)container
                    refreshType:(TAGContainerCallbackRefreshType)refreshType {
    // Notify UI that container is available.
    NSLog(@"---> Refresh succeeded new container");
}

/**
 * Called when a refresh has failed to complete for the given refresh type.
 *
 * @param container The container being refreshed.
 * @param failure The reason for the refresh failure.
 * @param refreshType The type of refresh which failed.
 */
- (void)containerRefreshFailure:(TAGContainer *)container
                        failure:(TAGContainerCallbackRefreshFailure)failure
                    refreshType:(TAGContainerCallbackRefreshType)refreshType {
    // Notify UI that container request has failed.
    NSLog(@"ERROR:Refresh failed new container");
}

/*
 *  Refresh Container
 *  ----------
 *  Utils function to force to get new container from the server
 */
- (void)refreshNewContainer {
    if (self.container) {
        [self.container refresh];
    }
}


@end
