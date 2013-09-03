//
//  IconGenerator.h
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, IconDeviceType) {
    IconDeviceTypePhone = 1 << 0,
    IconDeviceTypePad = 1 << 1
};

typedef NS_OPTIONS(NSInteger, IconType) {
    IconTypeHomeScreen = 1 << 0,
    IconTypeSearch = 1 << 1,
    IconTypeSpotlight = 1 << 2,
    IconTypeArtwork = 1 << 3
};

typedef NS_OPTIONS(NSInteger, IconOSVersion) {
    IconOSVersion_6 = 1 << 0,
    IconOSVersion_7 = 1 << 1
};

@interface IconGenerator : NSObject

+ (NSDictionary *)iconSizesDictionary DEPRECATED_ATTRIBUTE;

+ (NSDictionary *)iconSizesDictionaryWithDeviceTypes:(IconDeviceType)deviceTypes
                                           iconTypes:(IconType)iconTypes
                                          osVersions:(IconOSVersion)osVersions;

+ (NSImage *)resizeImage:(NSImage *)sourceImage size:(NSSize)newSize;

+ (void)saveImage:(NSImage *)image filePath:(NSString *)filePath type:(NSBitmapImageFileType)type;

@end
