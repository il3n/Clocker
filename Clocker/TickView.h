//
//  TickView.h
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TickView : NSView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) NSColor *backColor;
@property (nonatomic, strong) NSColor *titleColor;
+ (id)tickViewWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;
@end
