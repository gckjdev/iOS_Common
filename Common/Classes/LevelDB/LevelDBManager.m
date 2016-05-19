//
//  LevelDBManager.m
//  Draw
//
//  Created by qqn_pipi on 13-6-16.
//
//

#import "LevelDBManager.h"
//#import "FileUtil.h"
//#import "PPDebug.h"

#define LEVEL_DB_DIR   @"level_db"

static LevelDBManager* globalLevelDBManager;

@implementation LevelDBManager

+ (LevelDBManager*)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalLevelDBManager = [[LevelDBManager alloc] init];
    });
    
    return globalLevelDBManager;
}

- (id)init
{
    NSString* dir = [LevelDBManager filePathInAppDocument:LEVEL_DB_DIR];
    [LevelDBManager createDir:dir];
    
    self = [super init];
    _allDbs = [[NSMutableDictionary alloc] init];

    
    return self;
}

+ (BOOL)createDir:(NSString*)fullPath
{
    
    // Check if the directory already exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        
        // Directory does not exist so create it
        NSLog(@"create dir = %@", fullPath);
        
        NSError* error = nil;
        BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (result == NO){
            NSLog(@"create dir (%@) but error (%@)", fullPath, [error description]);
        }
        
        return result;
    }
    else{
        return YES;
    }
}
+ (NSString *)filePathInAppDocument:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *retDir = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    return retDir;
}

- (APLevelDB*)db:(NSString*)dbName
{
    if ([dbName length] == 0)
        return nil;
    
    APLevelDB* ldb = [_allDbs objectForKey:dbName];
    if (ldb != nil)
        return ldb;        
    
    NSString* path = [NSString stringWithFormat:@"%@/%@", LEVEL_DB_DIR, dbName];
    NSString* filePath = [LevelDBManager filePathInAppDocument:path];
    
    NSError* error = nil;
    ldb = [APLevelDB levelDBWithPath:filePath error:&error];
    if (ldb != nil){
        NSLog(@"Open Level DB At Path:%@", filePath);
        [_allDbs setObject:ldb forKey:dbName];
    }
    else{
        NSLog(@"ERROR(%@) Open Level DB At Path:%@", [error description], filePath);
    }

    return ldb;
}


@end
