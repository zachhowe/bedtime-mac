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
@property (weak) IBOutlet NSTextField *strokeSpacingTextField;

@end

@implementation AppDelegate

static CGSize ORIGINAL_SIZE;

+ (void)initialize {
    ORIGINAL_SIZE = NSMakeSize(1024, 1024);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self loadSettings];
    [self updatePreview:nil];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [self saveSettings];
}

- (void)loadSettings {
    CGFloat lineWidth = [[NSUserDefaults standardUserDefaults] floatForKey:@"LineWidth"];
    CGFloat spacing = [[NSUserDefaults standardUserDefaults] floatForKey:@"Spacing"];
    
    self.strokeWidthTextField.stringValue = [NSString stringWithFormat:@"%li", (NSInteger)lineWidth];
    self.strokeSpacingTextField.stringValue = [NSString stringWithFormat:@"%li", (long)spacing];
}

- (void)saveSettings {
    CGFloat lineWidth = [self.strokeWidthTextField.stringValue floatValue];
    CGFloat spacing = [self.strokeSpacingTextField.stringValue floatValue];
    
    [[NSUserDefaults standardUserDefaults] setFloat:lineWidth forKey:@"LineWidth"];
    [[NSUserDefaults standardUserDefaults] setFloat:spacing forKey:@"Spacing"];
}

- (NSImage *)generateImage {
    CGFloat lineWidth = [self.strokeWidthTextField.stringValue floatValue];
    CGFloat spacing = [self.strokeSpacingTextField.stringValue floatValue];
    
    return [BedtimeIconGenerator generateWithSize:ORIGINAL_SIZE lineWidth:lineWidth spacingOffset:spacing];
}

- (IBAction)updatePreview:(id)sender {
    NSImage *img = [self generateImage];
    
    if ([img isKindOfClass:[NSImage class]]) {
        self.previewImageView.image = img;
    }
    
    [self saveSettings];
}

- (IBAction)saveImages:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:NO];
    [openPanel setTitle:@"Choose Directory to Save Icons"];
    [openPanel setPrompt:@"Save"];
    
    NSDictionary *sizes = [BedtimeIconGenerator iconSizesDictionaryWithDeviceTypes:(IconDeviceTypePhone)
                                                                         iconTypes:(IconTypeHomeScreen | IconTypeSpotlight | IconTypeArtwork)
                                                                        osVersions:(IconOSVersion_7)];
    
    NSImage *originalImage = [self generateImage];
    
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
