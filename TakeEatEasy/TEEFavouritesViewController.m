//
//  TEEFavouritesViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 02.02.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEEFavouritesViewController.h"
#import "UIViewController+ScrollingNavbar.h"
#import "UIColor+Tints.h"
#import "TEERestaurantDetailsViewController.h"
#import "TEERestaurantTableViewCell.h"

#import <Parse/Parse.h>

@interface TEEFavouritesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView        *tableView;
@property (nonatomic) UISearchBar        *searchBar;

@property (nonatomic) NSArray *restaurantsList;
@property (nonatomic) PFObject *selectedObject;

@end

@implementation TEEFavouritesViewController

@synthesize tableView = _tableView;
@synthesize searchBar = _searchBar;

@synthesize restaurantsList = _restaurantsList;

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setUseSuperview:YES];
    
    _tableView = [UITableView new];
    _tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _tableView.frame = self.view.frame;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    if (self.tabBarController) {
        [self.tabBarController.tabBar setHidden:YES];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, -44, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, -44, 0);
    }
    
    [self followScrollView:_tableView];
    [self setShouldScrollWhenContentFits:YES];
    
    //----------------------------------------
    
    _searchBar = [UISearchBar new];
    _searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
    _searchBar.tintColor = [UIColor fp_green];
    _searchBar.barTintColor =[UIColor fp_green];
    _tableView.tableHeaderView = _searchBar;
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self followScrollView:_tableView];
    [self downloadRestaurantsFromLocalstore:NO];
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_restaurantsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"CellIdentifier";
    TEERestaurantTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[TEERestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                 reuseIdentifier:identifier];
    }
    
    PFObject *object = _restaurantsList[indexPath.row];
    PFFile *file = object[@"image"];
    
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if(!error){
            UIImage *image = [UIImage imageWithData:data];
            cell.image = image;
        }
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = object[@"title"];
    cell.detailTextLabel.text = @"European, Oriental\nMin. Order FREE\nDelivery 600tg/90min";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedObject = _restaurantsList[indexPath.row];
    [self performSegueWithIdentifier:@"FavToRestDetails" sender:nil];
}

#pragma mark - UIScrollViewDelegate
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self showNavbar];
    return YES;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

#pragma mark - Actions

- (void) downloadRestaurantsFromLocalstore: (BOOL) fromLocalStore{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    
    if(fromLocalStore){
        [query fromLocalDatastore];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            [PFObject pinAll:objects];
            _restaurantsList = objects;
            [_tableView reloadData];
        }
        else{
            
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"FavToRestDetails"]){
        TEERestaurantDetailsViewController *controller = segue.destinationViewController;
        controller.restaurantInfo = self.selectedObject;
    }
}

@end
