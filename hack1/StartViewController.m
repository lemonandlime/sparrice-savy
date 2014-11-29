//
//  StartViewController.m
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}// Default is 1 if not implemented


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
            
        default:
            return 1;
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 80.;
            break;
            
        default:
            return 120.;
            break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return [tableView dequeueReusableCellWithIdentifier:@"addCell"];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savingCell"];
    return cell;
}

@end
