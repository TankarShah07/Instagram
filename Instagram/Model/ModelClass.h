//
//  ModelClass.h
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelClass : NSObject

@property(nonatomic) NSString *format;
@property(nonatomic) NSString *width;
@property(nonatomic) NSString *height;
@property(nonatomic) NSString *filename;
@property(nonatomic) NSString *id;
@property(nonatomic) NSString *author;
@property(nonatomic) NSString *author_url;
@property(nonatomic) NSString *post_url;

- (instancetype)initWithDictionaryData:(NSDictionary *)JSONData;

@end
