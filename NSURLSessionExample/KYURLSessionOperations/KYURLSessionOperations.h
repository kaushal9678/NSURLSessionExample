//
//  KYURLSessionOperations.h
//  KYURLSessionOperations
//
//  Created by kaushal on 6/4/15.
//  Copyright (c) 2015 vStacks Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KYURLSessionOperations : NSOperation

// use it to fetch data
-(instancetype)initWithSession:(NSURLSession*)session URL:(NSURL*)url completionHandler:(void(^)(NSData* data, NSURLResponse *response, NSError *error))completionHandler;

// use this method to post data to API
-(instancetype)initWithSession:(NSURLSession*)session request:(NSURLRequest*)request completionHandler:(void(^)(NSData *data,NSURLResponse *response,NSError *error))completionHandler;

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

@end
