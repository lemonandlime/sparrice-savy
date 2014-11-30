//
//  DownloadManager.m
//  AsyncView
//
//  Created by Karl Söderberg on 2013-06-17.
//  Copyright (c) 2013 Karl Söderberg. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager
{
    NSDictionary * tempPushInformation;
}

-(id)initWithDelegate:(id<DownloadManagerDelegate>) aDelegate{
    self = [super init];
    self.returnDelegate = aDelegate;
    return self;
}


-(void)startDownloadWithRequest:(NSURLRequest *) request tag:(int)tag{
    
    self.DLTag = tag;
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


//////////////////NSURLConnectionDelegate/////////////////
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (self.data == nil) {
        self.data = [[NSMutableData alloc] init];
    }
    [self.data appendData:data];
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.returnDelegate downloadFinished:nil withTag:0];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (!_returnDelegate) {
        if (!_data) {
            NSLog(@"NO answer from push");
        }else{
            NSDictionary * answer = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
            NSLog(@"push result = %@", answer);
            if (answer[@"Success"]) {
                NSLog(@"Push sent to server");
                [[NSUserDefaults standardUserDefaults] setObject:tempPushInformation forKey:@"sentPushInfo"];
            }
        }
    }
    
    [self.returnDelegate downloadFinished:self.data withTag:(int)self.DLTag];
    self.data = nil;
}



@end
