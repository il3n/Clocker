//
//  TickerView.m
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import "TickerView.h"
#import "DoubleSidedLayer.h"
#import "GradientOverlayLayer.h"
#import "NSView+Extras.h"

@interface TickerView () {
    struct {
        unsigned int ticking:1;
    } _flags;
}
@property (nonatomic, strong) GradientOverlayLayer *topFaceLayer;
@property (nonatomic, strong) GradientOverlayLayer *bottomFaceLayer;
@property (nonatomic, strong) DoubleSidedLayer *tickLayer;
@property (nonatomic, strong) CALayer *flipLayer;
@end

@implementation TickerView

-(id) initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self _setup];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self _setup];
    }
    return self;
}

-(id) init {
    if (self = [super init]) {
        [self _setup];
    }
    return self;
}

-(void) resizeSubviewsWithOldSize:(NSSize)oldSize {
    [super resizeSubviewsWithOldSize:oldSize];
    
    [self.frontView setFrame:self.bounds];
    [self.backView setFrame:self.bounds];
}

-(void) setFrontView:(NSView *)frontView {
    if (_frontView.superview) {
        [_frontView removeFromSuperview];
    }
    _frontView = frontView;
    [self addSubview:frontView];
}



#pragma mark-Private

-(void) _setup {
    _frontView = [[NSView alloc] init];
    _backView = [[NSView alloc] init];
    _tickLayer = [[DoubleSidedLayer alloc] init];
    
    [self addSubview:self.frontView];
    [self addSubview:self.backView];
    _duration = 0.5;
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
}

-(void) _initializeTick:(TickerViewTickDirection)direction {
    [self setFlipLayer:[CALayer layer]];
    [_flipLayer setFrame:self.layer.bounds];
    CATransform3D perspecitive = CATransform3DIdentity;
    float zDistanse = 400.0;
    perspecitive.m34 = 1.0 / -zDistanse;
    [_flipLayer setSublayerTransform:perspecitive];
    
    [self.layer addSublayer:_flipLayer];
    
    NSImage *frontImage = [_frontView image];
    NSImage *backImage = [_backView image];
    
    CGImageSourceRef frontImageSource = CGImageSourceCreateWithData((CFDataRef)[frontImage TIFFRepresentation], NULL);
    CGImageRef frontCGImage =  CGImageSourceCreateImageAtIndex(frontImageSource, 0, NULL);
    
    CGImageSourceRef backImageSource = CGImageSourceCreateWithData((CFDataRef)[backImage TIFFRepresentation], NULL);
    CGImageRef backCGImage =  CGImageSourceCreateImageAtIndex(backImageSource, 0, NULL);

    [self setTopFaceLayer:[[GradientOverlayLayer alloc] initWithStyle:GradientOverlayLayerTypeFace segment:GradientOverlayLayerSegmentTop]];
    [_topFaceLayer setFrame:NSMakeRect(0, 0, _flipLayer.bounds.size.width, floorf(_flipLayer.bounds.size.height/2))];
    [self setBottomFaceLayer:[[GradientOverlayLayer alloc] initWithStyle:GradientOverlayLayerTypeFace segment:GradientOverlayLayerSegmentBottom]];
    [_bottomFaceLayer setFrame:NSMakeRect(0, floorf(_flipLayer.bounds.size.height/2), _flipLayer.bounds.size.width, floorf(_flipLayer.bounds.size.height/2.0))];
    
    [self setTickLayer:[[DoubleSidedLayer alloc] init]];
    [_tickLayer setAnchorPoint:NSMakePoint(1.0, 1.0)];
    [_tickLayer setFrame:NSMakeRect(0, 0, _flipLayer.bounds.size.width, floor(_flipLayer.bounds.size.height/2.0))];
    [_tickLayer setZPosition:1];
    
    [_tickLayer setFrontLayer:[[GradientOverlayLayer alloc] initWithStyle:GradientOverlayLayerTypeTick segment:GradientOverlayLayerSegmentTop]];
    [_tickLayer setBackLayer:[[GradientOverlayLayer alloc] initWithStyle:GradientOverlayLayerTypeTick segment:GradientOverlayLayerSegmentBottom]];
    
    if (direction == TickerViewTickDirectionDown) {
        [_topFaceLayer setContents:(__bridge id)backCGImage];
        [_bottomFaceLayer setContents:(__bridge id)frontCGImage];
        [_tickLayer.frontLayer setContents:(__bridge id)frontCGImage];
        [_tickLayer.backLayer setContents:(__bridge id)backCGImage];
        
        [_topFaceLayer setGradientOpacity:1.];
        
        [_tickLayer setTransform:CATransform3DIdentity];
    } else if (direction == TickerViewTickDirectionUp) {
        [_topFaceLayer setContents:(__bridge id)frontCGImage];
        [_bottomFaceLayer setContents:(__bridge id)backCGImage];
        [_tickLayer.frontLayer setContents:(__bridge id)backCGImage];
        [_tickLayer.backLayer setContents:(__bridge id)frontCGImage];
        
        [_bottomFaceLayer setGradientOpacity:1.];
        
        [_tickLayer setTransform:CATransform3DMakeRotation(-M_PI, 1., 0., 0.)];
    }
    
    
    // Add layers
    [_flipLayer addSublayer:_topFaceLayer];
    [_flipLayer addSublayer:_bottomFaceLayer];
    [_flipLayer addSublayer:_tickLayer];
}


- (void)_finalizeTick:(void (^)(void))completion {
    NSView *frontView = self.frontView;
    [self setFrontView:self.backView];
    [self setBackView:frontView];
    
    if (completion)
        completion();
    
    _flags.ticking = NO;
}

-(void) tick:(TickerViewTickDirection)direction animated:(BOOL)animated completion:(void (^)(void))completion {
    if (_flags.ticking || !_frontView || !_backView)
        return;
    _flags.ticking = YES;
    
    if (!animated) {
        [self _finalizeTick:completion];
        return;
    }
    
    [self _initializeTick:direction];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, .01 * NSEC_PER_SEC); // WTF!
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [CATransaction begin];
        [CATransaction setAnimationDuration:_duration];
        
        [CATransaction setCompletionBlock:^{
            [_flipLayer removeFromSuperlayer], _flipLayer = nil;
            [_topFaceLayer removeFromSuperlayer], _topFaceLayer = nil;
            [_bottomFaceLayer removeFromSuperlayer], _bottomFaceLayer = nil;
            [_tickLayer removeFromSuperlayer], _tickLayer = nil;
            
            [self _finalizeTick:completion];
        }];
        
        CGFloat angle = (M_PI) * (1-direction);
        _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
        
        _topFaceLayer.gradientOpacity = direction;
        _bottomFaceLayer.gradientOpacity = 1. - direction;
        
        ((GradientOverlayLayer*)_tickLayer.frontLayer).gradientOpacity = 1. - direction;
        ((GradientOverlayLayer*)_tickLayer.backLayer).gradientOpacity = direction;
        
        [CATransaction commit];
    });

}

@end







































