//
//  ViewController.m
//  MagicCalendar
//
//  Created by Bogdan Matveev on 09.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import "ViewController.h"
#import "MCDetailViewController.h"
#import "MCCalendarCollectionViewCell.h"

static const NSUInteger kTotalDays = 3655;
static const NSTimeInterval kSecondsInDay = 60 * 60 * 24;

@interface ViewController () <UICollectionViewDataSource>
{
    NSDate *_startDate;
    NSDate *_endDate;
    NSCalendar *_calendar;
    NSDateFormatter *_dateFormatter;
    BOOL _isAlreadyScrolled;
}
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rateButton.layer.cornerRadius = CGRectGetWidth(self.rateButton.bounds)/2.f;
    self.rateButton.layer.borderWidth = 1.f;
    self.rateButton.layer.borderColor = self.rateButton.tintColor.CGColor;
    
    _calendar = [NSCalendar currentCalendar];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval halfYearInterval = kSecondsInDay*kTotalDays/2;
    _startDate = [currentDate dateByAddingTimeInterval: -halfYearInterval];
    _endDate = [currentDate dateByAddingTimeInterval: halfYearInterval];
    _dateFormatter = [NSDateFormatter new];
    [_dateFormatter setDateFormat:@"EE d"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLayoutSubviews
{
    if (!_isAlreadyScrolled)
    {
        _isAlreadyScrolled = YES;
        
        CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.bounds);
        [self.collectionView setContentInset:
                UIEdgeInsetsMake(collectionViewHeight/2, 0, collectionViewHeight/2, 0)];
        
        NSInteger currentDateRow = [self rowForDate:[NSDate date]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentDateRow inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated: NO];
    }
}

- (IBAction)rateButtonClicked:(id)sender {
    CGPoint centerPoint = CGPointMake(self.collectionView.center.x,
                                      self.collectionView.center.y + self.collectionView.contentOffset.y);
    NSInteger row = [self.collectionView indexPathForItemAtPoint:centerPoint].row;
    NSDate *targetDate = [self dateForRow:row];
    [self performSegueWithIdentifier:@"toDetailVC" sender:targetDate];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MCDetailViewController *vc = segue.destinationViewController;
    NSDate *targetDate = (NSDate *)sender;
    vc.targetDate = targetDate;
}

#pragma mark -=Collection View methods=-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self numberOfDaysBetween:_startDate andDate:_endDate];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCCalendarCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"calendarCell" forIndexPath:indexPath];
    NSDate *rowDate = [self dateForRow:indexPath.row];
    NSString *dateString = [_dateFormatter stringFromDate:rowDate];

    MCCellDateType dateType = [self cellDateTypeForDate:rowDate];
    [cell setDateStr:dateString withType:dateType];
    return cell;
}

#pragma mark -=Working with dates=-
- (NSUInteger) numberOfDaysBetween:(NSDate*)startDate andDate:(NSDate*) endDate
{
    return [_calendar components:(NSCalendarUnitDay)
                            fromDate:startDate toDate:endDate options:0].day;
}
- (NSDate*) dateForRow:(NSInteger) row
{
    NSTimeInterval toCurrentRowTimeInterval = kSecondsInDay * (row + 1);
    NSDate *dateForRow = [_startDate dateByAddingTimeInterval:toCurrentRowTimeInterval];
    return dateForRow;
}
- (NSInteger) rowForDate:(NSDate*)date
{
    NSUInteger numberOfDays = [self numberOfDaysBetween:_startDate andDate:date];
    return numberOfDays - 1;
}
- (MCCellDateType) cellDateTypeForDate:(NSDate *) date
{
    NSUInteger ordinality = [_calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    return (ordinality == 1 || ordinality == 7)? MCCellDateTypeWeekend : MCCellDateTypeWeekdays;
}

@end
