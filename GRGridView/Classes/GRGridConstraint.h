//
//  GRGridCellConstraint.h
//  GRGridView
//
//  Created by Gabriel Rinaldi on 10/19/12.
//  Copyright (c) 2012 Gabriel Rinaldi. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

typedef enum {
    GRGridViewOptionDefault = 0,
    GRGridViewOptionFixedWidth = (1 << 0),
    GRGridViewOptionFixedHeight = (1 << 1),
    GRGridViewOptionFixedSize = GRGridViewOptionFixedWidth | GRGridViewOptionFixedHeight
} GRGridViewOption;

typedef struct {
    NSUInteger row;
    NSUInteger column;
} GRGridPair;

static inline GRGridPair
GRGridPairMake(NSUInteger row, NSUInteger column) {
    GRGridPair gridPair; gridPair.row = row; gridPair.column = column; return gridPair;
}

typedef struct {
    NSUInteger rows;
    NSUInteger columns;
} GRGridSpan;

static inline GRGridSpan
GRGridSpanMake(NSUInteger rows, NSUInteger columns) {
    GRGridSpan gridSpan; gridSpan.rows = rows; gridSpan.columns = columns; return gridSpan;
}

typedef struct {
    GRGridPair pair;
    GRGridSpan span;
} GRGridPosition;

static inline GRGridPosition
GRGridPositionMake(GRGridPair pair, GRGridSpan span) {
    GRGridPosition gridPosition; gridPosition.pair = pair; gridPosition.span = span; return gridPosition;
}

#pragma mark GRGridConstraint

@protocol GRGridConstraint <NSObject>

@property (nonatomic) GRGridPair gridPair;
@property (nonatomic) GRGridSpan gridSpan;
@property (nonatomic) NSUInteger options;

@end
