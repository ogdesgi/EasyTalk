//
//  FavoriteInterfaceController.m
//  EasyTalk
//
//  Created by Olivier Gonçalves on 03/12/2015.
//  Copyright © 2015 Chips&Chips. All rights reserved.
//

#import "WKInterfaceController+DataExchange.h"
#import "FavoriteInterfaceController.h"
#import "RowController.h"
#import "Constants.h"

@interface FavoriteInterfaceController ()
{
    NSMutableArray* items_;
}
@property(strong, nonatomic) NSMutableArray* items;

@end

@implementation FavoriteInterfaceController

@synthesize userInfo = userinfo_, items = items_;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.userInfo = [super getUserinfoAtFile:ARCHIVE];
    [self configure];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)configure
{
    self.items = [NSMutableArray new];
    NSUInteger length = [self.userInfo count], rowIndex = 0;
    for (NSUInteger i = 0; i < length; ++i) {
        NSString *key = [NSString stringWithFormat:@"%@ #%u", FAVWORD, i+1];
        NSString *value = [self.userInfo objectForKey:key];
        if (value != nil) {
            [self.items addObject:value];
            rowIndex++;
        }
    }
    [self.table setNumberOfRows:rowIndex withRowType:ROW];
    for (NSUInteger i = 0; i < rowIndex; ++i) {
        RowController *rowController = [self.table rowControllerAtIndex:i];
        [rowController setLabel:[self.items objectAtIndex:i]];
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    NSString *item = [self.items objectAtIndex:rowIndex];
    [self pushControllerWithName:ZOOMCTRL context:item];
}

@end



