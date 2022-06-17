//
//  MovieCellTableViewCell.h
//  Flixster
//
//  Created by ellabuysse on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *MovieSynopsis;
@property (weak, nonatomic) IBOutlet UILabel *MovieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@end

NS_ASSUME_NONNULL_END
