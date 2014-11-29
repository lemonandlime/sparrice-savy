//
//  ViewController.h
//  hack1
//
//  Created by Karl Söderberg on 28/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import <Colours/Colours.h>
#import "OBDragDrop.h"
#import "BaseViewController.h"

@interface ViewController : BaseViewController <OBOvumSource, OBDropZone, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *savingContent;
@property (weak, nonatomic) IBOutlet UIView *addMoneyDragger;
@property PNPieChart *pieChart;

@end

