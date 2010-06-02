//
//  ActionPadWindow.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ActionPadWindow.h"


@implementation ActionPadWindow

- (BOOL)hidesOnDeactivate {
	return TRUE;
}

- (BOOL)hasShadow {
	return FALSE;
}

- (void)resignKeyWindow {
	[self orderOut:self];
	[super resignKeyWindow];
}

@end
