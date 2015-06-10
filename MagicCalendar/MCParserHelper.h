//
//  MCParserHelper.h
//  MagicCalendar
//
//  Created by Bogdan Matveev on 10.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *kValCurs = @"ValCurs";
static NSString *kCharCode = @"CharCode";
static NSString *kValue = @"Value";
static NSString *kValute = @"Valute";

@interface MCParserHelper : NSObject
- (NSArray*) getCurrencyItemsForData:(NSData*) data;

@end
