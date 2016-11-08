//
//  GradientOverlayLayer.h
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AppKit/AppKit.h>

typedef enum {
    GradientOverlayLayerTypeFace,
    GradientOverlayLayerTypeTick
}GradientOverlayLayerType;

typedef enum {
    GradientOverlayLayerSegmentTop,
    GradientOverlayLayerSegmentBottom
}GradientOverlayLayerSegment;


@interface GradientOverlayLayer : CALayer

@property (nonatomic, readonly) GradientOverlayLayerType type;
@property (nonatomic, readonly) GradientOverlayLayerSegment segment;
@property (nonatomic) CGFloat gradientOpacity;

-(id) initWithStyle:(GradientOverlayLayerType)type segment:(GradientOverlayLayerSegment)segment;

@end
