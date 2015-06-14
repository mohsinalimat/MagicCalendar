//
//  MCDetailViewController.m
//  MagicCalendar
//
//  Created by Bogdan Matveev on 09.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import "MCDetailViewController.h"
#import "MCParserHelper.h"

static const NSString *kSBRFURL = @"http://cbr.ru/scripts/XML_daily.asp?";
@interface MCDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *euroLabel;
@property (weak, nonatomic) IBOutlet UILabel *dollarLabel;

@end

@implementation MCDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"d MMMM YYYY"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.targetDate];
    
    if ([self.targetDate compare:[NSDate date]] == NSOrderedAscending)
        [self startDownloading];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void) setCurrencyWithInfo:(NSArray *)items
{
    if (!items.count) return;
    
    __block NSString *euroValue;
    __block NSString *dollarValue;
    [items enumerateObjectsUsingBlock:^(NSDictionary *contentDict, NSUInteger idx, BOOL *stop) {
        if ([contentDict[kCharCode] isEqualToString:@"EUR"])
        {
            euroValue = contentDict[kValue];
        }
        else if ([contentDict[kCharCode] isEqualToString:@"USD"])
        {
            dollarValue = contentDict[kValue];
        }
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (euroValue.length)
            self.euroLabel.text = [NSString stringWithFormat:@"1 Eur = %@ Rub", euroValue];
        if (dollarValue.length)
            self.dollarLabel.text = [NSString stringWithFormat:@"1$ = %@ Rub", dollarValue];

        [UIView animateWithDuration:.2 animations:^{
            self.euroLabel.alpha = 1;
            self.dollarLabel.alpha = 1;
        }];
    });
}
#pragma mark -=Downloading=-
- (void) startDownloading
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:self.targetDate];
    
    NSString *dateURLString = [kSBRFURL stringByAppendingString:
                               [NSString stringWithFormat:@"date_req=%@",dateString]];
    
    NSURL *URL = [NSURL URLWithString:dateURLString];
    
    __weak typeof (self) weakSelf = self;
    [[session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            MCParserHelper *parseHelper = [MCParserHelper new];
            [weakSelf setCurrencyWithInfo:[parseHelper getCurrencyItemsForData:data]];
        }
        else NSLog(@"%@", error);
    }]resume];
    
}


@end
