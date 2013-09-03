//
//  BedtimeIconGenerator.m
//  Bedtime
//
//  Created by Zach Howe on 9/3/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "BedtimeIconGenerator.h"

@implementation BedtimeIconGenerator

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth
{
    NSColor *backgroundColor = [NSColor colorWithCalibratedRed:.25 green:0.25 blue:.25 alpha:1.0];
    
    //// Color Declarations
    NSColor* red = [NSColor colorWithCalibratedRed: 1 green: 0.176 blue: 0.333 alpha: 1];
    NSColor* blue = [NSColor colorWithCalibratedRed: 0.353 green: 0.784 blue: 0.98 alpha: 1];
    NSColor* yellow = [NSColor colorWithCalibratedRed: 1 green: 0.8 blue: 0 alpha: 1];
    
    CGFloat radiusOffset = (size.width / 20);
    
    return [NSImage
            imageWithSize:size
            flipped:NO
            drawingHandler:^BOOL(NSRect dstRect) {
                
        [backgroundColor setFill];
        NSRectFill(dstRect);
        
        NSPoint center = NSMakePoint(NSMidX(dstRect), NSMidY(dstRect));
        
        //// Yellow Arc Drawing
        NSBezierPath* yellowArcPath = [NSBezierPath bezierPath];
        [yellowArcPath appendBezierPathWithArcWithCenter:center
                                                  radius:((NSWidth(dstRect) - lineWidth * 6) / 2) - radiusOffset
                                              startAngle:150
                                                endAngle:8
                                               clockwise:YES];
        [yellow setStroke];
        [yellowArcPath setLineWidth: lineWidth];
        [yellowArcPath stroke];
        
        //// Blue Arc Drawing
        NSBezierPath* blueArcPath = [NSBezierPath bezierPath];
        [blueArcPath appendBezierPathWithArcWithCenter:center
                                                radius:((NSWidth(dstRect) - lineWidth * 4) / 2) - radiusOffset
                                            startAngle:150
                                              endAngle:323
                                             clockwise:YES];
        [blue setStroke];
        [blueArcPath setLineWidth: lineWidth];
        [blueArcPath stroke];
        
        //// Red Arc Drawing
        NSBezierPath* redArcPath = [NSBezierPath bezierPath];
        [redArcPath appendBezierPathWithArcWithCenter:center
                                               radius:((NSWidth(dstRect) - lineWidth * 2) / 2) - radiusOffset
                                           startAngle:150
                                             endAngle:278
                                            clockwise:YES];
        [red setStroke];
        [redArcPath setLineWidth: lineWidth+2];
        [redArcPath stroke];
        
        return YES;
    }];
}

@end
