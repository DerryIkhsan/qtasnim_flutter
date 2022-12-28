-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.35-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for db_qtasnim_flutter
CREATE DATABASE IF NOT EXISTS `db_qtasnim_flutter` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_qtasnim_flutter`;

-- Dumping structure for table db_qtasnim_flutter.barang
CREATE TABLE IF NOT EXISTS `barang` (
  `id_barang` int(11) NOT NULL AUTO_INCREMENT,
  `id_jenis_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_barang`) USING BTREE,
  KEY `FK_barang_jenis_barang` (`id_jenis_barang`),
  CONSTRAINT `FK_barang_jenis_barang` FOREIGN KEY (`id_jenis_barang`) REFERENCES `jenis_barang` (`id_jenis_barang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table db_qtasnim_flutter.barang: ~0 rows (approximately)
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
INSERT INTO `barang` (`id_barang`, `id_jenis_barang`, `nama_barang`, `stok`) VALUES
	(1, 1, 'Kopi', 100),
	(2, 1, 'Teh', 100),
	(3, 2, 'Pasta Gigi', 100),
	(4, 2, 'Sabun Mandi', 100),
	(5, 2, 'Sampo', 100);
/*!40000 ALTER TABLE `barang` ENABLE KEYS */;

-- Dumping structure for table db_qtasnim_flutter.history_stok
CREATE TABLE IF NOT EXISTS `history_stok` (
  `id_history_stok` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) NOT NULL,
  `stok_awal` int(11) NOT NULL,
  PRIMARY KEY (`id_history_stok`),
  KEY `FK_history_stok_transaksi` (`id_transaksi`),
  CONSTRAINT `FK_history_stok_transaksi` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table db_qtasnim_flutter.history_stok: ~0 rows (approximately)
/*!40000 ALTER TABLE `history_stok` DISABLE KEYS */;
INSERT INTO `history_stok` (`id_history_stok`, `id_transaksi`, `stok_awal`) VALUES
	(1, 1, 100),
	(2, 2, 100),
	(3, 3, 90),
	(4, 4, 100),
	(5, 5, 100),
	(6, 6, 100),
	(7, 7, 81);
/*!40000 ALTER TABLE `history_stok` ENABLE KEYS */;

-- Dumping structure for table db_qtasnim_flutter.jenis_barang
CREATE TABLE IF NOT EXISTS `jenis_barang` (
  `id_jenis_barang` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_barang` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_jenis_barang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table db_qtasnim_flutter.jenis_barang: ~0 rows (approximately)
/*!40000 ALTER TABLE `jenis_barang` DISABLE KEYS */;
INSERT INTO `jenis_barang` (`id_jenis_barang`, `jenis_barang`) VALUES
	(1, 'Konsumsi'),
	(2, 'Pembersih');
/*!40000 ALTER TABLE `jenis_barang` ENABLE KEYS */;

-- Dumping structure for table db_qtasnim_flutter.transaksi
CREATE TABLE IF NOT EXISTS `transaksi` (
  `id_transaksi` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `jumlah` int(11) NOT NULL,
  PRIMARY KEY (`id_transaksi`) USING BTREE,
  KEY `FK_transaksi_barang` (`id_barang`),
  CONSTRAINT `FK_transaksi_barang` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table db_qtasnim_flutter.transaksi: ~0 rows (approximately)
/*!40000 ALTER TABLE `transaksi` DISABLE KEYS */;
INSERT INTO `transaksi` (`id_transaksi`, `id_barang`, `tgl_transaksi`, `jumlah`) VALUES
	(1, 1, '2021-05-01', 10),
	(2, 2, '2021-05-05', 19),
	(3, 1, '2021-05-10', 15),
	(4, 3, '2021-05-11', 20),
	(5, 4, '2021-05-11', 30),
	(6, 5, '2021-05-12', 25),
	(7, 2, '2021-05-12', 5);
/*!40000 ALTER TABLE `transaksi` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
