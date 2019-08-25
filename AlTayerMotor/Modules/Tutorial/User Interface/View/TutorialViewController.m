//
//  TutorialViewController.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "TutorialViewController.h"
#import "ViewUtils.h"
#import "StyledPageControl.h"

#define kNumberPages 6

@interface TutorialViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) StyledPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    [self setupPageControl];
    [_btnContinue setTitle:LOCALIZED(@"TEXT GOT IT")
                  forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Log Event
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenUserTutorial
                      withAdditionalData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < kNumberPages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, self.scrollView.height)];
        view.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        NSString* imageName = [NSString stringWithFormat:@"first_time_image%d", i];
        imageView.image = IMAGE_MULTIPLE_LANGUAGE(imageName);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    
    [self.scrollView setContentSize:CGSizeMake(screenWidth * kNumberPages, self.scrollView.height)];
    _pageControl.frame = CGRectMake(0, self.btnContinue.top - 40, screenWidth, 40);
}

- (void)setupPageControl
{
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    _pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0, self.btnContinue.top - 80, screenWidth, 40)];
    _pageControl.pageControlStyle = PageControlStyleWithPageNumber;
    _pageControl.diameter = 12;
    _pageControl.gapWidth = 10;
    [_pageControl setNumberOfPages:kNumberPages];
    
    [self.view addSubview:_pageControl];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Actions

- (IBAction)continueAction:(id)sender {
    self.window.rootViewController = self.drawerController;
//    [UIView animateWithDuration:0.33 animations:^{
//       
//    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//        self.view = nil;
//        [self removeFromParentViewController];
//        [self didMoveToParentViewController:nil];
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }];
}


#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    [_pageControl setCurrentPage:page];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
