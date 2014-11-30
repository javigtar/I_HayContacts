//
//  ListaContactos.m
//  HayContacts
//
//  Created by alumno on 17/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "ListaContactos.h"
#import "Contacto.h"

@interface ListaContactos ()

-(void)cargarContactos;

@end

@implementation ListaContactos

-(id)init{
    self = [super init];
    [self cargarContactos];
    return self;
}

-(void)cargarContactos{
    
    self.contactos = [[NSMutableOrderedSet alloc] init];
    
    Contacto *contacto = [[Contacto alloc] initWithNombre:@"Isabel" apellidos:@"Mateos" telefono:@6874125963];
    contacto.imagenContacto = [UIImage imageNamed:contacto.nombre];
    contacto.grupo = @"Amigos";
    contacto.direccion = @"Calle Gran Vía 53, Madrid";
    contacto.mail = @"isabelm@gmail.com";
    contacto.twitter = @"@lapechotes";
    contacto.facebook = @"https://www.facebook.com/imateos";
    contacto.whatsapp = NO;
    
    Contacto *contacto2 = [[Contacto alloc] initWithNombre:@"Nicolas" apellidos:@"El Pequeño" telefono:@845751698];
    contacto2.imagenContacto = [UIImage imageNamed:contacto2.nombre];
    contacto2.grupo = @"Otros";
    contacto2.direccion = @"Avda. Puerta de Hierro s/n, Madrid";
    contacto2.mail = @"nicolas@gmail.com";
    contacto2.twitter = @"@littlenicky";
    contacto2.facebook = @"https://www.facebook.com/nicolas";
    contacto2.whatsapp = YES;
    
    [self.contactos addObject:contacto];
    [self.contactos addObject:contacto2];
    
}

//Añade un contacto a la colección
-(void)addContacto:(Contacto *)contacto{
    
    [self.contactos addObject:contacto];
    
}

//Devuelve el número de contactos de la colección
-(NSUInteger)numeroDeContactos{
    
    return [self.contactos count];
    
}

//Devuelve el contacto de la colección en la posición pasada como parámetro
-(Contacto*)contactoSegunIndice:(NSInteger)indiceContacto{
    
    return [self.contactos objectAtIndex:indiceContacto];
    
}

@end
