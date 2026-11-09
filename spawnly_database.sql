CREATE DATABASE  IF NOT EXISTS `spawnly` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `spawnly`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: spawnly
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `biomas`
--

DROP TABLE IF EXISTS `biomas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biomas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(30) NOT NULL,
  `nome` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_bioma_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biomas`
--

LOCK TABLES `biomas` WRITE;
/*!40000 ALTER TABLE `biomas` DISABLE KEYS */;
INSERT INTO `biomas` VALUES (1,'planicies','Planícies'),(2,'florestas','Florestas'),(3,'cherry_grove','Floresta de cerejeiras'),(4,'montanhas','Montanhas'),(5,'picos_nevados','Picos nevados'),(6,'desertos','Desertos'),(7,'savanas','Savanas'),(8,'selvas','Selvas'),(9,'pantanos','Pântanos'),(10,'manguezais','Manguezais'),(11,'taiga','Taiga'),(12,'taiga_nevada','Taiga nevada'),(13,'oceanos_ilhas','Oceanos e ilhas'),(14,'badlands','Badlands'),(15,'cogumelos','Campos de cogumelos'),(16,'raros','Biomas raros'),(17,'varios_proximos','Vários biomas próximos');
/*!40000 ALTER TABLE `biomas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(12) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `nome` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_categoria` (`tipo`,`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'terreno','montanhoso','Montanhas'),(2,'terreno','picos','Picos gigantes'),(3,'terreno','plano','Terreno plano'),(4,'terreno','ilha','Ilha isolada'),(5,'terreno','ilha_spawn','Spawn em ilha isolada'),(6,'terreno','vale','Vale'),(7,'terreno','lago','Lago'),(8,'terreno','rio','Rio próximo'),(9,'terreno','penhasco','Penhascos'),(10,'terreno','caverna_grande','Cavernas grandes'),(11,'terreno','agua','Próximo à água'),(12,'terreno','impressionante','Visualmente impressionante'),(13,'estilo','survival_tradicional','Survival tradicional'),(14,'estilo','survival_desafiador','Survival desafiador'),(15,'estilo','hardcore','Hardcore'),(16,'estilo','criativo','Criativo'),(17,'estilo','speedrun','Speedrun'),(18,'estilo','exploracao','Exploração'),(19,'estilo','construcao','Construção'),(20,'estilo','multiplayer_coop','Multiplayer cooperativo'),(21,'estilo','ilhas','Sobrevivência em ilhas'),(22,'estilo','cavernas','Exploração de cavernas'),(23,'construcao','grandes_planicies','Grandes construções em planícies'),(24,'construcao','bases_montanhosas','Bases montanhosas'),(25,'construcao','construcao_ilhas','Construção em ilhas'),(26,'construcao','proximo_agua','Construções próximas à água'),(27,'construcao','bases_subterraneas','Bases subterrâneas');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edicoes_versoes`
--

DROP TABLE IF EXISTS `edicoes_versoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edicoes_versoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `edicao` varchar(7) NOT NULL,
  `versao_texto` varchar(20) NOT NULL,
  `versao_min` varchar(12) NOT NULL,
  `versao_max` varchar(12) NOT NULL,
  `versao_min_num` int NOT NULL,
  `versao_max_num` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_edicao_versao` (`edicao`,`versao_texto`),
  CONSTRAINT `ck_edicao_versao_edicao` CHECK ((`edicao` in (_utf8mb4'Java',_utf8mb4'Bedrock',_utf8mb4'Ambas')))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edicoes_versoes`
--

LOCK TABLES `edicoes_versoes` WRITE;
/*!40000 ALTER TABLE `edicoes_versoes` DISABLE KEYS */;
INSERT INTO `edicoes_versoes` VALUES (1,'Ambas','1.21','1.21.0','1.21.99',1021000,1021099),(2,'Java','1.20-1.21','1.20.0','1.21.99',1020000,1021099),(3,'Bedrock','1.21.x','1.21.0','1.21.99',1021000,1021099),(4,'Java','1.21','1.21.0','1.21.99',1021000,1021099),(5,'Java','1.21.2','1.21.2','1.21.2',1021002,1021002),(6,'Java','1.21.4','1.21.4','1.21.4',1021004,1021004),(7,'Bedrock','1.21.4','1.21.4','1.21.4',1021004,1021004),(8,'Bedrock','1.21','1.21.0','1.21.99',1021000,1021099),(9,'Java','1.20-1.21.11','1.20.0','1.21.11',1020000,1021011),(10,'Java','1.21.5','1.21.5','1.21.5',1021005,1021005),(11,'Bedrock','1.20.6','1.20.6','1.20.6',1020006,1020006),(12,'Java','1.20.4','1.20.4','1.20.4',1020004,1020004),(13,'Java','26.3','26.3.0','26.3.99',26003000,26003099),(14,'Bedrock','26.51','26.51.0','26.51.99',26051000,26051099),(15,'Bedrock','1.20-1.21.11','1.20.0','1.21.11',1020000,1021011),(16,'Java','1.19-1.21.11','1.19.0','1.21.11',1019000,1021011),(17,'Bedrock','1.21.130','1.21.130','1.21.130',1021130,1021130),(18,'Bedrock','1.21.0','1.21.0','1.21.0',1021000,1021000);
/*!40000 ALTER TABLE `edicoes_versoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estruturas`
--

DROP TABLE IF EXISTS `estruturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estruturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(30) NOT NULL,
  `nome` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_estrutura_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estruturas`
--

LOCK TABLES `estruturas` WRITE;
/*!40000 ALTER TABLE `estruturas` DISABLE KEYS */;
INSERT INTO `estruturas` VALUES (1,'village','Vila'),(2,'trial_chambers','Trial Chambers'),(3,'ancient_city','Ancient City'),(4,'stronghold','Stronghold'),(5,'mansion','Woodland Mansion'),(6,'pillager_outpost','Pillager Outpost'),(7,'desert_temple','Desert Temple'),(8,'jungle_temple','Jungle Temple'),(9,'ocean_monument','Ocean Monument'),(10,'shipwreck','Shipwreck'),(11,'ruined_portal','Ruined Portal'),(12,'bastion','Bastion'),(13,'fortress','Nether Fortress'),(14,'mineshaft','Mineshaft'),(15,'ocean_ruins','Ocean Ruins'),(16,'buried_treasure','Tesouro enterrado');
/*!40000 ALTER TABLE `estruturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fontes`
--

DROP TABLE IF EXISTS `fontes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fontes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `dominio` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_fonte_url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fontes`
--

LOCK TABLES `fontes` WRITE;
/*!40000 ALTER TABLE `fontes` DISABLE KEYS */;
INSERT INTO `fontes` VALUES (1,'https://xgamingserver.com/blog/best-minecraft-cherry-grove-seeds/','xgamingserver.com'),(2,'https://www.exitlag.com/blog/game-seeds-for-minecraft','www.exitlag.com'),(3,'https://gurugamer.com/pc-console/15-best-cherry-biome-seeds-for-minecraft-1-21-22340','gurugamer.com'),(4,'https://blog.berrybyte.net/5-minecraft-cherry-blossom-seeds-location-coordinates-1-21/','blog.berrybyte.net'),(5,'https://www.minecraft-guides.com/seeds/1-21/cherry-blossom/','www.minecraft-guides.com'),(6,'https://xgamingserver.com/blog/best-minecraft-village-seeds/','xgamingserver.com'),(7,'https://thespike.gg/minecraft/best-seeds/best-minecraft-seeds-for-survival','thespike.gg'),(8,'https://stealthygaming.com/?p=34578','stealthygaming.com'),(9,'https://www.pcgamesn.com/minecraft/30-best-minecraft-seeds','www.pcgamesn.com'),(10,'https://gurugamer.com/pc-console/20-best-desert-seeds-for-suspicious-sand-in-minecraft-1-21-21814/amp','gurugamer.com'),(11,'https://xgamingserver.com/blog/best-minecraft-ancient-city-seeds/','xgamingserver.com'),(12,'https://beebom.com/best-minecraft-1-21-seeds','beebom.com'),(13,'https://twinfinite.net/guides/minecraft-best-tricky-trials-1-21-seeds','twinfinite.net'),(14,'https://beebom.com/best-trial-chambers-minecraft-seeds','beebom.com'),(15,'https://www.sportskeeda.com/minecraft/best-minecraft-ancient-city-seeds','www.sportskeeda.com'),(16,'https://www.sportskeeda.com/minecraft/best-minecraft-trial-chamber-seeds','www.sportskeeda.com'),(17,'https://www.craftmc.net/minecraft-seeds/trial-chambers','www.craftmc.net'),(18,'https://www.craftmc.net/minecraft-seeds/ancient-city','www.craftmc.net'),(19,'https://xgamingserver.com/blog/best-minecraft-speedrun-seeds/','xgamingserver.com'),(20,'https://wisehosting.com/minecraft-seeds/a-lakeside-village-with-a-ruined-portal','wisehosting.com'),(21,'https://www.minecraft-guides.com/seeds/1-21/speedrun/','www.minecraft-guides.com'),(22,'https://www.minecraft-guides.com/seeds/1-21/mountain/','www.minecraft-guides.com'),(23,'https://wisehosting.com/minecraft-seeds/several-massive-jagged-peaks-mountains','wisehosting.com'),(24,'https://wisehosting.com/minecraft-seeds/wide-jagged-peaks-mountain','wisehosting.com'),(25,'https://wisehosting.com/minecraft-seeds/huge-wide-flat-hill-with-several-other-rolling-hills-and-a-lake','wisehosting.com'),(26,'https://www.minecraft-guides.com/seeds/1-21/mansion/','www.minecraft-guides.com'),(27,'https://wisehosting.com/minecraft-seeds/a-woodland-mansion-and-village-caldera','wisehosting.com'),(28,'https://wisehosting.com/minecraft-seeds/skyscraper-woodland-mansion','wisehosting.com'),(29,'https://wisehosting.com/minecraft-seeds/woodland-mansion-island','wisehosting.com'),(30,'https://progameguides.com/minecraft/luckiest-minecraft-seeds/','progameguides.com'),(31,'https://craftlands.host/blogs/best-minecraft-seeds-for-bedrock-1-21-130','craftlands.host'),(32,'https://gurugamer.com/pc-console/minecraft-woodland-mansion-seeds-18562/amp','gurugamer.com'),(33,'https://www.minecraft-guides.com/seeds/1-21/desert/','www.minecraft-guides.com'),(34,'https://progameguides.com/minecraft/minecraft-bedrock-seeds','progameguides.com'),(35,'https://progameguides.com/minecraft/minecraft-best-seeds','progameguides.com'),(36,'https://xgamingserver.com/blog/best-minecraft-mushroom-island-seeds/','xgamingserver.com'),(37,'https://stealthygaming.com/?p=34440','stealthygaming.com'),(38,'https://www.minecraft-guides.com/seeds/1-21/building/','www.minecraft-guides.com');
/*!40000 ALTER TABLE `fontes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preferencias_usuarios`
--

DROP TABLE IF EXISTS `preferencias_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preferencias_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `dimensao` varchar(12) NOT NULL,
  `valor` varchar(30) NOT NULL,
  `peso` int NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `fk_preferencias_usuarios_usuarios` (`usuario_id`),
  CONSTRAINT `fk_preferencias_usuarios_usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_preferencias_peso` CHECK ((`peso` between 1 and 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preferencias_usuarios`
--

LOCK TABLES `preferencias_usuarios` WRITE;
/*!40000 ALTER TABLE `preferencias_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `preferencias_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seed_biomas`
--

DROP TABLE IF EXISTS `seed_biomas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seed_biomas` (
  `seed_id` int NOT NULL,
  `bioma_id` int NOT NULL,
  PRIMARY KEY (`seed_id`,`bioma_id`),
  KEY `fk_seed_biomas_biomas` (`bioma_id`),
  CONSTRAINT `fk_seed_biomas_biomas` FOREIGN KEY (`bioma_id`) REFERENCES `biomas` (`id`),
  CONSTRAINT `fk_seed_biomas_seeds` FOREIGN KEY (`seed_id`) REFERENCES `seeds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seed_biomas`
--

LOCK TABLES `seed_biomas` WRITE;
/*!40000 ALTER TABLE `seed_biomas` DISABLE KEYS */;
INSERT INTO `seed_biomas` VALUES (1,1),(2,1),(8,1),(19,1),(28,1),(46,1),(48,1),(49,1),(53,1),(55,1),(61,1),(88,1),(89,1),(8,2),(9,2),(23,2),(30,2),(32,2),(39,2),(40,2),(44,2),(50,2),(51,2),(52,2),(61,2),(62,2),(66,2),(76,2),(88,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(63,3),(2,4),(8,4),(56,4),(58,4),(59,4),(60,4),(63,4),(65,4),(8,5),(58,5),(59,5),(60,5),(63,5),(65,5),(11,6),(12,6),(14,6),(22,6),(29,6),(45,6),(72,6),(73,6),(74,6),(75,6),(76,6),(78,6),(9,7),(10,7),(18,7),(65,7),(9,8),(31,8),(68,8),(73,8),(79,8),(80,8),(81,8),(13,9),(16,9),(21,9),(10,10),(17,11),(21,11),(47,11),(54,11),(57,11),(61,11),(87,11),(88,11),(21,12),(28,12),(49,12),(11,13),(12,13),(14,13),(15,13),(17,13),(20,13),(22,13),(25,13),(35,13),(37,13),(38,13),(41,13),(64,13),(65,13),(78,13),(79,13),(80,13),(81,13),(82,13),(83,13),(84,13),(85,13),(86,13),(87,13),(72,14),(73,14),(77,14),(30,15),(80,15),(81,15),(82,15),(83,15),(84,15),(85,15),(86,15),(30,16),(44,16),(68,16),(80,16),(81,16),(82,16),(83,16),(84,16),(85,16),(86,16),(8,17),(9,17);
/*!40000 ALTER TABLE `seed_biomas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seed_categorias`
--

DROP TABLE IF EXISTS `seed_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seed_categorias` (
  `seed_id` int NOT NULL,
  `categoria_id` int NOT NULL,
  `origem` varchar(8) NOT NULL,
  PRIMARY KEY (`seed_id`,`categoria_id`),
  KEY `fk_seed_categorias_categorias` (`categoria_id`),
  CONSTRAINT `fk_seed_categorias_categorias` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  CONSTRAINT `fk_seed_categorias_seeds` FOREIGN KEY (`seed_id`) REFERENCES `seeds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_seed_categorias_origem` CHECK ((`origem` in (_utf8mb4'fonte',_utf8mb4'derivada')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seed_categorias`
--

LOCK TABLES `seed_categorias` WRITE;
/*!40000 ALTER TABLE `seed_categorias` DISABLE KEYS */;
INSERT INTO `seed_categorias` VALUES (3,6,'fonte'),(4,7,'fonte'),(4,16,'derivada'),(4,19,'derivada'),(4,26,'derivada'),(5,6,'fonte'),(5,20,'derivada'),(8,1,'fonte'),(8,14,'derivada'),(8,16,'derivada'),(8,18,'derivada'),(8,19,'derivada'),(8,24,'derivada'),(9,14,'derivada'),(11,11,'fonte'),(11,16,'derivada'),(11,19,'derivada'),(11,26,'derivada'),(12,11,'fonte'),(12,16,'derivada'),(12,19,'derivada'),(12,26,'derivada'),(14,4,'fonte'),(14,10,'fonte'),(14,16,'derivada'),(14,19,'derivada'),(14,21,'derivada'),(14,22,'derivada'),(14,25,'derivada'),(14,27,'derivada'),(15,11,'fonte'),(15,16,'derivada'),(15,19,'derivada'),(15,26,'derivada'),(17,4,'fonte'),(17,16,'derivada'),(17,19,'derivada'),(17,21,'derivada'),(17,25,'derivada'),(18,12,'fonte'),(18,16,'derivada'),(18,18,'derivada'),(18,19,'derivada'),(19,3,'fonte'),(19,16,'derivada'),(19,19,'derivada'),(19,23,'derivada'),(20,18,'derivada'),(21,8,'fonte'),(21,14,'derivada'),(22,4,'fonte'),(22,16,'derivada'),(22,19,'derivada'),(22,21,'derivada'),(22,25,'derivada'),(24,18,'derivada'),(25,9,'fonte'),(26,14,'derivada'),(30,4,'fonte'),(30,16,'derivada'),(30,19,'derivada'),(30,21,'derivada'),(30,25,'derivada'),(33,14,'derivada'),(35,4,'fonte'),(35,16,'derivada'),(35,19,'derivada'),(35,21,'derivada'),(35,25,'derivada'),(37,4,'fonte'),(37,16,'derivada'),(37,19,'derivada'),(37,21,'derivada'),(37,25,'derivada'),(38,4,'fonte'),(38,5,'fonte'),(38,14,'derivada'),(38,16,'derivada'),(38,18,'derivada'),(38,19,'derivada'),(38,21,'derivada'),(38,25,'derivada'),(41,4,'fonte'),(41,5,'fonte'),(41,9,'fonte'),(41,14,'derivada'),(41,16,'derivada'),(41,19,'derivada'),(41,21,'derivada'),(41,25,'derivada'),(46,13,'derivada'),(46,15,'derivada'),(46,17,'derivada'),(46,18,'derivada'),(47,13,'derivada'),(47,15,'derivada'),(47,17,'derivada'),(47,18,'derivada'),(48,13,'derivada'),(48,15,'derivada'),(48,17,'derivada'),(48,18,'derivada'),(49,13,'derivada'),(49,15,'derivada'),(49,17,'derivada'),(49,18,'derivada'),(50,13,'derivada'),(50,15,'derivada'),(50,17,'derivada'),(50,18,'derivada'),(51,13,'derivada'),(51,15,'derivada'),(51,17,'derivada'),(51,18,'derivada'),(52,13,'derivada'),(52,15,'derivada'),(52,17,'derivada'),(52,18,'derivada'),(53,7,'fonte'),(53,16,'derivada'),(53,19,'derivada'),(53,26,'derivada'),(55,13,'derivada'),(55,15,'derivada'),(56,1,'fonte'),(56,14,'derivada'),(56,16,'derivada'),(56,19,'derivada'),(56,24,'derivada'),(57,13,'derivada'),(57,15,'derivada'),(58,1,'fonte'),(58,2,'fonte'),(58,14,'derivada'),(58,16,'derivada'),(58,19,'derivada'),(58,24,'derivada'),(59,1,'fonte'),(59,2,'fonte'),(59,16,'derivada'),(59,19,'derivada'),(59,24,'derivada'),(60,1,'fonte'),(60,2,'fonte'),(60,16,'derivada'),(60,19,'derivada'),(60,24,'derivada'),(61,3,'fonte'),(61,7,'fonte'),(61,16,'derivada'),(61,19,'derivada'),(61,20,'derivada'),(61,23,'derivada'),(61,26,'derivada'),(62,18,'derivada'),(63,1,'fonte'),(63,12,'fonte'),(63,16,'derivada'),(63,18,'derivada'),(63,19,'derivada'),(63,24,'derivada'),(64,12,'fonte'),(64,16,'derivada'),(64,19,'derivada'),(65,4,'fonte'),(65,16,'derivada'),(65,19,'derivada'),(65,21,'derivada'),(65,25,'derivada'),(69,18,'derivada'),(70,18,'derivada'),(71,14,'derivada'),(74,13,'derivada'),(74,15,'derivada'),(77,10,'fonte'),(77,16,'derivada'),(77,19,'derivada'),(77,22,'derivada'),(77,27,'derivada'),(78,11,'fonte'),(78,16,'derivada'),(78,19,'derivada'),(78,26,'derivada'),(79,4,'fonte'),(79,5,'fonte'),(79,14,'derivada'),(79,16,'derivada'),(79,19,'derivada'),(79,21,'derivada'),(79,25,'derivada'),(80,11,'fonte'),(80,16,'derivada'),(80,19,'derivada'),(80,26,'derivada'),(81,11,'fonte'),(81,16,'derivada'),(81,19,'derivada'),(81,26,'derivada'),(82,4,'fonte'),(82,16,'derivada'),(82,19,'derivada'),(82,21,'derivada'),(82,25,'derivada'),(83,4,'fonte'),(83,16,'derivada'),(83,19,'derivada'),(83,21,'derivada'),(83,25,'derivada'),(84,4,'fonte'),(84,16,'derivada'),(84,19,'derivada'),(84,21,'derivada'),(84,25,'derivada'),(85,4,'fonte'),(85,16,'derivada'),(85,19,'derivada'),(85,21,'derivada'),(85,25,'derivada'),(86,4,'fonte'),(86,10,'fonte'),(86,16,'derivada'),(86,19,'derivada'),(86,21,'derivada'),(86,22,'derivada'),(86,25,'derivada'),(86,27,'derivada'),(87,4,'fonte'),(87,5,'fonte'),(87,14,'derivada'),(87,16,'derivada'),(87,19,'derivada'),(87,21,'derivada'),(87,25,'derivada'),(88,3,'fonte'),(88,16,'derivada'),(88,19,'derivada'),(88,23,'derivada'),(89,18,'derivada');
/*!40000 ALTER TABLE `seed_categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seed_estruturas`
--

DROP TABLE IF EXISTS `seed_estruturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seed_estruturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seed_id` int NOT NULL,
  `estrutura_id` int NOT NULL,
  `dist_spawn` int DEFAULT NULL,
  `coord_x` int DEFAULT NULL,
  `coord_z` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seed_estruturas_seeds` (`seed_id`),
  KEY `fk_seed_estruturas_estruturas` (`estrutura_id`),
  CONSTRAINT `fk_seed_estruturas_estruturas` FOREIGN KEY (`estrutura_id`) REFERENCES `estruturas` (`id`),
  CONSTRAINT `fk_seed_estruturas_seeds` FOREIGN KEY (`seed_id`) REFERENCES `seeds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seed_estruturas`
--

LOCK TABLES `seed_estruturas` WRITE;
/*!40000 ALTER TABLE `seed_estruturas` DISABLE KEYS */;
INSERT INTO `seed_estruturas` VALUES (1,1,1,NULL,NULL,NULL),(2,1,2,NULL,NULL,NULL),(3,2,6,NULL,NULL,NULL),(4,3,1,NULL,NULL,NULL),(5,4,1,NULL,NULL,NULL),(6,5,1,NULL,NULL,NULL),(7,5,1,NULL,NULL,NULL),(8,6,1,NULL,192,48),(9,8,11,229,224,48),(10,8,3,231,128,192),(11,8,1,279,272,64),(12,8,4,1426,-238,-1406),(13,9,1,429,NULL,NULL),(14,10,1,NULL,NULL,NULL),(15,11,1,NULL,NULL,NULL),(16,11,11,NULL,NULL,NULL),(17,12,1,NULL,NULL,NULL),(18,13,1,NULL,NULL,NULL),(19,14,1,NULL,NULL,NULL),(20,15,10,NULL,NULL,NULL),(21,16,16,NULL,NULL,NULL),(22,17,1,NULL,-304,0),(23,18,1,NULL,NULL,NULL),(24,18,10,NULL,NULL,NULL),(25,18,16,NULL,NULL,NULL),(26,18,11,NULL,NULL,NULL),(27,18,14,NULL,NULL,NULL),(28,19,1,NULL,NULL,NULL),(29,19,2,NULL,NULL,NULL),(30,20,1,NULL,NULL,NULL),(31,20,11,NULL,NULL,NULL),(32,20,2,NULL,NULL,NULL),(33,20,15,NULL,NULL,NULL),(34,21,1,368,0,-368),(35,21,11,NULL,85,-264),(36,22,7,NULL,-504,616),(37,22,15,NULL,-504,472),(38,23,3,NULL,128,-240),(39,23,2,NULL,NULL,NULL),(40,24,6,NULL,NULL,NULL),(41,24,1,NULL,NULL,NULL),(42,24,3,NULL,NULL,NULL),(43,25,3,NULL,-603,166),(44,26,3,0,NULL,NULL),(45,26,1,NULL,19,-7),(46,27,3,NULL,NULL,NULL),(47,27,3,NULL,NULL,NULL),(48,28,3,NULL,-328,8),(49,28,3,NULL,-1048,600),(50,28,2,NULL,NULL,NULL),(51,29,2,NULL,340,820),(52,29,3,NULL,480,820),(53,30,2,NULL,1961,295),(54,31,2,NULL,NULL,NULL),(55,31,2,NULL,NULL,NULL),(56,31,2,NULL,NULL,NULL),(57,31,2,NULL,NULL,NULL),(58,32,2,345,7,345),(59,33,3,0,NULL,NULL),(60,34,3,NULL,NULL,NULL),(61,36,2,NULL,NULL,NULL),(62,37,2,NULL,NULL,NULL),(63,38,5,NULL,NULL,NULL),(64,38,1,NULL,NULL,NULL),(65,38,2,NULL,NULL,NULL),(66,39,2,NULL,NULL,NULL),(67,39,3,NULL,NULL,NULL),(68,41,2,NULL,NULL,NULL),(69,41,3,NULL,NULL,NULL),(70,42,2,NULL,NULL,NULL),(71,43,3,NULL,NULL,NULL),(72,44,3,NULL,NULL,NULL),(73,45,7,NULL,NULL,NULL),(74,45,2,NULL,NULL,NULL),(75,46,11,0,NULL,NULL),(76,46,1,160,NULL,NULL),(77,46,2,192,NULL,NULL),(78,47,11,0,0,0),(79,47,1,80,NULL,NULL),(80,47,2,227,NULL,NULL),(81,48,11,0,NULL,NULL),(82,48,1,107,NULL,NULL),(83,48,2,170,NULL,NULL),(84,49,11,0,NULL,NULL),(85,49,1,71,NULL,NULL),(86,49,2,128,NULL,NULL),(87,50,11,0,NULL,NULL),(88,50,15,71,NULL,NULL),(89,50,1,97,NULL,NULL),(90,51,11,0,NULL,NULL),(91,51,2,176,NULL,NULL),(92,51,1,192,NULL,NULL),(93,52,11,0,NULL,NULL),(94,52,1,158,NULL,NULL),(95,52,15,240,NULL,NULL),(96,53,1,NULL,NULL,NULL),(97,53,11,NULL,NULL,NULL),(98,54,11,51,NULL,NULL),(99,55,1,129,NULL,NULL),(100,56,1,210,NULL,NULL),(101,57,1,58,NULL,NULL),(102,58,1,580,NULL,NULL),(103,58,3,96,NULL,NULL),(104,61,1,NULL,-304,-176),(105,61,1,NULL,-432,16),(106,61,1,NULL,-768,176),(107,61,1,NULL,687,-144),(108,61,1,NULL,160,-768),(109,61,4,NULL,-444,-1484),(110,62,11,86,80,32),(111,62,5,173,96,144),(112,62,2,253,80,-240),(113,63,5,NULL,NULL,NULL),(114,63,1,NULL,-185,575),(115,63,1,NULL,152,112),(116,63,6,NULL,-480,-224),(117,63,3,NULL,40,216),(118,64,5,NULL,-666,261),(119,64,1,NULL,1216,-944),(120,65,5,NULL,192,146),(121,65,1,NULL,NULL,NULL),(122,66,5,NULL,200,150),(123,66,16,NULL,9,121),(124,67,5,NULL,NULL,NULL),(125,67,1,NULL,NULL,NULL),(126,68,5,NULL,NULL,NULL),(127,69,5,NULL,NULL,NULL),(128,69,1,NULL,NULL,NULL),(129,69,6,NULL,NULL,NULL),(130,70,5,NULL,500,540),(131,70,5,NULL,1500,670),(132,70,8,NULL,695,40),(133,70,14,NULL,700,200),(134,71,5,0,NULL,NULL),(135,72,7,97,96,0),(136,72,2,193,176,96),(137,73,7,NULL,344,-456),(138,74,1,0,NULL,NULL),(139,74,7,NULL,NULL,NULL),(140,75,1,NULL,NULL,NULL),(141,75,7,NULL,NULL,NULL),(142,76,7,NULL,120,88),(143,78,1,NULL,NULL,NULL),(144,78,6,NULL,NULL,NULL),(145,79,8,NULL,NULL,NULL),(146,87,1,NULL,NULL,NULL),(147,88,2,205,128,160),(148,89,1,NULL,NULL,NULL),(149,89,11,NULL,NULL,NULL),(150,89,2,NULL,NULL,NULL),(151,90,13,NULL,13,27),(152,90,12,NULL,25,-119);
/*!40000 ALTER TABLE `seed_estruturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seed_recursos`
--

DROP TABLE IF EXISTS `seed_recursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seed_recursos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seed_id` int NOT NULL,
  `recurso` varchar(40) NOT NULL,
  `evidencia` varchar(12) NOT NULL DEFAULT 'desconhecido',
  PRIMARY KEY (`id`),
  KEY `fk_seed_recursos_seeds` (`seed_id`),
  CONSTRAINT `fk_seed_recursos_seeds` FOREIGN KEY (`seed_id`) REFERENCES `seeds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_seed_recursos_evidencia` CHECK ((`evidencia` in (_utf8mb4'comprovado',_utf8mb4'estimado',_utf8mb4'desconhecido')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seed_recursos`
--

LOCK TABLES `seed_recursos` WRITE;
/*!40000 ALTER TABLE `seed_recursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `seed_recursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seeds`
--

DROP TABLE IF EXISTS `seeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` bigint NOT NULL,
  `nome` varchar(120) NOT NULL,
  `edicao_versao_id` int NOT NULL,
  `spawn_texto` varchar(40) DEFAULT NULL,
  `dificuldade` int DEFAULT NULL,
  `dificuldade_base` varchar(10) DEFAULT NULL,
  `multiplayer` varchar(5) DEFAULT NULL,
  `nota` text,
  `atualizado_em` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_seed_codigo_ev` (`codigo`,`edicao_versao_id`),
  KEY `fk_seeds_edicoes_versoes` (`edicao_versao_id`),
  CONSTRAINT `fk_seeds_edicoes_versoes` FOREIGN KEY (`edicao_versao_id`) REFERENCES `edicoes_versoes` (`id`),
  CONSTRAINT `ck_seeds_dificuldade` CHECK ((`dificuldade` between 1 and 5)),
  CONSTRAINT `ck_seeds_multiplayer` CHECK ((`multiplayer` in (_utf8mb4'baixo',_utf8mb4'medio',_utf8mb4'alto')))
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seeds`
--

LOCK TABLES `seeds` WRITE;
/*!40000 ALTER TABLE `seeds` DISABLE KEYS */;
INSERT INTO `seeds` VALUES (1,4167799982467607063,'Vila de planície ao lado de cerejeiras',1,NULL,NULL,NULL,NULL,'Fonte XGC cita Java 1.21 e Bedrock 1.21.0; EXL cita só Java 1.21. Compatibilidade com Bedrock é afirmação da fonte.','2026-11-08'),(2,29151576,'Planície pequena dentro de cherry grove',1,NULL,NULL,NULL,NULL,'XGC cita ninho de abelhas e encostas nevadas a leste; EXL cita Pillager Outpost dentro do cherry grove.','2026-11-08'),(3,9064150133272194,'Cherry grove ao lado de cânion',2,NULL,NULL,NULL,'medio','Vila descrita como minúscula.','2026-11-08'),(4,-2032795982907864146,'Cherry grove sobre vila no lago',3,NULL,NULL,NULL,'medio',NULL,'2026-11-08'),(5,888880777356331877,'Vale de cerejeiras com duas vilas',3,NULL,NULL,NULL,'alto',NULL,'2026-11-08'),(6,-3110026074691520618,'Cherry grove pequeno com vila próxima',1,NULL,NULL,NULL,NULL,'Fonte dá vila em (192,48) no Java e (200,136) no Bedrock; cherry grove em (150,-57). Coordenadas da vila diferem por edição.','2026-11-08'),(7,879583942,'Círculo de cerejeiras',1,'spawn',NULL,NULL,NULL,'Fonte afirma teste em Java e Bedrock 1.21; coordenadas adicionais não foram vistas.','2026-11-08'),(8,8667245532688270355,'Spawn em cherry grove',4,'0,0',4,'estimada',NULL,NULL,'2026-11-08'),(9,-7215224875276709517,'Spawn em floresta com cherry grove',4,'0,0',4,'estimada',NULL,NULL,'2026-11-08'),(10,191,'Pântano de mangue com vila de savana',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(11,9705,'Vila no deserto perto de recife',4,NULL,NULL,NULL,NULL,'Recife de coral quente próximo ao spawn.','2026-11-08'),(12,1738801,'Recife de coral ao lado de vila no deserto',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(13,929568499221,'Vila no meio do pântano',3,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(14,1040934860,'Ilha caveira com vila no deserto',3,NULL,NULL,NULL,NULL,'Vila sobre uma lush cave. Outra fonte (gameskinny) cita spawn em X -112 Z -128 sem informar edição.','2026-11-08'),(15,-1996523481016217001,'Mini-oceano circular com naufrágio',3,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(16,521873,'Pântano com sapos e slimes',3,NULL,NULL,NULL,NULL,'Fonte também cita Bogged.','2026-11-08'),(17,1539682405972721628,'Vila de taiga em ilha',5,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(18,1606377695512438131,'Vila de savana com formação rochosa vertical',6,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(19,-4056461929217980211,'Spawn em meadow vazio',7,NULL,NULL,NULL,'medio','Fonte descreve como bom para construção.','2026-11-08'),(20,-7417157268905316998,'Início fácil Bedrock',8,NULL,NULL,NULL,NULL,'Fonte indica tudo ao alcance do spawn e testado no Bedrock 1.21; distâncias não vistas.','2026-11-08'),(21,9009245503860775875,'Vila de taiga em rio congelado',4,NULL,4,'estimada',NULL,'Mesmo código no Bedrock tem outro mundo (ver registro Bedrock).','2026-11-08'),(22,9009245503860775875,'Ilha de oásis no deserto',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(23,102,'Floresta com abelhas, câmaras e cidade antiga',4,NULL,NULL,NULL,NULL,'Ancient City em 128,-34,-240.','2026-11-08'),(24,4009,'Posto, vila e cidade antiga juntos',3,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(25,3211213744707030873,'Cidade costeira',8,NULL,NULL,NULL,NULL,'Cidade nos penhascos sobre oceano frio, y=-41.','2026-11-08'),(26,2422215857861955386,'Spawn dentro de cidade antiga',9,NULL,4,'estimada',NULL,'Cidade sobreposta a uma vila; início muito perigoso.','2026-11-08'),(27,8513480846194603528,'Duas cidades antigas',10,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(28,-8539506224916838806,'Trilha e provação',1,NULL,NULL,NULL,NULL,'Beebom cita Java e Bedrock; Twinfinite rotula Java. Spawn em Snowy Plains.','2026-11-08'),(29,4012088974005424937,'Câmara ao lado de cidade antiga',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(30,-5592633653095784779,'Ilha de cogumelo com câmaras embaixo',1,NULL,NULL,NULL,'medio','Ilha em X 1961 Z 295, longe do spawn.','2026-11-08'),(31,144919489830835999,'Quatro câmaras perto do spawn',1,NULL,NULL,NULL,NULL,'Spawn em Bamboo Jungle.','2026-11-08'),(32,-7833842402223417925,'Trilha em T até câmara',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(33,565535403532980236,'Spawn em cidade antiga Bedrock',11,NULL,4,'estimada',NULL,'Versão anterior; reconfirmar na 1.21+.','2026-11-08'),(34,986324898918317848,'Cidade antiga quase instantânea',11,NULL,NULL,NULL,NULL,'Versão anterior.','2026-11-08'),(35,-3659344165812520857,'A ilha alta',12,NULL,NULL,NULL,NULL,'Versão anterior.','2026-11-08'),(36,-8591900330462080048,'Câmaras em ravina exposta',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(37,-3556402759935773199,'Ilha de provação II',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(38,4358921489363102297,'Mansão sobre vila em ilha de spawn',13,NULL,4,'estimada',NULL,NULL,'2026-11-08'),(39,-4227634870293935746,'Dappled forest triplo',13,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(40,-4719577674963485983,'Dappled forest com cinco ferreiros',14,NULL,NULL,NULL,NULL,'Título cita 26.3 e Bedrock 26.51; tabela rotula Bedrock.','2026-11-08'),(41,4778319204640099844,'Ilha de sobrevivência com penhasco alto',6,NULL,4,'estimada',NULL,'Título menciona Java e Bedrock; página lista Java.','2026-11-08'),(42,6943112984220218,'Seed de sobrevivência elogiada',6,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(43,1248286902574319040,'Cidade antiga com baú de maçãs',13,NULL,NULL,NULL,NULL,'Conteúdo do baú é afirmação da fonte.','2026-11-08'),(44,6306952185402203104,'Dappled forest, ice spikes e cidade',13,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(45,-7470345881882915071,'Pirâmide dentro de câmara',6,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(46,2643542272131503067,'Portal ruinoso no spawn, planície',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(47,8363883376303312479,'Portal no spawn, taiga de pinheiros',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(48,-440472133329981616,'Portal no spawn, planície II',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(49,-7022391147313087402,'Triângulo apertado em planície nevada',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(50,8131646228639523493,'Portal e vila sob 100 blocos',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(51,-7111810036737204144,'Portal no spawn, floresta',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(52,3156037144607818502,'Portal no spawn, floresta II',4,'portal no spawn',2,'estimada',NULL,NULL,'2026-11-08'),(53,9034078504,'Vila no lago com portal flutuante',9,'9,78,24',NULL,NULL,'medio','Fontes concordam em edição e faixa de versão; há queda de lava próxima.','2026-11-08'),(54,7311929229522424735,'Speedrun em taiga',4,'0,0',NULL,NULL,NULL,NULL,'2026-11-08'),(55,382008044140127510,'Speedrun em planície',4,'16,32',2,'estimada',NULL,'Quatro vilas em 700 blocos.','2026-11-08'),(56,3541336324715204874,'Speedrun em meadow',4,'0,0',4,'estimada',NULL,NULL,'2026-11-08'),(57,-5321749643246355024,'Speedrun taiga com vila próxima',4,'0,0',2,'estimada',NULL,NULL,'2026-11-08'),(58,643202569219444926,'Picos serrilhados no spawn',4,'0,48',4,'estimada',NULL,'Vila distante; cidade antiga a 96 blocos segundo o resumo da fonte.','2026-11-08'),(59,-6897082504097952427,'Várias montanhas gigantes',15,'0,160,0',NULL,NULL,NULL,NULL,'2026-11-08'),(60,4489057056054590644,'Montanha larga de picos',15,'0,158,0',NULL,NULL,NULL,'Cadeia com cerca de 500 blocos.','2026-11-08'),(61,-788591392889958720,'Colina plana enorme com lago',9,'-2,83,-6',NULL,NULL,'alto',NULL,'2026-11-08'),(62,1605713702489912095,'Mansão em floresta de bétulas',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(63,26274881544121,'Caldeira com mansão e vila',9,'17,102,9',NULL,NULL,'medio',NULL,'2026-11-08'),(64,8232298652205430997,'Mansão arranha-céu',16,'3,260,-6',NULL,NULL,NULL,'Vilas a cerca de 1000 blocos ou mais.','2026-11-08'),(65,15632432739,'Ilha da mansão',9,'324,80,-494',NULL,NULL,NULL,NULL,'2026-11-08'),(66,1517427826679820078,'Mansão perto do spawn com tesouro',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(67,2794202425749257137,'Mansão imponente sobre vila',17,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(68,-2924912394841125808,'Mansão com borda de selva rara',4,NULL,NULL,NULL,NULL,'Fonte cita Modified Jungle Edge.','2026-11-08'),(69,1613434103,'Mansão com tudo',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(70,-24970,'Mansões duplas',8,NULL,NULL,NULL,NULL,'Fonte diz \'perto do spawn\' mas as coordenadas passam de 500 blocos.','2026-11-08'),(71,165605352,'Spawn no telhado da mansão',8,NULL,4,'estimada',NULL,NULL,'2026-11-08'),(72,8160717602774178302,'Deserto com pirâmide',4,'0,16',NULL,NULL,NULL,NULL,'2026-11-08'),(73,2482490754905255652,'Templo em badlands',4,NULL,NULL,NULL,NULL,'Poço do deserto em 328,-472.','2026-11-08'),(74,47634270473,'Vila zumbi com templo no spawn',4,'spawn',2,'estimada',NULL,NULL,'2026-11-08'),(75,47179726794,'Vila ao lado de templo do deserto',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(76,41649,'Floresta ao lado de templo',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(77,-6098732345511496012,'Caverna lush em badlands',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(78,8651751508037126301,'Enseada de coral com vila no deserto',8,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(79,4867719531267003880,'Ilha de selva com templo',8,NULL,4,'estimada',NULL,'Templo semi afundado só relatado no Bedrock; no Java o terreno é igual mas estruturas podem mudar.','2026-11-08'),(80,3903589,'Spawn em selva, ilha de cogumelo ao sul',4,NULL,NULL,NULL,'medio','No Bedrock o spawn e a ilha ficam em outro lugar (registro próprio).','2026-11-08'),(81,3903589,'Selva com papagaios, ilha de cogumelo ao sul',18,NULL,NULL,NULL,'medio',NULL,'2026-11-08'),(82,-6769744659830011552,'Ilha de cogumelo em oceano congelado',1,NULL,NULL,NULL,'medio','Ilha perto de -60,-219.','2026-11-08'),(83,2842901415727422438,'Ilha de cogumelo longa',8,NULL,NULL,NULL,'medio','Ilha perto de -537,327.','2026-11-08'),(84,-8936702305531883130,'Ilha de cogumelo em oceano frio',1,NULL,NULL,NULL,'medio','Ilha perto de -186,-122.','2026-11-08'),(85,-1348008547075949990,'Quatro ilhas de cogumelo',8,NULL,NULL,NULL,'medio',NULL,'2026-11-08'),(86,5374691412471917055,'Ilha de cogumelo com ravina',1,NULL,NULL,NULL,'medio',NULL,'2026-11-08'),(87,-608830374621340378,'Ilha de sobrevivência em taiga',4,NULL,4,'estimada',NULL,'Fonte descreve isolamento total e madeira limitada.','2026-11-08'),(88,7545373633457494908,'Planície ampla para construir',4,'0,0',NULL,NULL,'medio','Fonte afirma cerca de 82% de terreno plano em 250 blocos.','2026-11-08'),(89,-3645586091663890742,'Vila e portal sobre câmaras',4,NULL,NULL,NULL,NULL,NULL,'2026-11-08'),(90,4517475607999363428,'Nether fácil',4,NULL,NULL,NULL,NULL,'Coordenadas de fortaleza e bastião como dadas pela fonte (x,z).','2026-11-08');
/*!40000 ALTER TABLE `seeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  `edicao` varchar(7) NOT NULL,
  `versao` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ck_usuarios_edicao` CHECK ((`edicao` in (_utf8mb4'Java',_utf8mb4'Bedrock')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verificacoes`
--

DROP TABLE IF EXISTS `verificacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verificacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seed_id` int NOT NULL,
  `fonte_id` int DEFAULT NULL,
  `status` varchar(25) NOT NULL,
  `metodo` varchar(120) NOT NULL,
  `data_verificacao` date NOT NULL,
  `observacao` text,
  PRIMARY KEY (`id`),
  KEY `fk_verificacoes_seeds` (`seed_id`),
  KEY `fk_verificacoes_fontes` (`fonte_id`),
  CONSTRAINT `fk_verificacoes_fontes` FOREIGN KEY (`fonte_id`) REFERENCES `fontes` (`id`),
  CONSTRAINT `fk_verificacoes_seeds` FOREIGN KEY (`seed_id`) REFERENCES `seeds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_verificacoes_status` CHECK ((`status` in (_utf8mb4'confirmada',_utf8mb4'verificada_ferramenta',_utf8mb4'documentada',_utf8mb4'pendente')))
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verificacoes`
--

LOCK TABLES `verificacoes` WRITE;
/*!40000 ALTER TABLE `verificacoes` DISABLE KEYS */;
INSERT INTO `verificacoes` VALUES (1,1,1,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(2,1,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(3,2,1,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(4,2,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(5,3,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(6,4,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(7,5,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(8,6,3,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(9,7,4,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(10,8,5,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(11,9,5,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(12,10,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(13,11,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(14,12,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(15,13,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(16,14,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(17,15,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(18,16,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(19,17,6,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(20,18,7,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(21,19,7,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(22,20,8,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(23,21,9,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(24,22,10,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(25,23,11,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(26,23,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(27,24,2,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(28,25,11,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(29,26,11,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(30,27,11,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(31,28,12,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(32,28,13,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(33,29,14,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(34,30,14,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(35,31,14,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(36,32,12,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(37,33,15,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(38,34,15,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(39,35,15,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(40,36,16,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(41,37,16,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(42,38,17,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(43,39,17,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(44,39,18,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(45,40,17,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(46,41,17,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(47,41,18,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(48,42,17,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(49,43,18,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(50,44,18,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(51,45,18,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(52,46,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(53,47,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(54,48,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(55,49,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(56,50,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(57,51,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(58,52,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(59,53,19,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(60,53,20,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(61,54,21,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(62,55,21,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(63,56,21,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(64,57,21,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(65,58,22,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(66,59,23,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(67,60,24,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(68,61,25,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(69,62,26,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(70,63,27,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(71,64,28,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(72,65,29,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(73,66,30,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(74,67,31,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(75,68,32,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(76,69,32,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(77,70,32,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(78,71,32,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(79,72,33,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(80,73,10,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(81,74,10,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(82,75,10,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(83,76,10,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(84,77,34,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(85,78,34,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(86,79,35,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(87,80,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(88,81,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(89,82,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(90,83,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(91,84,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(92,85,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(93,86,36,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(94,87,37,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(95,88,38,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(96,89,35,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL),(97,90,9,'documentada','encontrada em fonte identificável; sem teste no jogo','2026-11-08',NULL);
/*!40000 ALTER TABLE `verificacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_seed_resumo`
--

DROP TABLE IF EXISTS `vw_seed_resumo`;
/*!50001 DROP VIEW IF EXISTS `vw_seed_resumo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_seed_resumo` AS SELECT 
 1 AS `id`,
 1 AS `codigo`,
 1 AS `nome`,
 1 AS `edicao`,
 1 AS `versao`,
 1 AS `dificuldade`,
 1 AS `multiplayer`,
 1 AS `qtd_estruturas`,
 1 AS `qtd_fontes`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_seed_resumo`
--

/*!50001 DROP VIEW IF EXISTS `vw_seed_resumo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_seed_resumo` AS select `s`.`id` AS `id`,`s`.`codigo` AS `codigo`,`s`.`nome` AS `nome`,`ev`.`edicao` AS `edicao`,`ev`.`versao_texto` AS `versao`,`s`.`dificuldade` AS `dificuldade`,`s`.`multiplayer` AS `multiplayer`,(select count(0) from `seed_estruturas` `se` where (`se`.`seed_id` = `s`.`id`)) AS `qtd_estruturas`,(select count(0) from `verificacoes` `v` where (`v`.`seed_id` = `s`.`id`)) AS `qtd_fontes` from (`seeds` `s` join `edicoes_versoes` `ev`) where (`s`.`edicao_versao_id` = `ev`.`id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-09 20:41:43
