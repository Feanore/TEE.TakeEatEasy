//
//  TEERestaurantDetailsViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 23.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEERestaurantDetailsViewController.h"
#import "TEEFoodTableViewCell.h"

@interface TEERestaurantDetailsViewController ()
@property (nonatomic) NSArray *list;
@end

@implementation TEERestaurantDetailsViewController

@synthesize list = _list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _list = @[@"1.jpg",
              @"2.jpg",
              @"3.jpg",
              @"4.jpg",
              @"5.jpg",
              @"6.jpg",
              @"7.jpg",
              @"8.jpg"
              ];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    PFFile *file = _restaurantInfo[@"image"];
    
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if(!error){
            UIImage *image = [UIImage imageWithData:data];
            [self setHeaderImage:image];
        }
    }];
    
    [self setTitleText:_restaurantInfo[@"title"]];
    [self setSubtitleText:@"European, Asian, Sushi & Rolls"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"CellIdentifier";
    TEEFoodTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[TEEFoodTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:identifier];
    }
    
    
    cell.image = [UIImage imageNamed:_list[indexPath.row % 8]];
    cell.price = 25.55;
    cell.textLabel.text = @"Club sandwich";
    cell.detailTextLabel.text = @"tomato, fried chicken, something eatable, sous";
    
    return cell;
}

@end
