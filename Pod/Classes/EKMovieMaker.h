//
//  EKMovieMaker.h
//  EKMovieMaker
//
//  Created by Lucas Ortis on 28/03/2015.
//  Copyright (c) 2015 Ekhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKMovieMaker : NSObject

//
//  Set the size of the movie.
//  The size of the movie has to be the same as the size of each input images.
//  Default is 400 x 200.
//
@property(nonatomic, assign) CGSize movieSize;

//
//  Set the fps.
//  Default is 30.
//
@property(nonatomic, assign) CGFloat framesPerSecond;

//
//  Set the frame duration.
//  Default is 5 seconds.
//
@property(nonatomic, assign) CGFloat frameDuration;

//
//  Initialize the tool with an array of UIImage.
//
- (instancetype)initWithImages:(NSArray *)images;

//
//  Convert the images collection into a movie.
//
- (void)createMovieWithCompletion:(void (^)(NSString *moviePath))completionBlock;

@end
