//
//  VoiceConverter.m
//  VoiceConvertDemo
//
//  Created by Mjwon on 2017/7/17.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "VoiceConverter.h"
#import "wav.h"
#import "interf_dec.h"
#import "dec_if.h"
#import "interf_enc.h"
#import "amrFileCodec.h"

@implementation VoiceConverter

+ (int)isMP3File:(NSString *)filePath{
    const char *_filePath = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
    return isMP3File(_filePath);
}

+ (int)isAMRFile:(NSString *)filePath{
    const char *_filePath = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
    return isAMRFile(_filePath);
}

+ (int)amrToWav:(NSString*)_amrPath wavSavePath:(NSString*)_savePath{
    
    if (EM_DecodeAMRFileToWAVEFile([_amrPath cStringUsingEncoding:NSASCIIStringEncoding], [_savePath cStringUsingEncoding:NSASCIIStringEncoding]))
        return 0; // success
    
    return 1;   // failed
}

+ (int)wavToAmr:(NSString*)_wavPath amrSavePath:(NSString*)_savePath{
    
    if (EM_EncodeWAVEFileToAMRFile([_wavPath cStringUsingEncoding:NSASCIIStringEncoding], [_savePath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16))
        return 0;   // success
    
    return 1;   // failed
}


@end
