/*
 *  NSAttributedString+Hyperlink.h
 *  Vanishing TextBox
 *
 *  Created by Hunter Leath on 5/31/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

@interface NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;
+(NSAttributedString *)attributedStringWithString:(NSString*)string;
@end

@implementation NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString: inString];
    NSRange range = NSMakeRange(0, [attrString length]);
	
    [attrString beginEditing];
    [attrString addAttribute:NSLinkAttributeName value:[aURL absoluteString] range:range];
    // next make the text appear with an underline
    [attrString addAttribute:
	 NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSSingleUnderlineStyle] range:range];
	
    [attrString endEditing];
	
    return [attrString autorelease];
}

+(NSAttributedString *)attributedStringWithString:(NSString*)string {
	return [[NSAttributedString alloc] initWithString:string];
}

@end