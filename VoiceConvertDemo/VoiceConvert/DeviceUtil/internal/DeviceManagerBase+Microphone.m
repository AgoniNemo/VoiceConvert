//
//  DeviceManagerBase+Microphone.m
//  VoiceConvertDemo
//
//  Created by Mjwon on 2017/7/17.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "DeviceManagerBase+Microphone.h"
#import "AudioRecorderUtil.h"

@implementation DeviceManagerBase (Microphone)

// 判断麦克风是否可用
- (BOOL)emCheckMicrophoneAvailability{
    __block BOOL ret = NO;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            ret = granted;
        }];
    } else {
        ret = YES;
    }
    
    return ret;
}

// 获取录制音频时的音量(0~1)
- (double)emPeekRecorderVoiceMeter{
    double ret = 0.0;
    if ([AudioRecorderUtil recorder].isRecording) {
        [[AudioRecorderUtil recorder] updateMeters];
        //获取音量的平均值  [recorder averagePowerForChannel:0];
        //音量的最大值  [recorder peakPowerForChannel:0];
        double lowPassResults = pow(10, (0.05 * [[AudioRecorderUtil recorder] peakPowerForChannel:0]));
        ret = lowPassResults;
    }
    
    return ret;
}

@end
