//
//  ImageLoader.h
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageLoader : NSObject

+(NSString *)documentsPathWithFileName:(NSString *)name;
+(void)saveDownloadedImageForReuse:(NSData *)imgData withName:(NSString*)strName;
+(UIImage *)getDownloadedImage:(NSString*)imgName;
+(BOOL)checkForImageAlreadyDownloaded:(NSString*)imgName;

@end
