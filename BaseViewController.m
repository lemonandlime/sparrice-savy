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

-(void) downloadFinished:(NSData*)data withTag:(int)tag{
    
}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    if (!self.userId || self.userId.length<1) {
        self.userId = @"60014";
    }
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

-(double)percentFinished:(NSDictionary *)socialSaving{
    NSNumber * moneySaved = socialSaving[@"money_saved"];
    NSNumber * goal = socialSaving[@"goal"];
    
    double percentProgress = [moneySaved doubleValue]/[goal doubleValue];
    return percentProgress;
}


@end
