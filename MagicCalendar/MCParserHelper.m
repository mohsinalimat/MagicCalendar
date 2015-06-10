//
//  MCParserHelper.m
//  MagicCalendar
//
//  Created by Bogdan Matveev on 10.06.15.
//  Copyright (c) 2015 BOGDAN MATVEEV. All rights reserved.
//

#import "MCParserHelper.h"


@interface MCParserHelper() <NSXMLParserDelegate>
{
    NSMutableArray * _items;
    NSString * _currentElement;
    NSMutableString * _charCode;
    NSMutableString * _value;
}

@end
@implementation MCParserHelper

- (NSArray*) getCurrencyItemsForData:(NSData*) data
{
    _items = [NSMutableArray array];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return _items;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (elementName.length)
    {
        _currentElement = elementName;
        if ([elementName isEqualToString:kValute])
        {
            _charCode = [NSMutableString string];
            _value = [NSMutableString string];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:kValute])
    {
        //Cuttin float value
        NSRange range = NSMakeRange(_value.length-2, 2);
        [_value replaceCharactersInRange:range withString:@""];
        
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithObjects:@[_charCode, _value] forKeys:@[kCharCode, kValue]];
        [_items addObject:dataDictionary];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_currentElement isEqualToString:kCharCode])
    {
        [_charCode appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    if ([_currentElement isEqualToString:kValue])
    {
        [_value appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

@end
