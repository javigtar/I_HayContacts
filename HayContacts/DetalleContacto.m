//
//  DetalleContacto.m
//  HayContacts
//
//  Created by alumno on 19/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import "DetalleContacto.h"
#import "Contacto.h"
#import "NuevoContacto.h"
#import "FotoContacto.h"

@interface DetalleContacto ()

@end

@implementation DetalleContacto

-(void)setContacto:(Contacto *)nuevoContacto{
    if(_contacto != nuevoContacto){
        _contacto = nuevoContacto;
        
        [self mostrarDetalle];
    }
}

- (void)viewDidLoad {
   [super viewDidLoad];
    
    [self mostrarDetalle];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Rellena los campos con el detalle del contacto
-(void)mostrarDetalle{
    
    Contacto *contacto = self.contacto;
    
    if (contacto) {
        NSString *nombreCompleto = [[NSString alloc] initWithFormat:@"%@ %@", self.contacto.nombre, self.contacto.apellidos];
        self.nombre.text = nombreCompleto;
        self.imagen.image = self.contacto.imagenContacto;
        self.telefono.text = [self.contacto.telefono stringValue];
        self.direccion.text = self.contacto.direccion;
        self.grupo.text = self.contacto.grupo;
        self.mail.text = self.contacto.mail;
        self.twitter.text = self.contacto.twitter;
        self.facebook.text = self.contacto.facebook;
        [self.whatsapp setOn:self.contacto.whatsapp];
        //Imagen del contacto redondeada
        self.imagen.layer.cornerRadius = 40;
        self.imagen.clipsToBounds = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 8;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {    
    
    //Muestra la escena FotoContacto pasandole el nombre de la foto del contacto
    if ([[segue identifier] isEqualToString:@"FotoContacto"]) {
        
        FotoContacto *mostrarFoto = [segue destinationViewController];
        
        mostrarFoto.nombreFoto = self.contacto.nombre;
    }
}

- (IBAction)volver:(UIStoryboardSegue *)segue{
    
}

@end
