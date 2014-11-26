//
//  ListaContactos.h
//  HayContacts
//
//  Created by alumno on 17/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Contacto;

@interface ListaContactos : NSObject

@property (nonatomic) NSMutableOrderedSet* contactos;

-(void) addContacto:(Contacto*) contacto;
-(NSUInteger) numeroDeContactos;
-(Contacto*) contactoSegunIndice:(NSInteger) indiceContacto;

@end
