//
//  AddAccountViewController.h
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddAccountViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray * peopleInvited;
@end
