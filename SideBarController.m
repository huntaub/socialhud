//
//  SideBarController.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SideBarController.h"


@implementation SideBarController
@synthesize updaterView;
@synthesize info;
@synthesize serviceIcon;
@synthesize actionView;
@synthesize actionPlace;

- (void)newUpdateWithService:(NSString *)service andText:(NSString *)text andDate:(NSDate *)date andImportanceFactor:(int)importance andId:(int)id_ {
	NSDictionary *dict;
	dict = [NSDictionary dictionaryWithObjectsAndKeys: service, @"service", text, @"text", date, @"date", [NSNumber numberWithInt:importance], @"importance", [NSNumber numberWithInt:id_], @"id", nil];
	[dict retain];
	if (updates == nil)
		updates = [[NSMutableArray alloc] init];
	if (![updates containsObject:dict])
	{	
		[updates addObject:dict];
		[self redrawUpdates];
	}
}

- (BOOL)removeUpdateWithService:(NSString *)service andText:(NSString *)text andDate:(NSDate *)date andImportanceFactor:(int)importance andId:(int)id_ {
	NSDictionary *dict;
	dict = [NSDictionary dictionaryWithObjectsAndKeys: service, @"service", text, @"text", date, @"date", [NSNumber numberWithInt:importance], @"importance", [NSNumber numberWithInt:id_], @"id", nil];
	[dict retain];
	if (updates == nil)
		updates = [[NSMutableArray alloc] init];
	if (![updates containsObject:dict])
	{	
		return NO;
	}
	[updates removeObject:dict];
	[self redrawUpdates];
	return YES;
}

- (void)setUpdates:(NSArray*)updateArray forService:(NSString*)serviceName {
	if (updates == nil)
		updates = [[NSMutableArray alloc] init];
	NSArray *localUpdates = [updates copy];
	for (NSDictionary *serviceSpecific in localUpdates) {
		if ([[serviceSpecific objectForKey:@"service"] isEqualToString:serviceName]) {
			[updates removeObject:serviceSpecific];
		}
	}
	[updates addObjectsFromArray:updateArray];
	[self redrawUpdates];
}

- (void)newUpdateWithDict:(NSDictionary *)dict {
	if (updates == nil)
		updates = [[NSMutableArray alloc] init];
	if ([updates containsObject:dict])
	{	
		return;
	} else {
		[updates addObject:dict];
		[self redrawUpdates];
	}
}

- (NSDictionary*)attributesOfItemAtIdex:(int)index {
	NSSortDescriptor *dateSorter = [[[NSSortDescriptor alloc] initWithKey:@"date"
																ascending:NO] autorelease];
	NSArray *sortedArray = [updates sortedArrayUsingDescriptors:[NSArray arrayWithObject:dateSorter]];
	return [sortedArray objectAtIndex:index];
}

- (void) redrawUpdates {
	NSMutableArray *subViews = [[NSMutableArray alloc] init];
	[subViews addObject:background];
	int i;
	NSSortDescriptor *dateSorter = [[[NSSortDescriptor alloc] initWithKey:@"date"
																	 ascending:NO] autorelease];
	NSArray *sortedArray = [updates sortedArrayUsingDescriptors:[NSArray arrayWithObject:dateSorter]];
	for (i = 0; i < (JHLNumberOfUpdatesToShow - 1) && i < [sortedArray count]; i++) {
		NSDictionary *dict = [sortedArray objectAtIndex:i];
		NSNib *viewNib = [[NSNib alloc] initWithNibNamed:@"UpdaterView" bundle:nil];
		[viewNib instantiateNibWithOwner:self topLevelObjects:nil];
		[viewNib release];
		NSView *newUpdate = [[[self updaterView] retain] autorelease];
		NSRect newFrame = [newUpdate frame];
		newFrame.origin.x = 0;
		newFrame.origin.y = [windowContentView frame].size.height - (newFrame.size.height * (i+1));
		[newUpdate setFrame:newFrame];
		[self setUpdaterView:nil];
		NSTextField *infoBox = [[[self info] retain] autorelease];
		if ([[dict objectForKey:@"text"] isKindOfClass:[NSAttributedString class]] || [[dict objectForKey:@"text"] isKindOfClass:[NSMutableAttributedString class]])
		{
			NSAttributedString *newString = [dict objectForKey:@"text"];
			[infoBox setAttributedStringValue:newString];
		} else {
			[infoBox setStringValue:[dict objectForKey:@"text"]];
		}
		if ([[dict objectForKey:@"importance"] intValue] == JHLImportantItem) {
			NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithAttributedString:[infoBox attributedStringValue]];
			[attrstr beginEditing];
			[attrstr addAttribute:NSForegroundColorAttributeName value:[NSColor whiteColor] range:NSMakeRange(0,[attrstr length])];
			[attrstr addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Lucida Grande" size:13] range:NSMakeRange(0,[attrstr length])];
			[attrstr endEditing];
			[infoBox setAttributedStringValue:attrstr];
		} else if ([[dict objectForKey:@"importance"] intValue] == JHLRegularItem) {
			NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithAttributedString:[infoBox attributedStringValue]];
			[attrstr beginEditing];
			[attrstr addAttribute:NSForegroundColorAttributeName value:[NSColor greenColor] range:NSMakeRange(0,[attrstr length])];
			[attrstr addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Lucida Grande" size:13] range:NSMakeRange(0,[attrstr length])];
			[attrstr endEditing];
			[infoBox setAttributedStringValue:attrstr];
		}
		[self setInfo:nil];
		NSImageView *service = [[[self serviceIcon] retain] autorelease];
		[service setImage:[NSImage imageNamed:[dict objectForKey:@"service"]]];
		[self setServiceIcon:nil];
		NSNib *viewNib1 = [[NSNib alloc] initWithNibNamed:[NSString stringWithFormat:@"%@Actions",[dict objectForKey:@"service"]] bundle:nil];
		[viewNib1 instantiateNibWithOwner:self topLevelObjects:nil];
		[viewNib1 release];
		NSView *newActions = [[[self actionView] retain] autorelease];
		NSView *actionHolder = [[[self actionPlace] retain] autorelease];
		[newActions setFrame:[actionHolder bounds]];
		[actionHolder addSubview:newActions];
		[self setActionPlace:nil];
		[self setActionView:nil];
		[subViews addObject:newUpdate];
	}
	[windowContentView setSubviews:subViews];
}

- (void)registerActionPad:(NSWindow*)pad {
	if (pads == nil)
		pads = [[NSMutableArray alloc] init];
	[pad retain];
	[[pad contentView] setAlphaValue:0];
	[pads addObject:pad];
}

- (void)showPad:(NSWindow*)pad atCoordinates:(NSPoint)screenPoint {
	for (NSWindow* oldPad in pads) {
		if (oldPad != pad) {
			[[[oldPad contentView] animator] setAlphaValue:0];
			[oldPad orderOut:self];
		} else {
			[pad setFrameOrigin:screenPoint];
			[[pad contentView] setAlphaValue:0];
			[pad makeKeyAndOrderFront:self];
			[[[pad contentView] animator] setAlphaValue:1];
		}
	}
}

- (void)logText:(NSString *)text andRead:(BOOL)read {
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"showsLog"] boolValue])
		[log setString:[NSString stringWithFormat:@"%@\n%@", [log string], text]];
	if (read) {
		NSSpeechSynthesizer *synth = [[NSSpeechSynthesizer alloc] init];
		[synth startSpeakingString:text];
	}
}

@end
