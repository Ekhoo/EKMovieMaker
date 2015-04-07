# EKMovieMaker

[![Version](https://img.shields.io/cocoapods/v/EKMovieMaker.svg?style=flat)](http://cocoapods.org/pods/EKMovieMaker)
[![License](https://img.shields.io/cocoapods/l/EKMovieMaker.svg?style=flat)](http://cocoapods.org/pods/EKMovieMaker)
[![Platform](https://img.shields.io/cocoapods/p/EKMovieMaker.svg?style=flat)](http://cocoapods.org/pods/EKMovieMaker)

Lite tool which convert an array of UIImage into a movie, written in Objective-C.

### Demonstration

Transform those images:

![EKMovieMakerImage](https://github.com/Ekhoo/EKMovieMaker/blob/master/Example/Assets/Images.png)


To this movie:


![EKMovieMaker](https://github.com/Ekhoo/EKMovieMaker/blob/master/Example/Assets/Movie.gif)

## Usage

EKMovieMaker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EKMovieMaker", '~> 0.0.1'
```

### Example

``` objective-c
#import <EKMovieMaker.h>

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSArray *images = @[
                      [UIImage imageNamed:@"image1.jpg"],
                      [UIImage imageNamed:@"image2.jpg"],
                      [UIImage imageNamed:@"image3.jpg"],
                      [UIImage imageNamed:@"image4.jpg"],
                      [UIImage imageNamed:@"image5.jpg"]
                      ];
                      
    EKMovieMaker movieMaker    = [[EKMovieMaker alloc] initWithImages:self.images];
    movieMaker.movieSize       = CGSizeMake(400.0f, 200.0f);
    movieMaker.framesPerSecond = 60.0f;
    movieMaker.frameDuration   = 3.0f;
    
    [movieMaker createMovieWithCompletion:^(NSString *moviePath) {
      NSLog(@"Movie path => %@", moviePath);
    }];
}
```

## Author

Ekhoo, me@lucas-ortis.com

## License

EKMovieMaker is available under the MIT license. See the LICENSE file for more info.
