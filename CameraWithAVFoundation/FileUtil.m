//
//  FileUtil.m
//  AfNetowrkExample
//
//  Created by YoungJeXu on 2/21/17.
//  Copyright © 2017 HT. All rights reserved.
//

#import "FileUtil.h"
#import "NSString+RandomString.h"


@implementation FileUtil

+(BOOL) fileExistsInProject:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileInResourcesFolder = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    return [fileManager fileExistsAtPath:fileInResourcesFolder];
}

+ (void) saveImageWithFixedNameAndGetPath: (UIImage *) image callBackBlock:(CallBackBlock)callBack {
    __block NSDictionary *retDict = nil;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,                                                         NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [@"filename" stringByAppendingString:@".jpg"]];
        NSData* data = UIImagePNGRepresentation(image);
        BOOL success = [data writeToFile:path atomically:YES];
        retDict = @{@"pathName":path,@"success":@(success)};
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callBack != nil) {
                callBack(retDict);
            }
        });
    });
}

+(NSString*) saveImageWithRandomNameAndGetPath: (UIImage *) image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [[NSString randomAlphanumericStringWithLength:5] stringByAppendingString:@".jpg"]];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
    
    return path;
}
@end
