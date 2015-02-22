//
//  TEEMapViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 19.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEEMapViewController.h"
#import <MapKit/MapKit.h>

@interface TEEMapViewController () <MKMapViewDelegate>

@property (nonatomic) MKMapView *mapView;

@end

@implementation TEEMapViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _mapView = [MKMapView new];
    _mapView.translatesAutoresizingMaskIntoConstraints = NO;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mapView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_mapView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_mapView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_mapView)]];

    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated{
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}
@end
