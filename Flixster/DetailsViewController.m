//
//  DetailsViewController.m
//  Flixster
//
//  Created by ellabuysse on 6/17/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *MovieSynopsis;
@property (weak, nonatomic) IBOutlet UILabel *MovieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.MovieTitle.text = _dictionary[@"title"];
    self.MovieSynopsis.text = _dictionary[@"overview"];
        
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *fullPosterUrl = [baseURLString stringByAppendingString:_dictionary[@"poster_path"]];
    NSURL *posterUrl = [NSURL URLWithString:fullPosterUrl];
        
    [self.ImageView setImageWithURL:posterUrl];
        
    NSLog(@"Details");
}


@end
