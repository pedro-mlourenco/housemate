drop database IF EXISTS housematedb;
create database housematedb;
use housematedb;
--
-- Defining table properties
--
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
)ENGINE=InnoDB;


DROP TABLE IF EXISTS `households`;
CREATE TABLE IF NOT EXISTS `households` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name`varchar(50) NOT NULL, 
  `description` varchar(255) NULL,
  `createdby` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_households_users` (`createdby`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `householdmembers`;
CREATE TABLE IF NOT EXISTS `householdmembers` (
  `userid` int NOT NULL,
  `householdid` int NOT NULL,
  `role` enum('admin','regular') NOT NULL DEFAULT ('regular'),
  CONSTRAINT `pk_householdmembers` PRIMARY KEY (`userid`,`householdid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NULL,
  `datetime`  DATETIME NOT NULL,
  `participants` JSON NULL,
  `createdby` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_events_users` (`createdby`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `pantry`;
CREATE TABLE IF NOT EXISTS `pantry`(
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `stock` int NOT NULL DEFAULT(0),
  `unit` enum('pcs','kg','g','liters','ml','pack','other') NOT NULL DEFAULT('other'),  
  `location` enum('fridge','freezer','pantry') NOT NULL DEFAULT('fridge'),
  `category` enum('dairy','vegetables','fruits','meat','grains','snacks','drinks','legumes','other') NOT NULL DEFAULT('other'),  
  `heldby` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

--
-- Defining contraints properties
--
ALTER TABLE `households`
  ADD CONSTRAINT `fk_households_users` FOREIGN KEY (`createdby`) REFERENCES `users` (`id`);


ALTER TABLE `householdmembers`
  ADD CONSTRAINT `fk_householdmembers_users` FOREIGN KEY (`userid`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_householdmembers_households` FOREIGN KEY (`householdid`) REFERENCES `households` (`id`);

ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_users` FOREIGN KEY (`createdby`) REFERENCES `users` (`id`);

ALTER TABLE `pantry`
  ADD CONSTRAINT `fk_household_pantry` FOREIGN KEY (`heldby`) REFERENCES `households` (`id`);