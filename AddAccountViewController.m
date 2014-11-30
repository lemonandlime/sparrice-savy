//
//  AddAccountViewController.m
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "AddAccountViewController.h"

@interface AddAccountViewController ()

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.peopleInvited = [NSMutableArray arrayWithArray:@[@"070-4243114", @"073-9225152"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 2;
            break;
            
        case 2:
            return self.peopleInvited.count+1;
            break;
            
        case 3:
            return 0;
            break;
            
        default:
            return 1;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"";
            break;
        
        case 1:
            return @"Goals";
            break;
            
        case 2:
            return @"Add people";
            break;
            
        default:
            return @"";
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 20)];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    [view addSubview:title];
    switch (section) {
        case 0:
            title.text =  @"";
            break;
            
        case 1:
            title.text = @"Goals";
            break;
            
        case 2:
            title.text = @"Add people";
            break;
            
        default:
            title.text = @"";
            break;
    }
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = @"Startup money: Savy";
            break;
        }
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"How much";
                    cell.detailTextLabel.text = @"50 000 kr";
                    break;
                    
                default:
                    cell.textLabel.text = @"When";
                    cell.detailTextLabel.text = @"2015-02-01";
                    break;
                    
            }
            break;
        }
            
        case 2:
        {
            if (indexPath.row<self.peopleInvited.count) {
                cell.textLabel.text = @"Phone number";
                NSString * number = self.peopleInvited[indexPath.row];
                cell.detailTextLabel.text = number.length>0 ? number : @"Add phone number";
            }else{
                return [tableView dequeueReusableCellWithIdentifier:@"addCell"];

            }
            break;
        }
        case 4:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"sendCell"];

            break;
        }
            
        default:
        {
            
            break;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell * cell = sender;
    NSIndexPath * indexPath = [self.tableview indexPathForCell:cell];
    InputViewController * inputview = segue.destinationViewController;
    inputview.accountDate = self.accountDate;
    inputview.accountGoal = self.accountGoal;
    inputview.accountName = self.accountName;
    
    if (indexPath.section == 0) {
        inputview.sender = @"name";
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            inputview.sender = @"goal";
        }else{
            inputview.sender = @"time";
        }
    }else if (indexPath.section == 2){
        inputview.sender = @"number";
    }
    
}



@end
