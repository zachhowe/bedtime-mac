//
//  AppDelegate.m
//  Bedtime
//
//  Created by Zach Howe on 9/2/13.
//  Copyright (c) 2013 Zach Howe. All rights reserved.
//

#import "AppDelegate.h"

#import "IconGenerator.h"

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
    
    NSImage *img = [IconGenerator generateWithSize:ORIGINAL_SIZE lineWidth:lineWidth];
    
    if ([img isKindOfClass:[NSImage class]]) {
        self.previewImageView.image = img;
    }
}

- (IBAction)saveImages:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:@"Icon"];
    
    NSDictionary *sizes = [IconGenerator iconSizesDictionary];

    CGFloat lineWidth = [self.strokeWidthTextField.stringValue floatValue];
    
    [savePanel beginWithCompletionHandler:^(NSInteger result) {
        NSURL *directoryURL = [savePanel directoryURL];
        NSString *directoryPath = [directoryURL path];
        
        if (result == NSFileHandlingPanelOKButton) {
            [sizes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSString *filename = (NSString *)key;
                NSValue *sizeValue = (NSValue *)obj;
                
                NSSize size = [sizeValue sizeValue];
                
                CGFloat usedLineWidth = (NSInteger)(lineWidth * (size.width / ORIGINAL_SIZE.width));
                
                NSString *filePath = [directoryPath stringByAppendingPathComponent:filename];
                
                NSImage *img = [IconGenerator generateWithSize:size lineWidth:usedLineWidth];
                [IconGenerator saveImage:img filePath:filePath type:NSPNGFileType];
            }];
        }
    }];
}

@end
