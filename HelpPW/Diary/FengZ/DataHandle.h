//
//  DataHandle.h
//  HelpPW
//
//  Created by BurNIng on 16/1/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDB.h"

@interface DataHandle : NSObject
+ (DataHandle *)shareDataHandle;
- (FMDatabase *)openDB;
@end
