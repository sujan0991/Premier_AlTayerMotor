//
//  BrandOfferCell.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandOfferCell.h"
#import "BrandOffersDisplayData.h"
#import "MOffer.h"
#import "BrandOfferView.h"
#import "ViewUtils.h"
#import "StyledPageControl.h"

@interface BrandOfferCell()
@property (nonatomic) StyledPageControl *pageControl;
@end

@implementation BrandOfferCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupPageControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupPageControl];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupPageControl];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutByLanguage)
                                                 name:kNotificationLanguageDidChange
                                               object:nil];
    [self layoutByLanguage];
}

- (void)layoutByLanguage
{
    [self.layer setAffineTransform:CGAffineTransformMakeScale([ATMGlobal isEnglish] ? 1 : -1, 1)];
}

- (void)setOffersData:(BrandOffersDisplayData *)data;
{
    if (![self.data isEqual:data]) {
        self.data = data;
        [self setUpScrollView];
    }
}

- (void)setupPageControl
{
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    _pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0, 88 + [ATMGlobal offerImageHeight], screenWidth, 40)];
    _pageControl.pageControlStyle = PageControlStyleWithPageNumber;
    _pageControl.diameter = 12;
    _pageControl.gapWidth = 10;
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:_pageControl];
}

-(void)pageAction:(UIPageControl*)control
{
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * _pageControl.currentPage;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:YES];
}

- (void)setUpScrollView
{
    // remove old subviews
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // set content size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.scrollView.contentSize = CGSizeMake(screenWidth*self.data.offers.count, 88 + [ATMGlobal offerImageHeight]);
    self.scrollView.delegate = self;
    
    // page control
    [_pageControl setNumberOfPages:self.data.offers.count];
    
    // add new subview
    [self.data.offers enumerateObjectsUsingBlock:^(MOffer *offer, NSUInteger idx, BOOL * _Nonnull stop) {
        BrandOfferView *brandOfferView = [[[NSBundle mainBundle] loadNibNamed:@"BrandOfferView" owner:self options:nil] lastObject];
        brandOfferView.frame = CGRectMake(idx*screenWidth, 0, screenWidth, 88 + [ATMGlobal offerImageHeight]);
        [brandOfferView displayOffer:offer];
        brandOfferView.btnOffer.tag = idx;
        [brandOfferView.btnOffer addTarget:self
                                    action:@selector(selectOfferAction:)
                          forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:brandOfferView];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    [_pageControl setCurrentPage:page];
}

#pragma mark - Actions
- (IBAction)selectOfferAction:(id)sender
{
    if (_delegate) {
        [_delegate brandOfferCell:self showOfferAtIndex:[sender tag]];
    }
}

@end
