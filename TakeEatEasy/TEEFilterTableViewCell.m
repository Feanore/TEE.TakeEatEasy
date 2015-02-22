//
//  TEEFilterTableViewCell.m
//  TakeEatEasy
//
//  Created by Zhanserik Kenes on 22.01.15.
//  Copyright (c) 2015 Take Eat Easy. All rights reserved.
//

#import "TEEFilterTableViewCell.h"

@interface TEEFilterTableViewCell()



@end

@implementation TEEFilterTableViewCell

@synthesize checkBox = _checkBox;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _checkBox = [BFPaperCheckbox new];
        _checkBox.frame = CGRectMake(10, 10, 30, 30);
        [self.contentView addSubview:_checkBox];
        
        self.indentationLevel = 8;
    }
    return self;
}


- (void)awakeFromNib {
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
