//
//  AppDelegate.m
//  ClockerTest
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

    NSFont *font = [NSFont fontWithName:@"Helvetica Neue" size:100];
    CGFloat fontHeight = [[[NSLayoutManager alloc] init] defaultLineHeightForFont:font];
    NSLog(@"fontHeight:%@", [[NSFontManager sharedFontManager] availableFonts]);
    
//    ClockerView *cv = [[ClockerView alloc] initWithFrame:NSZeroRect isPreview:false];
//    
////    NSView *cv = [[NSView alloc] initWithFrame:NSZeroRect];
//    
//    cv.wantsLayer = YES;
//    cv.layer.backgroundColor = [NSColor orangeColor].CGColor;
//    cv.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.window.contentView addSubview:cv];
// 
//    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:cv attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:cv.superview attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
//                                              [NSLayoutConstraint constraintWithItem:cv attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:cv.superview attribute:NSLayoutAttributeHeight multiplier:1 constant:0],
//                                              [NSLayoutConstraint constraintWithItem:cv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cv.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0],
//                                              [NSLayoutConstraint constraintWithItem:cv attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cv.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0]
//                                              ]];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
