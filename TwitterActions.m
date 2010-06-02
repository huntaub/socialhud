//
//  TwitterActions.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TwitterActions.h"
#import "ActivatingButton.h"
#import "SideBarController.h"

@implementation TwitterActions

- (void) awakeFromNib {
	[superController registerActionPad:tweeter];
}

- (IBAction) retweet:(id)sender {
	NSPoint myPoint = [[retweet window] convertBaseToScreen:[retweet clickedPoint]];
	[superController showPad:tweeter atCoordinates:NSMakePoint(myPoint.x+17,myPoint.y - 65)];
	//removePadTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(removePad:) userInfo:nil repeats:NO];
	NSArray *parts = [[[[[[retweet superview] superview] superview] viewWithTag:2] stringValue] componentsSeparatedByString:@": "];
	if ([parts count] == 2) {
		[tField setStringValue:[NSString stringWithFormat:@"RT @%@ %@", [parts objectAtIndex:0], [parts objectAtIndex:1]]];
	} else {
		NSMutableString *myString = [[NSMutableString alloc] init];
		[myString appendFormat:@"RT @%@ ", [parts objectAtIndex:0]];
		int i;
		for (i=1; i<[parts count]; i++) {
			if (i!=1)
				[myString appendFormat:@": "];
			[myString appendString:[parts objectAtIndex:i]];
		}
		[tField setStringValue:myString];
	}
	NSText* fieldEditor = [[tField window] fieldEditor:YES forObject:tField];
	[fieldEditor setSelectedRange:NSMakeRange([[fieldEditor string] length],0)];
	[fieldEditor setNeedsDisplay:YES];
	[characterCount setStringValue:[NSString stringWithFormat:@"%d/140",[[tField stringValue] length]]];
}

- (IBAction) reply:(id)sender {
	NSPoint myPoint = [[atReply window] convertBaseToScreen:[atReply clickedPoint]];
	NSLog(@"myPoint x:%f, y:%f", myPoint.x, myPoint.y);
	[superController showPad:tweeter atCoordinates:NSMakePoint(myPoint.x+17,myPoint.y - 93)];
	//removePadTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(removePad:) userInfo:nil repeats:NO];
	NSArray *parts = [[[[[[atReply superview] superview] superview] viewWithTag:2] stringValue] componentsSeparatedByString:@": "];
	[tField setStringValue:[NSString stringWithFormat:@"@%@ ", [parts objectAtIndex:0]]];
	NSText* fieldEditor = [[tField window] fieldEditor:YES forObject:tField];
	[fieldEditor setSelectedRange:NSMakeRange([[fieldEditor string] length],0)];
	[fieldEditor setNeedsDisplay:YES];
	[characterCount setStringValue:[NSString stringWithFormat:@"%d/140",[[tField stringValue] length]]];
}

- (void)controlTextDidChange:(NSNotification *)aNotification {
	//[removePadTimer invalidate];
	//removePadTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(removePad:) userInfo:nil repeats:NO];
	[characterCount setStringValue:[NSString stringWithFormat:@"%d/140",[[[aNotification object] stringValue] length]]];
}

- (IBAction)send:(id)sender {
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	[defaultCenter postNotificationName:@"JHLNewActionTweet" object:[tField stringValue]];
	[superController showPad:nil atCoordinates:NSMakePoint(0,0)];
}

- (void)removePad:(NSTimer *)aTimer {
	[removePadTimer invalidate];
	[superController showPad:nil atCoordinates:NSMakePoint(0, 0)];
}

@end
