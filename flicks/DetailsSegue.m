//
//  DetailsSegue.m
//  flicks
//
//  Created by William Thai on 1/27/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\willthai. All rights reserved.
//

#import "DetailsSegue.h"

@implementation DetailsSegue
- (void) perform
{
    [[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
}
@end
