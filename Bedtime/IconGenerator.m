//
//  IconGenerator.m
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "IconGenerator.h"

@implementation IconGenerator

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

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth
{
    NSColor *backgroundColor = [NSColor colorWithCalibratedRed:.25 green:0.25 blue:.25 alpha:1.0];
    
    //// Color Declarations
    NSColor* red = [NSColor colorWithCalibratedRed: 1 green: 0.176 blue: 0.333 alpha: 1];
    NSColor* blue = [NSColor colorWithCalibratedRed: 0.353 green: 0.784 blue: 0.98 alpha: 1];
    NSColor* yellow = [NSColor colorWithCalibratedRed: 1 green: 0.8 blue: 0 alpha: 1];
    
    CGFloat radiusOffset = (NSInteger)(size.width / 15);
    
    return [NSImage imageWithSize:size flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
        [backgroundColor setFill];
        NSRectFill(dstRect);
        
        NSPoint center = NSMakePoint(NSMidX(dstRect), NSMidY(dstRect));
        
        //// Yellow Arc Drawing
        NSBezierPath* yellowArcPath = [NSBezierPath bezierPath];
        [yellowArcPath appendBezierPathWithArcWithCenter:center
                                                  radius:(NSInteger)((NSWidth(dstRect) - lineWidth * 2) / 2) - radiusOffset
                                              startAngle:150
                                                endAngle:278
                                               clockwise:YES];
        [yellow setStroke];
        [yellowArcPath setLineWidth: lineWidth];
        [yellowArcPath stroke];
        
        //// Blue Arc Drawing
        NSBezierPath* blueArcPath = [NSBezierPath bezierPath];
        [blueArcPath appendBezierPathWithArcWithCenter:center
                                                radius:(NSInteger)((NSWidth(dstRect) - lineWidth * 4) / 2) - radiusOffset
                                            startAngle:150
                                              endAngle:323
                                             clockwise:YES];
        [blue setStroke];
        [blueArcPath setLineWidth: lineWidth];
        [blueArcPath stroke];
        
        //// Red Arc Drawing
        NSBezierPath* redArcPath = [NSBezierPath bezierPath];
        [redArcPath appendBezierPathWithArcWithCenter:center
                                               radius:(NSInteger)((NSWidth(dstRect) - lineWidth * 6) / 2) - radiusOffset
                                           startAngle:150
                                             endAngle:8
                                            clockwise:YES];
        [red setStroke];
        [redArcPath setLineWidth: lineWidth];
        [redArcPath stroke];
        
        return YES;
    }];
}

@end
