//
//  MailActions.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MailActions.h"
#import "SideBarController.h"
#import "ActivatingButton.h"

@implementation MailActions

- (void) awakeFromNib {
mail = [SBApplication applicationWithBundleIdentifier:@"com.apple.Mail"];
	[superController registerActionPad:mailPad];
}

- (IBAction)deleteMessage:(id)sender {
	float index = (6 - (([deleteButton clickedPoint].y - 58)/132)) + 1;
	NSLog(@"delete! withIndex:%f andY:%f andRounded:%d",index, [deleteButton clickedPoint].y, [[NSNumber numberWithFloat:index] intValue]);
	NSDictionary *dict = [superController attributesOfItemAtIdex:index];
	int id_ = [[dict objectForKey:@"id"] intValue];
	NSAppleScript *myScript = [[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@"tell application \"Mail\" \n activate \n repeat with hMessage in every message in inbox \n if the id of hMessage is %d then \n open hMessage \n tell application \"System Events\" \n tell process \"Mail\" \n keystroke (ASCII character 8) using command down \n keystroke \"h\" using command down \n end tell \n end tell \n end if \n end repeat \n end tell", id_]];
	[myScript executeAndReturnError:NULL];
	[superController removeUpdateWithService:[dict objectForKey:@"service"] andText:[dict objectForKey:@"text"] andDate:[dict objectForKey:@"date"] andImportanceFactor:[[dict objectForKey:@"importance"] intValue] andId:[[dict objectForKey:@"id"] intValue]];
}

- (IBAction)viewMessage:(id)sender {
	NSPoint myPoint = [[viewButton window] convertBaseToScreen:[viewButton clickedPoint]];
	if (((myPoint.y - 218)+[[mailPad contentView] frame].size.height) > 931) {
		[superController showPad:mailPad atCoordinates:NSMakePoint(myPoint.x+17,[[NSScreen mainScreen] frame].size.height-[[mailPad contentView] frame].size.height-22)];
	} else {
		[superController showPad:mailPad atCoordinates:NSMakePoint(myPoint.x+17,myPoint.y - 218)];
	}
	float index = (6 - (([viewButton clickedPoint].y - 58)/132)) + 1;
	NSLog(@"view! withIndex:%f andY:%f andRounded:%d",index, [viewButton clickedPoint].y, [[NSNumber numberWithFloat:index] intValue]);
	NSDictionary *dict = [superController attributesOfItemAtIdex:index];
	int id_ = [[dict objectForKey:@"id"] intValue];
	NSString *body;
	NSString *mSender;
	for (MailMessage *message in [[[mail inbox] messages] get]) {
		if ([message id] == id_) {
			body = [[[message content] get] copy];
			mSender = [[message sender] copy];
			[message setReadStatus:TRUE];
		}
	}
	[toField setHidden:TRUE];
	[sendButton setHidden:TRUE];
	[toLabel setHidden:FALSE];
	[toLabel setStringValue:[NSString stringWithFormat:@"From: %@", mSender]];
	[textInfo setHidden:FALSE];
	[textInfo setEditable:FALSE];
	[textInfo setString:body];
}

@end
