//
//  NuevoContacto.h
//  HayContacts
//
//  Created by alumno on 25/11/14.
//  Copyright (c) 2014 javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListaContactos;
@class Contacto;

@interface NuevoContacto : UITableViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)Contacto *contacto;
@property (strong,nonatomic) ListaContactos *listaContactos;

@property (nonatomic, strong)NSArray *datosPicker;
@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *apellidos;
@property (weak, nonatomic) IBOutlet UITextField *telefono;
@property (weak, nonatomic) IBOutlet UITextField *direccion;
@property (weak, nonatomic) IBOutlet UITextField *mail;
@property (weak, nonatomic) IBOutlet UITextField *twitter;
@property (weak, nonatomic) IBOutlet UITextField *facebook;
@property (weak, nonatomic) IBOutlet UIPickerView *grupo;
@property (weak, nonatomic) IBOutlet UISwitch *whatsapp;

- (IBAction)nuevaImagen:(UIButton *)sender;

@end
