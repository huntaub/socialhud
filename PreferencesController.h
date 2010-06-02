//
//  PreferencesController.h
//  SocialHUD
//
//  Created by Hunter Leath on 6/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define ANIMATION_TIME .1

@interface PreferencesController : NSObject {
	IBOutlet NSWindow *prefsWindow;
	IBOutlet NSToolbar *prefsToolbar;
	IBOutlet NSView *generalView;
	IBOutlet NSView *servicesView;
	NSTimer *workingTimer;
	NSMutableArray *servicesDictionaries;
}
- (void)makeKeyAndOrderFront:(id)sender;
- (IBAction)generalClicked:(id)sender;
- (IBAction)servicesClicked:(id)sender;
- (void)showGeneralPrefs:(NSTimer*)timer;
- (void)showServicesPrefs:(NSTimer*)timer;
@property (nonatomic, copy) NSMutableArray *servicesDictionaries;
@end
