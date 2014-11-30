//
//  AddAccountViewController.h
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "InputViewController.h"

@interface AddAccountViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray * peopleInvited;
@property NSString * accountName;
@property NSDate * accountDate;
@property NSNumber * accountGoal;
@property UIImage * accountImage;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
