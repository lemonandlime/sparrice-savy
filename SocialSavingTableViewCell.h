//
//  SocialSavingTableViewCell.h
//  hack1
//
//  Created by Karl Söderberg on 30/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialSavingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
@property (weak, nonatomic) IBOutlet UIView *overlay;

@end
