//
//  PandaDetailViewController.m
//  Panda
//
//  Created by usr10049697 on 2014/08/12.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaConst.h"
#import "PandaDetailViewController.h"

@interface PandaDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

// ビュー全体を覆うスクロールビュー
@property (weak, nonatomic) IBOutlet PandaScrollView *contentScrollView;
// タイトル
@property (weak, nonatomic) IBOutlet UITextField *titleTextFIeld;
// メモ
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
// 更新日時
@property (weak, nonatomic) IBOutlet UILabel *updateDateLabel;
// URLリストを表示するためのテーブルビュー
@property (weak, nonatomic) IBOutlet UITableView *urlListTableView;

// 現在編集中のテキストフィールドを保持する
@property (strong, nonatomic) UITextField *memoryEditingTextField;
// 画面をスクロールすべきか判定するフラグ
@property BOOL canScroll;
// Webサイト情報未編集を判定するフラグ
@property BOOL isEditingToContentsData;

// タイトルの編集完了
- (IBAction)titleEditingDidEnd:(id)sender;
- (IBAction)titleEditingChanged:(id)sender;
// Webサイトの情報を入力するテキストフィールドの追加
- (IBAction)addTextFieldForUrlData:(id)sender;
// 外部ブラウザを立ち上げる
- (IBAction)openExternalBrowser:(id)sender;

@end

@implementation PandaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初期化
    self.titleTextFIeld.text = self.item.title;
    self.memoTextView.text = self.item.note;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.updateDateLabel.text =
    [formatter stringFromDate:self.item.updateDate];
    
    // 制御系の変数の初期化
    self.canScroll = NO;
    self.isEditingToContentsData = NO;
    
    // textFieldのDelegate通知を受け取る
    self.titleTextFIeld.delegate = self;
    self.memoTextView.delegate = self;
    
    // tableViewのDelegate通知を受け取る
    self.urlListTableView.delegate = self;
    self.urlListTableView.dataSource = self;
    
    
    // タイトルのテキストビューに枠線を設定
    
    // メモのテキストビューに枠線を設定
    self.memoTextView.layer.borderWidth = 1;
    self.memoTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    // URLリストの読み込み
    [self.urlListTableView registerNib:[UINib nibWithNibName:@"PandaUrlListCustomCell" bundle:nil] forCellReuseIdentifier:@"PandaUrlListCustomCell"];
    
    // URLリストの生成
    if (self.item.urlGroupList.count == 0) {
        // デフォルトのURL情報入力フォームの作成
        NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:0 inSection:0];
        PandaUrl *urlInfo = [[PandaUrl alloc] init];
        [self.item.urlGroupList insertObject:urlInfo atIndex:indexPathToInsert.row];
        [self.urlListTableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        // 編集中フラグの初期化
        int cnt = self.item.urlGroupList.count;
        for (int i = 0; i < cnt; i++) {
            PandaUrl *info = [self.item.urlGroupList objectAtIndex:i];
            info.isEditing = NO;
            [self.item.urlGroupList replaceObjectAtIndex:i withObject:info];
        }
    }
    /*
    else {
        int i = 0;
        for (PandaUrl *urlInfo in self.item.urlGroupList) {
            NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:0];
            [self.item.urlGroupList insertObject:urlInfo atIndex:indexPathToInsert.row];
            [self.urlListTableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
            i++;
        }
    }
    */
    
    
//    if (self.urlList.count == 0) {
//        NSIndexPath *indexPathToDefault = [NSIndexPath indexPathForRow:0 inSection:0];
//        PandaUrl *urlInfo = [[PandaUrl alloc] init];
//        [self.urlList insertObject:urlInfo atIndex:indexPathToDefault.row];
//        [self.urlListTableView insertRowsAtIndexPaths:@[indexPathToDefault] withRowAnimation:UITableViewRowAnimationFade];
//    }
    
    // キーボードが表示されたときのNotificationをうけとる
    [self registerForKeyboardNotifications];
    
    // セルが編集されたときのNotificationをうけとる
    [self registForEditingCellNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITextFiledの編集開始時に呼ばれる処理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.memoryEditingTextField = textField;
    if (textField.tag >= PandaDetailContentsTitlePrefix && textField.tag <= PandaDetailScrollTermination) {
        self.canScroll = YES;
    } else {
        self.canScroll = NO;
    }
}

// UITextFieldのReturn時に呼ばれる処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを閉じる
    [textField resignFirstResponder];
    self.memoryEditingTextField = nil;
    return YES;
}

// ビューがtouchされたときに呼ばれる処理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // キーボードを閉じる
    [self.titleTextFIeld resignFirstResponder];
    [self.memoTextView resignFirstResponder];
    [self.memoryEditingTextField resignFirstResponder];
    self.memoryEditingTextField = nil;
}

// 編集完了の判定を行う
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // タイトル
    if ([identifier isEqualToString:@"SaveDetailEdit"]) {
        if (self.item.title == nil ||
            self.item.title.length == 0) {
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Warning"
                                       message:@"Title must not be empty."
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil,
             nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// タイトルの編集完了
- (IBAction)titleEditingDidEnd:(id)sender
{
    self.item.title = self.titleTextFIeld.text;
}
- (IBAction)titleEditingChanged:(id)sender
{
    self.item.title = self.titleTextFIeld.text;
}
// メモの編集完了
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.item.note = self.memoTextView.text;
    return YES;
}

// URLリストテーブルビューの行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.item.urlGroupList.count;;
}

// URLリストテーブルビューの行数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"PandaUrlListCustomCell";
    // 再利用できるセルがあれば再利用する
    PandaUrlListCustomCell *cell = (PandaUrlListCustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    
    // 識別のためにタグを設定
    cell.urlTitleTextField.tag = PandaDetailContentsTitlePrefix + indexPath.row;
    cell.urlTextField.tag = PandaDetailContentsUrlPrefix + indexPath.row;
    
    // Webサイト情報の設定
    PandaUrl *data = [self.item.urlGroupList objectAtIndex:indexPath.row];
    
    if (data == nil || data.isEditing) {
        cell.urlTitleTextField.text = cell.contentsInfo.contentsTitle;
        cell.urlTextField.text = cell.contentsInfo.contentsUrl;
    } else {
        cell.urlTitleTextField.text = data.contentsTitle;
        cell.urlTextField.text = data.contentsUrl;
        cell.contentsInfo.contentsTitle = data.contentsTitle;
        cell.contentsInfo.contentsUrl = data.contentsUrl;
    }
    
    // textFieldのDelegate通知を受け取る
    cell.urlTitleTextField.delegate = self;
    cell.urlTextField.delegate = self;
    
    // タイトルのテキストフィールドに枠線を追加
    cell.urlTitleTextField.layer.borderWidth = 1;
    cell.urlTextField.layer.borderWidth = 1;
    
    // テーブルビュー内の自分の位置をセット
    cell.rowNumber = indexPath.row;
    
    return cell;
}

// キーボードが表示されたときの通知を受け取る
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// キーボードが表示されたときにコールバックされる
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (self.canScroll) {
        CGPoint scrollPoint = CGPointMake(0.0,150.0);
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// キーボードが隠れたときにコールバックされる
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (self.canScroll) {
        [self.contentScrollView setContentOffset:CGPointZero animated:YES];
        self.canScroll = NO;
    }
}

// セルが編集されたときの通知を受け取る
- (void)registForEditingCellNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingContentCell:)
                                                 name:PandaDetailEditingCellNotification
                                               object:nil];
}

// セルが編集されたときにコールバックを受け取る
- (void)editingContentCell:(NSNotification*)aNotification
{
    NSNumber *rowNumber = [[aNotification userInfo] objectForKey:@"rowNumber"];
    //PandaUrl *pandaUrlInfo = [self.item.urlGroupList objectAtIndex:[rowNumber intValue]];
    //pandaUrlInfo.isEditing = YES;
    PandaUrl *pandaUrlInfo = [[aNotification userInfo] objectForKey:@"contentsInfo"];
    [self.item.urlGroupList replaceObjectAtIndex:[rowNumber intValue] withObject:pandaUrlInfo];
}


// 外部ブラウザを立ち上げる
- (IBAction)openExternalBrowser:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.co.jp/"]];
}

// Webサイトの情報を入力するテキストフィールドの追加
- (IBAction)addTextFieldForUrlData:(id)sender {
    // デフォルトのURL情報入力フォームの作成
    if (self.item.urlGroupList.count < PandaDetailAddUrlDataTextFieldMax) {
        NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:self.item.urlGroupList.count inSection:0];
        PandaUrl *urlInfo = [[PandaUrl alloc] init];
        [self.item.urlGroupList insertObject:urlInfo atIndex:indexPathToInsert.row];
        [self.urlListTableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end

@implementation PandaUrlListCustomCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.contentsInfo = [[PandaUrl alloc] init];
    }
    return self;
}

// URLタイトル編集完了
- (IBAction)contentsTitleEditingDidEnd:(id)sender {
    self.contentsInfo.contentsTitle = self.urlTitleTextField.text;
    // 通知
    [self notifyOfEditingContentCell];
}

// URL編集完了
- (IBAction)contentsUrlEditingDidEnd:(id)sender {
    self.contentsInfo.contentsUrl = self.urlTextField.text;
    // 通知
    [self notifyOfEditingContentCell];
}

// セルが編集中ということを通知する
- (void)notifyOfEditingContentCell {
    self.contentsInfo.isEditing = YES;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:self.rowNumber], @"rowNumber",
                         self.contentsInfo, @"contentsInfo",
                         nil];
    NSNotification *n = [NSNotification notificationWithName:PandaDetailEditingCellNotification object:self userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}

@end

@implementation PandaScrollView

// タッチイベントをビューコントローラに送り出す
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
