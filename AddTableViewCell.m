//
//  AddTableViewCell.m
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "AddTableViewCell.h"
#import <Colours.h>

@implementation AddTableViewCell

- (void)awakeFromNib {
    self.whiteRoundView.backgroundColor = [UIColor pinkPiggy];
    self.whiteRoundView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.whiteRoundView.layer.cornerRadius = 24.;
    self.whiteRoundView.layer.borderWidth = 1.;
    self.whiteRoundView.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
