//
//  TEERestaurantsViewController.h
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 19.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, TEEFilterSearchType) {
    TEEFilterSearchTypeByRestaurant,
    TEEFilterSearchTypeByCourse
};


typedef NS_ENUM(NSInteger, TEEFilterSortType) {
    TEEFilterSortTypeByPrice,
    TEEFilterSortTypeByDistance
};


@interface TEERestaurantsViewController : ViewController

@property (nonatomic) TEEFilterSearchType searchType;
@property (nonatomic) TEEFilterSortType   sortType;

@end
