//
//  ViewController.m
//  hack1
//
//  Created by Karl Söderberg on 28/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIImage * navaBarLogoImage = [[UIImage imageNamed:@"NavBarLogo"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    UIImageView * navBarLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBarLogo"]];
    navBarLogoImageView.frame = CGRectMake(0, 0, 60, 21);
    navBarLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationItem setTitleView: navBarLogoImageView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    
}

-(void)viewDidLayoutSubviews{
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:58 color:[UIColor greenHappy] description:@"58%"],
                       [PNPieChartDataItem dataItemWithValue:42 color:[UIColor lightGrayColor] description:@"42%"],
                       ];
    
    
    //PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 40.0, 240.0, 240.0) items:items];
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(60, 0, self.savingContent.frame.size.width-120, self.savingContent.frame.size.width-120) items:items];
    
    //pieChart.center = self.savingContent.center;
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont boldSystemFontOfSize:31.0];
    [pieChart strokeChart];

    [self.savingContent addSubview:pieChart];
    
    

}

@end
