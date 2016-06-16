//
//  DataHandle.m
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DataHandle.h"

#define dataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"diary.sqlite"]
static FMDatabase *db = nil;
@implementation DataHandle
+ (DataHandle *)shareDataHandle {
    static DataHandle *dataHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataHandle = [[DataHandle alloc] init];
    });
    return dataHandle;
}

- (FMDatabase *)openDB {
    if (db == nil) {
        db = [FMDatabase databaseWithPath:dataPath];
        if (![db open]) {
            NSLog(@"打开失败");
        }
        [db executeUpdate:@"CREATE TABLE class (Title text, Content text, Time text, PhotoData1 blob, PhotoData2 blob, PhotoData3 blob)"];
    }
    return db;
}
@end
