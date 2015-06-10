//
//  MCDetailViewController.m
//  MagicCalendar
//
//  Created by Bogdan Matveev on 09.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import "MCDetailViewController.h"

@interface MCDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *euroLabel;
@property (weak, nonatomic) IBOutlet UILabel *dollarLabel;
@end

@implementation MCDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"d MMMM YYYY"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.targetDate];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

}


@end
