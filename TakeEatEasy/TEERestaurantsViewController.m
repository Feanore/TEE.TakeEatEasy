//
//  TEERestaurantsViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 19.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEERestaurantsViewController.h"
#import "UIViewController+ScrollingNavbar.h"
#import "UIColor+Tints.h"
#import <MapKit/MapKit.h>
#import "SlideNavigationController.h"
#import "TEEMapViewController.h"
#import "TEEFilterViewController.h"
#import "TEERestaurantTableViewCell.h"
#import "TEERestaurantDetailsViewController.h"
#import "TEERootNavigaionViewController.h"

@interface TEERestaurantsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) UITableView        *tableView;
@property (nonatomic) UISearchBar        *searchBar;
@property (nonatomic) UIBarButtonItem    *filterBarButton;
@property (nonatomic) UIBarButtonItem    *mapBarButton;
@property (nonatomic) UIBarButtonItem    *favouritesBarButton;



@property (nonatomic) NSArray *restaurantsList;
@property (nonatomic) PFObject *selectedObject;
@property (nonatomic) NSArray  *filteredResulList;

@end

@implementation TEERestaurantsViewController

@synthesize tableView = _tableView;
@synthesize searchBar = _searchBar;
@synthesize filterBarButton = _filterBarButton;
@synthesize mapBarButton = _mapBarButton;
@synthesize favouritesBarButton = _favouritesBarButton;

@synthesize restaurantsList = _restaurantsList;

@synthesize sortType = _sortType;
@synthesize searchType = _searchType;

@synthesize filteredResulList = _filteredResulList;
#pragma mark - UIViewController Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUseSuperview:YES];
    
    _tableView = [UITableView new];
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
    _searchBar.delegate = self;
    _tableView.tableHeaderView = _searchBar;
    
    
    //----------------------------------------
    
    TEERootNavigaionViewController *rootNavigation = (TEERootNavigaionViewController *)self.navigationController;
    
    _mapBarButton = [UIBarButtonItem new];
    [_mapBarButton setTitle:@"Map"];
    _mapBarButton.tintColor = [UIColor whiteColor];
    _mapBarButton.target = rootNavigation;
    _mapBarButton.action = @selector(presentMapController:);
    
    
    _filterBarButton = [UIBarButtonItem new];
    [_filterBarButton setTitle:@"Filter"];
    _filterBarButton.tintColor = [UIColor whiteColor];
    _filterBarButton.target = rootNavigation;
    _filterBarButton.action = @selector(presentFilterController:);
    
    self.navigationItem.leftBarButtonItems = @[_filterBarButton, _mapBarButton];
    
    
    _favouritesBarButton = [UIBarButtonItem new];
    [_favouritesBarButton setTitle:@"Favourites"];
    _favouritesBarButton.tintColor = [UIColor whiteColor];
    _favouritesBarButton.target = self;
    _favouritesBarButton.action = @selector(favouritesBarButtonDidPress:);
    
    self.navigationItem.rightBarButtonItem = _favouritesBarButton;
    //----------------------------------------
    
    _searchType = TEEFilterSearchTypeByRestaurant;
    _sortType = TEEFilterSortTypeByPrice;
    
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
    
    if([_searchBar.text length] > 0){
        return [_filteredResulList count];
    }
    
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
    
    PFObject *object = nil;
    
    if([_searchBar.text length] > 0){
        object = _filteredResulList[indexPath.row];
    }
    else{
        object = _restaurantsList[indexPath.row];
    }
    
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
    [self performSegueWithIdentifier:@"RestToRestDetails" sender:nil];
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

#pragma mark - UISearBar Delegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self refreshFilteredResult];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
}


#pragma mark - Actions

- (void) favouritesBarButtonDidPress: (id) sender{
    TEEMapViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TEEFavouritesViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void) downloadRestaurantsFromLocalstore: (BOOL) fromLocalStore{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    
    if(fromLocalStore){
        //[query fromLocalDatastore];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        NSLog(@"%s [%i]", __FUNCTION__, (int)objects.count);
        if(!error){
            //[PFObject pinAll:objects];
            _restaurantsList = objects;
            [_tableView reloadData];
        }
        else{
            
        }
    }];
}
- (void) refreshFilteredResult{
    
    if([_searchBar.text length] == 0){
        [_tableView reloadData];
        return;
    }
    
    if(_searchType == TEEFilterSearchTypeByRestaurant){
        PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
        
        if(_sortType == TEEFilterSortTypeByPrice){
            //TO DO
        }
        else if (_sortType == TEEFilterSortTypeByDistance){
            //TO DO
        }
        
        [query whereKey:@"title" containsString:_searchBar.text];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if(!error){
                _filteredResulList = objects;
                [_tableView reloadData];
            }
        }];
        
    }
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"RestToRestDetails"]){
        TEERestaurantDetailsViewController *controller = segue.destinationViewController;
        controller.restaurantInfo = self.selectedObject;
    }
}

@end
