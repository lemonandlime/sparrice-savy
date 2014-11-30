//
//  DownloadManager.h
//  AsyncView
//
//  Created by Karl Söderberg on 2013-06-17.
//  Copyright (c) 2013 Karl Söderberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadManagerDelegate <NSObject>

-(void) downloadFinished:(NSData*)data withTag:(int)tag;

@end

@interface DownloadManager : NSObject

@property  id <DownloadManagerDelegate> returnDelegate;

@property NSURLConnection * connection;
@property NSMutableData *data;
@property NSInteger DLTag;

-(id)initWithDelegate:(id<DownloadManagerDelegate>) aDelegate;

-(void)startDownloadWithRequest:(NSURLRequest *) request tag:(int)tag;

-(void)sendTokenForPush:(NSDictionary *) pushInformation;


@end
