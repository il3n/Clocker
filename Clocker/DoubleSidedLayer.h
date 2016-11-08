//
//  DoubleSidedLayer.h
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface DoubleSidedLayer : CATransformLayer
@property (nonatomic, strong) CALayer *frontLayer;
@property (nonatomic, strong) CALayer *backLayer;
@end
