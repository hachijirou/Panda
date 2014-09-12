//
//  PandaConst.h
//  Panda
//
//  Created by usr10049697 on 2014/08/27.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PandaConst : NSObject

// 詳細画面
// Webサイトのタイトルのテキストフィールドの識別子のプレフィックス
UIKIT_EXTERN NSInteger const PandaDetailContentsTitlePrefix;
// WebサイトのURLのテキストフィールドの識別子のプレフィックス
UIKIT_EXTERN NSInteger const PandaDetailContentsUrlPrefix;
// スクロールを行う識別子の終端
UIKIT_EXTERN NSInteger const PandaDetailScrollTermination;
// Webサイト情報の入力フォームを増やせる最大回数
UIKIT_EXTERN NSInteger const PandaDetailAddUrlDataTextFieldMax;

// 通知
// 詳細画面のセルが編集されたときに通知される
UIKIT_EXTERN NSString *const PandaDetailEditingCellNotification;

@end
