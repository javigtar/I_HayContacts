//
//  FotoContacto.h
//  HayContacts
//
//  Created by Javi on 30/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FotoContacto : UIViewController

@property (nonatomic) NSString *nombreFoto;
@property (weak, nonatomic) IBOutlet UIImageView *fotoContacto;

@end
