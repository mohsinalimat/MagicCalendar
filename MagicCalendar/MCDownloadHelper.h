//
//  MCDownloadHelper.h
//  MagicCalendar
//
//  Created by Bogdan Matveev on 10.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MCDownloadDelegate
@required
- (void) didRecieveCurrency: (NSDictionary*) currency;
@end
@interface MCDownloadHelper : NSObject

@end