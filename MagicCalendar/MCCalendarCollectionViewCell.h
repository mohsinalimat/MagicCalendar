//
//  MCCalendarCollectionViewCell.h
//  MagicCalendar
//
//  Created by Bogdan Matveev on 10.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MCCellDateType)
{
    MCCellDateTypeWeekdays,
    MCCellDateTypeWeekend
};
@interface MCCalendarCollectionViewCell : UICollectionViewCell

- (void) setDateStr:(NSString*)dateStr withType:(MCCellDateType) type;
@end
