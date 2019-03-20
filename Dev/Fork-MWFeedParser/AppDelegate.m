//
//  AppDelegate.m
//  Fork-MWFeedParser
//
//  Created by 张超 on 2019/1/15.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "AppDelegate.h"
#import "FMFeedParserOperation.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSOperationQueue* quene;
@property (nonatomic, strong) NSOperationQueue* netQuene;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self test];
    NSLog(@"%s",__func__);
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    NSLog(@"%@",launchOptions);

    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
//    [self test];
    NSLog(@"%s",__func__);
    completionHandler(UIBackgroundFetchResultNewData);
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)test
{
    FMFeedParserOperation* (^feed)(NSString*,NSString*,NSOperationQueue*) = ^(NSString* name,NSString* url,NSOperationQueue* quene) {
        FMFeedParserOperation* o = [[FMFeedParserOperation alloc] init];
        o.feedURL = [NSURL URLWithString:url];
        o.title = name;
        o.netWorkQuene = quene;
        o.timeout = 5;
        [o setParseInfoBlock:^(MWFeedInfo * _Nonnull info) {
            NSLog(@"%@",info);
        }];
        [o setParseItemBlock:^(MWFeedItem * _Nonnull item) {
            NSLog(@"%@",item);
        }];
        return o;
    };
    
    NSOperationQueue* q = [[NSOperationQueue alloc] init];
    self.quene = q;
    [q setMaxConcurrentOperationCount:4];
    
    NSOperationQueue* q2 = [[NSOperationQueue alloc] init];
    [q2 setMaxConcurrentOperationCount:10];
    self.netQuene = q2;
    
    FMFeedParserOperation* o = feed(@"1",@"https://www.zhangzichuan.cn/atom.xml",q2);
    [o setType:FMParseTypeFull];
    [q addOperation:o];
//    [q addOperation:feed(@"2",@"https://www.zhangzichuan.cn/atom.xml",q2)];
    [q addOperation:feed(@"3",@"http://rss.cnki.net/kns/rss.aspx?Journal=ZXDT&Virtual=knavi",q2)];
//    [q addOperation:feed(@"4",@"http://www.zhihu.com/rss",q2)];
//    [q addOperation:feed(@"5",@"http://www.zhihu.com/rss",q2)];
//    [q addOperation:feed(@"6",@"http://www.zhihu.com/rss",q2)];
//    [q addOperation:feed(@"7",@"http://www.zhihu.com/rss",q2)];
//    [q addOperation:feed(@"8",@"http://www.zhihu.com/rss",q2)];
//    [q addOperation:feed(@"9",@"http://www.zhihu.com/rss",q2)];
//    [q addOperation:feed(@"10",@"http://www.zhihu.com/rss",q2)];
    
    [self.quene waitUntilAllOperationsAreFinished];
}

@end
