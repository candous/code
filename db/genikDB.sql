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



CREATE TABLE ICDChapter (
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
  FOREIGN KEY (idICDChapter) REFERENCES ICDChapter(id)
) ENGINE=InnoDB;

CREATE TABLE ICDDisease (
  id int(11) NOT NULL AUTO_INCREMENT,
  idSpecificChapter int(11) NOT NULL, 
  ICDClassNumber varchar(20) NOT NULL, 
  description varchar(200) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idSpecificChapter) REFERENCES ICDSpecificChapter(id)
) ENGINE=InnoDB;

CREATE TABLE disease (
  id int(11) NOT NULL AUTO_INCREMENT,
  idICDDisease int(11) NOT NULL, 
  DiseaseICDNumber varchar(20) NOT NULL, 
  description varchar(200) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idICDDisease) REFERENCES ICDDisease(id)
) ENGINE=InnoDB;

/* */
/*DOCTORS */
CREATE TABLE doctors (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(50) NOT NULL, 
  lastName varchar(50) NOT NULL, 
  CRM int(11) NOT NULL,
  CPF int(11) NULL,
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
CREATE TABLE admins (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(50) NOT NULL, 
  lastName varchar(50) NOT NULL, 
  CPF int(11) NOT NULL,
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
  isOnline boolean NOT NULL,
  rightToSendSms boolean NOT NULL,
  rightToSendMail boolean NOT NULL,
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
	
/*SECRETARY*/
CREATE TABLE secretaries (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(50) NOT NULL, 
  lastName varchar(50) NOT NULL, 
  CPF int(11) NULL,
  birthday DATETIME NULL,
  email varchar(50) NOT NULL,
  password varchar(200) NOT NULL,
  telephone int(11) NULL,
  mobile int(11) NULL,
  city varchar(50) NULL,
  state varchar(50) NULL,
  country varchar(50) NULL,
  adress varchar(200) NULL,
  URLPhoto varchar(200) NOT NULL,
  isOnline boolean NOT NULL,
  rightToSendSms boolean NOT NULL,
  rightToSendMail boolean NOT NULL,
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
CREATE TABLE patients (
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



CREATE TABLE adminSecretary (
  idAdmin int(11) NOT NULL,
  idSecretary int(11) NOT NULL,
  PRIMARY KEY (idAdmin, idSecretary),
  FOREIGN KEY (idAdmin) REFERENCES admins(id),
  FOREIGN KEY (idSecretary) REFERENCES secretaries(id)
) ENGINE=InnoDB;

CREATE TABLE adminAdmin (
  idAdmin int(11) NOT NULL,
  idAdmin2 int(11) NOT NULL,
  PRIMARY KEY (idAdmin, idAdmin2),
  FOREIGN KEY (idAdmin) REFERENCES admins(id),
  FOREIGN KEY (idAdmin2) REFERENCES admins(id)
) ENGINE=InnoDB;

CREATE TABLE adminDoctor (
  idAdmin int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  PRIMARY KEY (idAdmin, idDoctor),
  FOREIGN KEY (idAdmin) REFERENCES admins(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE secretaryDoctor (
  idSecretary int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  PRIMARY KEY (idSecretary, idDoctor),
  FOREIGN KEY (idSecretary) REFERENCES secretaries(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE patientDoctor (
  idPatient int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  PRIMARY KEY (idPatient, idDoctor),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE chat (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberTypeFrom int(11) NOT NULL,
  idMemberFrom int(11) NOT NULL,
  memberTypeTo int(11) NOT NULL,
  idMemberTo int(11) NOT NULL,
  msg LONGTEXT NOT NULL,
  dateMsg DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  unread boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberTypeFrom) REFERENCES memberType(id),
  FOREIGN KEY (memberTypeTo) REFERENCES memberType(id)
) ENGINE=InnoDB;


CREATE TABLE categorieExams (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  memberType int(11) NOT NULL,
  idMember int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;


CREATE TABLE listExams (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberTypeCreator int(11) NOT NULL,
  idMemberCreator int(11) NULL,
  examName varchar(200) NOT NULL,
  examDescription LONGTEXT NOT NULL,
  idCategorieExam int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberTypeCreator) REFERENCES memberType(id),
  FOREIGN KEY (idCategorieExam) REFERENCES categorieExams(id)
) ENGINE=InnoDB;



CREATE TABLE examsPatient (
  id int(11) NOT NULL AUTO_INCREMENT,
  idExam int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  idPatient int(11) NOT NULL,
  observation LONGTEXT NOT NULL,
  dateExam DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (id),
  FOREIGN KEY (idExam) REFERENCES listExams(id),
  FOREIGN KEY (idPatient) REFERENCES patients(id)
) ENGINE=InnoDB;

CREATE TABLE commentsExam (
  id int(11) NOT NULL AUTO_INCREMENT,
  idExamPatient int(11) NULL,
  idDoctorFrom int(11) NULL,
  comment LONGTEXT NULL,
  dateComment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (id),
  FOREIGN KEY (idExamPatient) REFERENCES examsPatient(id),
  FOREIGN KEY (idDoctorFrom) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE imageExam (
  id int(11) NOT NULL AUTO_INCREMENT,
  idExamPatient int(11) NULL,
  title TEXT NULL,
  Description LONGTEXT NULL,
  dateCreation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (id),
  FOREIGN KEY (idExamPatient) REFERENCES examsPatient(id)
) ENGINE=InnoDB;

CREATE TABLE commentsImageExam (
  id int(11) NOT NULL AUTO_INCREMENT,
  idimageExam int(11) NOT NULL,
  idDoctorFrom int(11) NOT NULL,
  comment LONGTEXT NULL,
  dateComment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (id),
  FOREIGN KEY (idimageExam) REFERENCES imageExam(id),
  FOREIGN KEY (idDoctorFrom) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE alergies (
  id int(11) NOT NULL AUTO_INCREMENT,
  product varchar(200) NOT NULL,
  description varchar(200) NULL,
  memberType int(11) NOT NULL,
  idMember int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;


CREATE TABLE alergiePatient (
  idAlergie int(11) NOT NULL,
  idPatient int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  comment varchar(200) NULL,
  PRIMARY KEY (idAlergie, idPatient),
  FOREIGN KEY (idAlergie) REFERENCES alergies(id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE favoriteICDs (
  id int(11) NOT NULL AUTO_INCREMENT,
  idDisease int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  comments varchar(200) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idDisease) REFERENCES disease(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE patientConditions (
  id int(11) NOT NULL AUTO_INCREMENT,
  idDisease int(11) NOT NULL,
  idPatient int(11) NOT NULL,
  idDoctorDiagnosis int(11) NULL,
  comments LONGTEXT NULL,
  dateDiagnosis NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (idDisease) REFERENCES disease(id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctorDiagnosis) REFERENCES doctors(id)
) ENGINE=InnoDB;


CREATE TABLE appointments (
  id int(11) NOT NULL AUTO_INCREMENT,
  dateAppointment DATETIME NOT NULL,
  idPatient int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  comments LONGTEXT NULL,
  confirmed	boolean NOT NULL,
  smsSent boolean NOT NULL,
  mailSent boolean NOT NULL,
  called boolean NOT NULL,
  showup boolean NOT NULL,
  patientArrived boolean NOT NULL,
  arrivalTime DATETIME NULL,
  unread boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE procedures (
  id int(11) NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  description TEXT NULL,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
) ENGINE=InnoDB;

CREATE TABLE proceduresPatient (
  id int(11) NOT NULL AUTO_INCREMENT,
  idProcedure int(11) NOT NULL,
  idPatient int(11) NOT NULL,
  idDoctorDemand int(11) NOT NULL,
  idDoctorProcedure int(11) NOT NULL,
  dateProcedure DATETIME NOT NULL,
  observations LONGTEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
) ENGINE=InnoDB;

CREATE TABLE commentsProcedure (
  id int(11) NOT NULL AUTO_INCREMENT,
  idProceduresPatient int(11) NOT NULL,
  idDoctorFrom int(11) NOT NULL,
  comment LONGTEXT NULL,
  dateComment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (id),
  FOREIGN KEY (idProceduresPatient) REFERENCES proceduresPatient(id),
  FOREIGN KEY (idDoctorFrom) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE medication (
  id int(11) NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  description TEXT NULL,
  posology TEXT NULL,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;

CREATE TABLE medicationDose (
  id int(11) NOT NULL AUTO_INCREMENT,
  idMedication int(11) NOT NULL,
  dose	TEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMedication) REFERENCES medication(id)
) ENGINE=InnoDB;

CREATE TABLE medicationPatient (
  idMedication int(11) NOT NULL,
  idPatient int(11) NOT NULL,
  idMedDose	int(11) NOT NULL,
  PRIMARY KEY (idMedication, idPatient, idMedDose),
  FOREIGN KEY (idMedication) REFERENCES medication(id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idMedDose) REFERENCES medicationDose(id)
) ENGINE=InnoDB;

CREATE TABLE precription (
  id int(11) NOT NULL AUTO_INCREMENT,
  idPatient int(11) NOT NULL,
  idDoctor	int(11) NOT NULL,
  datePrecription DATETIME NOT NULL,
  observations TEXT NOT NULL;
  PRIMARY KEY (id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE prescriptionsModel (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  modelName TEXT NOT NULL,
  observations LONGTEXT NOT NULL,
  comments TEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;

CREATE TABLE statement (
  id int(11) NOT NULL AUTO_INCREMENT,
  idPatient int(11) NOT NULL,
  idDoctor	int(11) NOT NULL,
  observations LONGTEXT NOT NULL,
  comments TEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES doctors(id)
) ENGINE=InnoDB;

CREATE TABLE statementModel (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  modelName TEXT NOT NULL,
  observations LONGTEXT NOT NULL,
  comments TEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;


CREATE TABLE smsModel (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  modelName TEXT NOT NULL,
  msg LONGTEXT NOT NULL,
  comments TEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;

CREATE TABLE mailModel (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  idMailType int(11) NOT NULL,
  modelName TEXT NOT NULL,
  msg LONGTEXT NOT NULL,
  comments TEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
  FOREIGN KEY (idMailType) REFERENCES mailType(id)
) ENGINE=InnoDB;

CREATE TABLE mailHistory (
  id int(11) NOT NULL AUTO_INCREMENT,
  toAddress TEXT NOT NULL,
  memberTypeFrom int(11) NOT NULL,
  idMemberFrom	int(11) NOT NULL,
  idMailType int(11) NOT NULL,
  subject TEXT NOT NULL,
  msg LONGTEXT NOT NULL,
  dateSent DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  sent boolean NOT NULL,
  read boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberTypeFrom) REFERENCES memberType(id),
  FOREIGN KEY (idMailType) REFERENCES mailType(id)
) ENGINE=InnoDB;

CREATE TABLE smsHistory (
  id int(11) NOT NULL AUTO_INCREMENT,
  toPhone int(11) NOT NULL,
  memberTypeFrom int(11) NOT NULL,
  idMemberFrom	int(11) NOT NULL,
  msg LONGTEXT NOT NULL,
  dateSent DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  sent boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberTypeFrom) REFERENCES memberType(id)
) ENGINE=InnoDB;


CREATE TABLE loginsLog (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  dateLogin DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  success boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;



CREATE TABLE insurancesDoctor (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  idInsuranceCompany int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
  FOREIGN KEY (idInsuranceCompany) REFERENCES insuranceCompany(id)
) ENGINE=InnoDB;


CREATE TABLE evolutionPatient (
  id int(11) NOT NULL AUTO_INCREMENT,
  idPatient int(11) NOT NULL,
  idDoctor	int(11) NOT NULL,
  evolutionName TEXT NULL,
  observations LONGTEXT NOT NULL,
  dateEvolution DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
  FOREIGN KEY (idInsuranceCompany) REFERENCES insuranceCompany(id)
) ENGINE=InnoDB;


CREATE TABLE evolutionModel (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  modelName TEXT NOT NULL,
  msg LONGTEXT NOT NULL,
  comments TEXT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id)
) ENGINE=InnoDB;





