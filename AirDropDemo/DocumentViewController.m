//
//  DocumentViewController.m
//  AirDropDemo
//
//  Created by Simon on 28/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "DocumentViewController.h"

@interface DocumentViewController ()

@end

@implementation DocumentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [self fileToURL:self.documentName];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//只要呼叫fileToURL：並傳遞文件名的訊息，
//會回傳相對的檔案網址
- (NSURL *) fileToURL:(NSString*)filename
{
    NSArray *fileComponents = [filename componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileComponents objectAtIndex:0] ofType:[fileComponents objectAtIndex:1]];

    return [NSURL fileURLWithPath:filePath];
}

- (IBAction)share:(id)sender {
    
    //網址的轉換
    //把要分享的檔案轉成NSURL物件
    //documentName：用來儲存目前的檔案並呈現在document view
    NSURL *url = [self fileToURL:self.documentName];
    //檔案網址物件變成陣列傳給AirDrop
    NSArray *objects2Share = @[url];
    
    //建立UIActivityViewController
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objects2Share applicationActivities:nil];
    
    //除了AirDrop排除所有的sctivities
    NSArray *excludedActivities = @[ UIActivityTypePostToTwitter,
                                     UIActivityTypePostToFacebook,
                                     UIActivityTypePostToWeibo,
                                     UIActivityTypeMessage,
                                     UIActivityTypeMail,
                                     UIActivityTypeMail,
                                     UIActivityTypeCopyToPasteboard,
                                     UIActivityTypeAssignToContact,
                                     UIActivityTypeSaveToCameraRoll,
                                     UIActivityTypeAddToReadingList,
                                     UIActivityTypePostToFlickr,
                                     UIActivityTypePostToVimeo,
                                     UIActivityTypePostToTencentWeibo];
    
    controller.excludedActivityTypes = excludedActivities;
    
    //把controller推到畫面前面
    [self presentViewController:controller animated:YES completion:nil];
}
@end
