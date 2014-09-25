//
//  IconGenerator.m
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "IconGenerator.h"

@implementation IconGenerator

+ (NSImage *)resizeImage:(NSImage *)originalImage size:(NSSize)newSize {
    NSImage *sourceImage = [originalImage copy];
    [sourceImage setScalesWhenResized:YES];
    
    if (![sourceImage isValid]) {
        NSLog(@"Invalid Image");
        return nil;
    }
    
    newSize = CGSizeMake(newSize.width / [NSScreen mainScreen].backingScaleFactor,
                         newSize.height / [NSScreen mainScreen].backingScaleFactor);
    
    NSImage *smallImage = [[NSImage alloc] initWithSize:newSize];
    [smallImage lockFocus];
    [sourceImage setSize:newSize];
    
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    
    [sourceImage drawAtPoint:NSZeroPoint
                    fromRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)
                   operation:NSCompositeCopy
                    fraction:1.0];
    
    [smallImage unlockFocus];
    return smallImage;
}

+ (NSDictionary *)iconSizesDictionaryWithDeviceTypes:(IconDeviceType)deviceTypes
                                           iconTypes:(IconType)iconTypes
                                          osVersions:(IconOSVersion)osVersions {
    NSMutableDictionary *sizes = [NSMutableDictionary dictionary];
    
    if (deviceTypes & IconDeviceTypePhone) {
        if (iconTypes & IconTypeHomeScreen) {
            if (osVersions & IconOSVersion_6) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(57, 57)] forKey:@"Icon-57"]; // iPhone @2x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(114, 114)] forKey:@"Icon-114"]; // iPhone @2x
            }
            
            if (osVersions & IconOSVersion_7) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(120, 120)] forKey:@"Icon-120"]; // iPhone @2x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(180, 180)] forKey:@"Icon-180"]; // iPhone @3x
            }
        }
        
        if (iconTypes & IconTypeSettings) {
            if (osVersions & IconOSVersion_6) {
            }
            
            if (osVersions & IconOSVersion_7) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(58, 58)] forKey:@"Icon-58"]; // iPhone @2x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(87, 87)] forKey:@"Icon-87"]; // iPhone @3x
            }
        }
        
        if (iconTypes & IconTypeSpotlight) {
            if (osVersions & IconOSVersion_6) {
            }
            
            if (osVersions & IconOSVersion_7) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(80, 80)] forKey:@"Icon-80"]; // iPhone @2x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(120, 120)] forKey:@"Icon-120"]; // iPhone @3x
            }
        }
    }
    
    if (deviceTypes & IconDeviceTypePad) {
        if (iconTypes & IconTypeHomeScreen) {
            if (osVersions & IconOSVersion_6) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(72, 72)] forKey:@"Icon-72"]; // iPad @1x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(144, 144)] forKey:@"Icon-144"]; // iPad @2x
            }
            
            if (osVersions & IconOSVersion_7) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(76, 76)] forKey:@"Icon-76"]; // iPad @1x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(152, 152)] forKey:@"Icon-152"]; // iPad @2x
            }
        }
        
        if (iconTypes & IconTypeSettings) {
            if (osVersions & IconOSVersion_6) {
            }
            
            if (osVersions & IconOSVersion_7) {
            }
        }
        
        if (iconTypes & IconTypeSpotlight) {
            if (osVersions & IconOSVersion_6) {
            }
            
            if (osVersions & IconOSVersion_7) {
            }
        }
    }
    
    
    if (iconTypes & IconTypeArtwork) {
        [sizes setObject:[NSValue valueWithSize:NSMakeSize(1024, 1024)] forKey:@"iTunesArtwork"];
    }
    
    return sizes;
}

+ (void)saveImage:(NSImage *)image filePath:(NSString *)filePath type:(NSBitmapImageFileType)type {
    if (type != NSPNGFileType) {
        return;
    }
    
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
    NSData *data = [imgRep representationUsingType:type properties:nil];
    
    NSString *file = [filePath stringByAppendingPathExtension:@"png"];

    [data writeToFile:file atomically:NO];
}

@end
