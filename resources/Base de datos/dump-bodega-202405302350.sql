-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: bodega
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ds_usuario`
--

DROP TABLE IF EXISTS `ds_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ds_usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `apellido` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_usuario`
--

LOCK TABLES `ds_usuario` WRITE;
/*!40000 ALTER TABLE `ds_usuario` DISABLE KEYS */;
INSERT INTO `ds_usuario` VALUES (1,'Andres','Rivas','andres@gmail.com','123',1,NULL,NULL),(2,'admin',NULL,'admin@gmail.com','$2y$12$TtigBSKY7DksI.F/m42hQuk6OX3.ZMCuDM38UzyNEgdFis.vKtUP.',NULL,'2024-05-30 05:01:36','2024-05-30 05:01:36');
/*!40000 ALTER TABLE `ds_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  `id_proveedor` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventario_productos_id_proveedor_IDX` (`id_proveedor`) USING BTREE,
  CONSTRAINT `inventario_productos_FK` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'caja1',1,1),(2,'producto 1',1,NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` varchar(150) DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Proveedor 1','77778888','Calle 1 pje 3'),(2,'proveedor 1','77887788','Calle1');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_transacciones`
--

DROP TABLE IF EXISTS `tipo_transacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_transacciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tabla catalogo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_transacciones`
--

LOCK TABLES `tipo_transacciones` WRITE;
/*!40000 ALTER TABLE `tipo_transacciones` DISABLE KEYS */;
INSERT INTO `tipo_transacciones` VALUES (1,'Ingreso'),(2,'Salida'),(3,'Devolucion'),(4,'Perdida');
/*!40000 ALTER TABLE `tipo_transacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacciones_productos`
--

DROP TABLE IF EXISTS `transacciones_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacciones_productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ingresado_por` int DEFAULT NULL,
  `id_producto` int DEFAULT NULL,
  `UPC` bigint DEFAULT NULL,
  `accion` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transacciones_productos_id_producto_IDX` (`id_producto`) USING BTREE,
  KEY `transacciones_productos_ingresado_por_IDX` (`ingresado_por`) USING BTREE,
  KEY `transacciones_productos_FK_2` (`accion`),
  CONSTRAINT `transacciones_productos_FK` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transacciones_productos_FK_1` FOREIGN KEY (`ingresado_por`) REFERENCES `ds_usuario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transacciones_productos_FK_2` FOREIGN KEY (`accion`) REFERENCES `tipo_transacciones` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones_productos`
--

LOCK TABLES `transacciones_productos` WRITE;
/*!40000 ALTER TABLE `transacciones_productos` DISABLE KEYS */;
INSERT INTO `transacciones_productos` VALUES (1,2,1,925429772485,1,'2024-05-30 17:27:00','2024-05-30 17:27:00'),(2,2,1,733376852460,1,'2024-05-30 17:27:28','2024-05-30 17:27:28'),(3,2,1,399362366962,1,'2024-05-30 17:49:09','2024-05-30 17:49:09'),(4,2,1,85678433749,1,'2024-05-30 17:50:52','2024-05-30 17:50:52'),(5,2,1,363371871748,1,'2024-05-30 17:57:28','2024-05-30 17:57:28'),(6,2,1,789461485259,1,'2024-05-30 17:57:41','2024-05-30 17:57:41'),(7,2,1,464034727973,1,'2024-05-30 21:30:11','2024-05-30 21:30:11'),(8,2,1,789461485259,2,'2024-05-30 21:35:54','2024-05-30 21:35:54'),(9,2,1,789461485259,2,'2024-05-30 21:39:02','2024-05-30 21:39:02');
/*!40000 ALTER TABLE `transacciones_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'bodega'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-30 23:50:40
