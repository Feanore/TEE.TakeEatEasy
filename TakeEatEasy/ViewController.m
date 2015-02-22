//
//  ViewController.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 18.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Tints.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:18.0f];
        [titleView setTextColor:[UIColor appColor]];
        self.navigationItem.titleView = titleView;
        
    }
    titleView.text = title;
    [titleView sizeToFit];
}
- (void) setWhiteBackButtonItem{
    UIImage *backButtonImage = [UIImage imageNamed:@"back_button_icon.png"];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, 20), NO, 0.0);
    [backButtonImage drawInRect:CGRectMake(0, 0, 10, 20)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithImage:newImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self.navigationController
                                                                  action:@selector(popViewControllerAnimated:)];
    customItem.tintColor = [UIColor whiteColor];
    customItem.customView.frame = CGRectMake(0, 0, 40, 40);
    [self.navigationItem setLeftBarButtonItem: customItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
