//
//  LoadingViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/14/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LoadingViewController.h"
#import "HttpsManager.h"

#import "ViewUtils.h"
#import "DGActivityIndicatorView.h"

@interface LoadingViewController ()
@property (weak, nonatomic) UIImageView *imvBackground;
@property (strong, nonatomic) UIImageView *imvLogo;
@property (strong, nonatomic) DGActivityIndicatorView *activityIndicatorView;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateToken
{
    [self.eventHandler generateToken];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self doEntranceAnimation];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupViews
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width * screenScale) ;
    NSNumber *screenHeight = @([UIScreen mainScreen].bounds.size.height * screenScale);
    NSString *background = [NSString stringWithFormat:@"background-%@-%@", screenWidth, screenHeight];
    self.imvBackground.image = [UIImage imageNamed:background];
    
    self.imvLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_logo"]];
    self.imvLogo.frame = CGRectMake(0, 0, 242, 63);
    self.imvLogo.center = self.view.center;
    self.imvLogo.transform =CGAffineTransformMakeScale(0.01, 0.01);
    self.imvLogo.alpha = 0.0;
    [self.view addSubview:self.imvLogo];
    
    self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor] size:20.0f];
    self.activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    self.activityIndicatorView.center = CGPointMake(self.imvLogo.center.x, self.imvLogo.center.y + 60);
    self.activityIndicatorView.alpha = 0.0f;
    [self.view addSubview:self.activityIndicatorView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

#pragma mark - Navigation
- (void)showFirstTimeInterface
{
    [self.eventHandler showFirstTimeInterface];
}

- (void)showMainInterface
{
    [self.eventHandler showMainInterface];
}

#pragma mark - View Interface
- (void)startLoadingIndicator
{
    [self.activityIndicatorView startAnimating];
}

- (void)stopLoadingIndicator
{
    [self.activityIndicatorView stopAnimating];
}

- (void)showAlertMessage:(NSString *)message
{
    [self showMessage:message];
}

#pragma mark - Animation
- (void)doEntranceAnimation
{
    [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imvLogo.transform =CGAffineTransformMakeScale(1.0, 1.0);
        self.imvLogo.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.activityIndicatorView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self generateToken];
        }];
    }];
}

- (void)doExitAnimation
{
    [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.activityIndicatorView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.imvLogo.transform =CGAffineTransformMakeScale(2.0, 2.0);
            self.imvLogo.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.eventHandler showNextInterface];
        }];
    }];
}

@end
