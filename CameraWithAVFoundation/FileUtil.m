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

+(NSString*) saveImageTODocumentAndGetPath: (UIImage *) image {
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
