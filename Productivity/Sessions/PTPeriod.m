//
//  PTPeriod.m
//  Productivity
//
//  Created by Alex Nichol on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PTPeriod.h"

@implementation PTPeriod

@synthesize states;
@synthesize startDate;
@synthesize periodDuration;
@synthesize idleDuration;
@synthesize totalProductivity;
@synthesize idleProductivity;

- (id)initWithStateObservers:(NSArray *)observers {
    if ((self = [super init])) {
        NSMutableArray * mStates = [[NSMutableArray alloc] init];
        for (id<PTStateObserver> observer in observers) {
            [mStates addObject:[observer state]];
        }
        states = [[NSArray alloc] initWithArray:mStates];
    }
    return self;
}

- (id<PTState>)stateWithStateID:(NSString *)theID {
    for (id<PTState> state in states) {
        if ([[[state class] stateID] isEqualToString:theID]) {
            return state;
        }
    }
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        states = [aDecoder decodeObjectForKey:@"states"];
        startDate = [aDecoder decodeObjectForKey:@"date"];
        periodDuration = [aDecoder decodeDoubleForKey:@"duration"];
        idleDuration = [aDecoder decodeDoubleForKey:@"idleDuration"];
        totalProductivity = [aDecoder decodeIntegerForKey:@"productivity"];
        idleProductivity = [aDecoder decodeIntegerForKey:@"idleProductivity"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:states forKey:@"states"];
    [aCoder encodeObject:startDate forKey:@"date"];
    [aCoder encodeDouble:periodDuration forKey:@"duration"];
    [aCoder encodeDouble:idleDuration forKey:@"idleDuration"];
    [aCoder encodeInteger:totalProductivity forKey:@"productivity"];
    [aCoder encodeInteger:idleProductivity forKey:@"idleProductivity"];
}

- (BOOL)isEqualToPeriod:(PTPeriod *)aPeriod {
    if (![aPeriod.states isEqualToArray:self.states]) {
        return NO;
    }
    if (![aPeriod.startDate isEqualToDate:self.startDate]) {
        return NO;
    }
    if (aPeriod.periodDuration != self.periodDuration) {
        return NO;
    }
    if (aPeriod.totalProductivity != self.totalProductivity) {
        return NO;
    }
    if (aPeriod.idleProductivity != self.idleProductivity) {
        return NO;
    }
    if (aPeriod.idleDuration != self.idleDuration) {
        return NO;
    }
    return YES;
}

@end
