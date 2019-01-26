//
//  FMFeedParserOperation.h
//  Fork-MWFeedParser
//
//  Created by 张超 on 2019/1/15.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPAsyncOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMFeedParserOperation : RPAsyncOperation

@property (nonatomic, strong) NSURL* feedURL;
@property (nonatomic, strong) NSString* title;

@property (nonatomic, weak) NSOperationQueue* netWorkQuene;
@property (nonatomic, weak) NSURLSession* session;

@end

NS_ASSUME_NONNULL_END
