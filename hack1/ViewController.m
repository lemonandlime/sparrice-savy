//
//  ViewController.m
//  hack1
//
//  Created by Karl Söderberg on 28/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import "ViewController.h"

BOOL hasChanges;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OBDragDropManager *dragDropManager = [OBDragDropManager sharedManager];
    self.savingContent.dropZoneHandler = self;
    UIGestureRecognizer *recognizer = [dragDropManager createDragDropGestureRecognizerWithClass:[UIPanGestureRecognizer class] source:self];
    [self.addMoneyDragger addGestureRecognizer:recognizer];

}


-(void)viewDidLayoutSubviews{
    if (!self.pieChart) {
        if (self.pieChart) {
            [self.pieChart removeFromSuperview];
            self.pieChart = nil;
        }
        
        double percentProgress = [super percentFinished:self.socialSaving];
        int finished = (int)(percentProgress*100);
        int left = 100-finished;
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:finished color:[UIColor greenHappy] description:[NSString stringWithFormat:@"%d%@", finished, @"%"]],
                           [PNPieChartDataItem dataItemWithValue:left color:[UIColor lightGrayColor] description:[NSString stringWithFormat:@"%d%@", left, @"%"]],
                           ];
        
        
        //PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 40.0, 240.0, 240.0) items:items];
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(60, 0, self.savingContent.frame.size.width-120, self.savingContent.frame.size.width-120) items:items];
        
        //pieChart.center = self.savingContent.center;
        
        self.pieChart.descriptionTextColor = [UIColor whiteColor];
        self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"HelveticaNeue-Bold" size:31];
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
    
    UIImageView *dragView = [[UIImageView alloc] initWithFrame:frame];
    dragView.image = [UIImage imageNamed:@"addPercent"];
    dragView.backgroundColor = sourceView.backgroundColor;
    //dragView.layer.cornerRadius = 5.0;
    //dragView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    //dragView.layer.borderWidth = 1.0;
    dragView.layer.masksToBounds = YES;
    return dragView;
}


-(void) dragViewWillAppear:(UIView *)dragView inWindow:(UIWindow*)window atLocation:(CGPoint)location
{
    dragView.transform = CGAffineTransformIdentity;
    dragView.alpha = 0.0;
    
    [UIView animateWithDuration:0.25 animations:^{
        dragView.center = location;
        dragView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        dragView.alpha = 1;
    }];
}



#pragma mark - OBDropZone

static NSInteger kLabelTag = 2323;

-(OBDropAction) ovumEntered:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    NSLog(@"Ovum<0x%x> %@ Entered", (int)ovum, ovum.dataObject);
    
    CGFloat red = 0.33 + 0.66 * location.y / self.view.frame.size.height;
    view.layer.borderColor = [UIColor colorWithRed:red green:0.0 blue:0.0 alpha:1.0].CGColor;
    view.layer.borderWidth = 0.0;
    
    CGRect labelFrame = CGRectMake(ovum.dragView.bounds.origin.x, ovum.dragView.bounds.origin.y, ovum.dragView.bounds.size.width, ovum.dragView.bounds.size.height / 2);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    //label.text = @"Ovum entered";
    label.tag = kLabelTag;
    label.backgroundColor = [UIColor clearColor];
    label.opaque = NO;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [ovum.dragView addSubview:label];
    
    return OBDropActionDelete;
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
            view.layer.borderColor = [UIColor pinkPiggy].CGColor;
            view.layer.borderWidth = 0.0;
            
            
            return OBDropActionNone;
        }
    }
    
    view.layer.borderColor = [UIColor pinkPiggy].CGColor;
    view.layer.borderWidth = 0.0;
    
    //UILabel *label = (UILabel*) [ovum.dragView viewWithTag:kLabelTag];
    //label.text = [NSString stringWithFormat:@"Ovum at %@", NSStringFromCGPoint(location)];
    
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
    
    if (location.y<300) {
        [UIView animateWithDuration:.3 animations:^(void) {
            self.pieChart.transform = CGAffineTransformScale(view.transform, 1.2, 1.2);
        } completion:^(BOOL boolean){
            [UIView animateWithDuration:.3 animations:^(void) {
                self.pieChart.transform = CGAffineTransformScale(view.transform, 1.0, 1.0);
            } completion:^(BOOL finished){
                [self addOnePercent];
            }];}];
    }
//    NSLog(@"Ovum<0x%x> %@ Dropped", (int)ovum, ovum.dataObject);
//    
//    view.layer.borderColor = [UIColor clearColor].CGColor;
//    view.layer.borderWidth = 0.0;
//    
//    UILabel *label = (UILabel*) [ovum.dragView viewWithTag:kLabelTag];
//    [label removeFromSuperview];
//
    [ovum.dragView removeFromSuperview];
    if ([ovum.dataObject isKindOfClass:[NSNumber class]])
    {
        UIView *itemView = [self.view viewWithTag:[ovum.dataObject integerValue]];
        if (itemView)
        {
            //[itemView removeFromSuperview];
            //[leftViewContents removeObject:itemView];
            
            //NSInteger insertionIndex = [self insertionIndexForLocation:location withContents:rightViewContents];
            //[rightView insertSubview:itemView atIndex:insertionIndex];
            //[rightViewContents insertObject:itemView atIndex:insertionIndex];
            
        }
    }

}


-(void) handleDropAnimationForOvum:(OBOvum*)ovum withDragView:(UIView*)dragView dragDropManager:(OBDragDropManager*)dragDropManager
{

}

-(void)addOnePercent{
    NSNumber * goal = self.socialSaving[@"goal"];
    double addingSum = [goal doubleValue]/100;
    NSNumber * presentSaved = self.socialSaving[@"money_saved"];
    double newSavedSum = [presentSaved doubleValue]+addingSum;
    self.socialSaving[@"money_saved"] = [NSNumber numberWithDouble:newSavedSum];
    
    if (self.pieChart) {
        [self.pieChart removeFromSuperview];
        self.pieChart = nil;
    }
    
    double percentProgress = [super percentFinished:self.socialSaving];
    int finished = (int)(percentProgress*100);
    int left = 100-finished;
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:finished color:[UIColor greenHappy] description:[NSString stringWithFormat:@"%d%@", finished, @"%"]],
                       [PNPieChartDataItem dataItemWithValue:left color:[UIColor lightGrayColor] description:[NSString stringWithFormat:@"%d%@", left, @"%"]],
                       ];
    
    
    //PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 40.0, 240.0, 240.0) items:items];
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(60, 0, self.savingContent.frame.size.width-120, self.savingContent.frame.size.width-120) items:items];
    
    //pieChart.center = self.savingContent.center;
    
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"HelveticaNeue-Bold" size:31];
    [self.pieChart strokeChart];
    
    [self.savingContent addSubview:self.pieChart];
    [self.view sendSubviewToBack:self.savingContent];
}




@end
