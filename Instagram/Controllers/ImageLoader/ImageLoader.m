//
//  ImageLoader.m
//  Instagram
//
//  Created by Tankar Shah on 14/07/18.
//  Copyright © 2018 Tankar Shah. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

#pragma - Base path for directory

+(NSString *)documentsPathWithFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
}

#pragma - Download and store images for reuse

+(void)saveDownloadedImageForReuse:(NSData *)imgData withName:(NSString*)strName {
    NSString *filePath = [self documentsPathWithFileName:strName];
    [imgData writeToFile:filePath atomically:YES];
}

#pragma - Get Download and store images for reuse

+(UIImage *)getDownloadedImage:(NSString*)imgName {
    NSString *filePath = [self documentsPathWithFileName:imgName];
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
}

#pragma - Check for Images Downloaded

+(BOOL)checkForImageAlreadyDownloaded:(NSString*)imgName {
    NSString *filePath = [self documentsPathWithFileName:imgName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    return fileExists;
}

@end
