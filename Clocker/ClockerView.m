//
//  KSColorHexView.m
//  KSColorHex
//
//  Created by Debasis Das on 2/3/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import "ClockerView.h"
#import <AppKit/AppKit.h>

@interface ClockerView ()
@property (nonatomic, strong) NSMutableArray *fontList;
@end

@implementation ClockerView

-(instancetype) initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    if (self = [super initWithFrame:frame isPreview:isPreview]) {
        _fontList = [[NSFontManager sharedFontManager] availableFonts].mutableCopy;
        NSLog(@"fontList:%@", _fontList);
        [self setAnimationTimeInterval:1];
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
    [dateFormatter setDateFormat:@"HH mm"];
    NSString *time = [dateFormatter stringFromDate:date];
    [[NSColor blackColor] set];
    NSRectFill(self.bounds);
    
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSCenterTextAlignment;
    
    NSString *fontName = @".GeezaProInterface-Light";
    
    NSFont *font = [NSFont fontWithName:fontName size:floor(self.bounds.size.height*0.3)];
//    font = [[NSFontManager sharedFontManager] convertFont:font toHaveTrait:NSFontBoldTrait];
    CGFloat fontHeight = [[[NSLayoutManager alloc] init] defaultLineHeightForFont:font];
    CGFloat timeY = (self.bounds.size.height-fontHeight)/2.;
    NSRect rect = NSMakeRect(0, timeY, self.bounds.size.width, fontHeight);
    
    [time drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:[NSColor colorWithWhite:0.8  alpha:1.0],NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    
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
