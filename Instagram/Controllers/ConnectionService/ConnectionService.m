//
//  ConnectionService.m
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import "ConnectionService.h"
#import "ModelClass.h"
#import "Constants.h"

@implementation ConnectionService

#pragma - Fetched Data Parsing Methods

- (void) parseAllTheDataToJSON:(NSData *) jsonData {
    NSError *err = nil;
    id objData = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&err];
    if(err) return;
    
    if ([objData isKindOfClass:[NSArray class]]) {
        NSMutableArray *arrData = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in objData) {
            ModelClass *cPasrsedData = [[ModelClass alloc] initWithDictionaryData:dict];
            [arrData addObject:cPasrsedData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(completeFetchData:)]) {
                [self.delegate completeFetchData:arrData];
            }
        });
    } else{
        
    }
}

#pragma - Service calling Methods

- (void)getAuthorsDataService{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:WEBSERVICE_URL]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (data != nil) {
                                          [self parseAllTheDataToJSON:data];
                                      }
                                  }];
    [task resume];
    
}

@end
