//
//  EKMovieMaker.m
//  EKMovieMaker
//
//  Created by Lucas Ortis on 28/03/2015.
//  Copyright (c) 2015 Ekhoo. All rights reserved.
//

@import AVFoundation;

#import "EKMovieMaker.h"

static NSString * const kVideoOutputFile = @"movie.mp4";

@interface EKMovieMaker()

@property(nonatomic, strong, readonly) NSArray       *images;
@property(nonatomic, strong, readonly) AVAssetWriter *videoWriter;

@end

@implementation EKMovieMaker

- (instancetype)initWithImages:(NSArray *)images {
    self = [super init];
    
    if (self) {
        NSParameterAssert(images);
        
        self->_images          = images;
        self->_movieSize       = CGSizeMake(400.0f, 200.0f);
        self->_frameDuration   = 5.0f;
        self->_framesPerSecond = 30.0f;
        
        for (id item in images) {
            NSAssert([item isKindOfClass:[UIImage class]], @"Each items should be a UIImage !");
        }
    }
    
    return self;
}

- (void)createMovieWithCompletion:(void (^)(NSString *moviePath))completionBlock {
    NSParameterAssert(self.images);
    
    self.frameDuration *= self.framesPerSecond;
    
    NSError *error = nil;
    
    NSFileManager *fileMgr       = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *videoOutputPath    = [documentsDirectory stringByAppendingPathComponent:kVideoOutputFile];

    if (![fileMgr removeItemAtPath:videoOutputPath error:&error]) {
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    }
        
    NSLog(@"Start building video from defined frames.");
    
    self->_videoWriter = [[AVAssetWriter alloc] initWithURL:
                          [NSURL fileURLWithPath:videoOutputPath] fileType:AVFileTypeQuickTimeMovie
                                                      error:&error];
    NSParameterAssert(self.videoWriter);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:self.movieSize.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:self.movieSize.height], AVVideoHeightKey,
                                   nil];
    
    AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput
                                            assetWriterInputWithMediaType:AVMediaTypeVideo
                                            outputSettings:videoSettings];
    
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
                                                     assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput
                                                     sourcePixelBufferAttributes:nil];
    
    NSParameterAssert(videoWriterInput);
    NSParameterAssert([self.videoWriter canAddInput:videoWriterInput]);
    
    videoWriterInput.expectsMediaDataInRealTime = YES;
    [self.videoWriter addInput:videoWriterInput];
    
    /*** Start the session ***/
    [self.videoWriter startWriting];
    [self.videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    CVPixelBufferRef buffer = NULL;
    int frameCount          = 0;
    
    NSLog(@"**************************************************");
    
    for(UIImage *img in self.images) {
        buffer = [self pixelBufferFromCGImage:[img CGImage]];
        
        BOOL append_ok = NO;
        int j          = 0;
        
        while (!append_ok && j < 30) {
            if (adaptor.assetWriterInput.readyForMoreMediaData)  {
                NSLog(@"Processing video frame (%d,%lu)", frameCount, (unsigned long)self.images.count);
                
                CMTime frameTime = CMTimeMake(frameCount * self.frameDuration,(int32_t) self.framesPerSecond);
                append_ok        = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
                
                if (!append_ok){
                    NSError *error = self.videoWriter.error;
                
                    if (error != nil) {
                        NSLog(@"Unresolved error %@,%@.", error, [error userInfo]);
                    }
                }
            }
            else {
                NSLog(@"adaptor not ready %d, %d\n", frameCount, j);
                [NSThread sleepForTimeInterval:0.1f];
            }
            
            j++;
        }
        
        if (!append_ok) {
            NSLog(@"error appending image %d times %d\n, with error.", frameCount, j);
        }
        
        frameCount++;
    }
    
    NSLog(@"**************************************************");
    
    //Finish the session:
    [videoWriterInput markAsFinished];
    [self.videoWriter finishWritingWithCompletionHandler:^{
        NSLog(@"Video path => %@", videoOutputPath);
        
        if (completionBlock) {
            completionBlock(videoOutputPath);
        }
    }];
}

- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef) image {
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          self.movieSize.width,
                                          self.movieSize.height,
                                          kCVPixelFormatType_32ARGB,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    if (status != kCVReturnSuccess){
        NSLog(@"Failed to create pixel buffer");
    }
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 self.movieSize.width,
                                                 self.movieSize.height,
                                                 8,
                                                 4 * self.movieSize.width,
                                                 rgbColorSpace,
                                                 kCGImageAlphaPremultipliedFirst);
    
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

@end
