//
//  StartViewController.m
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "StartViewController.h"

//static NSString * url = @"https://socialsaving.mybluemix.net/balance";
static NSString * url = @"https://dl.dropboxusercontent.com/u/7985407/savy-getBalance.json";

@interface StartViewController ()

@end

@implementation StartViewController


-(void) downloadFinished:(NSData*)data withTag:(int)tag{
    if (data) {
        NSError * error;
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"URL Response :  %@ error %@",jsonData, error);
        self.savingsinfo = jsonData[@"Result"];
        self.socialAccounts = self.savingsinfo[@"social_accounts"];
        [self.tableview reloadData];
        
        NSArray * users = self.socialAccounts[0][@"users"];
        
        for (NSDictionary * user in users) {
            if ([(NSString *)user[@"user_id"] isEqualToString:self.userId]) {
                self.transactionAmountLabel.text = [NSString stringWithFormat:@"%@ kr", user[@"transaction_account"]];
            }
        }
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.socialAccounts) {
        self.socialAccounts = @[];
    }
    
    if (!self.savingsinfo) {
        self.transactionAmountLabel.text = @"";
        DownloadManager  * DM = [[DownloadManager alloc] initWithDelegate:self];
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        [DM startDownloadWithRequest:request tag:1];
    }
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
            return self.socialAccounts.count;
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
    SocialSavingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savingCell"];
    cell.title.text = self.socialAccounts[indexPath.row][@"name"];

    double percentProgress = [super percentFinished:self.socialAccounts[indexPath.row]];
//    CGRect rect = cell.overlay.frame;
//    rect.size.width = 100;
//    //[UIView animateWithDuration:.3 animations:^{
//        cell.overlay.frame = rect;
//    //}];
    
    cell.subTitle.text = [NSString stringWithFormat:@"%.d%@",(int)(100*percentProgress),@"%Saved"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"socialAccount"]) {
        UITableViewCell * cell = sender;
        NSIndexPath * indexPath = [self.tableview indexPathForCell:cell];
        ViewController * nextView = segue.destinationViewController;
        nextView.socialSaving = [self.socialAccounts[indexPath.row] mutableCopy];
    }
}


@end
