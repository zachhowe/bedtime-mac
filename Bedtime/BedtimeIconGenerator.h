//
//  BedtimeIconGenerator.h
//  Bedtime
//
//  Created by Zach Howe on 9/3/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "IconGenerator.h"

@interface BedtimeIconGenerator : IconGenerator

+ (NSImage *)generateWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth;

@end
