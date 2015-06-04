//
//  KYURLSessionOperations.m
//  KYURLSessionOperations
//
//  Created by kaushal on 6/4/15.
//  Copyright (c) 2015 vStacks Infotech Pvt Ltd. All rights reserved.
//

#import "KYURLSessionOperations.h"


#define KYKVOBlock(KEYPATH, BLOCK) \
[self willChangeValueForKey:KEYPATH]; \
BLOCK(); \
[self didChangeValueForKey:KEYPATH];
@implementation KYURLSessionOperations
{
    bool finished;
    bool executing;
}
-(instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler{
    
    if(self=[super init]){
        __weak typeof(self)weakself=self;
        
        
        _task=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakself completeOperationWithBlock:completionHandler data:data response:response error:error];
        }];
        
    }
    return self;
    
}
-(instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler{
    if(self=[super init]){
        __weak typeof(self)weakself=self;
        _task=[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakself completeOperationWithBlock:completionHandler data:data response:response error:error];
            
        }];
        
    }
    return self;
    
}
// cancel task
-(void)cancel{
    [super cancel];
    [self.task cancel];
    
}
-(void)start{
    if (self.isCancelled) {
        KYKVOBlock(@"isFinished", ^{ finished=YES; });
        return;
    }
    KYKVOBlock(@"isExecuting", ^{
        [self.task resume];
        executing=YES;});
    
}
-(BOOL)isExecuting{
    return executing;
}
-(BOOL)isFinished{
    return finished;
}
-(BOOL)isConcurrent{
    return YES;
}
- (void)completeOperationWithBlock:(void (^)(NSData *, NSURLResponse *, NSError *))block data:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error {
    if (!self.isCancelled && block)
        block(data, response, error);
    [self completeOperation];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
