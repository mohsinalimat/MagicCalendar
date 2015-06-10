//
//  MCFlowLayout.m
//  MagicCalendar
//
//  Created by Bogdan Matveev on 10.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import "MCFlowLayout.h"

@implementation MCFlowLayout
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGSize collectionViewSize = self.collectionView.bounds.size;
    CGFloat proposedContentOffsetCenterY = proposedContentOffset.y + self.collectionView.bounds.size.height * 0.5f;
    CGRect proposedRect = CGRectMake(0.0, proposedContentOffset.y, collectionViewSize.width, collectionViewSize.height);
    
    UICollectionViewLayoutAttributes* candidateAttributes;
    for (UICollectionViewLayoutAttributes* attributes in [self layoutAttributesForElementsInRect:proposedRect])
    {
        if(!candidateAttributes)
        {
            candidateAttributes = attributes;
            continue;
        }
        
        if (fabs(attributes.center.y - proposedContentOffsetCenterY) < fabs(candidateAttributes.center.y - proposedContentOffsetCenterY))
        {
            candidateAttributes = attributes;
        }
    }
    
    return CGPointMake(proposedContentOffset.x, candidateAttributes.center.y - self.collectionView.bounds.size.height * 0.5f);
    
}
- (CGSize)itemSize
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), 44);
}
@end
