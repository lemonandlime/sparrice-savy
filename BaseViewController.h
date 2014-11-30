//
//  BaseViewController.h
//  hack1
//
//  Created by Karl Söderberg on 29/11/14.
//  Copyright (c) 2014 Sparrice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadManager.h"

@interface BaseViewController : UIViewController <DownloadManagerDelegate>
-(void) downloadFinished:(NSData*)data withTag:(int)tag;
-(double)percentFinished:(NSDictionary *)socialSaving;
@end
