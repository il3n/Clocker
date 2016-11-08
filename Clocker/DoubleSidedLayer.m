//
//  DoubleSidedLayer.m
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "DoubleSidedLayer.h"

@implementation DoubleSidedLayer

-(id) init {
    if (self = [super init]) {
        [self setDoubleSided:YES];
    }
    return self;
}

-(void) layoutSublayers {
    [super layoutSublayers];
    [_frontLayer setFrame:self.bounds];
    [_backLayer setFrame:self.bounds];
}

#pragma mark-properties

-(void) setFrontLayer:(CALayer *)frontLayer {
    if (_frontLayer != frontLayer) {
        [_frontLayer removeFromSuperlayer];
        _frontLayer = frontLayer;
        [_frontLayer setDoubleSided:NO];
        [self addSublayer:frontLayer];
        [self setNeedsLayout];
    }
}

-(void) setBackLayer:(CALayer *)backLayer {
    if (_backLayer != backLayer) {
        [_backLayer removeFromSuperlayer];
        _backLayer = backLayer;
        [_backLayer setDoubleSided:NO];
        CATransform3D transform = CATransform3DMakeRotation(M_PI, 1., 0., 0.);
        [_backLayer setTransform:transform];
        [self addSublayer:_backLayer];
        [self setNeedsLayout];
    }
}

@end
