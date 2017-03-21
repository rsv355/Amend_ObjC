//
//  FilterCollectionViewCell.h
//  PhotoEditorApp
//
//  Created by webmyne systems on 27/07/16.
//  Copyright © 2016 Webmyne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageRetouch;
@property (weak, nonatomic) IBOutlet UILabel *lblRetouchName;
@property (weak, nonatomic) IBOutlet UIImageView *imageFilter;
@property (weak, nonatomic) IBOutlet UILabel *lblFilterName;
@property (weak, nonatomic) IBOutlet UIView *viewRetouch;
@property (weak, nonatomic) IBOutlet UIImageView *viewImageRetouch;
@end
