//
//  TEEFilterViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 19.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEEFilterViewController.h"
#import "TEEFilterTableViewCell.h"
#import "UIViewController+REFrostedViewController.h"
#import "UIColor+Tints.h"


@interface TEEFilterViewController ()

@property (nonatomic) UILabel *searchLabel;
@property (nonatomic) UISegmentedControl *searchSegmentedControl;
@property (nonatomic) UILabel *sortLabel;
@property (nonatomic) UISegmentedControl *sortSegmentedControl;

@end

@implementation TEEFilterViewController

@synthesize searchLabel = _searchLabel;
@synthesize searchSegmentedControl = _searchSegmentedControl;
@synthesize sortLabel = _sortLabel;
@synthesize sortSegmentedControl = _sortSegmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _searchLabel = [UILabel new];
    _searchLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _searchLabel.textColor = [UIColor darkGrayColor];
    _searchLabel.textAlignment = NSTextAlignmentCenter;
    _searchLabel.font = [UIFont systemFontOfSize:20.0f];
    _searchLabel.text = @"Search by";
    [self.view addSubview:_searchLabel];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_searchLabel]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_searchLabel)]];
    
    UIView *view1 = [UIView new];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    
    _searchSegmentedControl = [UISegmentedControl new];
    _searchSegmentedControl.frame = CGRectMake(0, 10.5, 200, 29);
    _searchSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _searchSegmentedControl.tintColor = [UIColor appColor];
    [_searchSegmentedControl insertSegmentWithTitle:@"by Restaurant" atIndex:0 animated:NO];
    [_searchSegmentedControl insertSegmentWithTitle:@"by Course" atIndex:1 animated:NO];
    _searchSegmentedControl.selectedSegmentIndex = 0;
    [view1 addSubview:_searchSegmentedControl];
    [self.view addSubview:view1];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view1]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(view1)]];
    
    
    _sortLabel = [UILabel new];
    _sortLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _sortLabel.textColor = [UIColor darkGrayColor];
    _sortLabel.textAlignment = NSTextAlignmentCenter;
    _sortLabel.font = [UIFont systemFontOfSize:20.0f];
    _sortLabel.text = @"Sort by";
    [self.view addSubview:_sortLabel];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_sortLabel]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_sortLabel)]];
    
    
    
    UIView *view2 = [UIView new];
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    _sortSegmentedControl = [UISegmentedControl new];
    _sortSegmentedControl.frame = CGRectMake(0, 10.5, 200, 29);
    _sortSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _sortSegmentedControl.tintColor = [UIColor appColor];
    [_sortSegmentedControl insertSegmentWithTitle:@"by Price" atIndex:0 animated:NO];
    [_sortSegmentedControl insertSegmentWithTitle:@"by Distance" atIndex:1 animated:NO];
    _sortSegmentedControl.selectedSegmentIndex = 1;
    [view2 addSubview:_sortSegmentedControl];
    [self.view addSubview:view2];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view2]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(view2)]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_searchLabel(==40)]-0-[view1(==40)]-[_sortLabel(==40)]-0-[view2(==40)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_searchLabel, view1, _sortLabel, view2)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
