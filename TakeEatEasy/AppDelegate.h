//
//  AppDelegate.h
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 18.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TEEMapViewController.h"
#import "TEEFilterViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic) TEEFilterViewController *filterController;
@property (nonatomic) TEEMapViewController    *mapController;
@end

