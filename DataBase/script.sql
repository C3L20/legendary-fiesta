CREATE DATABASE bd30;
use bd30;
create table persona(
rut varchar(13) not null,
nombres varchar(100) not null,
apellidos varchar(100) not null,
telefono varchar(12) not null,
foto TINYTEXT not null,
prevision varchar(30) not null,
fecha_nacimiento DATE not null,
primary key (rut)
);

create table estado(
codigo_estado int(2) not null,
glosa varchar(20) not null,
primary key (codigo_estado)
);

create table tipo_de_usuario(
codigo_tip_usa int(2) not null,
glosa varchar(20) not null,
primary key (codigo_tip_usa)
);

create table usuario(
correo varchar(100) not null,
rut varchar(13) not null,
contrasena varchar(30) not null,
estado ENUM('ACTIVO', 'SUPRIMIDO', 'BLOQUEADO', 'INACTIVO') not null,
codigo_tip_usa integer(2) not null,
codigo_estado integer(2) not null,
primary key (correo),
foreign key(rut) references persona(rut)
on update cascade
on delete cascade,
foreign key(codigo_tip_usa) references tipo_de_usuario(codigo_tip_usa)
on update cascade
on delete cascade,
foreign key(codigo_estado) references estado(codigo_estado)
on update cascade
on delete cascade
);

create table direccion(
id_direccion integer auto_increment,
rut varchar(13) not null,
localidad varchar(50) not null,
numero int(11) not null,
poblacion varchar(100) not null,
calle varchar(100) not null,
primary key (id_direccion),
foreign key(rut) references persona(rut)
on update cascade
on delete cascade
);

create table ficha_clinica(
historial varchar(100) not null,
rut varchar(13) not null,
fecha DATE not null,
primary key (fecha),
foreign key(rut) references persona(rut)
on update cascade
on delete cascade
);

create table ficha_nutricional(
rut varchar(13) not null,
fecha DATE not null,
actividad_laboral int(45) not null,
actividad_fisica varchar(45) not null,
hrs_fisica_semanal int(3) not null,
consumo_alcohol boolean not null,
cant_alcohol_semanal int(3) not null,
habito_tabaco boolean not null,
cant_tabaco_semana int(3) not null,
antecedentes_morbidos varchar(45) not null,
otras_patologias varchar(45) not null,
peso int(3) not null,
talla int(3) not null,
imc int(3) not null,
pitri float not null,
pibi float not null,
pisb float not null,
pisc float not null,
porcentaje_grasa float not null,
gmb float not null,
tiempo_de_comida int(3) not null,
peso_ideal int(2) not null,
alimentos_porciones varchar(100) not null,
primary key (fecha),
foreign key(rut) references persona(rut)
on update cascade
on delete cascade
);

create table ficha_psicologica(
rut varchar(13) not null,
fecha DATE not null,
descripcion TEXT not null,
primary key (fecha),
foreign key(rut) references persona(rut)
on update cascade
on delete cascade
);

create table area(
id_area integer auto_increment,
area varchar(45) not null,
primary key (id_area)
);

create table especialidad(
id_especialidad integer auto_increment,
especialidad varchar(30) not null,
id_area int(3) not null,
primary key (id_especialidad),
foreign key(id_area) references area(id_area)
on update cascade
on delete cascade
);

create table sala(
num_sala int(3) not null,
ubicacion varchar(45) not null,
primary key (num_sala)
);

create table profesional(
rut_p varchar(13) not null,
nombre varchar(30) not null,
correo varchar(30) not null,
fono varchar(12) not null,
num_sala int(3) not null,
primary key (rut_p),
foreign key(num_sala) references sala(num_sala)
on update cascade
on delete cascade
);

create table pro_espec(
id_especialidad int(3) not null,
rut_p varchar(13) not null,
foreign key(rut_p) references profesional(rut_p)
on update cascade
on delete cascade,
foreign key(id_especialidad) references especialidad(id_especialidad)
on update cascade
on delete cascade
);

create table hora_medica(
id_hora integer auto_increment,
disponibilidad ENUM("Disponible","Ocupado") default not null,
fecha_hora datetime not null,
rut_p varchar(13) not null,
primary key (id_hora),
foreign key(rut_p) references profesional(rut_p)
on update cascade
on delete cascade
);

create table comprobante_de_hora(
id_comprobante integer auto_increment,
respuesta varchar(150) not null,
id_hora integer(3) not null,
primary key (id_comprobante),
foreign key(id_hora) references hora_medica(id_hora)
on update cascade
on delete cascade
);

create table solicita(
id_solicitud integer auto_increment,
motivo varchar(45) not null,
rut varchar(13) not null,
id_hora int(3) not null,
primary key (id_solicitud),
foreign key(rut) references persona(rut)
on update cascade
on delete cascade,
foreign key(id_hora) references hora_medica(id_hora)
on update cascade
on delete cascade
);

ALTER TABLE hora_medica CHANGE disponibilidad disponibilidad ENUM('Disponible','Reservado') NOT NULL DEFAULT 'Disponible';