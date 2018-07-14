//
//  ModelClass.m
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import "ModelClass.h"

@implementation ModelClass

- (instancetype)initWithDictionaryData:(NSDictionary *)JSONData
{
    self = [super init];
    if (self) {
        for (NSString* key in JSONData) {
            [self setValue:[JSONData valueForKey:key] forKey:key];
        }
    }
    return self;
}

@end
