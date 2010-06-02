//
//  PreferencesController.m
//  SocialHUD
//
//  Created by Hunter Leath on 6/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PreferencesController.h"


@implementation PreferencesController
@synthesize servicesDictionaries;

float ToolbarHeightForWindow(NSWindow *window)
{
	NSToolbar *toolbar;
	float toolbarHeight = 0.0;
	NSRect windowFrame;
	toolbar = [window toolbar];
	if(toolbar && [toolbar isVisible])
	{
		windowFrame = [NSWindow contentRectForFrameRect:[window frame]
											  styleMask:[window styleMask]];
		toolbarHeight = NSHeight(windowFrame) - NSHeight([[window contentView] bounds]);
	}
	return toolbarHeight;
}

- (void)awakeFromNib {
	[self generalClicked:self];
	[self setServicesDictionaries:[[NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:[NSImage imageNamed:@"facebook"],@"image",@"Facebook",@"name",nil],
							[NSDictionary dictionaryWithObjectsAndKeys:[NSImage imageNamed:@"twitter"],@"image",@"Twitter",@"name",nil],
							[NSDictionary dictionaryWithObjectsAndKeys:[NSImage imageNamed:@"buzz"],@"image",@"Google Buzz",@"name",nil], nil] mutableCopy]];
}

- (void)makeKeyAndOrderFront:(id)sender {
	[prefsWindow makeKeyAndOrderFront:sender];
	[prefsToolbar setSelectedItemIdentifier:@"GeneralPrefs"];
}

- (IBAction)generalClicked:(id)sender {
	if (workingTimer != nil)
		[workingTimer invalidate];
	[servicesView removeFromSuperview];
	NSRect newFrame = [prefsWindow frame];
	int deltaHeight = newFrame.size.height;
	newFrame.size.height = [generalView frame].size.height + ToolbarHeightForWindow(prefsWindow) + 22;
	deltaHeight -= newFrame.size.height;
    newFrame.origin.y += deltaHeight;
	[prefsWindow setFrame:newFrame display:YES animate:YES];
	workingTimer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_TIME target:self selector:@selector(showGeneralPrefs:) userInfo:nil repeats:NO];
}

- (IBAction)servicesClicked:(id)sender {
	if (workingTimer != nil)
		[workingTimer invalidate];
	[generalView removeFromSuperview];
	NSRect newFrame = [prefsWindow frame];
	int deltaHeight = newFrame.size.height;
	newFrame.size.height = [servicesView frame].size.height + ToolbarHeightForWindow(prefsWindow) + 22;
	deltaHeight -= newFrame.size.height;
    newFrame.origin.y += deltaHeight;
	[prefsWindow setFrame:newFrame display:YES animate:YES];
	workingTimer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_TIME target:self selector:@selector(showServicesPrefs:) userInfo:nil repeats:NO];
}

- (void)showGeneralPrefs:(NSTimer*)timer {
	[[prefsWindow contentView] addSubview:generalView];
	workingTimer = nil;
}

- (void)showServicesPrefs:(NSTimer*)timer {
	[[prefsWindow contentView] addSubview:servicesView];
	workingTimer = nil;
}
															
@end