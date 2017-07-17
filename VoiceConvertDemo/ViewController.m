//
//  ViewController.m
//  VoiceConvertDemo
//
//  Created by Mjwon on 2017/7/17.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ViewController.h"
#import "DeviceManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (nonatomic ,strong) NSString *recordPath;
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.beginBtn setTitle:@"取消录音" forState:UIControlStateSelected];
    [self.beginBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    
}
- (IBAction)begin:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        self.showLabel.text = @"录音中...";
        [self StartRecordingVoiceAction];
    }else{
        self.showLabel.text = @"录音已取消";
        [self CancelRecordingVoiceAction];
    }
    
    NSLog(@"%d",btn.selected);
    

}

-(void)StartRecordingVoiceAction{
    int x = arc4random() % 100000;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
    __weak typeof(self) weakSelf = self;
    [[DeviceManagerBase sharedInstance] asyncStartRecordingWithFileName:fileName completion:^(NSError *error)
     {
         if (error) {
             NSLog(@"录音失败！");
             weakSelf.showLabel.text = @"录音失败！";
         }
     }];
}
-(void)CancelRecordingVoiceAction{
    
    [[DeviceManagerBase sharedInstance] cancelCurrentRecording];
}

- (IBAction)end:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    self.showLabel.text = @"结束录音";
    self.beginBtn.selected = !self.beginBtn.selected;
    
    [[DeviceManagerBase sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {
            NSString *name = [recordPath substringWithRange:NSMakeRange(recordPath.length-19, 15)];
            weakSelf.recordPath = recordPath;
            NSLog(@"文件名：%@  路径：%@",name,recordPath);
        }else {
            weakSelf.showLabel.text = @"录音时间太短!";
            NSLog(@"录音时间太短!");
        }
    }];

    
}
- (IBAction)play:(id)sender {
    
    self.showLabel.text = @"播放中...";
    __weak typeof(self) weakSelf = self;
    [[DeviceManagerBase sharedInstance] asyncPlayingWithPath:self.recordPath completion:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"播放结束!");
            weakSelf.showLabel.text = @"播放结束!";
            [[DeviceManagerBase sharedInstance] disableProximitySensor];
        });
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
