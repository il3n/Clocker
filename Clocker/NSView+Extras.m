//
//  NSView+Extras.m
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "NSView+Extras.h"

@implementation NSView (Extras)

-(NSImage *) image {
    NSImage *im = [[NSImage alloc] initWithData:[self dataWithPDFInsideRect:self.bounds]];
    return  im;
}

@end
