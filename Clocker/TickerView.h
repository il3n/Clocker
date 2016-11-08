//
//  TickerView.h
//  Clocker
//
//  Created by lijun on 16/11/7.
//  Copyright © 2016年 lijun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    TickerViewTickDirectionDown,
    TickerViewTickDirectionUp,
}TickerViewTickDirection;



@interface TickerView : NSView

@property (nonatomic, strong) NSView *frontView;
@property (nonatomic, strong) NSView *backView;

// default .5
@property (nonatomic, assign) CFTimeInterval duration;

-(void) tick:(TickerViewTickDirection)direction animated:(BOOL)animated completion:(void (^)(void))completion;




@end
