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
    self.peopleInvited = @[];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
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
    title.font = [UIFont boldSystemFontOfSize:17];
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
            break;
        }
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"How much";
                    break;
                    
                default:
                    cell.textLabel.text = @"When";
                    break;
                    
            }
            break;
        }
            
        case 2:
        {
            if (indexPath.row>self.peopleInvited.count-1) {
                cell.textLabel.text = @"Phone number";
                cell.detailTextLabel.text = self.peopleInvited[indexPath.row];
            }else{
                cell.textLabel.text = @"Add more people";
            }
            break;
        }
            
        default:
        {
            
            break;
        }
    }
    
    return cell;
}



@end
