//
//  IconGenerator.m
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "IconGenerator.h"

@implementation IconGenerator

+ (NSImage *)resizeImage:(NSImage *)originalImage size:(NSSize)newSize
{
    NSImage *sourceImage = [originalImage copy];
    [sourceImage setScalesWhenResized:YES];
    
    if (![sourceImage isValid])
    {
        NSLog(@"Invalid Image");
        return nil;
    }
    
    NSImage *smallImage = [[NSImage alloc] initWithSize: newSize];
    [smallImage lockFocus];
    [sourceImage setSize: newSize];
    
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    
    [sourceImage drawAtPoint:NSZeroPoint
                    fromRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)
                   operation:NSCompositeCopy
                    fraction:(sourceImage.size.width / newSize.width)];
    
    [smallImage unlockFocus];
    
    return smallImage;
}

+ (NSDictionary *)iconSizesDictionary
{
    NSMutableDictionary *sizes = [NSMutableDictionary dictionary];
    
    // iOS 6 Sizes:
    sizes[@"Icon-57"] = [NSValue valueWithSize:NSMakeSize(57, 57)]; // iPhone @1x
    sizes[@"Icon-114"] = [NSValue valueWithSize:NSMakeSize(114, 114)]; // iPhone @2x
    sizes[@"Icon-72"] = [NSValue valueWithSize:NSMakeSize(72, 72)]; // iPad @1x
    sizes[@"Icon-144"] = [NSValue valueWithSize:NSMakeSize(144, 144)]; // iPad @2x
    
    // iOS 7 Sizes:
    sizes[@"Icon-120"] = [NSValue valueWithSize:NSMakeSize(120, 120)]; // iPhone @2x
    sizes[@"Icon-76"] = [NSValue valueWithSize:NSMakeSize(76, 76)]; // iPad @1x
    sizes[@"Icon-152"] = [NSValue valueWithSize:NSMakeSize(152, 152)]; // iPad @2x
    
    // iTunes Artwork
    sizes[@"iTunesArtwork"] = [NSValue valueWithSize:NSMakeSize(1024, 1024)]; // iTunesArtwork
    
    return sizes;
}

+ (NSDictionary *)iconSizesDictionaryWithDeviceTypes:(IconDeviceType)deviceTypes
                                           iconTypes:(IconType)iconTypes
                                          osVersions:(IconOSVersion)osVersions
{
    NSMutableDictionary *sizes = [NSMutableDictionary dictionary];
    
    if (deviceTypes & IconDeviceTypePhone) {
        if (iconTypes & IconTypeHomeScreen) {
            if (osVersions & IconOSVersion_6) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(57, 57)] forKey:@"Icon-57"]; // iPhone @2x
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(114, 114)] forKey:@"Icon-114"]; // iPhone @2x
            }
            
            if (osVersions & IconOSVersion_7) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(120, 120)] forKey:@"Icon-120"]; // iPhone @2x
            }
        }
        
        if (iconTypes & IconTypeSpotlight) {
            if (osVersions & IconOSVersion_6) {
            }
            
            if (osVersions & IconOSVersion_7) {
                [sizes setObject:[NSValue valueWithSize:NSMakeSize(80, 80)] forKey:@"Icon-80"]; // iPhone @2x
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

+ (void)saveImage:(NSImage *)image filePath:(NSString *)filePath type:(NSBitmapImageFileType)type
{
    if (type != NSPNGFileType) {
        return;
    }
    
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
    NSData *data = [imgRep representationUsingType:type properties:nil];
    
    NSString *file = [filePath stringByAppendingPathExtension:@"png"];

    [data writeToFile:file atomically:NO];
}

@end
