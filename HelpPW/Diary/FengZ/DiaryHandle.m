//
//  DiaryHandle.m
//  HelpPW
//
//  Created by BurNIng on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiaryHandle.h"
#import "DataHandle.h"
#import "DiaryModel.h"

@implementation DiaryHandle

+ (BOOL)insectInfoDiary:(DiaryModel *)diary {
    FMDatabase *db = [[DataHandle shareDataHandle] openDB];
    BOOL isSuccess = [db executeUpdate:@"insert into class (Title, Content, Time, PhotoData1, PhotoData2, PhotoData3) values(?,?,?,?,?,?)", diary.title, diary.content, diary.time, diary.photoData1, diary.photoData2, diary.photoData3, nil];
    return isSuccess;
}

+ (DiaryModel *)SelectActivityWithTitle:(NSString *)title {
    FMDatabase *db = [[DataHandle shareDataHandle] openDB];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM class where Title = ?", title];
    DiaryModel *diary = nil;
    while ([rs next]) {
        NSString *title = [rs stringForColumn:@"Title"];
        NSString *content = [rs stringForColumn:@"Content"];
        NSString *time = [rs stringForColumn:@"Time"];
        NSData *data1 = [rs dataForColumn:@"PhotoData1"];
        NSData *data2 = [rs dataForColumn:@"PhotoData2"];
        NSData *data3 = [rs dataForColumn:@"PhotoData3"];
        diary = [[DiaryModel alloc] initWithTitle:title Content:content Time:time PhotoData1:data1 PhotoData2:data2 PhotoData3:data3];
    }
    return diary;
}

+ (NSMutableArray *)SelectActivityWithTime:(NSString *)time {
    FMDatabase *db = [[DataHandle shareDataHandle] openDB];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM class where Time = ?", time];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([rs next]) {
        NSString *title = [rs stringForColumn:@"Title"];
        NSString *content = [rs stringForColumn:@"Content"];
        NSString *time = [rs stringForColumn:@"Time"];
        NSData *data1 = [rs dataForColumn:@"PhotoData1"];
        NSData *data2 = [rs dataForColumn:@"PhotoData2"];
        NSData *data3 = [rs dataForColumn:@"PhotoData3"];
        DiaryModel *diary = [[DiaryModel alloc] initWithTitle:title Content:content Time:time PhotoData1:data1 PhotoData2:data2 PhotoData3:data3];
        [arr addObject:diary];
    }
    return arr;
}

+ (NSMutableArray *)selectDiarySqlite {
    FMDatabase *db = [[DataHandle shareDataHandle] openDB];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM class"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ([rs next]) {
        NSString *title = [rs stringForColumn:@"Title"];
        NSString *content = [rs stringForColumn:@"Content"];
        NSString *time = [rs stringForColumn:@"Time"];
        NSData *data1 = [rs dataForColumn:@"PhotoData1"];
        NSData *data2 = [rs dataForColumn:@"PhotoData2"];
        NSData *data3 = [rs dataForColumn:@"PhotoData3"];
        DiaryModel *diary = [[DiaryModel alloc] initWithTitle:title Content:content Time:time PhotoData1:data1 PhotoData2:data2 PhotoData3:data3];
        [array addObject:diary];
    }
    return array;
}

+ (BOOL)updateDiaryByTime:(NSString *)time WithDiary:(DiaryModel *)diary {
    FMDatabase *db = [[DataHandle shareDataHandle] openDB];
    BOOL isOrNo = [db executeUpdate:@"UPDATE class SET Title = ?, Content = ?, PhotoData1 = ?, PhotoData2 = ?, PhotoData3 = ? WHERE Time = ?", diary.title, diary.content, diary.photoData1, diary.photoData2, diary.photoData3, diary.time, nil];
    return isOrNo;
    
}

+ (BOOL)removeDiaryByTime:(NSString *)time {
    FMDatabase *db = [[DataHandle shareDataHandle] openDB];
    BOOL isOrNo = [db executeUpdate:@"delete from class where time = ?", time];
    return isOrNo;
}

@end
