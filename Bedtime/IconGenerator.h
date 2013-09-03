//
//  IconGenerator.h
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconGenerator : NSObject

+ (NSDictionary *)iconSizesDictionary;

+ (void)saveImage:(NSImage *)image filePath:(NSString *)filePath type:(NSBitmapImageFileType)type;

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth;

@end
