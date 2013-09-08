//
//  BedtimeIconGenerator.m
//  Bedtime
//
//  Created by Zach Howe on 9/3/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "BedtimeIconGenerator.h"

@implementation BedtimeIconGenerator

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth spacingOffset:(CGFloat)spacingOffset
{
    NSColor *backgroundColor = BACKGROUND_COLOR;
    NSColor *redColor = RED_COLOR;
    NSColor *blueColor = BLUE_COLOR;
    NSColor *yellowColor = YELLOW_COLOR;
    
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
                                                radius:((NSWidth(dstRect) - (lineWidth + spacingOffset) * 2) / 2) - radiusOffset
                                            startAngle:150
                                              endAngle:278
                                             clockwise:YES];
        [blueColor setStroke];
        [blueArcPath setLineWidth: lineWidth];
        [blueArcPath stroke];
                
        //// Yellow Arc Drawing
        NSBezierPath* yellowArcPath = [NSBezierPath bezierPath];
        [yellowArcPath appendBezierPathWithArcWithCenter:center
                                                  radius:((NSWidth(dstRect) - (lineWidth + spacingOffset) * 4) / 2) - radiusOffset
                                              startAngle:150
                                                endAngle:323
                                               clockwise:YES];
        [yellowColor setStroke];
        [yellowArcPath setLineWidth: lineWidth];
        [yellowArcPath stroke];
        
        //// Red Arc Drawing
        NSBezierPath* redArcPath = [NSBezierPath bezierPath];
        [redArcPath appendBezierPathWithArcWithCenter:center
                                               radius:((NSWidth(dstRect) - (lineWidth + spacingOffset) * 6) / 2) - radiusOffset
                                           startAngle:150
                                             endAngle:8
                                            clockwise:YES];
        [redColor setStroke];
        [redArcPath setLineWidth: lineWidth+2];
        [redArcPath stroke];
        
        return YES;
    }];
}

@end
