USE emmet;
--
-- Table structure for table `mobile_user`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE IF NOT EXISTS `mobile_user` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `auth_key`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE  IF NOT EXISTS `auth_key` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `auth_key` varchar(255) NOT NULL,
  `mobile_user_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK5563974818294D56` (`mobile_user_id`),
  CONSTRAINT `FK5563974818294D56` FOREIGN KEY (`mobile_user_id`) REFERENCES `mobile_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `authorised_system`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE  IF NOT EXISTS `authorised_system` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` bigint(20) NOT NULL,
  `host` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `authorities`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE IF NOT EXISTS `authorities` (
  `userid` int(11) NOT NULL,
  `authority` varchar(30) NOT NULL,
  PRIMARY KEY  (`userid`,`authority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `c3p0TestTable`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE IF NOT EXISTS `c3p0TestTable` (
  `a` char(1) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `identities`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE IF NOT EXISTS `identities` (
  `userid` int(11) NOT NULL,
  `identityuri` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  PRIMARY KEY  (`userid`,`identityuri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `passwords`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
SET sql_mode = '';
CREATE TABLE IF NOT EXISTS `passwords` (
  `userid` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `expiry` timestamp NOT NULL default '0000-00-00 00:00:00',
  `status` varchar(10) NOT NULL,
  PRIMARY KEY  (`userid`,`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `profiles`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE  IF NOT EXISTS `profiles` (
  `userid` int(11) NOT NULL,
  `property` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY  (`userid`,`property`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `role`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE IF NOT EXISTS `role` (
  `role` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('ROLE_ABRS_ADMIN',''),('ROLE_ABRS_INSTITUTION',''),('ROLE_ADMIN','Admin role for ALA staff'),('ROLE_API_EDITOR','Enables a user to update the online web service API'),('ROLE_APPD_USER','APPD user'),('ROLE_AVH_ADMIN',''),('ROLE_AVH_CLUB',''),('ROLE_COLLECTION_ADMIN',''),('ROLE_COLLECTION_EDITOR',''),('ROLE_COLLECTORS_ADMIN',''),('ROLE_FC_ADMIN','Admin role for the Field Capture webapp'),('ROLE_FC_OFFICER','Field Capture officer role'),('ROLE_FC_READ_ONLY','Provides read only access to all projects in the field capture system.'),('ROLE_IMAGE_ADMIN',''),('ROLE_SPATIAL_ADMIN',''),('ROLE_SYSTEM_ADMIN',''),('ROLE_USER',''),('ROLE_VP_ADMIN',''),('ROLE_VP_TEST_ADMIN','The admin role for BVP Test server'),('ROLE_VP_VALIDATOR','');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE IF NOT EXISTS `user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` varchar(255) NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`),
  KEY `FK143BF46AF129182D` (`role_id`),
  CONSTRAINT `FK143BF46AF129182D` FOREIGN KEY (`role_id`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
SET sql_mode = '';
CREATE TABLE IF NOT EXISTS `users` (
  `userid` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `firstname` varchar(255) default NULL,
  `lastname` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `activated` char(1) NOT NULL,
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `expiry` timestamp NOT NULL default '0000-00-00 00:00:00',
  `locked` char(1) NOT NULL,
  `temp_auth_key` varchar(255) default NULL,
  PRIMARY KEY  (`userid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10649 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
