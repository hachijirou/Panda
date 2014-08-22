//
//  PandaUrlGroup.h
//  Panda
//
//  Created by usr10049697 on 2014/07/29.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Webサイト情報のひとつのまとまりを管理するオブジェクト.
 */
@interface PandaUrlGroup : NSObject <NSCopying>

// グループ名称
@property (nonatomic, copy) NSString *title;

// グループ概要
@property (nonatomic, copy) NSString *note;

// 更新日時
@property (nonatomic, copy) NSDate *updateDate;

// Webサイトの情報を管理する配列(PandaUrlオブジェクトの配列)
@property (nonatomic, copy) NSArray *urlGroupList;

@end
