//
//  ActivatingButton.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ActivatingButton.h"


@implementation ActivatingButton
@synthesize clickedPoint;

- (void) awakeFromNib {
	NSTrackingArea *newArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways) owner:self userInfo:nil];
	[self addTrackingArea:newArea];
}

- (void) mouseEntered: (NSEvent *)theEvent {
	[self setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@On",[[[[self image] name] componentsSeparatedByString:@"Off"] objectAtIndex:0]]]];
}

- (void) mouseExited: (NSEvent *)theEvent {
	[self setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@Off",[[[[self image] name] componentsSeparatedByString:@"On"] objectAtIndex:0]]]];
}

- (void)mouseDown:(NSEvent *)theEven {
	clickedPoint = [self convertPoint:[self frame].origin toView:[[self window] contentView]];
	NSLog(@"clickedPoint x:%f, y:%f", clickedPoint.x, clickedPoint.y);
	[self sendAction:[self action] to:[self target]];
}

@end
