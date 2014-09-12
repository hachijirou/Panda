//
//  PandaUrlGroupRepository.h
//  Panda
//
//  Created by usr10049697 on 2014/09/09.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Webサイト情報のひとつのまとまりを管理するオブジェクトを永続化する.
 */
@interface PandaUrlGroupRepository : NSObject

// データを永続化する
- (void)addObject:(NSMutableArray *) data;

// データをすべて取得する
- (NSMutableArray *)selectAll;

@end
