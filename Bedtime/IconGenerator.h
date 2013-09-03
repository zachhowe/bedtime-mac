//
//  IconGenerator.h
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, IconDeviceType) {
    IconTypePhone,
    IconTypePad
};

typedef NS_OPTIONS(NSInteger, IconType) {
    IconTypeHomeScreen,
    IconTypeSearch,
    IconTypeSpotlight
};

typedef NS_OPTIONS(NSInteger, IconOSVersion) {
    IconOSVersion_6_1,
    IconOSVersion_7_0
};

@interface IconGenerator : NSObject

+ (NSDictionary *)iconSizesDictionary;

+ (void)saveImage:(NSImage *)image filePath:(NSString *)filePath type:(NSBitmapImageFileType)type;

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth;

@end
