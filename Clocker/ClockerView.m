//
//  KSColorHexView.m
//  KSColorHex
//
//  Created by Debasis Das on 2/3/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import "ClockerView.h"
//#import <WebKit/WebKit.h>
#import <AppKit/AppKit.h>

@interface ClockerView ()
//@property (nonatomic, strong) WebView *htmlView;
@end

@implementation ClockerView

-(instancetype) initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    if (self = [super initWithFrame:frame isPreview:isPreview]) {
//        self.htmlView = [[WebView alloc]initWithFrame:_frame];
//        [self addSubview:self.htmlView];
        
        [self setAnimationTimeInterval:1/30];
    }
    return self;
}

-(void) startAnimation {
    [super startAnimation];
}

-(void) stopAnimation {
    [super stopAnimation];
}

-(void) animateOneFrame {

    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH : mm : ss"];
    NSString *time = [dateFormatter stringFromDate:date];
    [[NSColor blackColor] set];
    NSRectFill(self.bounds);
    
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSCenterTextAlignment;
    
    NSFont *font = [NSFont fontWithName:@"Helvetica Neue"     size:100.0];
    CGFloat fontHeight = [[[NSLayoutManager alloc] init] defaultLineHeightForFont:font];
    CGFloat timeY = (self.bounds.size.height-fontHeight)/2.;
    NSRect rect = NSMakeRect(0, timeY, self.bounds.size.width, fontHeight);
    
    [time drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:[NSColor whiteColor],NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
