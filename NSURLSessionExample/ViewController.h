//
//  ViewController.h
//  NSURLSessionExample
//
//  Created by Kaushlendra . on 6/4/15.
//  Copyright (c) 2015 Kaushal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYURLSessionOperations.h"
@interface ViewController : UIViewController<NSCoding>

@property(nonatomic,strong)NSOperationQueue *queue;
@property(nonatomic,strong)NSURLSession *session;
@end

