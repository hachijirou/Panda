//
//  PandaUrlGroupRepository.m
//  Panda
//
//  Created by usr10049697 on 2014/09/09.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaUrlGroupRepository.h"

@implementation PandaUrlGroupRepository

- (void)addObject:(NSMutableArray *) data
{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"PandaUrlGroup.dat"];
    BOOL successful = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    if (successful) {
        NSLog(@"%@", @"データの保存に成功しました。");
    }
}

- (NSMutableArray *)selectAll
{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"PandaUrlGroup.dat"];
    NSMutableArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (data) {
        NSLog(@"%@", @"データの読み込みに成功しました。");
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }
    return data;
}

@end
