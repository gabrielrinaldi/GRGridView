//
//  ExampleCell.m
//  GRGridView
//
//  Created by Gabriel Rinaldi on 10/22/12.
//  Copyright (c) 2012 Gabriel Rinaldi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ExampleCell.h"

@implementation ExampleCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        _textLabel = [[UILabel alloc] initWithFrame:frame];
        [_textLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [[_textLabel layer] setCornerRadius:10];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_textLabel];

        _gridSpan = GRGridSpanMake(1, 1);
        _options = GRGridViewOptionDefault;
    }

    return self;
}

@end
