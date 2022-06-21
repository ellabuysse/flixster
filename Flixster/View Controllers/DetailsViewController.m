//
//  DetailsViewController.m
//  Flixster
//
//  Created by ellabuysse on 6/17/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
        
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *fullPosterUrl = [baseURLString stringByAppendingString:self.movie[@"poster_path"]];
    NSURL *posterUrl = [NSURL URLWithString:fullPosterUrl];
        
    NSString *fullBackdropUrl = [baseURLString stringByAppendingString:self.movie[@"backdrop_path"]];
    NSURL *backdropUrl = [NSURL URLWithString:fullBackdropUrl];
    
    [self.posterImageView setImageWithURL:posterUrl];
    [self.backdropImageView setImageWithURL:backdropUrl];
    NSLog(@":EB: Details");
}


@end
