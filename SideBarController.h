//
//  SideBarController.h
//  Vanishing TextBox
//
//  Created by Hunter Leath on 5/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GlobalDefinitions.h"

@interface SideBarController : NSObject {
	IBOutlet NSView *updaterView;
	IBOutlet NSTextField *info;
	IBOutlet NSTextView *log;
	IBOutlet NSImageView *serviceIcon;
	IBOutlet NSView *actionView;
	IBOutlet NSView *actionPlace;
	IBOutlet NSView *windowContentView;
	IBOutlet NSView *background;
	NSMutableArray *updates;
	NSMutableArray *pads;
}
@property (retain, nonatomic) IBOutlet NSView *updaterView;
@property (retain, nonatomic) IBOutlet NSView *actionView;
@property (retain, nonatomic) IBOutlet NSView *actionPlace;
@property (retain, nonatomic) IBOutlet NSTextField *info;
@property (retain, nonatomic) IBOutlet NSImageView *serviceIcon;
- (void)newUpdateWithService:(NSString *)service andText:(NSString *)text andDate:(NSDate *)date andImportanceFactor:(int)importance andId:(int)id_;
- (BOOL)removeUpdateWithService:(NSString *)service andText:(NSString *)text andDate:(NSDate *)date andImportanceFactor:(int)importance andId:(int)id_;
- (void)redrawUpdates;
- (void)registerActionPad:(NSWindow*)pad;
- (void)showPad:(NSWindow*)pad atCoordinates:(NSPoint)screenPoint;
- (NSDictionary*)attributesOfItemAtIdex:(int)index;
- (void)setUpdates:(NSArray*)updateArray forService:(NSString*)serviceName;
- (void)newUpdateWithDict:(NSDictionary *)dict;
- (void)logText:(NSString *)text andRead:(BOOL)read;
@end
