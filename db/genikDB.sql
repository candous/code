DROP DATABASE IF EXISTS genik;
CREATE DATABASE genik;

use genik;
CREATE TABLE gender (
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


