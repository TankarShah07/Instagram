//
//  ConnectionService.h
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionServiceDelegates
-(void)completeFetchData:(NSArray *)arrAuthorsData;

@end

@interface ConnectionService : NSObject

@property(weak,nonatomic) id delegate;

- (void)getAuthorsDataService;

@end
