//
//  TEERestaurantDetailsViewController.h
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 23.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "JPBFloatingTextViewController.h"
#import <Parse/Parse.h>

@interface TEERestaurantDetailsViewController : JPBFloatingTextViewController

@property (nonatomic) PFObject *restaurantInfo;

@end
