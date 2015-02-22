//
//  TEEFoodTableViewCell.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 23.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEEFoodTableViewCell.h"



@interface TEEFoodTableViewCell()

@property (nonatomic) UIImageView *restaurantImageView;
@property (nonatomic) UILabel *priceLabel;

@end


@implementation TEEFoodTableViewCell

@synthesize image = _image;
@synthesize restaurantImageView = _restaurantImageView;
@synthesize price = _price;
@synthesize priceLabel = _priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _restaurantImageView = [UIImageView new];
        _restaurantImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _restaurantImageView.contentMode = UIViewContentModeScaleAspectFill;
        _restaurantImageView.clipsToBounds = YES;
        _restaurantImageView.layer.masksToBounds = YES;
        _restaurantImageView.layer.cornerRadius = 25;
        
        _restaurantImageView.backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:_restaurantImageView];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_restaurantImageView(==50)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_restaurantImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_restaurantImageView(==50)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_restaurantImageView)]];
        
        self.indentationLevel = 6;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.detailTextLabel.numberOfLines = 100;
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        _priceLabel = [UILabel new];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = [UIColor lightGrayColor];
        _priceLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        [self.contentView addSubview:_priceLabel];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_priceLabel]-0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_priceLabel)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel(==60)]-10-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_priceLabel)]];
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

- (void) setPrice:(CGFloat)price{
    _price = price;
    _priceLabel.text = [NSString stringWithFormat:@"$%2.f",_price];
}
- (CGFloat) price{
    return _price;
}
@end
