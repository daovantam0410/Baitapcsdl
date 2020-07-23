drop database if exists CsdlSPJ;
create database CsdlSPJ;
use CsdlSPJ;

create table NCC(
  MaNCC		char(10),
  Ten			varchar(30),
  Heso			int,
  ThPho		varchar(20),
  constraint NCC_PK primary key (MaNCC)
);

create table VATTU (
  MaVT		 char(10),
  Ten			varchar(50),
  Mau			varchar(30),
  TrLuong	float,
  ThPho		varchar(20),
  constraint VATTU_PK primary key (MaVT)
);

create table DUAN (
  MaDA     char(10),
  Ten			varchar(30),
  ThPho		varchar(20),
  constraint DUAN_PK primary key (MaDA)
);

create table CUNGCAP (
  MaNCC     char(10),
  MaVT      char(10),
  MaDA			char(10),
  SLuong		int,
  constraint CUNGCAP_PK primary key (MaNCC, MaVT, MaDA),
  constraint CUNGCAP_FK_NCC foreign key (MaNCC) references NCC (MaNCC),
  constraint CUNGCAP_FK_VATTU foreign key (MaVT) references VATTU (MaVT),
  constraint CUNGCAP_FK_DUAN foreign key (MaDA) references DUAN (MaDA)
);

-- chen du lieu moi vao bang NCC
insert into NCC values ('S1', 'Son', 20, 'TpHCM');
insert into NCC values ('S2', 'Tran', 10, 'Ha Noi');
insert into NCC values ('S3', 'Bach', 30, 'Ha Noi');
insert into NCC values ('S4', 'Lap', 20, 'TpHCM');
insert into NCC values ('S5', 'Anh', 30, 'Da Nang');

-- chen du lieu moi vao bang VATTU
insert into VATTU values ('P1', 'Dai oc', 'Do', 12., 'TpHCM');
insert into VATTU values ('P2', 'Bu long', 'Xanh la', 17., 'Ha Noi');
insert into VATTU values ('P3', 'Dinh vit', 'Xanh duong', 17., 'Hai Phong');
insert into VATTU values ('P4', 'Dinh vit', 'Do', 14., 'TpHCM');
insert into VATTU values ('P5', 'Cam', 'Xanh duong', 12., 'Ha Noi');
insert into VATTU values ('P6', 'Banh rang', 'Do', 19., 'TpHCM');

-- chen du lieu moi vao bang DUAN
insert into DUAN values ('J1', 'May phan loai', 'Ha Noi');
insert into DUAN values ('J2', 'Man hinh', 'Viet Tri');
insert into DUAN values ('J3', 'OCR', 'Da Nang');
insert into DUAN values ('J4', 'Bang dieu khien', 'Da Nang');
insert into DUAN values ('J5', 'RAID', 'TpHCM');
insert into DUAN values ('J6', 'EDS', 'Hai Phong');
insert into DUAN values ('J7', 'Bang tu', 'TpHCM');

-- chen du lieu moi vao bang CUNGCAP
insert into CUNGCAP values ('S1', 'P1', 'J1', 200);
insert into CUNGCAP values ('S1', 'P1', 'J4', 700);
insert into CUNGCAP values ('S2', 'P3', 'J1', 400);
insert into CUNGCAP values ('S2', 'P3', 'J2', 200);
insert into CUNGCAP values ('S2', 'P3', 'J3', 200);
insert into CUNGCAP values ('S2', 'P3', 'J4', 500);
insert into CUNGCAP values ('S2', 'P3', 'J5', 600);
insert into CUNGCAP values ('S2', 'P3', 'J6', 400);
insert into CUNGCAP values ('S2', 'P3', 'J7', 800);
insert into CUNGCAP values ('S2', 'P5', 'J2', 200);
insert into CUNGCAP values ('S3', 'P3', 'J1', 200);
insert into CUNGCAP values ('S3', 'P4', 'J2', 500);
insert into CUNGCAP values ('S4', 'P6', 'J3', 300);
insert into CUNGCAP values ('S4', 'P6', 'J7', 300);
insert into CUNGCAP values ('S5', 'P2', 'J2', 200);
insert into CUNGCAP values ('S5', 'P2', 'J4', 100);
insert into CUNGCAP values ('S5', 'P5', 'J5', 500);
insert into CUNGCAP values ('S5', 'P5', 'J7', 100);
insert into CUNGCAP values ('S5', 'P6', 'J2', 200);
insert into CUNGCAP values ('S5', 'P1', 'J4', 100);
insert into CUNGCAP values ('S5', 'P3', 'J4', 200);
insert into CUNGCAP values ('S5', 'P4', 'J4', 800);
insert into CUNGCAP values ('S5', 'P5', 'J4', 400);
insert into CUNGCAP values ('S5', 'P6', 'J4', 500);