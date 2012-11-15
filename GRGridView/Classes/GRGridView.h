//
//  GRGridView.h
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

#import "GRGridConstraint.h"

#pragma mark GRGridView

@interface GRGridView : UIScrollView

@property (nonatomic) UIView *footerView;
@property (nonatomic) NSUInteger padding;
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGSize gridSize; // 0 to auto ajust to grid contentSize

- (NSArray *)cells;
- (UIView <GRGridConstraint> *)cellAtGridPair:(GRGridPair)pair;
- (void)addCell:(UIView <GRGridConstraint> *)cell; // Don't redraw the layout
- (void)addCell:(UIView <GRGridConstraint> *)cell animated:(BOOL)animated; // Redraw the layout
- (void)removeCell:(UIView <GRGridConstraint> *)cell; // Don't redraw the layout
- (void)removeCell:(UIView <GRGridConstraint> *)cell animated:(BOOL)animated; // Redraw the layout
- (void)removeCellAtGridPair:(GRGridPair)pair; // Don't redraw the layout
- (void)removeCellAtGridPair:(GRGridPair)pair animated:(BOOL)animated; // Redraw the layout
- (void)removeAllCells; // Don't redraw the layout
- (void)removeAllCellsAnimated:(BOOL)animated; // Redraw the layout
- (void)layoutViewsAnimated:(BOOL)animated;

@end
