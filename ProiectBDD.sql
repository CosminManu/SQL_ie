DROP TABLE SEDII CASCADE CONSTRAINTS;
DROP TABLE ANGAJATI CASCADE CONSTRAINTS;
DROP TABLE CLIENTI CASCADE CONSTRAINTS;
DROP TABLE CONTRACTE CASCADE CONSTRAINTS;
DROP TABLE MASINI CASCADE CONSTRAINTS;
DROP TABLE ASIGURARI CASCADE CONSTRAINTS;
DROP TABLE EVIDENTE_CONTABILE CASCADE CONSTRAINTS;

create table SEDII
(
    id_sediu    NUMBER(5),
    adresa      VARCHAR2(40),
    cod_postal  VARCHAR2(6),
    oras        VARCHAR2(30)
);

alter table SEDII add constraint SEDII_ID_SED_PK primary key (id_sediu);
alter table SEDII add constraint SEDII_ID_SED_CH check (id_sediu > 0);

create table ANGAJATI
(
    id_angajat     NUMBER(6) not null,
    prenume        VARCHAR2(20),
    nume           VARCHAR2(25),
    email          VARCHAR2(40),
    telefon        VARCHAR2(20),
    data_angajare  DATE,
    salariul       NUMBER(8,2),
    id_sediu       NUMBER(5)
);

alter table ANGAJATI add constraint ANGAJATI_ID_ANG_PK primary key (id_angajat);
alter table ANGAJATI add constraint ANGAJATI_ID_SED_FK foreign key (id_sediu) references SEDII(id_sediu);
alter table ANGAJATI add constraint ANGAJATI_EMAIL_TEL_UK unique (email, telefon);
alter table ANGAJATI add constraint ANGAJATI_ID_ANG_NN check (id_angajat is not null);
alter table ANGAJATI add constraint ANGAJATI_NUME_NN check (nume is not null);
alter table ANGAJATI add constraint ANGAJATI_PRENUME_NN check (prenume is not null);
alter table ANGAJATI add constraint ANGAJATI_SALARIUL_MIN check (salariul > 0);

create table EVIDENTE_CONTABILE
(
    id_evidenta  NUMBER(5) not null,
    venituri     NUMBER(8,2),
    cheltuieli   NUMBER(8,2),
    sold_final   NUMBER(8,2),
    id_sediu     NUMBER(5)
);

alter table EVIDENTE_CONTABILE add constraint EVIDENTE_ID_EVID_PK primary key (id_evidenta);
alter table EVIDENTE_CONTABILE add constraint EVIDENTE_ID_SED_FK foreign key (id_sediu) references SEDII(id_sediu);
alter table EVIDENTE_CONTABILE add constraint EVIDENTE_ID_EVID_NN check(id_evidenta is not null);
alter table EVIDENTE_CONTABILE add constraint EVIDENTE_VENIT_CH check(venituri > 0);

create table ASIGURARI
(
    id_asigurare        VARCHAR2(6) not null,
    tip_asigurare       VARCHAR2(20),
    detalii_asigurare   VARCHAR2(40),
    pret                NUMBER(5,2)
);

alter table ASIGURARI add constraint ASIGURARI_ID_ASIG_PK primary key (id_asigurare);
alter table ASIGURARI add constraint ASIGURARI_ID_ASIG_NN check(id_asigurare is not null);
alter table ASIGURARI add constraint ASIGURARI_PRET_CH check (pret > 0);

create table MASINI
(
    id_masina       NUMBER(3) not null,
    marca           VARCHAR2(30),
    tip             VARCHAR2(20),
    nr_scaune       NUMBER(1),
    nr_usi          NUMBER(1),
    consum          VARCHAR2(10),
    transmisie      CHAR(1),
    nr_kilometri    NUMBER(6),
    status          VARCHAR2(20),
    id_sediu        NUMBER(5),
    id_asigurare    VARCHAR2(6)
);
alter table MASINI add constraint MASINI_ID_MAS_PK primary key (id_masina);
alter table MASINI add constraint MASINI_ID_SED_FK foreign key (id_sediu) references SEDII(id_sediu);
alter table MASINI add constraint MASINI_ID_ASIG_FK foreign key (id_asigurare) references ASIGURARI(id_asigurare);
alter table MASINI add constraint MASINI_MARCA_NN check(marca is not null);
alter table MASINI add constraint MASINI_SCAUNE_CH check(nr_scaune > 0);
alter table MASINI add constraint MASINI_USI_CH check(nr_usi > 0);
alter table MASINI add constraint MASINI_KM_CH check(nr_kilometri > 0);
alter table MASINI add constraint MASINI_TRANSM_CH check(transmisie in ('A','M'));
alter table MASINI add constraint MASINI_CONSUM_CH check(consum in ('benzina','motorina','electric'));

create table CLIENTI
(
    id_client           NUMBER(6) not null,
    prenume_client      VARCHAR2(20),
    nume_client         VARCHAR2(20),
    telefon_client      VARCHAR2(20),
    email_client        VARCHAR2(30),
    data_nastere        DATE,
    tara_provenienta    VARCHAR2(20)
);

alter table CLIENTI add constraint CLIENTI_ID_CLI_PK primary key (id_client);
alter table CLIENTI add constraint CLIENTI_ID_CLI_NN check (id_client is not null);
alter table CLIENTI add constraint CLIENTI_EMAIL_TEL_UK unique (email_client, telefon_client);
alter table CLIENTI add constraint CLIENTI_DATA_NAS_NN check(data_nastere is not null);

create table CONTRACTE
(
    id_contract         VARCHAR2(10) not null,
    pret                NUMBER(8,2),
    cantitate           NUMBER(2),
    data_preluarii      DATE,
    data_aducerii       DATE,
    locatia_preluarii   VARCHAR2(40),
    perioada            NUMBER(2),
    id_masina           NUMBER(3),
    id_client           NUMBER(6)
);

alter table CONTRACTE add constraint CONTRACTE_ID_CON_PK primary key (id_contract);
alter table CONTRACTE add constraint CONTRACTE_ID_MAS_FK foreign key (id_masina) references MASINI(id_masina);
alter table CONTRACTE add constraint CONTRACTE_ID_CLI_FK foreign key (id_client) references CLIENTI(id_client);
alter table CONTRACTE add constraint CONTRACTE_ID_CON_NN check(id_contract is not null);
alter table CONTRACTE add constraint CONTRACTE_DATA_PREL_NN check(data_preluarii is not null);
alter table CONTRACTE add constraint CONTRACTE_DATA_ADUC_NN check(data_aducerii is not null);
alter table CONTRACTE add constraint CONTRACTE_DATA_CH check(data_aducerii > data_preluarii);
alter table CONTRACTE add constraint CONTRACTE_PRET_CH check (pret > 0);


insert into SEDII (id_sediu, adresa, cod_postal, oras)
    values(1101, 'Calea Bucurestilor Nr. 224 E', '040223', 'Otopeni');
insert into SEDII (id_sediu, adresa, cod_postal, oras)
    values(1102, 'Bd. Nicolae Balcescu 4', '060551', 'Bucuresti');
insert into SEDII (id_sediu, adresa, cod_postal, oras)
    values(1103, 'Bd. Theodor Pallady nr. 51', '060533', 'Bucuresti');
insert into SEDII (id_sediu, adresa, cod_postal, oras)
    values(1104, 'Calea Constructorilo nr 20', '070422', 'Bucuresti');
insert into SEDII (id_sediu, adresa, cod_postal, oras)
    values(1105, 'Sos De Centura Nr. 41', '070530', 'Chiajna');
commit;

insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(101,'Cosmin-Mihai','Manu','manucosmin@yahoo.com','0770 857 788',to_date('01-01-2016', 'dd-mm-yyyy'), 2800, 1103);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(102,'Maria','Teodorescu','marteodor@yahoo.com','0721 197 628',to_date('15-02-2016', 'dd-mm-yyyy'), 2500, 1103);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(103,'Teodora','Petrovici','tpetrov@yahoo.ro','0733 800 707',to_date('23-02-2016', 'dd-mm-yyyy'), 2400, 1103);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(104,'Alexandru','Ion','ialex13@gmail.com','0745 212 688',to_date('08-01-2017', 'dd-mm-yyyy'), 2300, 1103);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(105,'Catalin','Glavan','glavan.catalin@europcar.ro','0771 298 422',to_date('28-10-2018', 'dd-mm-yyyy'), 2200, 1103);

insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(110,'Daniel','Gavrila','dani.gav@yahoo.com','0722 844 701',to_date('20-08-2020', 'dd-mm-yyyy'), 1900, 1101);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(111,'Dinu','Costache','din.costache@gmail.com','0721 220 221',to_date('14-09-2020', 'dd-mm-yyyy'), 1900, 1101);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(112,'Radu','Puscas','radu.pus@yahoo.ro','0721 101 887',to_date('10-03-2019', 'dd-mm-yyyy'), 2100, 1101);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(113,'Mihail','Vasilescu','mih.vasil@gmail.com','0722 320 678',to_date('30-11-2018', 'dd-mm-yyyy'), 2000, 1101);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(114,'Ana','Comanescu','ana.coman@yahoo.ro','0745 442 393',to_date('14-05-2019', 'dd-mm-yyyy'), 1600, 1101);

insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(120,'Andreea','Pacuraru','andreea.pac@yahoo.com','0721 244 159',to_date('20-02-2017', 'dd-mm-yyyy'), 1800, 1102);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(121,'Ion','Amariei','a.ion@gmail.ro','0733 220 929',to_date('08-08-2017', 'dd-mm-yyyy'), 2000, 1102);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(122,'Radu','Georgian','radu.geo@yahoo.ro','0733 101 442',to_date('08-01-2021', 'dd-mm-yyyy'), 2300, 1102);

insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(140,'Ioana','Voda','ioana98@yahoo.com','0721 258 176',to_date('06-01-2021', 'dd-mm-yyyy'), 2000, 1104);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(141,'Alexandru','Lovinar','alexx@gmail.ro','0733 758 330',to_date('06-01-2021', 'dd-mm-yyyy'), 2300, 1104);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(142,'George','Bancu','george.bancu@yahoo.ro','0777 200 492',to_date('22-11-2020', 'dd-mm-yyyy'), 2000, 1104);

insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(150,'Pavel','Cezar','pav.cezaru@yahoo.com','0711 223 106',to_date('12-03-2019', 'dd-mm-yyyy'), 1800, 1105);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(151,'Alexandru','Branescu','bran.alex@yahoo.ro','0733 999 881',to_date('14-04-2019', 'dd-mm-yyyy'), 2400, 1105);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(152,'Maria','Branescu','bran.maria@yahoo.ro','0733 112 880',to_date('22-05-2019', 'dd-mm-yyyy'), 2400, 1105);
insert into ANGAJATI (id_angajat,prenume,nume,email,telefon,data_angajare,salariul,id_sediu)
    values(153,'Ioana','Comnat','ioa.comnat@yahoo.ro','0744 337 746',to_date('01-05-2019', 'dd-mm-yyyy'), 2200, 1105);
commit;

insert into EVIDENTE_CONTABILE (id_evidenta,venituri,cheltuieli,sold_final,id_sediu)
    values(99018,16800,14500,2300,1101);
insert into EVIDENTE_CONTABILE (id_evidenta,venituri,cheltuieli,sold_final,id_sediu)
    values(99026,10000,9400,600,1102);
insert into EVIDENTE_CONTABILE (id_evidenta,venituri,cheltuieli,sold_final,id_sediu)
    values(99033,20000,15000,5000,1103);
insert into EVIDENTE_CONTABILE (id_evidenta,venituri,cheltuieli,sold_final,id_sediu)
    values(99046,8000,7000,1000,1104);
insert into EVIDENTE_CONTABILE (id_evidenta,venituri,cheltuieli,sold_final,id_sediu)
    values(99051,8000,9800,-1800,1105);
commit;

insert into ASIGURARI (id_asigurare,tip_asigurare,detalii_asigurare,pret)
    values('AM101','Standard','Protectie in caz de accident',700.20);
insert into ASIGURARI (id_asigurare,tip_asigurare,detalii_asigurare,pret)
    values('AM211','Plus+','Standard si protectie in caz de furt',800.20);
insert into ASIGURARI (id_asigurare,tip_asigurare,detalii_asigurare,pret)
    values('AM330','EcoPlus','Plus+ si asistenta rutiera extinsa',900.20);
commit;

insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(700,'Volkswagen Up!','Masina mica',4,5,'electric','M',3000,'neinchiriata',1101,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(701,'Volkswagen Polo','Masina mica',5,5,'motorina','M',4000,'neinchiriata',1101,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(702,'Volkswagen Golf','Masina medie',5,5,'benzina','M',2000,'inchiriata',null,'AM211');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(703,'Ford Fiesta','Masina medie',5,5,'benzina','A',4200,'inchiriata',null,'AM211');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(704,'Dacia Duster 4x4','Masina medie',5,5,'benzina','M',3000,'neinchiriata',1103,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(705,'Dacia Logan MCV','Masina medie',5,5,'motorina','M',3000,'neinchiriata',1104,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(706,'Ford Mondeo Automatic','Masina medie',5,4,'motorina','A',2500,'inchiriata',null,'AM330');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(707,'Ford Fiesta','Masina medie',5,5,'benzina','M',3000,'neinchiriata',1103,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(708,'Dacia Duster 4x4','Masina medie',5,5,'motorina','M',1000,'neinchiriata',1102,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(709,'Volkswagen Tiguan 4x4','Masina medie',5,5,'motorina','M',2600,'neinchiriata',1101,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(710,'Opel Corsa','Masina mica',5,4,'benzina','M',2500,'inchiriata',null,'AM211');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(711,'Opel Corsa','Masina mica',5,4,'benzina','M',2700,'neinchiriata',1102,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(712,'Opel Corsa','Masina mica',5,4,'motorina','M',3000,'inchiriata',null,'AM330');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(713,'Volkswagen Transporter Diesel','Masina mare',9,5,'motorina','M',4100,'neinchiriata',1105,'AM101');
insert into MASINI (id_masina,marca,tip,nr_scaune,nr_usi,consum,transmisie,nr_kilometri,status,id_sediu,id_asigurare)
    values(714,'Volkswagen Transporter Diesel','Masina mare',9,5,'motorina','M',4200,'neinchiriata',1105,'AM101');
commit;

insert into CLIENTI(id_client,prenume_client,nume_client,telefon_client,email_client,data_nastere,tara_provenienta)
    values(400,'James','Marlow','650.124.7234','jamesatkin@yahoo.com', to_date('16-02-1988', 'dd-mm-yyyy'),'USA');
insert into CLIENTI(id_client,prenume_client,nume_client,telefon_client,email_client,data_nastere,tara_provenienta)
    values(401,'Curtis','McPharell','233.111.7234','curtis123@yahoo.com', to_date('11-07-1973', 'dd-mm-yyyy'),'Ireland');
insert into CLIENTI(id_client,prenume_client,nume_client,telefon_client,email_client,data_nastere,tara_provenienta)
    values(402,'Peter','Schmidt','0162.124.8831','schmidtpeter80@gmail.com', to_date('23-06-1980', 'dd-mm-yyyy'),'Germany');
insert into CLIENTI(id_client,prenume_client,nume_client,telefon_client,email_client,data_nastere,tara_provenienta)
    values(403,'Gonzales','Alejo','144.723.8803','alejo99@yahoo.com', to_date('31-07-1978', 'dd-mm-yyyy'),'Spain');
commit;

insert into CONTRACTE (id_contract,pret,cantitate,data_preluarii,data_aducerii,locatia_preluarii,perioada,id_masina,id_client)
    values('CON01',1069.2,1,to_date('15-03-2021', 'dd-mm-yyyy'),to_date('20-03-2021', 'dd-mm-yyyy'),'Calea Bucurestilor Nr. 224 E',5,702,400);
insert into CONTRACTE (id_contract,pret,cantitate,data_preluarii,data_aducerii,locatia_preluarii,perioada,id_masina,id_client)
    values('CON02',826.2,1,to_date('20-12-2020', 'dd-mm-yyyy'),to_date('25-12-2020', 'dd-mm-yyyy'),'Bd. Nicolae Balcescu 4',5,703,401);

insert into CONTRACTE (id_contract,pret,cantitate,data_preluarii,data_aducerii,locatia_preluarii,perioada,id_masina,id_client)
    values('CON03',1500.68,1,to_date('14-08-2020', 'dd-mm-yyyy'),to_date('28-08-2020', 'dd-mm-yyyy'),'Bd. Nicolae Balcescu 4',14,710,402);

insert into CONTRACTE (id_contract,pret,cantitate,data_preluarii,data_aducerii,locatia_preluarii,perioada,id_masina,id_client)
    values('CON04',1800.68,1,to_date('14-08-2020', 'dd-mm-yyyy'),to_date('28-08-2020', 'dd-mm-yyyy'),'Bd. Nicolae Balcescu 4',14,712,402);

insert into CONTRACTE (id_contract,pret,cantitate,data_preluarii,data_aducerii,locatia_preluarii,perioada,id_masina,id_client)
    values('CON05',1600.46,1,to_date('08-03-2019', 'dd-mm-yyyy'),to_date('18-03-2019', 'dd-mm-yyyy'),'Calea Constructorilo nr 20',10,706,403);
commit;
