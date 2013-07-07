//
//  SecondViewController.m
//  Hello
//
//  Created by 市岡 侑子 on 13/07/03.
//  Copyright (c) 2013年 Yuko Ichioka. All rights reserved.
//

#import "SecondViewController.h"
#define OFFSET_Y 20.0

@interface SecondViewController ()
{
    UIImageView *imageView;
    UILabel *label;
    UIFont *labelFont;
    UIButton *button;
    UIButton *button2;
    int buttonCount;
}
@property (copy, nonatomic) NSArray *imageArray;
@property (copy, nonatomic) NSArray *textArray;


@end

@implementation SecondViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        // 画像とラベルを、自分のメソッドである arrayInitialize でいれておくよ。
//        [self arrayInitialize];
        // buttonCountも初期化
        buttonCount = 0;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self;
}

- (void)loadView
{
    //下地のビューを作っておく
    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = contentView;    //retainされるので
    [contentView release];      //解放しておくよ
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    // UIImageなどで、お気に入りの画像をcontentViewにaddSubViewする。
    // UIImageViewを初期化。同時に、始めに表示するのは配列の最初の画像を指定。
    imageView = [[UIImageView alloc] initWithImage:_imageArray[0]];
    
    // imageViewの中央はどこ?
    NSLog(@"%@", NSStringFromCGPoint(imageView.center));
    // imageViewを置くself.viewの中央はどこ?
    NSLog(@"%@", NSStringFromCGPoint(self.view.center));
    // その差を使えば横のセンタリングはできるんじゃね?
    NSLog(@"%f", self.view.center.x - imageView.center.x);
    // あ。でも小数点以下があると画像がボケるので、roundf()をつかって丸めておくよ。
    NSLog(@"%f", roundf(self.view.center.x - imageView.center.x));
    
    // imageViewの中央の位置を変更するよ。
    CGFloat offsetX = roundf(self.view.center.x - imageView.center.x);
    // yは固定でオフセットしておくよ。
    CGFloat offsetY = OFFSET_Y;
    // いろいろサイズがわかったので、それをつかってimageViewのセンターを設定。
    [imageView setCenter:CGPointMake(imageView.center.x + offsetX, imageView.center.y + offsetY)];
    [contentView addSubview:imageView];
    [imageView release];
    
    // UILabelで、その画像のキャプションを書いて、addSubViewする。
    // ラベルのフォンサイズを指定
    labelFont = [UIFont systemFontOfSize:18];
    // ラベルの表示サイズをテキストから取得
    CGSize labelSize = [_textArray[0] sizeWithFont:labelFont];
    // ラベルのx, yの位置決め
    CGFloat labelX = roundf((self.view.frame.size.width - labelSize.width) / 2);
    CGFloat labelY = roundf(offsetY + imageView.frame.size.height + 10);
    
    // ラベルの作成
    label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelSize.width, labelSize.height)];
    label.font = labelFont; // Fontはうえで決めたやつね。
    label.text = _textArray[0]; // 初めに表示するテキストは配列の一番始めのやつ。
    [contentView addSubview:label];
    [label release];
    
    //ボタンはいつもRoundRect
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //ボタンのテキストをNSStringで作っておく
    NSString *buttonText = @"◀";
    //ラベルと同じようにテキストからサイズを取るから
    CGSize buttonTextSize = [buttonText sizeWithFont:labelFont];
    //ボタンのステータスに対応したテキストを設定
    [button setTitle:buttonText forState:UIControlStateNormal];
    //ボタンの文字の周りに少しマージンをつける
    CGFloat buttonMargin = 5.0;
    CGFloat buttonX=roundf((self.view.frame.size.width - buttonTextSize.width) / 2);
    
    button.frame = CGRectMake(buttonX, labelY+30, buttonTextSize.width + buttonMargin, buttonTextSize.height + buttonMargin);
    button.tag = 1;
    [button addTarget:self action:@selector(changeImageAndLabel:)forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    
    
    
}

- (void)arrayInitialize
{
    // 画像はこのクラスのInitの時に配列にいれておくよ。
    // UIImageで自動でリサイズしてもらうにはpng形式じゃないとだめ。
    UIImage *image1 = [UIImage imageNamed:@"image01"];
    UIImage *image2 = [UIImage imageNamed:@"image02"];
    
    self.imageArray = @[image1, image2];
    
    // キャプションもinit時に配列にいれておくよ。
    NSString *text1 = @"学校のアイドル";
    NSString *text2 = @"もふもふ";
    
    self.textArray = @[text1, text2];
}

- (void)changeImageAndLabel:(UIButton *)button
{
    
    if (buttonCount != [_imageArray count] - 1) {
        buttonCount ++;
        CGSize labelSize = [_textArray[buttonCount] sizeWithFont:labelFont];
        CGFloat labelX = roundf((self.view.frame.size.width - labelSize.width) / 2);
        CGFloat offsetY = OFFSET_Y;
        CGFloat labelY = roundf(offsetY + imageView.frame.size.height + 10);
        label.frame = CGRectMake(labelX, labelY, labelSize.width, labelSize.height);
        label.text = _textArray[buttonCount];
        imageView.image = _imageArray[buttonCount];
    } else if (buttonCount == [_imageArray count] - 1) {
        buttonCount = 0;
        CGSize labelSize = [_textArray[buttonCount] sizeWithFont:labelFont];
        CGFloat labelX = roundf((self.view.frame.size.width - labelSize.width) / 2);
        CGFloat offsetY = OFFSET_Y;
        CGFloat labelY = roundf(offsetY + imageView.frame.size.height + 10);
        label.frame = CGRectMake(labelX, labelY, labelSize.width, labelSize.height);
        label.text = _textArray[buttonCount];
        imageView.image = _imageArray[buttonCount];
    }
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
