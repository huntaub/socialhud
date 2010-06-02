//
//  HyperLinkTextView.m
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HyperLinkTextView.h"
#import "NSAttributedString+Hyperlink.h"

@implementation HyperLinkTextView

- (void) setStringValue: (NSString *) stringValue {
	@try {
		NSScanner *hyperlinkScanner = [[NSScanner alloc] initWithString:stringValue];
		NSMutableAttributedString *realString = [[NSMutableAttributedString alloc] init];
		int beforeLocation, afterLocation, timer;
		timer = 0;
		BOOL stop = TRUE;
		while ([hyperlinkScanner isAtEnd] == NO && stop)
		{
			if ([hyperlinkScanner scanUpToString:@"http://" intoString:NULL])
			{
				if ([hyperlinkScanner isAtEnd] == NO) {
					beforeLocation = [hyperlinkScanner scanLocation];
					if ([hyperlinkScanner scanUpToString:@" " intoString:NULL]) {
						if ([hyperlinkScanner isAtEnd] == NO) {
							NSString *restOfURL = [stringValue substringWithRange:NSMakeRange(beforeLocation, [hyperlinkScanner scanLocation])];
							if (timer == 0) {
								NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringToIndex:beforeLocation]];
								[realString appendAttributedString:start];
							} else {
								NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringWithRange:NSMakeRange(afterLocation, beforeLocation - afterLocation)]];
								[realString appendAttributedString:start];
							}
							restOfURL = [[restOfURL componentsSeparatedByString:@" "] objectAtIndex:0];
							[realString appendAttributedString:[NSAttributedString hyperlinkFromString:restOfURL withURL:[NSURL URLWithString:restOfURL]]];
							afterLocation = [hyperlinkScanner scanLocation];
						} else {
							[hyperlinkScanner setScanLocation:beforeLocation];
							if ([hyperlinkScanner scanUpToString:@". " intoString:NULL]) {
								if ([hyperlinkScanner isAtEnd] == NO) {
									NSString *restOfURL = [[stringValue substringWithRange:NSMakeRange(beforeLocation, [hyperlinkScanner scanLocation])] copy];
									if (timer == 0) {
										NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringToIndex:beforeLocation]];
										[realString appendAttributedString:start];
									} else {
										NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringWithRange:NSMakeRange(afterLocation, beforeLocation - afterLocation)]];
										[realString appendAttributedString:start];
									}
									restOfURL = [[restOfURL componentsSeparatedByString:@" "] objectAtIndex:0];
									[realString appendAttributedString:[NSAttributedString hyperlinkFromString:restOfURL withURL:[NSURL URLWithString:restOfURL]]];
									afterLocation = [hyperlinkScanner scanLocation];
								} else {
									NSString *restOfURL = [[stringValue substringFromIndex:beforeLocation] copy];
									if (timer == 0) {
										NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringToIndex:beforeLocation]];
										[realString appendAttributedString:start];
									} else {
										NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringWithRange:NSMakeRange(afterLocation, beforeLocation - afterLocation)]];
										[realString appendAttributedString:start];
									}
									[realString appendAttributedString:[NSAttributedString hyperlinkFromString:restOfURL withURL:[NSURL URLWithString:restOfURL]]];
									afterLocation = -1;
								}
							}
						}
					} else {
						beforeLocation = 0;
					}
				} else {
					if (afterLocation != -1) {
						NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringFromIndex:afterLocation]];
						[realString appendAttributedString:start];
					}
				}
			} else {
				/*stop = FALSE;
				 if (afterLocation != -1) {
				 NSAttributedString *start = [[NSAttributedString alloc] initWithString:[stringValue substringFromIndex:afterLocation]];
				 [realString appendAttributedString:start];
				 }*/
			}
			timer ++;
		}
		[super setAttributedStringValue:realString];
	} @catch (...) {
		NSLog(@"Caught: %@", stringValue);
		[super setStringValue:stringValue];
	}
}

@end
