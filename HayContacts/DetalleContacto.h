//
//  DetalleContacto.h
//  HayContacts
//
//  Created by alumno on 19/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacto.h"

@interface DetalleContacto : UITableViewController

@property (nonatomic,copy) Contacto *contacto;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UILabel *telefono;
@property (weak, nonatomic) IBOutlet UILabel *direccion;
@property (weak, nonatomic) IBOutlet UILabel *grupo;
@property (weak, nonatomic) IBOutlet UILabel *mail;
@property (weak, nonatomic) IBOutlet UILabel *twitter;
@property (weak, nonatomic) IBOutlet UILabel *facebook;
@property (weak, nonatomic) IBOutlet UILabel *whatsapp;

@end
