//
//  Contact.h
//  HayContacts
//
//  Created by alumno on 17/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contacto : NSObject

@property (nonatomic) NSString *nombre;
@property (nonatomic) NSString *apellidos;
@property (nonatomic) UIImage *imagenContacto;
@property (nonatomic) NSNumber *telefono;
@property (nonatomic) NSString *grupo;
@property (nonatomic) NSString *direccion;
@property (nonatomic) NSString *mail;
@property (nonatomic) NSString *twitter;
@property (nonatomic) NSString *facebook;
@property (nonatomic) BOOL whatsapp;

-(id)initWithNombre:(NSString*)nombre apellidos:(NSString*)apellidos telefono:(NSNumber*)telefono;

@end
