//
//  PandaDetailViewController.h
//  Panda
//
//  Created by usr10049697 on 2014/08/12.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaUrlGroup.h"

@interface PandaDetailViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, copy) PandaUrlGroup *item;

@end

// カスタムセル
@interface PandaUrlListCustomCell : UITableViewCell
// タイトル(サイト)
@property (weak, nonatomic) IBOutlet UITextField *urlTitleTextField;
// URL
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@end

// カスタムスクロールビュー
@interface PandaScrollView : UIScrollView

@end
