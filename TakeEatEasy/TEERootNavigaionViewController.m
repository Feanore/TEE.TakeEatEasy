//
//  TEERootNavigaionViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 02.02.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEERootNavigaionViewController.h"
#import "TEEFilterViewController.h"
#import "TEEMapViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "AppDelegate.h"

@interface TEERootNavigaionViewController ()

@end

@implementation TEERootNavigaionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(panGestureRecognized:)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    self.frostedViewController.menuViewController = [self appdelegate].filterController;
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController panGestureRecognized:sender];

}


#pragma mark - Actions

- (AppDelegate *) appdelegate{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate;
}

- (void) presentFilterController: (id) sender{
    
    NSLog(@"%s",__FUNCTION__);
    
    self.frostedViewController.menuViewController = [self appdelegate].filterController;
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
    
}
- (void) presentMapController: (id) sender{
    
    NSLog(@"%s",__FUNCTION__);
    
    self.frostedViewController.menuViewController = [self appdelegate].mapController;
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
    
}


@end
