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
    
    Contacto *contacto = [[Contacto alloc] initWithParams:@"Javi" apellidos:@"Garcia" telefono:@902548139];
    Contacto *contacto2 = [[Contacto alloc] initWithParams:@"Nicolas" apellidos:@"El Pequeño" telefono:@845751698];
    contacto2.imagenContacto = [UIImage imageNamed:@"nicolas.jpg"];
    
    [self.contactos addObject:contacto];
    [self.contactos addObject:contacto2];
    
}

-(void)addContacto:(Contacto *)contacto{
    
    [self.contactos addObject:contacto];
    
}

-(NSUInteger)numeroDeContactos{
    
    return [self.contactos count];
    
}

-(Contacto*)contactoSegunIndice:(NSInteger)indiceContacto{
    
    return [self.contactos objectAtIndex:indiceContacto];
    
}


@end
