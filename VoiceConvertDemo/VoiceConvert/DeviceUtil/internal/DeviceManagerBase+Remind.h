//
//  DeviceManagerBase+Remind.h
//  VoiceConvertDemo
//
//  Created by Mjwon on 2017/7/17.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "DeviceManagerBase.h"
#import <AudioToolbox/AudioToolbox.h>

@interface DeviceManagerBase (Remind)

// 播放接收到新消息时的声音
- (SystemSoundID)playNewMessageSound;

// 震动
- (void)playVibration;

@end
