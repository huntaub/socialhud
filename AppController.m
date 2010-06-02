//
//  AppController.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "XPathQuery.h"
#import "NSAttributedString+Hyperlink.h"
#import "AppSecrets.h"
#import "PreferencesController.h"

@implementation AppController

- (void)textDidChange:(NSNotification *)aNotification {
	[characterCount setStringValue:[NSString stringWithFormat:@"%d/140",[[[aNotification object] string] length]]];
}

- (BOOL)textView:(NSTextView *)textView
shouldChangeTextInRange:(NSRange)affectedCharRange
replacementString:(NSString *)replacementString {
	//NSLog(@"Loc: %d, Length: %d,\nRep:%@  Length:%d", affectedCharRange.location, affectedCharRange.length, replacementString, [replacementString length]);
	if (![replacementString isEqualToString:@""]){
		if ([replacementString characterAtIndex:0] == NSNewlineCharacter) {
			//NSLog(@"enter Character");
			//Update Center
			//FACEBOOK UPDATE CODE
			NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
			MKFacebookRequest *request = [MKFacebookRequest requestWithDelegate:self];
			
			//set up parameters for request
			[parameters setValue:[textView string] forKey:@"status"];
			
			//send the request
			[request sendRequest:@"status.set" withParameters:parameters];
			//END FACEBOOK UPDATE
			//TWITTER UPDATE CODE
			NSLog(@"Sending update... %@",[twitterEngine sendUpdate:[textView string]]);
			//END TWITTER UPDATE CODE
			[textView setString:@"Enter Here"];
			[characterCount setStringValue:[NSString stringWithFormat:@"%d/140",[[textView string] length]]];
			return NO;
		} else if (affectedCharRange.location == 140 || (affectedCharRange.location + [replacementString length] > 140)) {
			NSBeep();
			return NO;
		} else {
			return YES;
		}
	} else {
		return YES;
	}
}

- (void)awakeFromNib
{
	prefsLoaded = FALSE;
	prefs = [[PreferencesController alloc] init];
	if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"showsLog"] boolValue]) {
		[logWindow close];
	}
	[log setString:@"Welcome to SocialHUD.\nThis is the log."];
	NSLog(@"done");
    // Put your Twitter username and password here:
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitterUName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitterPassword"];
	
	NSString *consumerKey = CONSUMER_KEY;
	NSString *consumerSecret = CONSUMER_SECRET;
	
    // Most API calls require a name and password to be set...
    if (! username || ! password || !consumerKey || !consumerSecret) {
        NSLog(@"You forgot to specify your username/password/key/secret in AppController.m, things might not work!");
		NSLog(@"And if things are mysteriously working without the username/password, it's because NSURLConnection is using a session cookie from another connection.");
    }
    
    // Create a TwitterEngine and set our login details.
    twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
	[twitterEngine setUsesSecureConnection:YES];
	[twitterEngine setConsumerKey:consumerKey secret:consumerSecret];
	//[twitterEngine setUsername:username password:password];
	[twitterEngine getXAuthAccessTokenForUsername:username password:password];
	fbEngine= [[MKFacebook facebookWithAPIKey:API_KEY delegate:self] retain];
	[fbEngine loginWithPermissions:[NSArray arrayWithObjects:@"offline_access",@"status_update",@"publish_stream",nil] forSheet:NO];
	[NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(checkTweets:) userInfo:nil repeats:YES];
	//f[NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(checkForMail:) userInfo:nil repeats:YES];
	[NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(checkForFacebookNotifications:) userInfo:nil repeats:YES];
	//mail = [MLApplication applicationWithName: @"Mail"];
	//[self checkForMail:nil];
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	[defaultCenter addObserver:self selector:@selector(postActionTweet:) name:@"JHLNewActionTweet" object:nil];
}

- (void)requestSucceeded:(NSString *)connectionIdentifier
{
    NSLog(@"Request succeeded for connectionIdentifier = %@", connectionIdentifier);
}


- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
    NSLog(@"Request failed for connectionIdentifier = %@, error = %@ (%@)", 
          connectionIdentifier, 
          [error localizedDescription], 
          [error userInfo]);
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier
{
	if ([statuses count] > 0) {
		latest = [[[statuses objectAtIndex:0] objectForKey:@"id"] intValue];
		for(NSDictionary *dict in statuses) {
			//NSLog(@"From: %@; Text: %@", [[dict objectForKey:@"user"] objectForKey:@"screen_name"], text);
			NSDate *date = [dict objectForKey:@"created_at"];
			NSMutableString *text = [[NSMutableString alloc] initWithString:[dict objectForKey:@"text"]];
			[text replaceOccurrencesOfString:@"\n" withString:@" " options:0 range:NSMakeRange(0, [text length])];
			NSRange textRange =[text rangeOfString:@"@huntaub"];
			if (textRange.location == NSNotFound){
				[currentController newUpdateWithService:@"twitter" andText:[NSString stringWithFormat:@"%@: %@",[[dict objectForKey:@"user"] objectForKey:@"screen_name"], text] andDate:date andImportanceFactor:JHLRegularItem andId:[[dict objectForKey:@"id"] intValue]];
			} else {
				[currentController newUpdateWithService:@"twitter" andText:[NSString stringWithFormat:@"%@: %@",[[dict objectForKey:@"user"] objectForKey:@"screen_name"], text] andDate:date andImportanceFactor:JHLImportantItem andId:[[dict objectForKey:@"id"] intValue]];
			}
		}
	}
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got direct messages for %@:\r%@", connectionIdentifier, messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got user info for %@:\r%@", connectionIdentifier, userInfo);
}


- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got misc info for %@:\r%@", connectionIdentifier, miscInfo);
}


- (void)searchResultsReceived:(NSArray *)searchResults forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got search results for %@:\r%@", connectionIdentifier, searchResults);
}


- (void)socialGraphInfoReceived:(NSArray *)socialGraphInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got social graph results for %@:\r%@", connectionIdentifier, socialGraphInfo);
}


- (void)imageReceived:(NSImage *)image forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got an image for %@: %@", connectionIdentifier, image);
    
    // Save image to the Desktop.
    NSString *path = [[NSString stringWithFormat:@"~/Desktop/%@.tiff", connectionIdentifier] stringByExpandingTildeInPath];
    [[image TIFFRepresentation] writeToFile:path atomically:NO];
}

- (void)connectionFinished:(NSString *)connectionIdentifier
{
    NSLog(@"Connection finished %@", connectionIdentifier);
	
	if ([twitterEngine numberOfConnections] == 0)
	{
		//[NSApp terminate:self];
	}
}

- (void)accessTokenReceived:(OAToken *)aToken forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Access token received! %@",aToken);
	token = [aToken retain];
	[twitterEngine setAccessToken:token];
	
	NSLog(@"getHomeTimelineFor: connectionIdentifier = %@", [twitterEngine getHomeTimelineSinceID:0 startingAtPage:0 count:8]);
	
	
	//[self runTests];
}

-(void)userLoginSuccessful
{
	MKFacebookRequest *request = [MKFacebookRequest requestWithDelegate:self];
	NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
	NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate dateWithTimeIntervalSinceNow:-86400] timeIntervalSince1970]];
	NSLog(@"%@",time);
	[parameters setValue:time forKey:@"start_time"];
	[parameters setValue:@"true2" forKey:@"include_read"];
	[request sendRequest:@"notifications.getList" withParameters:parameters];
	MKFacebookRequest *fbookRequests = [MKFacebookRequest requestWithDelegate:self];
	[fbookRequests sendRequest:@"notifications.get" withParameters:nil];
}

- (void)facebookRequest:(MKFacebookRequest *)request responseReceived:(id)response
{
	if ([[request method] isEqualToString:@"notifications.get"]) {
		//do something with the response
		//NSLog(@"%@",response);
		//NSLog(@"%@",[[response rootElement] elementsForName:@"messages"]);
		//NSLog(@"%@",[[[[[[[response rootElement] elementsForName:@"messages"] objectAtIndex:0] elementsForName:@"unread"] objectAtIndex:0] stringValue] intValue]);
		//MESSAGES
		int unreadMessages = [[[[[[[response rootElement] elementsForName:@"messages"] objectAtIndex:0] elementsForName:@"unread"] objectAtIndex:0] stringValue] intValue];
		if (unreadMessages == 1) {
			
		} else if (unreadMessages > 1) {
			
		} else {
			//NO MESSAGES
		}
		//END MESSAGES
		//EVENTS
		int newEvents = [[[[[response rootElement] elementsForName:@"event_invites"] objectAtIndex:0] elementsForName:@"eid"] count];
		int i;
		for (i = 0; i < newEvents; i++) {
			MKFacebookRequest *request = [MKFacebookRequest requestWithDelegate:self];
			NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
			[parameters setValue:[[[[[[response rootElement] elementsForName:@"event_invites"] objectAtIndex:0] elementsForName:@"eid"] objectAtIndex:i] stringValue] forKey:@"eids"];
			[request sendRequest:@"events.get" withParameters:parameters];
			NSLog(@"%@",[[[[[[response rootElement] elementsForName:@"event_invites"] objectAtIndex:0] elementsForName:@"eid"] objectAtIndex:i] stringValue] );
		}
		//END EVENTS
	} else if ([[request method] isEqualToString:@"notifications.getList"]) {
		NSMutableArray *noteIds = [[NSMutableArray alloc] init];
		NSArray *notifications = [[[[response rootElement] elementsForName:@"notifications"] objectAtIndex:0] children];
		for (NSXMLElement *notificationElement in notifications) {
			NSMutableString *url = [[NSMutableString alloc] init];
			for (NSString *part in [[[[notificationElement elementsForName:@"href"] objectAtIndex:0] stringValue] componentsSeparatedByString:@"&amp;"]) {
				[url appendFormat:@"%@",part];
			}
			NSMutableAttributedString *updateText = [[NSMutableAttributedString alloc] init];
			//NSLog(@"%@",response);
			//NSLog(@"Text: \"%@\"", [[[notificationElement elementsForName:@"body_text"] objectAtIndex:0] stringValue]);
			if ((![[[[notificationElement elementsForName:@"body_text"] objectAtIndex:0] stringValue] isEqualToString:@""]) && [[[notificationElement elementsForName:@"body_text"] objectAtIndex:0] stringValue] != nil) {
				[updateText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\"", [[[notificationElement elementsForName:@"title_text"] objectAtIndex:0] stringValue]]]];
				[updateText appendAttributedString:[NSAttributedString hyperlinkFromString:[[[notificationElement elementsForName:@"body_text"] objectAtIndex:0] stringValue] withURL:[NSURL URLWithString:url]]];
				[updateText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\""]];
			} else {
				[updateText appendAttributedString:[NSAttributedString hyperlinkFromString:[[[notificationElement elementsForName:@"title_text"] objectAtIndex:0] stringValue] withURL:[NSURL URLWithString:url]]];
			}
			[noteIds addObject:[[[notificationElement elementsForName:@"notification_id"] objectAtIndex:0] stringValue]];
			NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:updateText, @"text", @"facebook", @"service", [NSDate dateWithTimeIntervalSince1970:[[[[notificationElement elementsForName:@"created_time"] objectAtIndex:0] stringValue] intValue]], @"date", [NSNumber numberWithInt:JHLImportantItem], @"importance", [[[notificationElement elementsForName:@"notification_id"] objectAtIndex:0] stringValue], @"id", nil];
			[currentController newUpdateWithDict:dict];
		}
		if ([noteIds count] > 0) {
			MKFacebookRequest *request = [MKFacebookRequest requestWithDelegate:self];
			NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
			
			[parameters setValue:noteIds forKey:@"notification_ids"];
			[request sendRequest:@"notifications.markRead" withParameters:parameters];
			lastTimeFacebookWasCalled = [NSString stringWithFormat:@"%d",[[NSDate date] timeIntervalSince1970]];
		}
	} else if ([[request method] isEqualToString:@"events.get"]) {
		//NSLog(@"%@",response);
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"h:mm a EEEE MMMM d"];
		NSString *date = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[[[[[[response rootElement] elementsForName:@"event"] objectAtIndex:0] elementsForName:@"start_time"] objectAtIndex:0] stringValue] intValue]]];
		//NSLog(@"%@", date);
		NSString *eventInvitation = [NSString stringWithFormat:@"Sir, your attendance is being requested at a function: %@ at %@. I have checked your calendar and you seem to be free.",
									 [[[[[[response rootElement] elementsForName:@"event"] objectAtIndex:0] elementsForName:@"name"] objectAtIndex:0] stringValue], date];
		//NSLog(@"%@",eventInvitation);
		[currentController logText:eventInvitation andRead:NO];
	}
}

- (void)facebookRequest:(MKFacebookRequest *)request errorReceived:(MKFacebookResponseError *)error
{
	NSLog(@"%d: %@", [error errorCode], [error errorMessage]);
    //oh crap something went wrong, do something with the error
}

- (void)facebookRequest:(MKFacebookRequest *)request failed:(NSError *)error{
    //something went very wrong..
}

- (void)checkTweets:(NSTimer*)theTimer {
	NSLog(@"Checking for new Tweets");
	NSLog(@"getHomeTimelineFor: connectionIdentifier = %@", [twitterEngine getHomeTimelineSinceID:latest startingAtPage:0 count:20]);
}

- (void)checkForMail: (NSTimer*)theTimer {
	mail = [SBApplication applicationWithBundleIdentifier:@"com.apple.Mail"];
	NSString *scriptPath = [[NSBundle mainBundle] pathForResource: @"ProcessMail" ofType: @"scpt" inDirectory: @"Scripts"];
	NSAppleScript *mailProcessor = [[NSAppleScript alloc] initWithContentsOfURL:[NSURL fileURLWithPath: scriptPath] error: nil];
	[mailProcessor executeAndReturnError:nil];
	/*MLReference *ref = [mail inbox];
	 MLCountCommand *cmd = [[ref count] each:[MLConstant message]];
	 id numberOfMessages = [cmd send];*/
	NSMutableArray *updatesToSend = [[NSMutableArray alloc] init];
	for (MailMessage *message in [[[mail inbox] messages] get]) {
		//NSLog(@"%@",[[[ref get] each:[MLConstant message]] send]);
		if ([message readStatus]) {
			[updatesToSend addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"mail",@"service",[NSString stringWithFormat:@"From: %@\nSubject: %@",[message sender], [message subject]], @"text",[message dateSent], @"date",[NSNumber numberWithInt:0],@"importance",[NSNumber numberWithInt:[message id]],@"id", nil]];
		} else {
			[updatesToSend addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"mail",@"service",[NSString stringWithFormat:@"From: %@\nSubject: %@",[message sender], [message subject]], @"text",[message dateSent], @"date",[NSNumber numberWithInt:1],@"importance",[NSNumber numberWithInt:[message id]],@"id", nil]];
		}
	}
	NSLog(@"%@",updatesToSend);
	[currentController setUpdates:updatesToSend forService:@"mail"];
}

- (void)checkForFacebookNotifications:(NSTimer*)theTimer {
	MKFacebookRequest *request = [MKFacebookRequest requestWithDelegate:self];
	NSMutableDictionary *parameters = [[[NSMutableDictionary alloc] init] autorelease];
	
	[parameters setValue:lastTimeFacebookWasCalled forKey:@"start_time"];
	[parameters setValue:@"true" forKey:@"include_read"];
	[request sendRequest:@"notifications.getList" withParameters:parameters];
	MKFacebookRequest *fbookRequests = [MKFacebookRequest requestWithDelegate:self];
	[fbookRequests sendRequest:@"notifications.get" withParameters:nil];
}

- (void)postActionTweet:(NSNotification *)aNotification {
	[twitterEngine sendUpdate:[aNotification object]];
}

- (IBAction)showPreferences:(id)sender {
	if (!prefsLoaded) {
		[NSBundle loadNibNamed:@"Preferences" owner:prefs];
		prefsLoaded = TRUE;
	}
	[prefs makeKeyAndOrderFront:self];
}

@end
