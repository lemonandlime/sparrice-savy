//
//  StartViewController.h
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SocialSavingTableViewCell.h"
#import "ViewController.h"

@interface StartViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property NSDictionary * savingsinfo;
@property NSArray * socialAccounts;
@end
