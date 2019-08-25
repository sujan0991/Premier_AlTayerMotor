//
//  LocationViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LocationViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "UIView+Border.h"
#import "MLocation.h"
#import "InfoWindow.h"
#import "UIView+Roundify.h"
#import "MDDirectionService.h"
#import "ViewUtils.h"

@interface LocationViewController() <GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>
{
    BOOL isFilteringShowRoom;
    BOOL isFilteringService;
    BOOL isFilteringBodyShop;
    NSMutableArray *waypoints;
    NSInteger currentTimestamp;
    GMSPolyline *polyline;
}

@property (strong, nonatomic) NSArray *locations;

@property (weak, nonatomic) IBOutlet UIButton *btnShowRoom;
@property (weak, nonatomic) IBOutlet UIButton *btnService;
@property (weak, nonatomic) IBOutlet UIButton *btnBodyShop;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *btnRoute;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSMutableArray *filterLocations;
@property (assign, nonatomic) BOOL showCurrentLocation;
@property (weak, nonatomic) IBOutlet UILabel *lbFilter;
@property (weak, nonatomic) IBOutlet UIView *viewFilter;

@end

@implementation LocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    [self setupViews];
    [self setupMap];
    [self.eventHandler findLocations];
    [self layoutByLanguage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.locationManager startUpdatingLocation];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenLocateBranch];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)layoutByLanguage
{
    self.navigationItem.title = LOCALIZED(@"TEXT TITLE FIND LOCATION");
    [self.navigationController.navigationBar.layer setAffineTransform:LANGUAGE_TRANSFORM];
    for (UIView *subview in [self.navigationController.navigationBar allSubviews]) {
        if ([subview isKindOfClass:[UILabel class]]) {
            AFFINE_TRANSFORM(subview);
        }
    }
    
    _lbFilter.text = LOCALIZED(@"TEXT FILTER");
    TEXT_ALIGN(_tfSearch);
    _tfSearch.placeholder = LOCALIZED(@"TEXT NEARBY");
    AFFINE_TRANSFORM(_viewFilter);
    AFFINE_TRANSFORM(_lbFilter);
    AFFINE_TRANSFORM(_btnBodyShop);
    AFFINE_TRANSFORM(_btnShowRoom);
    AFFINE_TRANSFORM(_btnService);
}


- (void)updateLocations:(NSArray *)locations
{
    self.locations = locations;
    
    // update view
    if (self.locations) {
        [self.mapView animateToZoom:0];
        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
        for (MLocation *location in self.locations) {
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(location.latitude, location.longitude);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            bounds = [bounds includingCoordinate:marker.position];
        }
        [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:150.f]];
    }
    
    [self chooseBodyShopAction:nil];
    [self chooseServiceAction:nil];
    [self chooseShowRoomAction:nil];
    [self showMarkersAtLocations:self.locations];
}

- (void)callToLocation:(MLocation *)location
{
    if (location && location.phoneNumber && ![location.phoneNumber isEqual:[NSNull null]] && location.phoneNumber.length > 0) {
        [ATMGlobal callPhoneNumber:location.phoneNumber];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"This location has no phone number" delegate:nil cancelButtonTitle:LOCALIZED(@"TEXT OK") otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)routeToLocation:(MLocation *)location
{
    NSString *link = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude, location.latitude, location.longitude];
    NSURL *URL = [NSURL URLWithString:link];
    [[UIApplication sharedApplication] openURL:URL];
//    if (polyline) {
//        polyline.map = nil;
//        polyline = nil;
//    }
//    
//    [waypoints removeAllObjects];
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
//                                                                 self.currentLocation.coordinate.latitude,
//                                                                 self.currentLocation.coordinate.longitude);
//    GMSMarker *currentMarker = [GMSMarker markerWithPosition:position];
//    [waypoints addObject:currentMarker];
//    
//    CLLocationCoordinate2D tappedPosition = CLLocationCoordinate2DMake(location.latitude, location.longitude);
//    GMSMarker *marker = [GMSMarker markerWithPosition:tappedPosition];
//    [waypoints addObject:marker];
//    
//    NSArray *waypointStrings = [waypoints linq_select:^id(GMSMarker *item) {
//        return [NSString stringWithFormat:@"%f,%f", item.position.latitude, item.position.longitude];
//    }];
//    
//    NSString *sensor = @"false";
//    NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings, nil];
//    
//    NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
//    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
//                                                      forKeys:keys];
//    MDDirectionService *mds=[[MDDirectionService alloc] init];
//    SEL selector = @selector(addDirections:);
//    [mds setDirectionsQuery:query
//               withSelector:selector
//               withDelegate:self];
}

#pragma mark - UI
- (void)setupViews
{
    [self.tfSearch addBottomLine];
    
    // setup Icon Search
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction:)];
    tapGesture.numberOfTapsRequired = 1;
    [imageView  addGestureRecognizer:tapGesture];
    
    if ([ATMGlobal isEnglish]) {
        [_tfSearch setRightView:imageView];
        [_tfSearch setRightViewMode:UITextFieldViewModeAlways];
    } else {
        [_tfSearch setLeftView:imageView];
        [_tfSearch setLeftViewMode:UITextFieldViewModeAlways];
    }
    
    _btnBodyShop.adjustsImageWhenHighlighted = NO;
    _btnService.adjustsImageWhenHighlighted = NO;
    _btnShowRoom.adjustsImageWhenHighlighted = NO;
    
}

- (void)setupMap
{
    waypoints = [[NSMutableArray alloc]init];
    self.filterLocations = [@[] mutableCopy];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    _mapView.delegate = self;
    _mapView.myLocationEnabled = YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = locations.lastObject;
    
    if (_showCurrentLocation) {
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
        
        [self.mapView animateToLocation:target];
        [self.mapView animateToZoom:12];
        _showCurrentLocation = NO;
    }

    [self.locationManager stopUpdatingLocation];
}

- (void)showMarkersAtLocations:(NSArray *)locations
{
    if (locations) {
        [_mapView clear];
        [self.filterLocations removeAllObjects];
        NSMutableSet *filter = [[NSMutableSet alloc] init];
        
        if (isFilteringBodyShop) {
            [filter addObjectsFromArray:[locations linq_where:^BOOL(id item) {
                return [item isBodyShop];
            }]];
        }
        
        if (isFilteringService) {
            [filter addObjectsFromArray:[locations linq_where:^BOOL(id item) {
                return [item isServiceCenter];
            }]];
        }
        
        if (isFilteringShowRoom) {
            [filter addObjectsFromArray:[locations linq_where:^BOOL(id item) {
                return [item isShowRoom];
            }]];
        }
        
        [self.filterLocations addObjectsFromArray:[filter allObjects]];
        
        for (MLocation *location in self.filterLocations) {
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(location.latitude, location.longitude);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = [NSString stringWithFormat:@"%ld", (long)location.Id];
            marker.map = _mapView;
            if (location.isShowRoom && isFilteringShowRoom) {
                marker.icon = [UIImage imageNamed:@"marker_showroom"];
            }  else if (location.isServiceCenter && isFilteringService) {
                marker.icon = [UIImage imageNamed:@"marker_service"];
            } else {
                marker.icon = [UIImage imageNamed:@"marker_bodyshop"];
            }
        }
    }
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    MLocation *location = [[self.locations linq_where:^BOOL(id item) {
        return [item Id] == [[marker title] integerValue];
    }] linq_firstOrNil];
    
    InfoWindow *view =  [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"InfoWindow%@", [ATMGlobal isEnglish] ? @"" : @"AR"]
                                                       owner:self
                                                     options:nil] objectAtIndex:0];
    view.lbName.text = location.name;
    view.lbCity.text = location.city;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    if ([location isValidString:location.openHourTitle1] && location.openHourTitle1.length > 0) {
        NSString *string = [NSString stringWithFormat:@"%@\n%@", TRIM(location.openHourTitle1), TRIM(location.openHourValue1)];
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont boldSystemFontOfSize:12]
                                 range:NSMakeRange(0, location.openHourTitle1.length)];
        view.lbFirst.attributedText = attributedString;
    } else {
        view.lbFirst.text = @"";
    }
    
    if ([location isValidString:location.openHourTitle2] && location.openHourTitle2.length > 0) {
        NSString *string = [NSString stringWithFormat:@"%@\n%@", TRIM(location.openHourTitle2), TRIM(location.openHourValue2)];
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont boldSystemFontOfSize:12]
                                 range:NSMakeRange(0, location.openHourTitle2.length)];
        view.lbSecond.attributedText = attributedString;
    } else {
        view.lbSecond.text = @"";
    }
    
    if ([location isValidString:location.openHourTitle3] && location.openHourTitle3.length > 0) {
        NSString *string = [NSString stringWithFormat:@"%@\n%@", TRIM(location.openHourTitle3), TRIM(location.openHourValue3)];
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont boldSystemFontOfSize:12]
                                 range:NSMakeRange(0, location.openHourTitle3.length)];
        view.lbThird.attributedText = attributedString;
    } else {
        view.lbThird.text = @"";
    }
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callGesture:)];
    [view.bgView addGestureRecognizer:letterTapRecognizer];
    
    [view layoutIfNeeded];
    [view.bgView addRoundedCorners:UIRectCornerAllCorners
                         withRadii:CGSizeMake(4, 4)];
    
    return view;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    MLocation *location = [[self.locations linq_where:^BOOL(id item) {
        return [item Id] == [[marker title] integerValue];
    }] linq_firstOrNil];
    
    [self.eventHandler showSelectionsInLocation:location];
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    return NO;
}

- (void)addDirections:(NSDictionary *)json {
    
    if (json && ![json isEqual:[NSNull null]] && json[@"routes"] && [json[@"routes"] count] > 0) {
        NSDictionary *routes = [json objectForKey:@"routes"][0];
        
        NSDictionary *route = [routes objectForKey:@"overview_polyline"];
        NSString *overview_route = [route objectForKey:@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
        polyline = [GMSPolyline polylineWithPath:path];
        polyline.map = _mapView;
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Could not find a route" delegate:nil cancelButtonTitle:LOCALIZED(@"TEXT OK") otherButtonTitles:nil];
        [alertView show];
    }
    
}

#pragma mark - Actions
- (IBAction)chooseShowRoomAction:(id)sender {
    isFilteringShowRoom = !isFilteringShowRoom;
    NSString *imageNamed = [NSString stringWithFormat:@"btn_showroom_%@", isFilteringShowRoom ? @"on" : @"off"];
    [self.btnShowRoom setImage:IMAGE_MULTIPLE_LANGUAGE(imageNamed)
                      forState:UIControlStateNormal];
    [[self.btnShowRoom imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self showMarkersAtLocations:self.locations];
}

- (IBAction)chooseServiceAction:(id)sender {
    isFilteringService = !isFilteringService;
    NSString *imageNamed = [NSString stringWithFormat:@"btn_service_%@", isFilteringService ? @"on" : @"off"];
    [self.btnService setImage:IMAGE_MULTIPLE_LANGUAGE(imageNamed)
                      forState:UIControlStateNormal];
    [[self.btnService imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self showMarkersAtLocations:self.locations];
}

- (IBAction)chooseBodyShopAction:(id)sender {
    isFilteringBodyShop = !isFilteringBodyShop;
    NSString *imageNamed = [NSString stringWithFormat:@"btn_bodyshop_%@", isFilteringBodyShop ? @"on" : @"off"];
    [self.btnBodyShop setImage:IMAGE_MULTIPLE_LANGUAGE(imageNamed)
                      forState:UIControlStateNormal];
    [[self.btnBodyShop imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self showMarkersAtLocations:self.locations];
}

- (void)callGesture:(UITapGestureRecognizer*)sender {
    UIView *view = sender.view;
    NSLog(@"%ld", (long)view.tag);//By tag, you can find out where you had tapped.
}

- (IBAction)routeAction:(id)sender {
    if (self.locationManager) {
        _showCurrentLocation = YES;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        DLog();
    }
}

- (IBAction)searchAction:(id)textField
{
    [self.tfSearch resignFirstResponder];
    if (self.tfSearch.text.length > 0) {
        [[GMSPlacesClient sharedClient] autocompleteQuery:self.tfSearch.text bounds:nil filter:nil callback:^(NSArray * _Nullable results, NSError * _Nullable error) {
            if (results && results.count > 0) {
                GMSAutocompletePrediction *prediction = results[0];
                [[GMSPlacesClient sharedClient] lookUpPlaceID:prediction.placeID callback:^(GMSPlace * _Nullable result, NSError * _Nullable error) {
                    if (result) {
                        CLLocationCoordinate2D target =
                        CLLocationCoordinate2DMake(result.coordinate.latitude, result.coordinate.longitude);
                        
                        [self.mapView animateToLocation:target];
                        [self.mapView animateToZoom:10];
                        
                    }
                }];
            }
        }];
    }

}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchAction:nil];
    return YES;
}

@end
