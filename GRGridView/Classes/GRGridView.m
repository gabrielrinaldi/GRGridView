//
//  GRGridView.m
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

#import "GRGridView.h"

typedef struct {
    NSUInteger rows;
    NSUInteger columns;
} GRGridSize;

static inline GRGridSize
GRGridSizeMake(NSUInteger rows, NSUInteger columns) {
    GRGridSize gridSize; gridSize.rows = rows; gridSize.columns = columns; return gridSize;
}

#pragma mark GRGridView (Private)

@interface GRGridView ()

@property (strong, nonatomic) NSMutableArray *cells;

- (void)commonInitialization;
- (GRGridSize)countRowsAndColumns;

@end

#pragma mark - GRGridView

@implementation GRGridView

#pragma mark - Getters/Setters

- (NSArray *)cells {
    return [NSArray arrayWithArray:_cells];
}

- (UIView <GRGridConstraint> *)cellAtGridPair:(GRGridPair)pair {
    for (UIView <GRGridConstraint> *cell in _cells) {
        if (cell.gridPair.row == pair.row && cell.gridPair.column == pair.column) {
            return cell;
        }
    }

    return nil;
}

#pragma mark - Initialization

- (id)init {
    self = [super init];
    if (self != nil) {
        [self commonInitialization];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self commonInitialization];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self commonInitialization];
    }

    return self;
}

- (void)commonInitialization {
    _cells = [NSMutableArray new];
    _padding = 0;
    _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    _gridSize = CGSizeMake(0, 0);
}

#pragma mark - Content management

- (void)addCell:(UIView <GRGridConstraint> *)cell {
    [_cells addObject:cell];
    [self addSubview:cell];
}

- (void)addCell:(UIView <GRGridConstraint> *)cell animated:(BOOL)animated {
    [self addCell:cell];

    [self layoutViewsAnimated:animated];
}

- (void)removeCell:(UIView <GRGridConstraint> *)cell {
    [cell removeFromSuperview];
    [_cells removeObject:cell];
}

- (void)removeCell:(UIView <GRGridConstraint> *)cell animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.35 : 0 animations:^{
        [cell setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeCell:cell];
    }];
}

- (void)removeCellAtGridPair:(GRGridPair)pair {
    for (UIView <GRGridConstraint> *cell in _cells) {
        if (cell.gridPair.row == pair.row && cell.gridPair.column == pair.column) {
            [cell removeFromSuperview];
            [_cells removeObject:cell];
            break;
        }
    }
}

- (void)removeCellAtGridPair:(GRGridPair)pair animated:(BOOL)animated {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];

    [UIView animateWithDuration:animated ? 0.35 : 0 animations:^{
        NSUInteger index = 0;
        for (UIView <GRGridConstraint> *cell in _cells) {
            if (cell.gridPair.row == pair.row && cell.gridPair.column == pair.column) {
                [indexSet addIndex:index];
                [cell setAlpha:0.0];
            }

            ++index;
        }
    } completion:^(BOOL finished) {
        [[_cells objectsAtIndexes:indexSet] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_cells removeObjectsAtIndexes:indexSet];
    }];
}

- (void)removeAllCells {
    [_cells makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_cells removeAllObjects];
}

- (void)removeAllCellsAnimated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.35 : 0 animations:^{
        for (UIView <GRGridConstraint> *cell in _cells) {
            [cell setAlpha:0.0];
        }
    } completion:^(BOOL finished) {
        [_cells makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_cells removeAllObjects];
    }];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [self layoutViewsAnimated:NO];
}

- (GRGridSize)countRowsAndColumns {
    NSUInteger maxRowIndex = 0;
    NSUInteger maxColumnIndex = 0;

    for (UIView <GRGridConstraint> *cell in _cells) {
        maxRowIndex = MAX((cell.gridPair.row + cell.gridSpan.rows - 1), maxRowIndex);
        maxColumnIndex = MAX((cell.gridPair.column + cell.gridSpan.columns - 1), maxColumnIndex);
    }

    return GRGridSizeMake(maxRowIndex + 1, maxColumnIndex + 1);
}

- (void)layoutViewsAnimated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.35 : 0 animations:^{
        GRGridSize size = [self countRowsAndColumns];
        if (size.rows == 0 || size.columns == 0) {
            return;
        }

        NSUInteger rowGapCount = size.rows - 1;
        CGFloat totalRowGapSpace = rowGapCount * [self padding];

        NSUInteger columnGapCount = size.columns - 1;
        CGFloat totalColumnGapSpace = columnGapCount * [self padding];

        CGRect bounds = CGRectMake(self.insets.left, self.insets.top, self.bounds.size.width - self.insets.left - self.insets.right, self.bounds.size.height - self.insets.top - self.insets.bottom);

        CGFloat rowHeight = (bounds.size.height - totalRowGapSpace) / size.rows;
        if (_gridSize.height != 0) {
            rowHeight = _gridSize.height + [self padding];
        }

        CGFloat columnWidth = (bounds.size.width - totalColumnGapSpace) / size.columns;
        if (_gridSize.width != 0) {
            columnWidth = _gridSize.width + [self padding];
        }

        for (UIView <GRGridConstraint> *cell in _cells) {
            CGFloat originX = bounds.origin.x + cell.gridPair.column * (columnWidth + [self padding]);
            CGFloat originY = bounds.origin.y + cell.gridPair.row * (rowHeight + [self padding]);
            CGFloat width = columnWidth * cell.gridSpan.columns + (cell.gridSpan.columns - 1) * [self padding];
            CGFloat height = rowHeight * cell.gridSpan.rows + (cell.gridSpan.rows - 1) * [self padding];

            NSUInteger options = [cell options];
            CGRect oldFrame = [cell frame];
            CGRect newFrame;

            if ((options & GRGridViewOptionFixedWidth) != 0) {
                CGFloat centerX = (originX + width) / 2;
                newFrame.origin.x = centerX - oldFrame.size.width / 2;
                newFrame.size.width = oldFrame.size.width;
            } else {
                newFrame.origin.x = originX;
                newFrame.size.width = width;
            }

            if ((options & GRGridViewOptionFixedHeight) != 0) {
                CGFloat centerY = (originY + height) / 2;
                newFrame.origin.y = centerY - oldFrame.size.height / 2;
                newFrame.size.height = oldFrame.size.height;
            } else {
                newFrame.origin.y = originY;
                newFrame.size.height = height;
            }
            
            [cell setFrame:newFrame];
        }

        [self setContentSize:CGSizeMake((columnWidth * size.columns) + totalColumnGapSpace + self.insets.left + self.insets.right, (rowHeight * size.rows) + totalRowGapSpace + self.insets.top + self.insets.bottom)];
    }];
}

@end
