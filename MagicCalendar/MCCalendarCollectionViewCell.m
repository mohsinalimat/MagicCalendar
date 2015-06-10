//
//  MCCalendarCollectionViewCell.m
//  MagicCalendar
//
//  Created by Bogdan Matveev on 10.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import "MCCalendarCollectionViewCell.h"
@interface MCCalendarCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
@implementation MCCalendarCollectionViewCell

- (void) setDateStr:(NSString*)dateStr withType:(MCCellDateType) type
{
    self.dateLabel.text = dateStr;
    self.dateLabel.textColor = type == MCCellDateTypeWeekdays?
                                [UIColor grayColor] : [UIColor redColor];
}

- (void)prepareForReuse
{
    self.dateLabel.text = nil;
}
@end
