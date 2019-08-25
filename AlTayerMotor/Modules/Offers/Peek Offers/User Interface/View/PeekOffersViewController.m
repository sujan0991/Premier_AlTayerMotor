//
//  PeekOffersViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "PeekOffersViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PeekOfferCell.h"
#import "iCarousel.h"
#import "TapDetectingImageView.h"
#import "MOffer.h"

#import "NSString+Utils.h"
#import "UIView+Roundify.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 2.0

@interface PeekOffersViewController () <iCarouselDataSource, iCarouselDelegate, UIScrollViewDelegate, TapDetectingImageViewDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;
@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, assign) NSInteger startIndex;
@end

@implementation PeekOffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DLog(@"%lu - %lu", (unsigned long)self.offers.count, self.startIndex);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.iCarousel scrollToItemAtIndex:self.startIndex animated:NO];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - View Interface
- (void)setOffersData:(NSArray *)data withDefaultIndex:(NSInteger)index
{
    self.offers = data;
    self.startIndex = index;
}

#pragma mark - CollectionView Datasource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.offers count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        
        view = [[UIScrollView alloc] initWithFrame:self.pageFrame];
        ((UIScrollView *)view).delegate = self;
        ((UIScrollView *)view).minimumZoomScale = 1.0;
        ((UIScrollView *)view).maximumZoomScale = 5.0;
        ((UIScrollView *)view).decelerationRate = UIScrollViewDecelerationRateFast;
        ((UIScrollView *)view).contentSize = self.pageFrame.size;
        
        TapDetectingImageView *imageView = [[TapDetectingImageView alloc] initWithFrame:self.pageFrame];
        imageView.tag = ZOOM_VIEW_TAG;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.delegate = self;
        [view addSubview:imageView];
    }
    
    MOffer *offer = self.offers[index];
    [((TapDetectingImageView *)[view viewWithTag:ZOOM_VIEW_TAG]) sd_setImageWithURL:[NSURL URLWithString:[offer.posterUrl toImageLink]]
                                          placeholderImage:[UIImage imageNamed:@"placeholder_car"]
                                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                     UIImage *roundedImage = [self makeRoundedImage:image radius:8];
                                                     [((TapDetectingImageView *)[view viewWithTag:ZOOM_VIEW_TAG]) setImage:roundedImage];
                                                 }];
    return view;
}

-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value + 10.f/self.pageFrame.size.width;
//        return value;
    }
    return value;
}

- (CGRect)pageFrame {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
//    return CGRectMake(0, 0, screenWidth - 30, screenHeight);
    return CGRectMake(0, 0, screenWidth, screenHeight);
}

#pragma mark - Actions
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:ZOOM_VIEW_TAG];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)tapDetectingImageView:(TapDetectingImageView *)view gotSingleTapAtPoint:(CGPoint)tapPoint {
    // single tap does nothing for now
}

- (void)tapDetectingImageView:(TapDetectingImageView *)view gotDoubleTapAtPoint:(CGPoint)tapPoint {
    // double tap zooms in
    if ([view.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view.superview;
        float newScale = [scrollView zoomScale] * ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:tapPoint inScrollView:scrollView];
        [scrollView zoomToRect:zoomRect animated:YES];
    }
    
}

- (void)tapDetectingImageView:(TapDetectingImageView *)view gotTwoFingerTapAtPoint:(CGPoint)tapPoint {
    // two-finger tap zooms out
    if ([view.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view.superview;
        float newScale = [scrollView zoomScale] / ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:tapPoint inScrollView:scrollView];
        [scrollView zoomToRect:zoomRect animated:YES];
    }
    
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center inScrollView:(UIScrollView *)scrollView {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
@end
