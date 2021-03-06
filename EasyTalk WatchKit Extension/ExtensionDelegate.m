//
//  ExtensionDelegate.m
//  EasyTalk WatchKit Extension
//
//  Created by Olivier Gonçalves on 20/11/2015.
//  Copyright © 2015 Chips&Chips. All rights reserved.
//

#import <WatchConnectivity/WatchConnectivity.h>
#import "ExtensionDelegate.h"
#import "Constants.h"

@interface ExtensionDelegate () <WCSessionDelegate>

@end

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    if ([WCSession class] && [WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *,id> *)userInfo
{
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString* filePath = [documentPath stringByAppendingPathComponent:ARCHIVE];
    [NSKeyedArchiver archiveRootObject:userInfo toFile:filePath];
}

@end
