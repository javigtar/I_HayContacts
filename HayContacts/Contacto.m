//
//  Contact.m
//  HayContacts
//
//  Created by alumno on 17/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "Contacto.h"

@implementation Contacto

-(id)initWithNombre:(NSString*)nombre apellidos:(NSString*)apellidos telefono:(NSNumber*)telefono{
    self = [super init];
    _nombre = nombre;
    _apellidos = apellidos;
    _telefono = telefono;
    _imagenContacto = [UIImage imageNamed:@"contacto.png"];
    _grupo = @" ";
    _direccion = @" ";
    _mail = @" ";
    _twitter = @" ";
    _facebook = @" ";
    _whatsapp = FALSE;
    
    return self;
}

@end
