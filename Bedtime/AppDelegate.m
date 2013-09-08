//
//  AppDelegate.m
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "AppDelegate.h"

#import "BedtimeIconGenerator.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSImageView *previewImageView;
@property (weak) IBOutlet NSTextField *strokeWidthTextField;

@end

@implementation AppDelegate

static CGSize ORIGINAL_SIZE;

+ (void)initialize
{
    ORIGINAL_SIZE = NSMakeSize(1024, 1024);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self updatePreview:nil];
}

- (IBAction)updatePreview:(id)sender
{
    CGFloat lineWidth = [self.strokeWidthTextField.stringValue floatValue];
    
    NSImage *img = [BedtimeIconGenerator generateWithSize:ORIGINAL_SIZE lineWidth:lineWidth];
    
    if ([img isKindOfClass:[NSImage class]]) {
        self.previewImageView.image = img;
    }
}

- (IBAction)saveImages:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:NO];
    [openPanel setTitle:@"Choose Directory to Save Icons"];
    [openPanel setPrompt:@"Choose"];
    
    NSDictionary *sizes = [BedtimeIconGenerator iconSizesDictionaryWithDeviceTypes:IconDeviceTypePhone
                                                                         iconTypes:(IconTypeHomeScreen | IconTypeSpotlight | IconTypeArtwork)
                                                                        osVersions:IconOSVersion_7];

    CGFloat lineWidth = [self.strokeWidthTextField.stringValue floatValue];
    
    NSImage *originalImage = [BedtimeIconGenerator generateWithSize:ORIGINAL_SIZE lineWidth:lineWidth];
    
    [openPanel beginWithCompletionHandler:^(NSInteger result) {
        NSURL *directoryURL = [openPanel directoryURL];
        NSString *directoryPath = [directoryURL path];
        
        if (result == NSFileHandlingPanelOKButton) {
            [sizes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSString *filename = (NSString *)key;
                NSValue *sizeValue = (NSValue *)obj;
                
                NSString *filePath = [directoryPath stringByAppendingPathComponent:filename];
                NSSize size = [sizeValue sizeValue];
                
                NSImage *img = [BedtimeIconGenerator resizeImage:originalImage size:size];
                
                [BedtimeIconGenerator saveImage:img
                                       filePath:filePath
                                           type:NSPNGFileType];
            }];
        }
    }];
}

@end
