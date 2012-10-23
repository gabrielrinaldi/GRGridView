//
//  ExampleCell.h
//  GRGridView
//
//  Created by Gabriel Rinaldi on 10/22/12.
//  Copyright (c) 2012 Gabriel Rinaldi. All rights reserved.
//

#import "GRGridConstraint.h"

#pragma mark ExampleCell

@interface ExampleCell : UIView <GRGridConstraint>

@property (strong, nonatomic) UILabel *textLabel;
@property (nonatomic) GRGridPair gridPair;
@property (nonatomic) GRGridSpan gridSpan;
@property (nonatomic) NSUInteger options;

@end
