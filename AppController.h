//
//  AppController.h
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGTwitterEngine.h"
#import "SideBarController.h"
#import "Mail.h"
#import "GlobalDefinitions.h"
#import <MKAbeFook/MKAbeFook.h>
@class PreferencesController;
@class SideBarController;

@interface AppController : NSObject <MGTwitterEngineDelegate> {
	IBOutlet NSTextField *characterCount;
	IBOutlet NSTextView *log;
	IBOutlet NSWindow *logWindow;
	MGTwitterEngine *twitterEngine;
	MKFacebook *fbEngine;
	int latest;
	OAToken *token;
	IBOutlet SideBarController *currentController;
	NSString *lastTimeFacebookWasCalled;
	//MLApplication *mail;
	MailApplication *mail;
	PreferencesController *prefs;
	BOOL prefsLoaded;
}
- (void)textDidChange:(NSNotification *)aNotification;
- (void)checkTweets:(NSTimer*)theTimer;
- (void)checkForMail:(NSTimer*)theTimer;
- (void)checkForFacebookNotifications:(NSTimer*)theTimer;
- (void)postActionTweet:(NSNotification *)aNotification;
- (IBAction)showPreferences:(id)sender;
@end
