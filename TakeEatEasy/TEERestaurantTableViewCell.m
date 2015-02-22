//
//  TEERestaurantTableViewCell.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 19.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEERestaurantTableViewCell.h"

@interface TEERestaurantTableViewCell()

@property (nonatomic) UIImageView *restaurantImageView;

@end


@implementation TEERestaurantTableViewCell

@synthesize image = _image;
@synthesize restaurantImageView = _restaurantImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _restaurantImageView = [UIImageView new];
        _restaurantImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _restaurantImageView.contentMode = UIViewContentModeScaleAspectFill;
        _restaurantImageView.clipsToBounds = YES;
        _restaurantImageView.layer.masksToBounds = YES;
        _restaurantImageView.layer.cornerRadius = 40;
        
        _restaurantImageView.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:_restaurantImageView];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_restaurantImageView(==80)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_restaurantImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_restaurantImageView(==80)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_restaurantImageView)]];
        
        self.indentationLevel = 8;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.detailTextLabel.numberOfLines = 100;
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setImage:(UIImage *)image{
    _image = image;
    _restaurantImageView.image = _image;
}
- (UIImage *) image{
    return _image;
}

@end
