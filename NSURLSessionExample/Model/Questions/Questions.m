//
//  Questions.m
//  NSURLSessionExample
//
//  Created by Kaushlendra . on 6/4/15.
//  Copyright (c) 2015 Kaushal. All rights reserved.
//

#import "Questions.h"
static NSString * const IdentifierKey = @"identifier";
static NSString * const QuestionIDKey =@"qm_id";
static NSString * const QuestionNameKey  = @"qm_name";
static NSString * const QuestionWeightKey = @"hq_weight";
static NSString * const OtherOptionsKey = @"other_options";
static NSString * const QuestionOptionsKey = @"hq_option";

@implementation Questions
- (NSString *)description
{
    NSString *formatString = @"<%@: %p> (%lld) \"%@\"";
    return [NSString stringWithFormat:formatString, [self class], self,
            (long long) self.identifier, self.qm_name];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInt64:self.identifier forKey:IdentifierKey];
    [coder encodeObject:self.qm_id forKey:QuestionIDKey];
    [coder encodeObject:self.qm_name forKey:QuestionNameKey];
    [coder encodeObject:self.hq_option forKey:QuestionOptionsKey];
    [coder encodeObject:self.hq_weight forKey:QuestionWeightKey];
    [coder encodeObject:self.other_options forKey:OtherOptionsKey];

}

- (BOOL)requiresSecureCoding
{
    return YES;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.identifier = [coder decodeInt64ForKey:IdentifierKey];
        self.qm_id = [coder decodeObjectOfClass:[NSString class] forKey:QuestionIDKey];
        self.qm_name = [coder decodeObjectOfClass:[NSString class] forKey:QuestionNameKey];
        self.hq_option = [coder decodeObjectOfClass:[NSArray class] forKey:QuestionOptionsKey];
        self.hq_weight = [coder decodeObjectOfClass:[NSString class] forKey:QuestionWeightKey];
        self.hq_option = [coder decodeObjectOfClass:[NSString class] forKey:OtherOptionsKey];
    }
    return self;
}

@end
