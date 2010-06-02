//
//  TwitterActions.h
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ActivatingButton;
@class SideBarController;

@interface TwitterActions : NSObject {
	IBOutlet NSWindow *tweeter;
	IBOutlet NSView *tView;
	IBOutlet NSTextField *tField;
	IBOutlet NSTextField *characterCount;
	IBOutlet ActivatingButton *retweet;
	IBOutlet ActivatingButton *atReply;
	IBOutlet SideBarController *superController;
	NSTimer *removePadTimer;
}
- (IBAction) retweet:(id)sender;
- (IBAction) reply:(id)sender;
- (void)controlTextDidChange:(NSNotification *)aNotification;
- (IBAction)send:(id)sender;
- (void)removePad:(NSTimer *)aTimer;
@end
