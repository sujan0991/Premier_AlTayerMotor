//
//  LatestOfferCell.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LatestOfferCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LatestOfferView.h"

@implementation LatestOfferCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        self.scrollView = [[PWParallaxScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 180)];
        _scrollView.foregroundScreenEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.delegate = self;
        _scrollView.dataSource = self;
        [self addSubview:self.scrollView];
        DLog(@"%@", NSStringFromCGRect(self.scrollView.frame));
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfItemsInScrollView:(PWParallaxScrollView *)scrollView
{
    return 3;
}

- (UIView *)backgroundViewAtIndex:(NSInteger)index scrollView:(PWParallaxScrollView *)scrollView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://s-media-cache-ak0.pinimg.com/736x/49/88/f6/4988f67ed56ffba0f5de0b3148458260.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

- (UIView *)foregroundViewAtIndex:(NSInteger)index scrollView:(PWParallaxScrollView *)scrollView
{
    LatestOfferView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"LatestOfferView" owner:self options:nil] lastObject];
    containerView.frame = _scrollView.frame;
    
    return containerView;
}



- (void)test
{
    NSLog(@"hit test");
}

- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
