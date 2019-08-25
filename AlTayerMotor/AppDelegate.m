//
//  AppDelegate.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <GoogleMaps/GoogleMaps.h>

#import "AppDependencies.h"
#import "GTMHelper.h"
#import "DataManager.h"
#import "DateManager.h"
#import "CoreDataStore.h"
#import "MRegisteredVehicle.h"
#import "TestFairy.h"

static NSString * const kATMStoreName = @"AlTayerMotors.sqlite";

@interface AppDelegate ()

@property (nonatomic, strong) AppDependencies *dependencies;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"Doc path: %@", paths[0]);
    // update setting app
    
    
    // Test Fairy
    [TestFairy begin:@"3b4d113b3fbeda9bc79cb79832fbe21fd6a3bdc7"];
    
    // Init google tag manager
    [[GTMHelper sharedInstance] startApplicationEvent];
    
    // Override point for customization after application launch.
    // Initialize Google Map
    [GMSServices provideAPIKey:kGoogleMapKey];
    
    // Initialize Fabric
    [Fabric with:@[[Crashlytics class]]];

    // Magical Record
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
    [MagicalRecord setupCoreDataStack];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [[DataManager sharedManager] importDefaultData];
    
    // Register Push Notification
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    [self setupRemotePushNotification];
    
    // Custom user interface
    [self setupUI];
    
    // Show root view file
    [self startApplication];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Log App Launch
    DLog();
    [[GTMHelper sharedInstance] logEvent:kEventAppLaunch];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupUI
{
    // TAB BAR
    UIImage *tabBarBackground = nil;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0") && SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        tabBarBackground = [UIImage imageNamed:@"tab_bar_49"];
    } else {
        tabBarBackground = [UIImage imageNamed:@"tab_bar_56"];
    }
    
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"transparent_shadow"]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    // NAVIGATION BAR
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:21.f]}];
    
    // BACK BUTTON
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"icon_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back"]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)setupRemotePushNotification
{
    // Cancel all curren local notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // load current
    NSArray *registeredVehicles = [[CoreDataStore sharedStore] fetchAllRegisteredVehicles];
    for (MRegisteredVehicle *vehicle in registeredVehicles) {
        NSString *dateStr = vehicle.registrationExpiry;
        NSDate *date = [[[DateManager sharedManager] presentedDateFormatter] dateFromString:dateStr];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate =
        [[NSCalendar currentCalendar] isDateInToday:date] ? [NSDate dateWithTimeIntervalSinceNow:20] : date;
        localNotification.alertBody = @"Your car registration is due on today. Please renew your car insurance before your registration expires.";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (void)startApplication
{
    self.dependencies = [AppDependencies new];
    [self.dependencies installRootViewControllerIntoWindow:self.window];
}

@end
