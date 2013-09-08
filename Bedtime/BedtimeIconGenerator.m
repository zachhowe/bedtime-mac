//
//  BedtimeIconGenerator.m
//  Bedtime
//
//  Created by Zach Howe on 9/3/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "BedtimeIconGenerator.h"

@implementation BedtimeIconGenerator

#define RED_COLOR                   [NSColor colorWithCalibratedRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1.0]
#define YELLOW_COLOR                [NSColor colorWithCalibratedRed:255.0/255.0 green:0.8 blue:0.0/255.0 alpha:1.0]
#define BLUE_COLOR                  [NSColor colorWithCalibratedRed:0.353 green:0.784 blue:0.98 alpha:1.0]

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth
{
    NSColor *backgroundColor = [NSColor colorWithCalibratedRed:.25 green:0.25 blue:.25 alpha:1.0];
    
    //// Color Declarations
    NSColor* red = RED_COLOR;
    NSColor* blue = BLUE_COLOR;
    NSColor* yellow = YELLOW_COLOR;
    
    CGFloat radiusOffset = (size.width / 100);
    
    return [NSImage
            imageWithSize:size
            flipped:NO
            drawingHandler:^BOOL(NSRect dstRect) {
                
        [backgroundColor setFill];
        NSRectFill(dstRect);
        
        NSPoint center = NSMakePoint(NSMidX(dstRect), NSMidY(dstRect));
                
        //// Blue Arc Drawing
        NSBezierPath* blueArcPath = [NSBezierPath bezierPath];
        [blueArcPath appendBezierPathWithArcWithCenter:center
                                                radius:((NSWidth(dstRect) - (lineWidth + 20) * 2) / 2) - radiusOffset
                                            startAngle:150
                                              endAngle:278
                                             clockwise:YES];
        [blue setStroke];
        [blueArcPath setLineWidth: lineWidth];
        [blueArcPath stroke];
                
        //// Yellow Arc Drawing
        NSBezierPath* yellowArcPath = [NSBezierPath bezierPath];
        [yellowArcPath appendBezierPathWithArcWithCenter:center
                                                  radius:((NSWidth(dstRect) - (lineWidth + 20) * 4) / 2) - radiusOffset
                                              startAngle:150
                                                endAngle:323
                                               clockwise:YES];
        [yellow setStroke];
        [yellowArcPath setLineWidth: lineWidth];
        [yellowArcPath stroke];
        
        //// Red Arc Drawing
        NSBezierPath* redArcPath = [NSBezierPath bezierPath];
        [redArcPath appendBezierPathWithArcWithCenter:center
                                               radius:((NSWidth(dstRect) - (lineWidth + 20) * 6) / 2) - radiusOffset
                                           startAngle:150
                                             endAngle:8
                                            clockwise:YES];
        [red setStroke];
        [redArcPath setLineWidth: lineWidth+2];
        [redArcPath stroke];
        
        return YES;
    }];
}

@end
