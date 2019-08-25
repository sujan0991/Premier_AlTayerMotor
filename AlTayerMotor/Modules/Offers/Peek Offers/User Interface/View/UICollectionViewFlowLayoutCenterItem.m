//
//  UICollectionViewFlowLayoutCenterItem.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "UICollectionViewFlowLayoutCenterItem.h"

@interface UICollectionViewFlowLayoutCenterItem(){
    NSArray *_layoutInfo;
    IBInspectable CGFloat _cellSpacing;
    IBInspectable CGFloat _cellPadding;
    IBInspectable NSInteger _numbersOfCell;
}

@end

@implementation UICollectionViewFlowLayoutCenterItem
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGSize boundsSize = self.collectionView.bounds.size;
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger pageCount = count/_numbersOfCell + (((count % _numbersOfCell) != 0) ? 1 : 0);
    
    CGSize contentSize = CGSizeMake(pageCount * boundsSize.width, boundsSize.height);
    return contentSize;
}

- (void)prepareLayout{
    NSMutableArray *array = [NSMutableArray array];
    CGSize boundsSize = self.collectionView.bounds.size;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    CGSize itemSize = CGSizeMake((boundsSize.width - 2 * _cellPadding - (_numbersOfCell - 1) * _cellSpacing)/_numbersOfCell, boundsSize.height);
    for (int i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        NSInteger pageIndex = i/_numbersOfCell;
        NSInteger indexOnPage = i % _numbersOfCell;
        CGFloat offsetX = boundsSize.width * pageIndex + _cellPadding + indexOnPage * (_cellSpacing + itemSize.width);
        attributes.frame = CGRectMake(offsetX, 0, itemSize.width, itemSize.height);
        [array addObject:attributes];
    }
    _layoutInfo = array;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in _layoutInfo) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }
    return allAttributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _layoutInfo[indexPath.item];
}

@end
