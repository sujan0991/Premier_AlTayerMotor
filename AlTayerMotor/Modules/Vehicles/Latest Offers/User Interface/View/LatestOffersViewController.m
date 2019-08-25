//
//  LatestOffersViewController.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LatestOffersViewController.h"
#import "LatestOffersModuleInterface.h"
#import "ATMFullRowButton.h"
#import "StyledPageControl.h"
#import "ViewUtils.h"
#import "MOffer.h"
#import "BrandOfferView.h"
#import "UIView+Utils.h"
#import "NSString+Color.h"

@interface LatestOffersViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topButtonConstraint;
@property (strong, nonatomic) StyledPageControl *pageControl;
@property (weak, nonatomic) IBOutlet ATMFullRowButton *btnExplorer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *latestOffers;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnExplorerTop;
@end

@implementation LatestOffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.latestOffers = [@[] mutableCopy];
    
    [self setupViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setTextByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTextByLanguage];
    [self.loadingIndicator startAnimating];
    [self.eventHandler getLatestOffers];
    
    [[GTMHelper sharedInstance] logEvent:kEventScreenLoad
                            inScreenName:kScreenHome
                      withAdditionalData:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (_pageControl) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        _pageControl.frame = CGRectMake(0, _scrollViewHeight.constant + self.scrollView.top + 20, screenWidth, 50);
        DLog(@"%f - %f, %@", _scrollViewHeight.constant, self.scrollView.bottom, NSStringFromCGRect(self.scrollView.frame));
    }
}   

- (void)setTextByLanguage
{
    [self.navigationController.navigationBar.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1, 1)];
    self.navigationItem.title = LOCALIZED(@"TITLE PRE-OWNED");
    [self.btnExplorer setTitle:LOCALIZED(@"TEXT EXPLORER OUR PRE-OWNED VEHICLES")
                      forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UI
- (void)setupViews
{
    // Navigation View
    [self addRightMenuWithAction:@selector(toggleMenu:) inController:self];
    
    [self setUpScrollView];
    [self setupPageControl];
    
    // config gradient background
    [self.view setBackGroundGradientFromColor:[@"071f3c" representedColor]
                                      toColor:[@"081f3c" representedColor]];
}

- (void)setupPageControl
{
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    _pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.bottom + 20, screenWidth, 40)];
    _pageControl.isTransparencyNumber = YES;
    _pageControl.pageControlStyle = PageControlStyleWithPageNumber;
    _pageControl.diameter = 12;
    _pageControl.gapWidth = 10;
    [_pageControl setNumberOfPages:self.latestOffers.count];
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];

//    [self.view addSubview:_pageControl];
    [self.mainScrollView addSubview:_pageControl];
    [self.mainScrollView layoutIfNeeded];
}

- (void)setUpScrollView
{
    // set content size
    self.scrollView.delegate = self;
    _scrollViewHeight.constant = 88 + [ATMGlobal offerImageHeight];
    DLog(@"%@", NSStringFromCGRect(_scrollView.frame));
    [self setLatestOffers:nil];
}

- (CGFloat)pageWidth
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    return screenWidth;
}

#pragma mark - ScrollView Delegate
-(void)pageAction:(UIPageControl*)control
{
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * _pageControl.currentPage;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    [_pageControl setCurrentPage:page];
}

#pragma mark - Actions
- (IBAction)showBrandsAction:(id)sender {
    [self.eventHandler presentBrandsInterface];
}

- (IBAction)showPeekOffers:(id)sender {
    NSInteger currentIndex = [_pageControl currentPage];
    [self.eventHandler presentOffersInterfaceWithData:self.latestOffers
                                      withViewedIndex:currentIndex];
}

#pragma mark - View Interface
- (NSArray *)getLatestOffers
{
    return _latestOffers;
}

- (void)setLatestOffers:(NSArray *)latestOffers
{
    _latestOffers = latestOffers;
    if (_latestOffers) {
        [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        // set content size
        self.scrollView.contentSize = CGSizeMake(self.pageWidth*self.latestOffers.count, 88 + [ATMGlobal offerImageHeight]);
        
        // page control
        [_pageControl setNumberOfPages:self.latestOffers.count];

        // add new subview
        [self.latestOffers enumerateObjectsUsingBlock:^(MOffer *offer, NSUInteger idx, BOOL * _Nonnull stop) {
            BrandOfferView *brandOfferView = [[[NSBundle mainBundle] loadNibNamed:@"BrandOfferView" owner:self options:nil] lastObject];
            brandOfferView.frame = CGRectMake(idx*self.pageWidth, 0, self.pageWidth, 88 + [ATMGlobal offerImageHeight]);
            [brandOfferView displayOffer:offer];
            [brandOfferView.btnOffer addTarget:self action:@selector(showPeekOffers:) forControlEvents:UIControlEventTouchUpInside];
            [brandOfferView layoutIfNeeded];
            
            [self.scrollView addSubview:brandOfferView];
        }];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL hasOfferData = (_latestOffers && _latestOffers.count > 0);
        self.logoView.hidden = hasOfferData;
        self.scrollView.hidden = !hasOfferData;
        [self.loadingIndicator stopAnimating];
        self.loadingIndicator.hidden = YES;
        self.topButtonConstraint.constant = hasOfferData ? 370 : 178;
        self.btnExplorerTop.constant = 20 + (hasOfferData ? 0 : 128);
    });    
}


@end
