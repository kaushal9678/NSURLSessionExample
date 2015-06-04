//
//  Questions.h
//  NSURLSessionExample
//
//  Created by Kaushlendra . on 6/4/15.
//  Copyright (c) 2015 Kaushal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questions : NSObject<NSCoding>

@property (nonatomic) int64_t identifier;
@property (nonatomic, copy) NSString *qm_id;
@property (nonatomic, copy) NSString *qm_name;
@property (nonatomic, copy) NSString *hq_weight;
@property (nonatomic, copy) NSString *other_options;
@property (nonatomic, copy) NSArray *hq_option;


@end
