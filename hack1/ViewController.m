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
    UIImageView * navBarLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBarLogo"]];
    navBarLogoImageView.frame = CGRectMake(0, 0, 60, 21);
    navBarLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationItem setTitleView: navBarLogoImageView];
    
    OBDragDropManager *dragDropManager = [OBDragDropManager sharedManager];
    UIGestureRecognizer *recognizer = [dragDropManager createDragDropGestureRecognizerWithClass:[UIPanGestureRecognizer class] source:self];
    [self.addMoneyDragger addGestureRecognizer:recognizer];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    
}

-(void)viewDidLayoutSubviews{
    if (!self.pieChart) {
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:58 color:[UIColor greenHappy] description:@"58%"],
                           [PNPieChartDataItem dataItemWithValue:42 color:[UIColor lightGrayColor] description:@"42%"],
                           ];
        
        
        //PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 40.0, 240.0, 240.0) items:items];
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(60, 0, self.savingContent.frame.size.width-120, self.savingContent.frame.size.width-120) items:items];
        
        //pieChart.center = self.savingContent.center;
        self.pieChart.descriptionTextColor = [UIColor whiteColor];
        self.pieChart.descriptionTextFont  = [UIFont boldSystemFontOfSize:31.0];
        [self.pieChart strokeChart];
        
        [self.savingContent addSubview:self.pieChart];
        [self.view sendSubviewToBack:self.savingContent];
    }
}

#pragma mark - OBOvumSource

-(OBOvum *) createOvumFromView:(UIView*)sourceView
{
    OBOvum *ovum = [[OBOvum alloc] init];
    ovum.dataObject = [NSNumber numberWithInteger:sourceView.tag];
    return ovum;
}


-(UIView *) createDragRepresentationOfSourceView:(UIView *)sourceView inWindow:(UIWindow*)window
{
    CGRect frame = [sourceView convertRect:sourceView.bounds toView:sourceView.window];
    frame = [window convertRect:frame fromWindow:sourceView.window];
    
    UIView *dragView = [[UIView alloc] initWithFrame:frame];
    dragView.backgroundColor = sourceView.backgroundColor;
    dragView.layer.cornerRadius = 5.0;
    dragView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    dragView.layer.borderWidth = 1.0;
    dragView.layer.masksToBounds = YES;
    return dragView;
}


-(void) dragViewWillAppear:(UIView *)dragView inWindow:(UIWindow*)window atLocation:(CGPoint)location
{
    dragView.transform = CGAffineTransformIdentity;
    dragView.alpha = 0.0;
    
    [UIView animateWithDuration:0.25 animations:^{
        dragView.center = location;
        dragView.transform = CGAffineTransformMakeScale(0.80, 0.80);
        dragView.alpha = 0.75;
    }];
}



#pragma mark - OBDropZone

static NSInteger kLabelTag = 2323;

-(OBDropAction) ovumEntered:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    NSLog(@"Ovum<0x%x> %@ Entered", (int)ovum, ovum.dataObject);
    
    CGFloat red = 0.33 + 0.66 * location.y / self.view.frame.size.height;
    view.layer.borderColor = [UIColor colorWithRed:red green:0.0 blue:0.0 alpha:1.0].CGColor;
    view.layer.borderWidth = 5.0;
    
    CGRect labelFrame = CGRectMake(ovum.dragView.bounds.origin.x, ovum.dragView.bounds.origin.y, ovum.dragView.bounds.size.width, ovum.dragView.bounds.size.height / 2);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = @"Ovum entered";
    label.tag = kLabelTag;
    label.backgroundColor = [UIColor clearColor];
    label.opaque = NO;
    label.font = [UIFont boldSystemFontOfSize:24.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [ovum.dragView addSubview:label];
    
    return OBDropActionMove;
}

-(OBDropAction) ovumMoved:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    //  NSLog(@"Ovum<0x%x> %@ Moved", (int)ovum, ovum.dataObject);
    
    CGFloat hiphopopotamus = 0.33 + 0.66 * location.y / self.view.frame.size.height;
    
    // This tester currently only supports dragging from left to right view
    if ([ovum.dataObject isKindOfClass:[NSNumber class]])
    {
        UIView *itemView = [self.view viewWithTag:[ovum.dataObject integerValue]];
        if (false)
        {
            view.layer.borderColor = [UIColor colorWithRed:hiphopopotamus green:0.0 blue:0.0 alpha:1.0].CGColor;
            view.layer.borderWidth = 5.0;
            
            UILabel *label = (UILabel*) [ovum.dragView viewWithTag:kLabelTag];
            label.text = @"Cannot Drop Here";
            
            return OBDropActionNone;
        }
    }
    
    view.layer.borderColor = [UIColor colorWithRed:0.0 green:hiphopopotamus blue:0.0 alpha:1.0].CGColor;
    view.layer.borderWidth = 5.0;
    
    UILabel *label = (UILabel*) [ovum.dragView viewWithTag:kLabelTag];
    label.text = [NSString stringWithFormat:@"Ovum at %@", NSStringFromCGPoint(location)];
    
    return OBDropActionMove;
}

-(void) ovumExited:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    NSLog(@"Ovum<0x%x> %@ Exited", (int)ovum, ovum.dataObject);
    
    view.layer.borderColor = [UIColor clearColor].CGColor;
    view.layer.borderWidth = 0.0;
    
    UILabel *label = (UILabel*) [ovum.dragView viewWithTag:kLabelTag];
    [label removeFromSuperview];
}

-(void) ovumDropped:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
//    NSLog(@"Ovum<0x%x> %@ Dropped", (int)ovum, ovum.dataObject);
//    
//    view.layer.borderColor = [UIColor clearColor].CGColor;
//    view.layer.borderWidth = 0.0;
//    
//    UILabel *label = (UILabel*) [ovum.dragView viewWithTag:kLabelTag];
//    [label removeFromSuperview];
//    
//    if ([ovum.dataObject isKindOfClass:[NSNumber class]])
//    {
//        UIView *itemView = [self.view viewWithTag:[ovum.dataObject integerValue]];
//        if (itemView)
//        {
//            [itemView removeFromSuperview];
//            [leftViewContents removeObject:itemView];
//            
//            NSInteger insertionIndex = [self insertionIndexForLocation:location withContents:rightViewContents];
//            [rightView insertSubview:itemView atIndex:insertionIndex];
//            [rightViewContents insertObject:itemView atIndex:insertionIndex];
//            
//        }
//    }
//    else if ([ovum.dataObject isKindOfClass:[UIColor class]])
//    {
//        // An item from AdditionalSourcesViewController
//        UIView *itemView = [self createItemView];
//        itemView.backgroundColor = ovum.dataObject;
//        NSInteger insertionIndex = rightViewContents.count;
//        [rightView insertSubview:itemView atIndex:insertionIndex];
//        [rightViewContents insertObject:itemView atIndex:insertionIndex];
//    }
}


-(void) handleDropAnimationForOvum:(OBOvum*)ovum withDragView:(UIView*)dragView dragDropManager:(OBDragDropManager*)dragDropManager
{
//    UIView *itemView = nil;
//    if ([ovum.dataObject isKindOfClass:[NSNumber class]])
//        itemView = [self.view viewWithTag:[ovum.dataObject integerValue]];
//    else if ([ovum.dataObject isKindOfClass:[UIColor class]])
//        itemView = [rightViewContents lastObject];
//    
//    if (itemView)
//    {
//        // Set the initial position of the view to match that of the drag view
//        CGRect dragViewFrameInTargetWindow = [ovum.dragView.window convertRect:dragView.frame toWindow:rightView.window];
//        dragViewFrameInTargetWindow = [rightView convertRect:dragViewFrameInTargetWindow fromView:rightView.window];
//        itemView.frame = dragViewFrameInTargetWindow;
//        
//        CGRect viewFrame = [ovum.dragView.window convertRect:itemView.frame fromView:itemView.superview];
//        
//        void (^animation)() = ^{
//            dragView.frame = viewFrame;
//            
//            [self layoutScrollView:leftView withContents:leftViewContents];
//            [self layoutScrollView:rightView withContents:rightViewContents];
//        };
//        
//        [dragDropManager animateOvumDrop:ovum withAnimation:animation completion:nil];
//    }
}




@end
