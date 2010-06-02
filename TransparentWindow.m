//
//  TransparentWindow.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TransparentWindow.h"


@implementation TransparentWindow


- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setIgnoresMouseEvents:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setOpaque:NO];
	}
	return self;
}

-(BOOL) canBecomeKeyWindow { return true; }



@end
