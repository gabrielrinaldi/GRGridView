//
//  ExampleViewController.m
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
#import "ExampleCell.h"
#import "ExampleViewController.h"

#pragma mark ExampleViewController (Private)

@interface ExampleViewController ()

@property (retain, nonatomic) GRGridView *gridView;

@end

#pragma mark - ExampleViewController

@implementation ExampleViewController

#pragma mark - Getters/Setters

@synthesize gridView;

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)loadView {
    [super loadView];

    gridView = [[GRGridView alloc] initWithFrame:self.view.bounds];
    [gridView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [gridView setGridSize:CGSizeMake(0, 300)];
    [gridView setPadding:10];
    [gridView setInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [[self view] addSubview:gridView];

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [footerView setBackgroundColor:[UIColor yellowColor]];
    [gridView setFooterView:footerView];
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSRunLoopCommonModes];

    ExampleCell *twoRowCell = [[ExampleCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [[twoRowCell textLabel] setText:@"2x2"];
    [twoRowCell setGridPair:GRGridPairMake(0, 0)];
    [twoRowCell setGridSpan:GRGridSpanMake(2, 2)];
    [gridView addCell:twoRowCell animated:YES];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];

    ExampleCell *twoColumnCell = [[ExampleCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [[twoColumnCell textLabel] setText:@"1x2"];
    [twoColumnCell setGridPair:GRGridPairMake(0, 2)];
    [twoColumnCell setGridSpan:GRGridSpanMake(1, 2)];
    [gridView addCell:twoColumnCell animated:YES];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];

    twoColumnCell = [[ExampleCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [[twoColumnCell textLabel] setText:@"1x2"];
    [twoColumnCell setGridPair:GRGridPairMake(1, 2)];
    [twoColumnCell setGridSpan:GRGridSpanMake(1, 2)];
    [gridView addCell:twoColumnCell animated:YES];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];

    int j = 2;
    for (int i = 0; i < 20; i++) {
        ExampleCell *cell = [[ExampleCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [[cell textLabel] setText:[NSString stringWithFormat:@"%d", i]];
        [cell setGridPair:GRGridPairMake(j, i % 4)];
        [gridView addCell:cell animated:YES];

        if (i > 0 && i % 4 == 3) {
            j++;
        }

        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

@end
