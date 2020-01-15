//
//  ViewController.m
//  LAMEEncodeDemo
//
//  Created by 芝麻酱 on 2020/1/15.
//  Copyright © 2020 芝麻酱. All rights reserved.
//

#import "ViewController.h"
#import "mp3_encoder.hpp"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    AVAudioPlayer *_audioPlayer;
}
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playBtn.userInteractionEnabled = NO;

}

- (IBAction)encodeAction:(id)sender {
    Mp3Encoder* encoder = new Mp3Encoder();
    const char* pcmFilePath = [[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent: @"vocal.pcm"]
                               cStringUsingEncoding: NSUTF8StringEncoding];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = paths.firstObject;
    
    const char* mp3FilePath = [[document stringByAppendingPathComponent: @"vocal.mp3"] cStringUsingEncoding: NSUTF8StringEncoding];
    
    int sampleRate = 44100;
    int channels = 2;
    int bitRate = 128 * 1024;
    encoder->Init(pcmFilePath, mp3FilePath, sampleRate, channels, bitRate);
    encoder->Encode();
    encoder->Destory();
    delete encoder;
    self.playBtn.userInteractionEnabled = YES;
}

- (IBAction)playAction:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = paths.firstObject;
    NSString *mp3Path = [document stringByAppendingPathComponent: @"vocal.mp3"];

    NSError *error = nil;

    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath: mp3Path] error: &error];
    if (error == nil) {
        [_audioPlayer prepareToPlay];
    }
    [_audioPlayer play];
}


@end
