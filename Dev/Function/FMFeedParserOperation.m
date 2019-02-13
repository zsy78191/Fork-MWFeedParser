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
    switch (self.type) {
        case FMParseTypeFull:
            parser.feedParseType = ParseTypeFull;
            break;
        case FMParseTypeInfo:
            parser.feedParseType = ParseTypeInfoOnly;
            break;
        case FMParseTypeItems:
            parser.feedParseType = ParseTypeItemsOnly;
            break;
        default:
            break;
    }
    
    parser.delegate  = self;
    
    [parser parseWithQuene:self.netWorkQuene];
    self.parser = parser;
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    if (self.parseErrorBlock) {
        self.parseErrorBlock(error);
    }
    self.state = RPAsyncOperationStateFinished;
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    if (self.parseFinishBlock) {
        self.parseFinishBlock();
    }
    self.state = RPAsyncOperationStateFinished;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
//    NSLog(@"[%@] %@",self.title,info);
    if (self.parseInfoBlock) {
        self.parseInfoBlock(info);
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
//    NSLog(@"-- %@",item.title);
    if (self.parseItemBlock) {
        self.parseItemBlock(item);
    }
}

- (void)dealloc
{
    self.parser.delegate = nil;
}
 

@end
