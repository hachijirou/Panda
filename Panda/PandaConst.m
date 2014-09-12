//
//  PandaConst.m
//  Panda
//
//  Created by usr10049697 on 2014/08/27.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaConst.h"

@implementation PandaConst

// 詳細画面
// Webサイトのタイトルのテキストフィールドの識別子
NSInteger const PandaDetailContentsTitlePrefix = 21000;
// WebサイトのURLのテキストフィールドの識別子
NSInteger const PandaDetailContentsUrlPrefix = 22000;
// スクロールを行う識別子の終端
NSInteger const PandaDetailScrollTermination = 22999;
// Webサイト情報の入力フォームを増やせる最大回数
NSInteger const PandaDetailAddUrlDataTextFieldMax = 10;

// 通知
// 詳細画面のセルが編集されたときに通知される
NSString *const PandaDetailEditingCellNotification = @"PandaDetailEditingCellNotification";

@end
