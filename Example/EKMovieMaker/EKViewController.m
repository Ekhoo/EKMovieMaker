//
//  EKViewController.m
//  EKMovieMaker
//
//  Created by Ekhoo on 03/27/2015.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import "EKViewController.h"

@interface EKViewController ()

@property(nonatomic, strong) UIScrollView *scrollView;

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
                                                                              style:UIBarButtonItemStylePlain target:nil action:nil];
    
    /*** Scroll view ***/
    self.scrollView                 = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    
    /*** Images ***/
    NSArray *images = @[
                        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image1.jpg"]],
                        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image2.jpg"]],
                        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image3.jpg"]],
                        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image4.jpg"]],
                        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image5.jpg"]]
                        ];
    
    CGFloat imageHeight     = 100.0f;
    CGFloat separatorHeight = 4.0f;
    CGFloat currentY        = separatorHeight;
    
    for (UIImageView *imageView in images) {
        /*** ImageView ***/
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
