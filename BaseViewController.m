//
//  BaseViewController.m
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * navBarLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBarLogo"]];
    navBarLogoImageView.frame = CGRectMake(0, 0, 60, 21);
    navBarLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationItem setTitleView: navBarLogoImageView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
