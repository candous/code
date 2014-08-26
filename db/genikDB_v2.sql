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


/*USERS : doctors+admins+secretaries*/
CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstName varchar(50) NOT NULL,
  lastName varchar(50) NOT NULL,
  CRM int(11) NULL,
  CPF int(11) NULL,
  birthday DATETIME NULL ,
  email varchar(50) NOT NULL,
  password varchar(200) NOT NULL,
  telephone int(11) NULL,
  mobile int(11) NULL,
  city varchar(50) NULL,
  state varchar(50) NULL,
  country varchar(50) NULL,
  adress varchar(200) NULL,
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

CREATE TABLE insuranceCompany (
  id int(11) NOT NULL AUTO_INCREMENT,
  codeNom varchar(3) NOT NULL,
  nom varchar(200) NOT NULL,
  idMember int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMember) REFERENCES users(id)
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



CREATE TABLE usersRelationship (
  idUser1 int(11) NOT NULL,
  idUser2 int(11) NOT NULL,
  PRIMARY KEY (idUser1, idUser2),
  FOREIGN KEY (idUser1) REFERENCES users(id),
  FOREIGN KEY (idUser2) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE patientDoctor (
  idPatient int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  PRIMARY KEY (idPatient, idDoctor),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE chat (
  id int(11) NOT NULL AUTO_INCREMENT,
  idMemberFrom int(11) NOT NULL,
  idMemberTo int(11) NOT NULL,
  msg LONGTEXT NOT NULL,
  dateMsg DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  unread boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMemberFrom) REFERENCES users(id),
  FOREIGN KEY (idMemberTo) REFERENCES users(id)
) ENGINE=InnoDB;


CREATE TABLE categorieExams (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  idMember int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMember) REFERENCES users(id)
) ENGINE=InnoDB;


CREATE TABLE listExams (
  id int(11) NOT NULL AUTO_INCREMENT,
  idMemberCreator int(11) NOT NULL,
  examName varchar(200) NOT NULL,
  examDescription LONGTEXT NULL,
  idCategorieExam int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMemberCreator) REFERENCES users(id),
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
  FOREIGN KEY (idDoctor) REFERENCES users(id),
  FOREIGN KEY (idPatient) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE commentsExam (
  id int(11) NOT NULL AUTO_INCREMENT,
  idExamPatient int(11) NULL,
  idDoctorFrom int(11) NULL,
  comment LONGTEXT NULL,
  dateComment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (idExamPatient) REFERENCES examsPatient(id),
  FOREIGN KEY (idDoctorFrom) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE imageExam (
  id int(11) NOT NULL AUTO_INCREMENT,
  idExamPatient int(11) NULL,
  title TEXT NULL,
  description LONGTEXT NULL,
  dateCreation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (idExamPatient) REFERENCES examsPatient(id)
) ENGINE=InnoDB;


CREATE TABLE commentsImageExam (
  id int(11) NOT NULL AUTO_INCREMENT,
  idImageExam int(11) NOT NULL,
  idDoctorFrom int(11) NOT NULL,
  comment LONGTEXT NULL,
  dateComment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (idImageExam) REFERENCES imageExam(id),
  FOREIGN KEY (idDoctorFrom) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE alergies (
  id int(11) NOT NULL AUTO_INCREMENT,
  product varchar(200) NOT NULL,
  description varchar(200) NULL,
  idMember int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMember) REFERENCES users(id)
) ENGINE=InnoDB;


CREATE TABLE alergiePatient (
  idAlergie int(11) NOT NULL,
  idPatient int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  comment varchar(200) NULL,
  PRIMARY KEY (idAlergie, idPatient),
  FOREIGN KEY (idAlergie) REFERENCES alergies(id),
  FOREIGN KEY (idPatient) REFERENCES users(id),
  FOREIGN KEY (idDoctor) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE favoriteICDs (
  id int(11) NOT NULL AUTO_INCREMENT,
  idDisease int(11) NOT NULL,
  idDoctor int(11) NOT NULL,
  comments varchar(200) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idDisease) REFERENCES disease(id),
  FOREIGN KEY (idDoctor) REFERENCES users(id)
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
  FOREIGN KEY (idDoctorDiagnosis) REFERENCES users(id)
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
  showedup boolean NOT NULL,
  patientArrived boolean NOT NULL,
  arrivalTime DATETIME NULL,
  unread boolean NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctor) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE procedures (
  id int(11) NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  description TEXT NULL,
  idMember	int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idMember) REFERENCES users(id),
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
  FOREIGN KEY (idPatient) REFERENCES patients(id),
  FOREIGN KEY (idDoctorDemand) REFERENCES users(id),
  FOREIGN KEY (idDoctorProcedure) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE commentsProcedure (
  id int(11) NOT NULL AUTO_INCREMENT,
  idProceduresPatient int(11) NOT NULL,
  idDoctorFrom int(11) NOT NULL,
  comment LONGTEXT NULL,
  dateComment DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (idProceduresPatient) REFERENCES proceduresPatient(id),
  FOREIGN KEY (idDoctorFrom) REFERENCES users(id)
) ENGINE=InnoDB;

/***************************ARRETE*******************************/

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

CREATE TABLE configurations (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  sendMailBirthday	boolean NOT NULL,
  sendSMSBirthday	boolean NOT NULL,
  daysBeforeSMSbirthday int(11) NOT NULL,
  daysBeforeMailBirthday int(11) NOT NULL,
  sendMailAppointConfirmation	boolean NOT NULL,
  sendSMSAppointConfirmation	boolean NOT NULL,
  daysBeforeSMSConfirmation int(11) NOT NULL,
  daysBeforeMailConfirmation int(11) NOT NULL,
  idMailConfirmationModel int(11) NOT NULL,
  idSmsConfirmationModel int(11) NOT NULL,
  idMailBirthdayModel int(11) NOT NULL,
  idSmsBirthdayModel int(11) NOT NULL,
  receiveSmsAppointments	boolean NOT NULL,
  idSmsAppointmentModel int(11) NOT NULL,
  dateEpiration	DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
  FOREIGN KEY (idMailConfirmationModel) REFERENCES mailModel(id),
  FOREIGN KEY (idSmsConfirmationModel) REFERENCES smsModel(id),
  FOREIGN KEY (idMailBirthdayModel) REFERENCES mailModel(id),
  FOREIGN KEY (idSmsBirthdayModel) REFERENCES smsModel(id),
  FOREIGN KEY (idSmsAppointmentModel) REFERENCES smsModel(id)
) ENGINE=InnoDB;


CREATE TABLE exercise (
  id int(11) NOT NULL AUTO_INCREMENT,
  description varchar(200) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE patientData (
  id int(11) NOT NULL AUTO_INCREMENT,
  memberType int(11) NOT NULL,
  idMember	int(11) NOT NULL,
  dateChange DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idDoctorModifiedHistory	int(11) NOT NULL,
  height int(11) NULL,
  weight double NULL,
  bloodPressureMax int(11) NULL,
  bloodPressureMin int(11) NULL,
  bloodSugar int(11) NULL,
  heartRate double NULL,
  temperature double NULL,
  drink boolean NULL,
  smoke boolean NULL,
  BMI double NULL,
  idExercise int(11) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (memberType) REFERENCES memberType(id),
  FOREIGN KEY (idDoctorModifiedHistory) REFERENCES doctors(id),
  FOREIGN KEY (idExercise) REFERENCES exercise(id)
) ENGINE=InnoDB;
