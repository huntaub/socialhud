//
//  ActivatingButton.h
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ActivatingButton : NSImageView {
	NSPoint clickedPoint;
}
@property (readonly) NSPoint clickedPoint;
@end
