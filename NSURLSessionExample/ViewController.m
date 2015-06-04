//
//  ViewController.m
//  NSURLSessionExample
//
//  Created by Kaushlendra . on 6/4/15.
//  Copyright (c) 2015 Kaushal. All rights reserved.
//

#import "ViewController.h"
#import "Questions.h"
static NSString const *kAppId = @"YOUR_APP_KEY";
static NSString const *kRestApiKey = @"YOUR_REST_API_KEY";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _queue=[[NSOperationQueue alloc]init];
    _queue.maxConcurrentOperationCount=1;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
   
    // in case custom header require
    // Parse requires HTTP headers for authentication. Set them before creating your NSURLSession
   
    /* [config setHTTPAdditionalHeaders:@{@"X-Parse-Application-Id":kAppId,
                                       @"X-Parse-REST-API-Key":kRestApiKey,
                                       @"Content-Type": @"application/json"}];*/
    
    
    _session=[NSURLSession sessionWithConfiguration:config];
    
  NSArray *urls=  @[[NSURL URLWithString:@"http://api.healthians.com/home/navigation" ],[NSURL URLWithString:@"http://api.healthians.com/hplus/gethqquestion"]];
  
    // create request of post type
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] initWithURL:urls[0]];
    request1.HTTPMethod = @"POST";
    
    
    [_queue addOperation:[[KYURLSessionOperations alloc]initWithSession:_session request:request1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"response of data navigation =%@",jsonArray);
        
        // handle response here for first API
        
        for (NSDictionary *dict in jsonArray) {
            
        }
        
    }]];
    
    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL:urls[1]];
    request2.HTTPMethod = @"POST";
    

    [_queue addOperation:[[KYURLSessionOperations alloc]initWithSession:_session request:request2 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"response of data navigation =%@",jsonArray);
       
        //handle response here for second API
        for (NSDictionary *dict in jsonArray) {
          
            NSMutableData *data=[[NSMutableData alloc]init];
            NSKeyedArchiver *archive=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
            [archive encodeObject:dict forKey:@"questions"];
            [archive finishEncoding];
            
        }
    }]];
    
 
    [_queue waitUntilAllOperationsAreFinished];
    
    NSLog(@"array URL=%@ ",urls);
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
