//
//  DetailViewController.m
//  Melodies
//
//  Created by Evgeny Zorin on 17/03/15.
//  Copyright (c) 2015 Evgeny Zorin. All rights reserved.
//

#import "DetailViewController.h"
#import "AsyncImageView.h"

#define ERR_COOF 1.5f

@import AVFoundation;


@interface DetailViewController ()
{
    AVURLAsset* _avAsset;
    AVPlayerItem* _playerItem;
    AVPlayer* _audioPlayer;
    
    NSTimer* _sliderTimer;
}

@property (weak, nonatomic) IBOutlet AsyncImageView* coverPhoto;
@property (weak, nonatomic) IBOutlet UILabel* melodyArtist;
@property (weak, nonatomic) IBOutlet UILabel* melodyTitle;

@property (weak, nonatomic) IBOutlet UISlider* aSlider;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property BOOL isPlaying;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(IBAction)playMelody:(id)sender;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

#pragma mark - ViewCycle managment

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        _coverPhoto.imageURL = [NSURL URLWithString:_detailItem.picUrl];
        _melodyArtist.text = [NSString stringWithFormat:@"Artist : %@",_detailItem.artist];
        _melodyTitle.text = [NSString stringWithFormat:@"Title : %@",_detailItem.title];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    // Construct URL to sound file
    NSURL *url = [NSURL URLWithString:_detailItem.demoUrl];
    _avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    _playerItem = [AVPlayerItem playerItemWithAsset:_avAsset];
    _audioPlayer = [AVPlayer playerWithPlayerItem:_playerItem];
    
    // Set a timer which keep getting the current music time and update the UISlider in 1 sec interval
    _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    // Set the maximum value of the UISlider
    //
    // Set the valueChanged target
    [_aSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_audioPlayer pause];
    [_sliderTimer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Slider player managment
- (IBAction)sliderChanged:(UISlider *)sender {
    // Fast skip the music when user scroll the UISlider
    CMTime seekTime = CMTimeMake(CMTimeGetSeconds(_audioPlayer.currentItem.asset.duration)*sender.value/ERR_COOF, 1);
    [_audioPlayer seekToTime:seekTime];
}

- (void)updateSlider {
    // Update the slider about the music time
    double duration = CMTimeGetSeconds(_audioPlayer.currentItem.duration)/ERR_COOF;
    double time = CMTimeGetSeconds(_audioPlayer.currentTime);
    _aSlider.value = (CGFloat) (time / duration);
}

#pragma mark - Memory Managment

-(void)dealloc
{
    _avAsset = nil;
    _playerItem = nil;
    _audioPlayer = nil;
    
    [_sliderTimer invalidate];
    _sliderTimer = nil;
    
    self.detailItem = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Action

-(IBAction)playMelody:(id)sender
{
    if(_isPlaying)
    {
        [_audioPlayer pause];
        [_playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    else
    {
        [_audioPlayer play];
        [_playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    _isPlaying = !_isPlaying;
    
}


#pragma mark - AVPLayer callback

-(void)itemDidFinishPlaying:(NSNotification *) notification {
    // Will be called when AVPlayer finishes playing playerItem
    CMTime seekTime = CMTimeMake(0, 1);
    [_audioPlayer seekToTime:seekTime];
    _aSlider.value = 0.;
}

@end
