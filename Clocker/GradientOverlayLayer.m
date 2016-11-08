//
//  GradientOverlayLayer.m
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "GradientOverlayLayer.h"

@interface GradientOverlayLayer()
@property (nonatomic, assign) CGFloat minimumOpacity;
@property (nonatomic, assign) CGFloat maximumOpacity;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CALayer *gradientMaskLayer;
@end


@implementation GradientOverlayLayer

-(id) initWithStyle:(GradientOverlayLayerType)type segment:(GradientOverlayLayerSegment)segment {
    if (self = [super init]) {
        _type = type;
        _segment = segment;
        
        [self setMasksToBounds:YES];
        [self addSublayer:self.gradientLayer];
        [self setContentsScale:[[NSScreen mainScreen] backingScaleFactor]];
        [_gradientLayer setMask:_gradientMaskLayer];
        
        if (type == GradientOverlayLayerTypeFace) {
            [_gradientLayer setColors:@[(__bridge id)[NSColor colorWithWhite:0.0 alpha:0.5].CGColor,
                                        (__bridge id)[NSColor colorWithWhite:0.0 alpha:1.0].CGColor
                                        ]];
            
            [_gradientLayer setLocations:@[@(0.0), @(1.0)]];
            _maximumOpacity = 0.75;
            
        } else {
            [_gradientLayer setColors:@[(__bridge id)[NSColor colorWithWhite:0.0 alpha:0.0].CGColor,
                                       (__bridge id)[NSColor colorWithWhite:0.0 alpha:0.5].CGColor,
                                        (__bridge id)[NSColor colorWithWhite:0.0 alpha:1.0].CGColor]];
            [_gradientLayer setLocations:@[@(0.2), @(0.4), @(1.0)]];
            _maximumOpacity = 1.0;
        }
        
        if (segment == GradientOverlayLayerSegmentTop) {
            [self setContentsGravity:kCAGravityBottom];
            [_gradientLayer setStartPoint:CGPointMake(0.0, 0.0)];
            [_gradientLayer setEndPoint:CGPointMake(0.0, 1.0)];
            [_gradientMaskLayer setContentsGravity:kCAGravityBottom];
            
        } else {
            [self setContentsGravity:kCAGravityTop];
            [_gradientLayer setStartPoint:CGPointMake(0.0, 1.0)];
            [_gradientLayer setEndPoint:CGPointMake(0.0, 0.0)];
            [_gradientMaskLayer setContentsGravity:kCAGravityTop];
        }
        [_gradientLayer setOpacity:_minimumOpacity];
    }
    return self;
}

-(void) layoutSublayers {
    [super layoutSublayers];
    [_gradientLayer setFrame:self.bounds];
    [_gradientMaskLayer setFrame:self.bounds];
}

-(CAGradientLayer *) gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc] init];
        [_gradientLayer setFrame:self.bounds];
    }
    return _gradientLayer;
}

-(CGFloat) gradientOpacity {
    return _gradientLayer.opacity;
}

-(void) setGradientOpacity:(CGFloat)opacity {
    [_gradientLayer setOpacity:(opacity * (_maximumOpacity - _minimumOpacity) + _minimumOpacity)];
}

-(void) setContents:(id)contents {
    [super setContents:contents];
    [_gradientMaskLayer setContents:contents];
}

@end




























