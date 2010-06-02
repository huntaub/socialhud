//
//  MailActions.h
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Mail.h"
@class SideBarController;
@class ActivatingButton;

@interface MailActions : NSObject {
	IBOutlet SideBarController *superController;
	IBOutlet ActivatingButton *deleteButton;
	IBOutlet ActivatingButton *viewButton;
	IBOutlet NSWindow *mailPad;
	IBOutlet NSTextField *toLabel;
	IBOutlet NSTextField *toField;
	IBOutlet NSTextView *textInfo;
	IBOutlet NSButton *sendButton;
	MailApplication *mail;
}
- (IBAction)deleteMessage:(id)sender;
- (IBAction)viewMessage:(id)sender;
@end
