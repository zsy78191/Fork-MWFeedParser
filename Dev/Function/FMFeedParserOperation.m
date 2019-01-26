//
//  FMFeedParserOperation.m
//  Fork-MWFeedParser
//
//  Created by 张超 on 2019/1/15.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "FMFeedParserOperation.h"
#import "FMFeedParserOperation+ext.h"

@implementation FMFeedParserOperation

- (void)main
{
    [super main];
    FMParser* parser = [[FMParser alloc] initWithFeedURL:self.feedURL];
    parser.feedParseType = ParseTypeFull;
    parser.delegate  = self;
    
    [parser parseWithQuene:self.netWorkQuene];
    self.parser = parser;
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    self.state = RPAsyncOperationStateFinished;
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    self.state = RPAsyncOperationStateFinished;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
    NSLog(@"[%@] %@",self.title,info);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
//    NSLog(@"-- %@",item.title);
}

- (void)dealloc
{
    self.parser.delegate = nil;
    NSLog(@"%@ %s",self,__func__);
}
 

@end
