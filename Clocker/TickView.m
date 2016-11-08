//
//  TickView.m
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "TickView.h"

@implementation TickView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackColor:[NSColor colorWithRed:0.173 green:0.176 blue:0.173 alpha:1.000]];
        [self setTitleColor:[NSColor colorWithWhite:0.7 alpha:1.000]];
        self.backColor = [NSColor clearColor];
        [self setFontSize:50.];
    }
    return self;
}

+ (id)tickViewWithTitle:(NSString *)title fontSize:(CGFloat)fontSize {
    TickView *view = [[TickView alloc] initWithFrame:CGRectZero];
    [view setTitle:title];
    [view setFontSize:fontSize];
    return view;
}
- (void)drawRect:(CGRect)rect {
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 1., 1.) xRadius:0 yRadius:0];
    
    [self.backColor set];
    [path fill];
    
    [self.titleColor set];

    
    NSFont *font = [NSFont fontWithName:@"Helvetica Neue" size:_fontSize];
//    CGFloat fontHeight = [[[NSLayoutManager alloc] init] defaultLineHeightForFont:font];
//    CGFloat fontY = (self.bounds.size.height - fontHeight) / 2.0;
//    CGRect rect = CGRectMake(0, fontY, self.bounds.size.width, fontHeight);
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;

    
    [self.title drawInRect:self.bounds withAttributes:@{NSForegroundColorAttributeName:[NSColor whiteColor], NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
}

@end
