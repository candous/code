DROP DATABASE IF EXISTS genik;
CREATE DATABASE genik;

use genik;
CREATE TABLE gender (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE designation (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;


CREATE TABLE memberType (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE categorieExamens (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE mailType (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE relationshipStatus (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;



CREATE TABLE ICDchapters (
  id int(11) NOT NULL AUTO_INCREMENT,
  ICDRange varchar(20) NOT NULL, 
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE ICDSpecificChapter (
  id int(11) NOT NULL AUTO_INCREMENT,
  idICDChapter int(11) NOT NULL, 
  ICDRange varchar(20) NOT NULL, 
  description varchar(200) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idICDChapter) REFERENCES ICDchapters(id)
) ENGINE=InnoDB;

CREATE TABLE ICDDisease (
  id int(11) NOT NULL AUTO_INCREMENT,
  idSpecificChapter int(11) NOT NULL, 
  ICDClassNumber varchar(20) NOT NULL, 
  description varchar(200) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idSpecificChapter) REFERENCES ICDSpecificChapter(id)
) ENGINE=InnoDB;

CREATE TABLE Disease (
  id int(11) NOT NULL AUTO_INCREMENT,
  idICDDisease int(11) NOT NULL, 
  DiseaseICDNumber varchar(20) NOT NULL, 
  description varchar(200) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idICDDisease) REFERENCES ICDDisease(id)
) ENGINE=InnoDB;

/* */
/*DOCTORS */
CREATE TABLE Doctors (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(50) NOT NULL, 
  lastName varchar(50) NOT NULL, 
  CRM int(11) NOT NULL,
  birthday DATETIME NULL ,
  email varchar(50) NOT NULL,
  password varchar(200) NOT NULL,
  telephone int(11) NULL,
  mobile int(11) NULL,
  city varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  country varchar(50) NOT NULL,
  adress varchar(200) NOT NULL,
  URLPhoto varchar(200) NOT NULL,
  smsSchedule boolean NOT NULL,
  mailSchedule boolean NOT NULL,
  isOnline boolean NOT NULL,
  rightToSendSms boolean NOT NULL,
  rightToSendMail boolean NOT NULL,
  smsNotifications boolean NOT NULL,
  active boolean NOT NULL,
  SMScredits int(11) NOT NULL,
  lastLogIn	DATETIME NULL,
  designation int(11) NULL,
  gender int(11) NULL,
  memberType int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (designation) REFERENCES relationshipStatus(id),
  FOREIGN KEY (gender) REFERENCES gender(id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;


/*ADMINS*/

/*SECRETARY*/






CREATE TABLE insuranceCompany (
  id int(11) NOT NULL AUTO_INCREMENT,
  codeNom varchar(3) NOT NULL,
  nom varchar(200) NOT NULL,
  memberType int(11) NOT NULL,
  idMember int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;


/*PATIENTS*/
CREATE TABLE Patients (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(50) NOT NULL, 
  lastName varchar(50) NOT NULL, 
  birthday DATETIME NULL ,
  email varchar(50) NULL,
  telephone int(11) NULL,
  mobile int(11) NULL,
  city varchar(50) NULL,
  state varchar(50) NULL,
  country varchar(50) NULL,
  adress varchar(200) NULL,
  URLPhoto varchar(200) NOT NULL,
  smsBirthday boolean NOT NULL,
  mailBirthday boolean NOT NULL,
  smsAppointement boolean NOT NULL,
  mailAppointement boolean NOT NULL,
  id_relationshipStatus int(11) NULL,
  InsuranceCompany int(11) NOT NULL,
  gender int(11) NULL,
  memberType int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_relationshipStatus) REFERENCES designation(id),
  FOREIGN KEY (InsuranceCompany) REFERENCES insuranceCompany(id),
  FOREIGN KEY (gender) REFERENCES gender(id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;




