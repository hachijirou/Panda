//
//  PandaUrl.h
//  Panda
//
//  Created by usr10049697 on 2014/07/29.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Webサイト情報を管理するオブジェクト.
 */
@interface PandaUrl : NSObject <NSCopying>

// Webサイトのタイトル
@property (nonatomic, copy) NSString *contentsTitle;

// WebサイトのURL
@property (nonatomic, copy) NSURL *contentsUrl;

@end
