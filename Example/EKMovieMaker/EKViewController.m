//
//  EKViewController.m
//  EKMovieMaker
//
//  Created by Ekhoo on 03/27/2015.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import "EKViewController.h"
#import "EKMovieMaker.h"

@interface EKViewController ()

@property(nonatomic, strong) UIScrollView           *scrollView;
@property(nonatomic, strong, readonly) NSArray      *images;
@property(nonatomic, strong, readonly) EKMovieMaker *movieMaker;

@end

@implementation EKViewController

- (void)loadView {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    /*** Main view ***/
    self.view                 = [[UIView alloc] initWithFrame:screenBounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*** Navigation bar ***/
    self.navigationController.navigationBar.topItem.title = @"Demonstration";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Convert"
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(convertImages)];
    
    /*** Scroll view ***/
    self.scrollView                 = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    
    /*** Images ***/
    self->_images = @[
                      [UIImage imageNamed:@"image1.jpg"],
                      [UIImage imageNamed:@"image2.jpg"],
                      [UIImage imageNamed:@"image3.jpg"],
                      [UIImage imageNamed:@"image4.jpg"],
                      [UIImage imageNamed:@"image5.jpg"]
                      ];
    
    CGFloat imageHeight     = 100.0f;
    CGFloat separatorHeight = 4.0f;
    CGFloat currentY        = separatorHeight;
    
    for (UIImage *image in self.images) {
        /*** ImageView ***/
        UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
        imageView.frame         = CGRectMake(0.0f, currentY, screenBounds.size.width, imageHeight);
        imageView.contentMode   = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [self.scrollView addSubview:imageView];
        
        currentY += imageHeight + separatorHeight;
    }
    
    self.scrollView.contentSize = CGSizeMake(screenBounds.size.width, currentY);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->_movieMaker               = [[EKMovieMaker alloc] initWithImages:self.images];
    self.movieMaker.movieSize       = CGSizeMake(400.0f, 200.0f);
    self.movieMaker.framesPerSecond = 60.0f;
    self.movieMaker.frameDuration   = 3.0f;
}

- (void)convertImages {
    [self.movieMaker createMovieWithCompletion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
