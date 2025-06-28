-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 28 juin 2025 à 13:26
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cismat_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add Catégorie', 6, 'add_categorie'),
(22, 'Can change Catégorie', 6, 'change_categorie'),
(23, 'Can delete Catégorie', 6, 'delete_categorie'),
(24, 'Can view Catégorie', 6, 'view_categorie'),
(25, 'Can add Membre équipe', 7, 'add_equipe'),
(26, 'Can change Membre équipe', 7, 'change_equipe'),
(27, 'Can delete Membre équipe', 7, 'delete_equipe'),
(28, 'Can view Membre équipe', 7, 'view_equipe'),
(29, 'Can add Paramètre', 8, 'add_setting'),
(30, 'Can change Paramètre', 8, 'change_setting'),
(31, 'Can delete Paramètre', 8, 'delete_setting'),
(32, 'Can view Paramètre', 8, 'view_setting'),
(33, 'Can add user', 9, 'add_user'),
(34, 'Can change user', 9, 'change_user'),
(35, 'Can delete user', 9, 'delete_user'),
(36, 'Can view user', 9, 'view_user'),
(37, 'Can add Commande', 10, 'add_commande'),
(38, 'Can change Commande', 10, 'change_commande'),
(39, 'Can delete Commande', 10, 'delete_commande'),
(40, 'Can view Commande', 10, 'view_commande'),
(41, 'Can add Article de commande', 11, 'add_commandeitem'),
(42, 'Can change Article de commande', 11, 'change_commandeitem'),
(43, 'Can delete Article de commande', 11, 'delete_commandeitem'),
(44, 'Can view Article de commande', 11, 'view_commandeitem'),
(45, 'Can add Fichier', 12, 'add_fichier'),
(46, 'Can change Fichier', 12, 'change_fichier'),
(47, 'Can delete Fichier', 12, 'delete_fichier'),
(48, 'Can view Fichier', 12, 'view_fichier'),
(49, 'Can add Rendez-vous', 13, 'add_rdv'),
(50, 'Can change Rendez-vous', 13, 'change_rdv'),
(51, 'Can delete Rendez-vous', 13, 'delete_rdv'),
(52, 'Can view Rendez-vous', 13, 'view_rdv'),
(53, 'Can add Service', 14, 'add_service'),
(54, 'Can change Service', 14, 'change_service'),
(55, 'Can delete Service', 14, 'delete_service'),
(56, 'Can view Service', 14, 'view_service'),
(57, 'Can add Réalisation', 15, 'add_realisation'),
(58, 'Can change Réalisation', 15, 'change_realisation'),
(59, 'Can delete Réalisation', 15, 'delete_realisation'),
(60, 'Can view Réalisation', 15, 'view_realisation'),
(61, 'Can add Témoignage', 16, 'add_testimonial'),
(62, 'Can change Témoignage', 16, 'change_testimonial'),
(63, 'Can delete Témoignage', 16, 'delete_testimonial'),
(64, 'Can view Témoignage', 16, 'view_testimonial'),
(65, 'Can add Détail de service', 17, 'add_servicedetail'),
(66, 'Can change Détail de service', 17, 'change_servicedetail'),
(67, 'Can delete Détail de service', 17, 'delete_servicedetail'),
(68, 'Can view Détail de service', 17, 'view_servicedetail'),
(69, 'Can add Détail de service', 17, 'add_service_modeldetail'),
(70, 'Can change Détail de service', 17, 'change_service_modeldetail'),
(71, 'Can delete Détail de service', 17, 'delete_service_modeldetail'),
(72, 'Can view Détail de service', 17, 'view_service_modeldetail'),
(73, 'Can add Service model', 18, 'add_service_model'),
(74, 'Can change Service model', 18, 'change_service_model'),
(75, 'Can delete Service model', 18, 'delete_service_model'),
(76, 'Can view Service model', 18, 'view_service_model');

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

--
-- Déchargement des données de la table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-06-13 12:34:22.845016', '1', 'Grand Format', 1, '[{\"added\": {}}]', 6, 1),
(2, '2025-06-13 12:35:51.154176', '2', 'Petit Format', 1, '[{\"added\": {}}]', 6, 1),
(3, '2025-06-13 12:39:09.877937', '3', 'Gadget et Pub', 1, '[{\"added\": {}}]', 6, 1),
(4, '2025-06-13 14:16:00.074698', '1', 'GRAND FORMAT', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 6, 1),
(5, '2025-06-13 14:16:48.593197', '2', 'PETIT FORMAT', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 6, 1),
(6, '2025-06-13 14:17:04.561645', '3', 'GADGET ET PUB', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 6, 1),
(7, '2025-06-13 14:31:59.143725', '1', 'Service object (1)', 1, '[{\"added\": {}}]', 14, 1),
(8, '2025-06-13 14:32:34.193826', '2', 'Service object (2)', 1, '[{\"added\": {}}]', 14, 1),
(9, '2025-06-13 14:33:19.587889', '3', 'Service object (3)', 1, '[{\"added\": {}}]', 14, 1),
(10, '2025-06-13 14:34:28.673354', '4', 'Service object (4)', 1, '[{\"added\": {}}]', 14, 1),
(11, '2025-06-13 14:34:44.793035', '5', 'Service object (5)', 1, '[{\"added\": {}}]', 14, 1),
(12, '2025-06-13 14:35:08.444108', '6', 'Service object (6)', 1, '[{\"added\": {}}]', 14, 1),
(13, '2025-06-13 14:35:30.430579', '7', 'Service object (7)', 1, '[{\"added\": {}}]', 14, 1),
(14, '2025-06-13 14:35:51.722972', '8', 'Service object (8)', 1, '[{\"added\": {}}]', 14, 1),
(15, '2025-06-13 14:36:11.688471', '9', 'Service object (9)', 1, '[{\"added\": {}}]', 14, 1),
(16, '2025-06-13 14:36:31.642818', '10', 'Service object (10)', 1, '[{\"added\": {}}]', 14, 1),
(17, '2025-06-13 14:36:51.933385', '11', 'Service object (11)', 1, '[{\"added\": {}}]', 14, 1),
(18, '2025-06-13 14:37:10.813932', '12', 'Service object (12)', 1, '[{\"added\": {}}]', 14, 1),
(19, '2025-06-13 14:37:27.785499', '13', 'Service object (13)', 1, '[{\"added\": {}}]', 14, 1),
(20, '2025-06-13 14:37:46.124209', '14', 'Service object (14)', 1, '[{\"added\": {}}]', 14, 1),
(21, '2025-06-13 14:38:02.401892', '15', 'Service object (15)', 1, '[{\"added\": {}}]', 14, 1),
(22, '2025-06-13 14:38:13.187645', '16', 'Service object (16)', 1, '[{\"added\": {}}]', 14, 1),
(23, '2025-06-13 14:38:56.763443', '17', 'Service object (17)', 1, '[{\"added\": {}}]', 14, 1),
(24, '2025-06-13 15:12:04.417293', '4', 'Service object (4)', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 14, 1),
(25, '2025-06-13 15:12:26.148201', '4', 'Service object (4)', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 14, 1),
(26, '2025-06-13 15:22:26.239968', '18', 'Service object (18)', 1, '[{\"added\": {}}]', 14, 1),
(27, '2025-06-13 15:22:44.005855', '19', 'Service object (19)', 1, '[{\"added\": {}}]', 14, 1),
(28, '2025-06-13 15:23:03.519176', '20', 'Service object (20)', 1, '[{\"added\": {}}]', 14, 1),
(29, '2025-06-13 16:16:24.165979', '1', 'bics - 100€/frrrg', 1, '[{\"added\": {}}]', 18, 1),
(30, '2025-06-13 16:17:34.567880', '2', 'bicsse - 500€/jrkjgg', 1, '[{\"added\": {}}]', 18, 1),
(31, '2025-06-13 16:18:30.885516', '2', 'bicsse - 500.00€/jrkjgg', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(32, '2025-06-13 16:19:16.999903', '3', 'perforéé - 150€/,rnbf', 1, '[{\"added\": {}}]', 18, 1),
(33, '2025-06-13 16:20:30.811079', '4', 'non perforé - 780€/fik', 1, '[{\"added\": {}}]', 18, 1),
(34, '2025-06-13 17:26:37.798887', '1', 'bics - 100.00€/frrrg', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(35, '2025-06-13 17:26:55.269632', '4', 'non perforé - 780.00€/fik', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(36, '2025-06-13 17:29:56.865060', '4', 'non perforé - 780.00€/fik', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(37, '2025-06-13 17:31:14.489236', '4', 'non perforé - 780.00€/fik', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(38, '2025-06-13 17:32:34.092021', '3', 'perforéé - 150.00€/,rnbf', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(39, '2025-06-13 21:33:37.502422', '21', 'hhehf', 1, '[{\"added\": {}}]', 14, 1),
(40, '2025-06-13 21:34:40.253216', '21', 'hhehf', 3, '', 14, 1),
(41, '2025-06-13 21:35:49.683768', '5', 'la vie - 200€/85', 1, '[{\"added\": {}}]', 18, 1),
(42, '2025-06-14 13:04:31.622988', '6', 'ggg - 100€/45', 1, '[{\"added\": {}}]', 18, 1),
(43, '2025-06-14 13:05:21.891834', '7', 'deff - 500€/a2', 1, '[{\"added\": {}}]', 18, 1),
(44, '2025-06-14 14:19:09.086363', '3', 'Transparent - 3500€/1m', 2, '[{\"changed\": {\"fields\": [\"Id service\", \"Nom\", \"Description\", \"Prix unitaire\", \"Unite mesure\", \"Specifications techniques\", \"Image\"]}}]', 18, 1),
(45, '2025-06-14 14:20:09.598453', '3', 'Vinyle Transparent - 3500.00€/1m', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 18, 1),
(46, '2025-06-14 14:28:39.017369', '8', 'Vinyle Opaque - 3000€/1m', 1, '[{\"added\": {}}]', 18, 1),
(47, '2025-06-14 14:31:25.622213', '9', 'Vinyle Perforée - 4000€/1m', 1, '[{\"added\": {}}]', 18, 1),
(48, '2025-06-14 14:32:10.676086', '3', 'Vinyle Transparent - 3500.00€/1m', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 18, 1),
(49, '2025-06-14 14:32:18.770300', '9', 'Vinyle Perforé - 4000.00€/1m', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 18, 1),
(50, '2025-06-14 14:49:49.822853', '10', 'Kakemono Prémium-extérieur - 80000€/1', 1, '[{\"added\": {}}]', 18, 1),
(51, '2025-06-14 14:50:05.470759', '9', 'Vinyle Micro-Perforé - 4000.00€/1m', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 18, 1),
(52, '2025-06-14 14:51:00.173672', '5', 'la vie - 200.00€/85', 3, '', 18, 1),
(53, '2025-06-14 14:51:09.624272', '4', 'non perforé - 780.00€/fik', 3, '', 18, 1),
(54, '2025-06-14 14:51:16.056901', '6', 'ggg - 100.00€/45', 3, '', 18, 1),
(55, '2025-06-14 14:51:21.418803', '2', 'bicsse - 500.00€/jrkjgg', 3, '', 18, 1),
(56, '2025-06-14 14:51:26.746483', '7', 'deff - 500.00€/a2', 3, '', 18, 1),
(57, '2025-06-14 14:51:31.939132', '1', 'bics - 100.00€/frrrg', 3, '', 18, 1),
(58, '2025-06-14 15:00:31.902640', '11', 'Kakemono Géant XXXL - 3m/2m - 250000€/1', 1, '[{\"added\": {}}]', 18, 1),
(59, '2025-06-14 15:09:03.446315', '12', 'Bâche micro-perforé - 8000€/1m', 1, '[{\"added\": {}}]', 18, 1),
(60, '2025-06-14 15:12:42.375579', '13', 'Bâche Publicitaire - 4000€/1m', 1, '[{\"added\": {}}]', 18, 1),
(61, '2025-06-14 15:12:49.857238', '12', 'Bâche micro-perforé - 6000.00€/1m', 2, '[{\"changed\": {\"fields\": [\"Prix unitaire\"]}}]', 18, 1),
(62, '2025-06-14 19:17:59.222757', '1', 'Vinyle', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(63, '2025-06-14 19:43:30.970776', '1', 'Juze e,ne je e, - 2025', 1, '[{\"added\": {}}]', 15, 1),
(64, '2025-06-15 00:13:22.113110', '1', 'Juze e,ne je e, - 2025', 3, '', 15, 1),
(65, '2025-06-15 00:14:08.789960', '2', 'cisse - 2025', 1, '[{\"added\": {}}]', 15, 1),
(66, '2025-06-15 00:18:42.378598', '3', 'bb - 2025', 1, '[{\"added\": {}}]', 15, 1),
(67, '2025-06-15 02:45:19.498070', '14', 'Carte de visite aux coins arrandis - 500fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(68, '2025-06-15 02:47:13.582492', '15', 'Carte de visite recto - 5000fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(69, '2025-06-15 02:50:38.896289', '16', 'Carte de visite recto-verso - 8000fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(70, '2025-06-15 02:55:02.215149', '17', 'Carte de visite avec QR code - 8000fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(71, '2025-06-15 03:08:08.341816', '18', 'Flayer format A6 recto - 50fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(72, '2025-06-15 03:10:55.355079', '19', 'Flayer format A6 recto-verso - 75fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(73, '2025-06-15 03:14:32.699008', '20', 'Flayer format DL 10*21 - 50fcfa/100 pièces', 1, '[{\"added\": {}}]', 18, 1),
(74, '2025-06-15 10:26:24.961608', '21', 'Dépliant A4 Ouvert / A5 Fermé - 700fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(75, '2025-06-15 10:31:06.349497', '22', 'Dépliant A4 Ouvert 10 x 21 Fermé 3 Volets - 700fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(76, '2025-06-15 10:34:48.260813', '23', 'Depliant en plaquette commerciale a 3 voltes - 1200fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(77, '2025-06-15 10:35:53.324498', '7', 'Brochures', 3, '', 14, 1),
(78, '2025-06-15 10:37:33.901449', '23', 'Depliant en plaquette commerciale a 3 volet - 1200.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Nom\", \"Description\"]}}]', 18, 1),
(79, '2025-06-15 10:40:15.363260', '23', 'Depliant en plaquette commerciale a 3 volets - 1200.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 18, 1),
(80, '2025-06-15 10:50:18.369421', '24', 'sticker rond - 150fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(81, '2025-06-15 10:52:38.576264', '25', 'sticker transparent - 200fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(82, '2025-06-15 10:57:13.947147', '26', 'Etiquette d\'adresse - 300fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(83, '2025-06-15 11:00:16.650628', '27', 'Etiquette Bouteille - 400fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(84, '2025-06-15 11:02:58.203388', '9', 'Cartes de d\'invation', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 14, 1),
(85, '2025-06-15 11:04:21.453366', '9', 'Cartes d\'invations', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 14, 1),
(86, '2025-06-15 11:11:31.989265', '28', 'Carte d\'invitation Mariage - 500fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(87, '2025-06-15 11:14:10.781184', '29', 'Carte d\'invitation Décès - 500fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(88, '2025-06-15 13:38:19.075989', '30', 'Bloc Note A4/A5/A6 couverture Rembordée - 1000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(89, '2025-06-15 13:43:02.414875', '31', 'Stylos (Grand public ) - 200fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(90, '2025-06-15 13:47:47.041673', '32', 'Stylos (Luxe) - 500fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(91, '2025-06-15 13:48:27.177395', '31', 'Stylos (Grand public ) - 350.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Prix unitaire\"]}}]', 18, 1),
(92, '2025-06-15 13:53:20.693449', '32', 'Stylos (Luxe) - 500.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(93, '2025-06-15 13:55:59.521803', '14', 'Carte de visite aux coins arrandis - 500.00fcfa/100 pièces', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(94, '2025-06-15 14:02:22.933967', '33', 'T-Shirt anniversaire - 5000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(95, '2025-06-15 14:09:42.963679', '34', 'T-Shirt Mariage - 300fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(96, '2025-06-15 14:13:24.859461', '35', 'T-Shirt Enfant - 3500fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(97, '2025-06-15 14:18:19.963170', '36', 'T-Shirt Campagne - 2500fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(98, '2025-06-15 14:21:02.130902', '11', 'Stylos', 2, '[{\"changed\": {\"fields\": [\"Ordre affichage\"]}}]', 14, 1),
(99, '2025-06-15 14:21:55.645202', '11', 'Stylos', 2, '[{\"changed\": {\"fields\": [\"Ordre affichage\"]}}]', 14, 1),
(100, '2025-06-15 14:22:36.784481', '11', 'Stylos', 2, '[{\"changed\": {\"fields\": [\"Ordre affichage\"]}}]', 14, 1),
(101, '2025-06-15 14:33:22.193073', '37', 'Gillet - 700fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(102, '2025-06-15 14:34:43.728523', '37', 'Gillet - 700.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(103, '2025-06-15 14:39:31.813267', '38', 'Mugs - 5000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(104, '2025-06-15 14:46:17.095024', '39', 'Bol Personnalisé - 7000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(105, '2025-06-15 15:08:42.090947', '40', 'Modèle 1 - 250fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(106, '2025-06-15 15:09:58.755211', '41', 'Modèle 2 - 250fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(107, '2025-06-15 15:20:21.494885', '42', 'Casquette Personnalisé - 2000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(108, '2025-06-15 15:23:09.063182', '43', 'Casquette Simple - 1500fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(109, '2025-06-15 15:28:10.434148', '44', 'Bonnet Avec ou Sans la personnalisation - 2000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(110, '2025-06-15 15:30:03.904138', '45', 'Bonnet Femme Avec ou Sans la personnalisation - 2000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(111, '2025-06-15 15:32:13.820190', '15', 'Chapeaux', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 14, 1),
(112, '2025-06-15 15:36:24.135380', '16', 'Tampons', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 14, 1),
(113, '2025-06-15 15:37:29.015285', '22', 'Gourdes', 1, '[{\"added\": {}}]', 14, 1),
(114, '2025-06-15 15:40:56.455765', '46', 'Tampons de Poche/Bic - 4000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(115, '2025-06-15 15:42:19.284750', '47', 'Tampons de Rectangles - 5000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(116, '2025-06-15 15:44:03.424175', '48', 'Tampns Dateur - 5000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(117, '2025-06-15 15:45:45.927218', '49', 'Tampons Dateur Rectangle - 60000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(118, '2025-06-15 15:46:04.557494', '47', 'Tampons Rectangle - 5000.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 18, 1),
(119, '2025-06-15 16:00:06.740342', '50', 'Tapis de prière - 10000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(120, '2025-06-15 16:03:00.755807', '51', 'Tapis Personnalisé modèle pour Couple - 15000fcfa/2 pièces', 1, '[{\"added\": {}}]', 18, 1),
(121, '2025-06-15 16:05:47.226371', '52', 'Autre Modèle - 10000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(122, '2025-06-15 16:08:35.361663', '53', 'Tapis pour Enfant - 8000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(123, '2025-06-15 21:25:11.139988', '54', 'Gourde Isotherme - 4000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(124, '2025-06-15 21:27:24.479772', '55', 'Gourde Personnalisée - 5000fcfa/1 pièce', 1, '[{\"added\": {}}]', 18, 1),
(125, '2025-06-15 21:29:18.069143', '22', 'Gourdes', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(126, '2025-06-15 21:45:15.371279', '1', 'Vinyle', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(127, '2025-06-15 21:46:01.019821', '2', 'Kakemono', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(128, '2025-06-15 21:47:10.700947', '3', 'Bâches', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(129, '2025-06-15 21:48:59.637670', '4', 'Cartes de visite', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(130, '2025-06-15 21:50:25.749511', '5', 'Flyers', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(131, '2025-06-15 21:51:36.133148', '6', 'Dépliants', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(132, '2025-06-15 21:52:22.173094', '8', 'Autocollants', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(133, '2025-06-15 21:53:32.016365', '9', 'Cartes d\'invations', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(134, '2025-06-15 21:55:52.424585', '10', 'Bloc-notes', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(135, '2025-06-15 21:58:32.118566', '11', 'Stylos', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(136, '2025-06-15 21:59:10.629694', '12', 'T-shirts', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(137, '2025-06-15 22:00:12.611379', '13', 'Tasses', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(138, '2025-06-15 22:01:29.432820', '14', 'Pin\'s', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(139, '2025-06-15 22:03:16.795713', '15', 'Chapeaux', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(140, '2025-06-15 22:04:22.807898', '16', 'Tampons', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(141, '2025-06-15 22:05:30.711548', '17', 'Tapis Personnalisés', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(142, '2025-06-15 22:08:39.688543', '15', 'Chapeaux', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 14, 1),
(143, '2025-06-16 00:00:16.421881', '16', 'Carte de visite recto-verso - 8000.00fcfa/100 pièces', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(144, '2025-06-16 00:02:27.635897', '16', 'Carte de visite recto-verso - 8000.00fcfa/100 pièces', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(145, '2025-06-16 00:03:47.709286', '16', 'Carte de visite recto-verso - 8000.00fcfa/100 pièces', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(146, '2025-06-16 00:04:08.972702', '15', 'Carte de visite recto - 5000.00fcfa/100 pièces', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(147, '2025-06-16 14:48:01.984757', '3', 'bb - 2025', 3, '', 15, 1),
(148, '2025-06-16 14:48:17.833434', '2', 'cisse - 2025', 2, '[]', 15, 1),
(149, '2025-06-16 14:53:49.290787', '4', 'Anniversaire - 2025', 1, '[{\"added\": {}}]', 15, 1),
(150, '2025-06-16 14:54:41.044798', '5', 'Tasse - 2025', 1, '[{\"added\": {}}]', 15, 1),
(151, '2025-06-16 14:56:21.626123', '6', 'Stylos - 2025', 1, '[{\"added\": {}}]', 15, 1),
(152, '2025-06-16 14:58:15.840630', '7', 'Tapis Personnalisé - 2025', 1, '[{\"added\": {}}]', 15, 1),
(153, '2025-06-16 14:59:24.729373', '8', 'Kakemono - 2025', 1, '[{\"added\": {}}]', 15, 1),
(154, '2025-06-16 15:00:34.320987', '9', 'Pin\'s - 2025', 1, '[{\"added\": {}}]', 15, 1),
(155, '2025-06-16 15:03:04.451128', '10', 'Vinyle - 2025', 1, '[{\"added\": {}}]', 15, 1),
(156, '2025-06-16 15:04:41.155599', '11', 'Gourde - 2025', 1, '[{\"added\": {}}]', 15, 1),
(157, '2025-06-16 15:10:13.254004', '12', 'Carte de visite - 2025', 1, '[{\"added\": {}}]', 15, 1),
(158, '2025-06-16 15:12:02.211135', '13', 'Bonnet - 2025', 1, '[{\"added\": {}}]', 15, 1),
(159, '2025-06-16 15:27:51.810042', '2', 'cisse - 2025', 3, '', 15, 1),
(160, '2025-06-16 16:19:38.854740', '12', 'Bâche micro-perforé - 6000.00fcfa/1m', 2, '[{\"changed\": {\"fields\": [\"Disponible\"]}}]', 18, 1),
(161, '2025-06-16 17:47:36.044778', '11', 'Gourdehhhh - 2025', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 15, 1),
(162, '2025-06-16 17:48:32.106854', '11', 'Gourde - 2025', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 15, 1),
(163, '2025-06-16 17:52:00.786830', '1', 'dddrr css - ffffff', 1, '[{\"added\": {}}]', 7, 1),
(164, '2025-06-16 17:52:28.040843', '2', 'jhguyv jhgfu - hvhuv', 1, '[{\"added\": {}}]', 7, 1),
(165, '2025-06-16 18:10:09.686738', '1', 'dddrr css - ffffff', 2, '[{\"changed\": {\"fields\": [\"Telephone\"]}}]', 7, 1),
(166, '2025-06-16 18:10:56.839062', '1', 'dddrr css - ffffff', 2, '[{\"changed\": {\"fields\": [\"Photo\", \"Ordre affichage\"]}}]', 7, 1),
(167, '2025-06-16 18:36:08.045636', '40', 'Modèle 1 - 250.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 18, 1),
(168, '2025-06-16 20:26:26.423486', '20', 'Tous les Services', 3, '', 14, 1),
(169, '2025-06-16 20:26:34.524285', '19', 'Tous les Services', 3, '', 14, 1),
(170, '2025-06-16 20:26:42.694496', '18', 'Tous les Services', 3, '', 14, 1),
(171, '2025-06-28 01:21:40.339191', '2', 'jhguyv jhgfu - hvhuv', 3, '', 7, 1),
(172, '2025-06-28 01:21:46.924093', '1', 'dddrr css - ffffff', 3, '', 7, 1),
(173, '2025-06-28 01:22:55.275491', '3', 'BRAHIMA CISSE - CO-FONDATEUR', 1, '[{\"added\": {}}]', 7, 1),
(174, '2025-06-28 01:23:58.436587', '4', 'ABDOUL MATINI LENGANE - CO-FONDATEUR', 1, '[{\"added\": {}}]', 7, 1),
(175, '2025-06-28 01:24:54.288859', '5', 'REGINA GAHA - SECRETAIRE/ASSISTANTE', 1, '[{\"added\": {}}]', 7, 1),
(176, '2025-06-28 01:25:47.694249', '6', 'ABOUBACAR TRAORE - DIRECTEUR DES PRODUCTIONS', 1, '[{\"added\": {}}]', 7, 1),
(177, '2025-06-28 01:26:02.148414', '3', 'BRAHIMA CISSE - CO-FONDATEUR', 2, '[{\"changed\": {\"fields\": [\"Ordre affichage\"]}}]', 7, 1),
(178, '2025-06-28 01:26:02.151654', '5', 'REGINA GAHA - SECRETAIRE/ASSISTANTE', 2, '[{\"changed\": {\"fields\": [\"Ordre affichage\"]}}]', 7, 1),
(179, '2025-06-28 01:26:02.153976', '4', 'ABDOUL MATINI LENGANE - CO-FONDATEUR', 2, '[{\"changed\": {\"fields\": [\"Ordre affichage\"]}}]', 7, 1),
(180, '2025-06-28 13:06:09.861837', '38', 'Tasse - 5000.00fcfa/1 pièce', 2, '[{\"changed\": {\"fields\": [\"Nom\"]}}]', 18, 1);

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(6, 'web_site', 'categorie'),
(7, 'web_site', 'equipe'),
(8, 'web_site', 'setting'),
(9, 'web_site', 'user'),
(10, 'web_site', 'commande'),
(11, 'web_site', 'commandeitem'),
(12, 'web_site', 'fichier'),
(13, 'web_site', 'rdv'),
(14, 'web_site', 'service'),
(15, 'web_site', 'realisation'),
(16, 'web_site', 'testimonial'),
(17, 'web_site', 'service_modeldetail'),
(18, 'web_site', 'service_model');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-06-13 12:17:24.734443'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-06-13 12:17:24.836894'),
(3, 'auth', '0001_initial', '2025-06-13 12:17:25.165734'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-06-13 12:17:25.228587'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-06-13 12:17:25.239217'),
(6, 'auth', '0004_alter_user_username_opts', '2025-06-13 12:17:25.247529'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-06-13 12:17:25.259820'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-06-13 12:17:25.260818'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-06-13 12:17:25.276428'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-06-13 12:17:25.284088'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-06-13 12:17:25.291344'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-06-13 12:17:25.359287'),
(13, 'auth', '0011_update_proxy_permissions', '2025-06-13 12:17:25.368715'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-06-13 12:17:25.379112'),
(15, 'web_site', '0001_initial', '2025-06-13 12:17:27.095820'),
(16, 'admin', '0001_initial', '2025-06-13 12:17:27.391663'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-06-13 12:17:27.391663'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-13 12:17:27.426647'),
(19, 'sessions', '0001_initial', '2025-06-13 12:17:27.487824'),
(20, 'web_site', '0002_alter_service_options_and_more', '2025-06-13 14:27:05.850375'),
(21, 'web_site', '0003_alter_service_model_id_service', '2025-06-13 16:14:17.698905'),
(22, 'web_site', '0004_alter_categorie_image', '2025-06-13 17:26:06.729983'),
(23, 'web_site', '0005_alter_categorie_image', '2025-06-13 17:29:28.285659'),
(24, 'web_site', '0006_alter_categorie_image', '2025-06-13 17:30:33.685864'),
(25, 'web_site', '0007_service_image', '2025-06-14 19:15:42.472363');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('7rkyfx7b4zxxnoh2v2ls6mbu1dw4e1mf', '.eJxVjDsOwjAQBe_iGlmJF39CSZ8zWLveNQ4gR4qTCnF3iJQC2jcz76UibmuJW5MlTqwuqlen340wPaTugO9Yb7NOc12XifSu6IM2Pc4sz-vh_h0UbOVbewPkwXRAyUvAnlyw504wA7Ehsd4ZYBus85DFQaYBB0lZfGAjyWT1_gDeBjhw:1uQ3QK:rKgz7GhOIW5EeWfzQVQ7avg3revoQaOJodevgKQoTjY', '2025-06-27 12:22:20.410537'),
('p6c8cjaacwfg3ivuqeao99nilr5akmid', '.eJxVjDsOwjAQBe_iGlmJF39CSZ8zWLveNQ4gR4qTCnF3iJQC2jcz76UibmuJW5MlTqwuqlen340wPaTugO9Yb7NOc12XifSu6IM2Pc4sz-vh_h0UbOVbewPkwXRAyUvAnlyw504wA7Ehsd4ZYBus85DFQaYBB0lZfGAjyWT1_gDeBjhw:1uVK63:zcqm53o2499Cofv2u5fC3ZZHrWw-5yJV8fBcHvDu3fg', '2025-07-12 01:11:11.355390');

-- --------------------------------------------------------

--
-- Structure de la table `web_site_categorie`
--

DROP TABLE IF EXISTS `web_site_categorie`;
CREATE TABLE IF NOT EXISTS `web_site_categorie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `ordre_affichage` int UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom` (`nom`)
) ;

--
-- Déchargement des données de la table `web_site_categorie`
--

INSERT INTO `web_site_categorie` (`id`, `nom`, `description`, `image`, `ordre_affichage`, `active`) VALUES
(1, 'GRAND FORMAT', 'impression sur les supports plus grandes', 'categories/logo.jpeg', 1, 1),
(2, 'PETIT FORMAT', 'impressions sur les supports de moyennes tailles', 'categories/WhatsApp_Image_2024-12-30_at_21.54.01.jpeg', 2, 1),
(3, 'GADGET ET PUB', 'impressions sur tous les supports plus personnels', 'categories/WhatsApp_Image_2025-01-24_at_00.10.29.jpeg', 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `web_site_commande`
--

DROP TABLE IF EXISTS `web_site_commande`;
CREATE TABLE IF NOT EXISTS `web_site_commande` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_commande` varchar(50) NOT NULL,
  `nom_client` varchar(200) NOT NULL,
  `email_client` varchar(254) NOT NULL,
  `telephone_client` varchar(20) NOT NULL,
  `adresse_livraison` longtext NOT NULL,
  `statut` varchar(15) NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `total_ttc` decimal(10,2) NOT NULL,
  `taux_tva` decimal(5,2) NOT NULL,
  `date_commande` datetime(6) NOT NULL,
  `date_livraison_prevue` datetime(6) DEFAULT NULL,
  `date_livraison_reelle` datetime(6) DEFAULT NULL,
  `notes_client` longtext NOT NULL,
  `notes_admin` longtext NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_commande` (`numero_commande`),
  KEY `web_site_commande_user_id_a7901ed3` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_commandeitem`
--

DROP TABLE IF EXISTS `web_site_commandeitem`;
CREATE TABLE IF NOT EXISTS `web_site_commandeitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantite` int UNSIGNED NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `prix_total` decimal(10,2) NOT NULL,
  `options_selectionnees` json DEFAULT NULL,
  `instructions_speciales` longtext NOT NULL,
  `commande_id` bigint NOT NULL,
  `service_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_site_commandeitem_commande_id_b8285132` (`commande_id`),
  KEY `web_site_commandeitem_service_id_b6633bda` (`service_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_equipe`
--

DROP TABLE IF EXISTS `web_site_equipe`;
CREATE TABLE IF NOT EXISTS `web_site_equipe` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `poste` varchar(150) NOT NULL,
  `bio` longtext NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `affiche_public` tinyint(1) NOT NULL,
  `ordre_affichage` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Déchargement des données de la table `web_site_equipe`
--

INSERT INTO `web_site_equipe` (`id`, `nom`, `prenom`, `poste`, `bio`, `photo`, `email`, `telephone`, `affiche_public`, `ordre_affichage`) VALUES
(4, 'LENGANE', 'ABDOUL MATINI', 'CO-FONDATEUR', '', 'web_site/static/equipe/abc7ab13-2d1a-4a03-b0ab-ec8861692ec3.jpeg', 'cisseibra0102@gmail.com', '0123456789', 1, 3),
(3, 'CISSE', 'BRAHIMA', 'CO-FONDATEUR', '', 'web_site/static/equipe/0bbbbf57-ac77-4e23-b120-f910d5604af3.jpeg', 'brahimacisse59@gmail.com', '0759106003', 1, 1),
(5, 'GAHA', 'REGINA', 'SECRETAIRE/ASSISTANTE', '', 'web_site/static/equipe/79d106f8-118f-4c68-af17-a733ce3c96c2.jpeg', 'cisseibra0102@gmail.com', '0123456789', 1, 2),
(6, 'TRAORE', 'ABOUBACAR', 'DIRECTEUR DES PRODUCTIONS', '', 'web_site/static/equipe/bac3bed5-02d8-419d-8847-f1066962fcaa.jpeg', 'cisseibra0102@gmail.com', '0123456789', 1, 4);

-- --------------------------------------------------------

--
-- Structure de la table `web_site_fichier`
--

DROP TABLE IF EXISTS `web_site_fichier`;
CREATE TABLE IF NOT EXISTS `web_site_fichier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom_original` varchar(255) NOT NULL,
  `fichier` varchar(100) NOT NULL,
  `type_mime` varchar(100) NOT NULL,
  `taille_octets` bigint NOT NULL,
  `hash_fichier` varchar(64) NOT NULL,
  `date_upload` datetime(6) NOT NULL,
  `commande_item_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_site_fichier_commande_item_id_ae9fdfc3` (`commande_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_rdv`
--

DROP TABLE IF EXISTS `web_site_rdv`;
CREATE TABLE IF NOT EXISTS `web_site_rdv` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom_client` varchar(200) NOT NULL,
  `telephone_client` varchar(20) NOT NULL,
  `email_client` varchar(254) NOT NULL,
  `date_rdv` datetime(6) NOT NULL,
  `duree_minutes` int UNSIGNED NOT NULL,
  `type_rdv` varchar(15) NOT NULL,
  `motif` longtext NOT NULL,
  `statut` varchar(10) NOT NULL,
  `notes_admin` longtext NOT NULL,
  `date_creation` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_site_rdv_user_id_3ddb3257` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_realisation`
--

DROP TABLE IF EXISTS `web_site_realisation`;
CREATE TABLE IF NOT EXISTS `web_site_realisation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `client` varchar(200) NOT NULL,
  `image_principale` varchar(100) NOT NULL,
  `images_galerie` json DEFAULT NULL,
  `date_realisation` date NOT NULL,
  `duree_projet` varchar(100) NOT NULL,
  `cout_projet` decimal(10,2) DEFAULT NULL,
  `difficulte` varchar(20) NOT NULL,
  `technologies_utilisees` longtext NOT NULL,
  `visible_public` tinyint(1) NOT NULL,
  `ordre_affichage` int UNSIGNED NOT NULL,
  `date_creation` datetime(6) NOT NULL,
  `date_modification` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Déchargement des données de la table `web_site_realisation`
--

INSERT INTO `web_site_realisation` (`id`, `titre`, `description`, `client`, `image_principale`, `images_galerie`, `date_realisation`, `duree_projet`, `cout_projet`, `difficulte`, `technologies_utilisees`, `visible_public`, `ordre_affichage`, `date_creation`, `date_modification`) VALUES
(4, 'Anniversaire', 'Transformez vos anniversaires en événements magiques ! Invitations élégantes, décorations personnalisées et souvenirs photo - chaque détail imprimé avec amour pour des fêtes inoubliables !', '', 'web_site/static/realisations/c9feb760-a9f9-4eb8-b35f-d5b8788f124c.jpg', NULL, '2025-06-10', '', NULL, 'MOYEN', '', 1, 2, '2025-06-16 14:53:49.286942', '2025-06-16 14:53:49.286942'),
(5, 'Tasse', 'Votre café n\'aura jamais eu si bon goût ! Tasses personnalisées avec vos photos, logos ou messages - le cadeau parfait qui réchauffe le cœur à chaque gorgée !', '', 'web_site/static/realisations/a4b0d28a-8d6c-43cd-96de-569238e32072.jpg', NULL, '2025-06-23', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 14:54:40.991778', '2025-06-16 14:54:40.991778'),
(6, 'Stylos', 'Écrivez votre succès avec style ! Stylos personnalisés gravés à votre image - l\'outil marketing qui reste entre toutes les mains et fait parler de votre marque à chaque trait !', '', 'web_site/static/realisations/10d9b449-2410-4f9f-a633-534be2bee9d1.jpg', NULL, '2025-06-19', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 14:56:21.623383', '2025-06-16 14:56:21.623383'),
(7, 'Tapis Personnalisé', 'Élevez vos prières avec dévotion ! Tapis de prière personnalisés alliant spiritualité et élégance - créez votre espace sacré unique avec des motifs et calligraphies qui touchent l\'âme !', '', 'web_site/static/realisations/14a2ac17-5124-4dd7-b7c4-39b0b2d74a55.jpeg', NULL, '2025-06-27', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 14:58:15.836058', '2025-06-16 14:58:15.836058'),
(8, 'Kakemono', 'Imposez votre présence avec élégance ! Kakemonos haute définition qui captivent le regard - parfaits pour salons, boutiques et événements. Votre message vertical qui marque les esprits', '', 'web_site/static/realisations/7c7c6a87-1c7d-4d59-819e-86fa4012a86d.jpg', NULL, '2025-07-08', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 14:59:24.716442', '2025-06-16 14:59:24.716442'),
(9, 'Pin\'s', 'Petits mais puissants ! Pin\'s personnalisés qui transforment chaque veste en support publicitaire - l\'accessoire tendance qui fait briller votre marque avec distinction !', '', 'web_site/static/realisations/da2c7e95-673e-493e-95fc-a73b7a71c4fb.jpg', NULL, '2025-07-07', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 15:00:34.314191', '2025-06-16 15:00:34.314191'),
(10, 'Vinyle', 'Décorez avec impact ! Vinyles adhésifs haute qualité qui transforment vos surfaces - vitrines, murs, véhicules, tout devient un espace d\'expression créative et durable !', '', 'web_site/static/realisations/86073a2e-a82e-407c-aca8-2d27cfc76822.jpeg', NULL, '2025-07-07', '', NULL, 'MOYEN', '', 1, 1, '2025-06-16 15:03:04.436705', '2025-06-16 15:03:04.436705'),
(11, 'Gourde', 'Hydratez-vous avec style ! Gourdes personnalisées éco-responsables qui vous accompagnent partout - le compagnon quotidien qui affiche vos valeurs et votre image !', '', 'web_site/static/realisations/dba918dc-cdea-43e7-a00b-4349c69126ec.jpeg', NULL, '2025-08-10', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 15:04:41.141526', '2025-06-16 17:48:32.106854'),
(12, 'Carte de visite', 'Votre première impression en format poche ! Cartes de visite premium qui ouvrent toutes les portes - finitions élégantes, papier noble, l\'art de marquer les esprits en un échange !', '', 'web_site/static/realisations/341cf25a-e851-470b-ad95-da18a78db557.jpeg', NULL, '2025-04-08', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 15:10:13.254004', '2025-06-16 15:10:13.254004'),
(13, 'Bonnet', 'Gardez la tête haute avec style ! Bonnets personnalisés qui réchauffent et marquent - l\'accessoire tendance qui affiche votre logo même par temps froid !', '', 'web_site/static/realisations/7a837bfa-1ca3-40b5-8fd5-7299e120067e.jpeg', NULL, '2025-05-06', '', NULL, 'MOYEN', '', 1, 0, '2025-06-16 15:12:02.204563', '2025-06-16 15:12:02.208368');

-- --------------------------------------------------------

--
-- Structure de la table `web_site_realisation_services_utilises`
--

DROP TABLE IF EXISTS `web_site_realisation_services_utilises`;
CREATE TABLE IF NOT EXISTS `web_site_realisation_services_utilises` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `realisation_id` bigint NOT NULL,
  `service_model_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_site_realisation_ser_realisation_id_service_i_34b63498_uniq` (`realisation_id`,`service_model_id`),
  KEY `web_site_realisation_services_utilises_realisation_id_b2f02c56` (`realisation_id`),
  KEY `web_site_realisation_services_utilises_service_id_5a5dd80f` (`service_model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_service`
--

DROP TABLE IF EXISTS `web_site_service`;
CREATE TABLE IF NOT EXISTS `web_site_service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `active` tinyint(1) NOT NULL,
  `id_categorie_id` bigint NOT NULL,
  `ordre_affichage` int UNSIGNED NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_site_service_id_categorie_id_0536f228` (`id_categorie_id`)
) ;

--
-- Déchargement des données de la table `web_site_service`
--

INSERT INTO `web_site_service` (`id`, `titre`, `description`, `active`, `id_categorie_id`, `ordre_affichage`, `image`) VALUES
(1, 'Vinyle', 'tous les modeles', 1, 1, 1, 'web_site/static/services/50443ff4-aa01-4f5d-8b94-be610632ec1b.jpg'),
(2, 'Kakemono', 'tous les modeles', 1, 1, 2, 'web_site/static/services/89534bcd-ffad-4932-bd50-51bee62afc10.jpg'),
(3, 'Bâches', 'tous les modeles', 1, 1, 3, 'web_site/static/services/99be9e07-cee3-45e7-ac1d-cfc9a3ff739a.jpg'),
(4, 'Cartes de visite', 'tous les modeles', 1, 2, 1, 'web_site/static/services/b34681da-be70-4523-94ab-76fd3b06c181.jpeg'),
(5, 'Flyers', 'tous les modeles', 1, 2, 2, 'web_site/static/services/e12934b6-a231-4009-98b4-c69c85962ed3.jpeg'),
(6, 'Dépliants', 'tous les modeles', 1, 2, 3, 'web_site/static/services/bbf865e1-54f9-48de-8f32-a1276e30462c.jpg'),
(8, 'Autocollants', 'tous les modeles', 1, 2, 5, 'web_site/static/services/1776f9b2-cd89-4ed0-badc-201b84d852e4.jpg'),
(9, 'Cartes d\'invations', 'tous les modeles', 1, 2, 6, 'web_site/static/services/4f179a40-72dd-48be-9db3-eb1ee038070c.jpg'),
(10, 'Bloc-notes', 'tous les modeles', 1, 2, 7, 'web_site/static/services/d84cb27b-1255-4188-a02c-d2a35f1e23eb.jpg'),
(11, 'Stylos', 'tous les modeles', 1, 3, 1, 'web_site/static/services/9b0fadd0-7967-4bbd-8033-c1d0aa26c3ee.jpg'),
(12, 'T-shirts', 'tous les modeles', 1, 3, 2, 'web_site/static/services/f494be17-15a5-4ca9-ac51-19dc74804a91.jpg'),
(13, 'Tasses', 'tous les modeles', 1, 3, 3, 'web_site/static/services/a2464b5a-8c89-4ffa-9ef3-089d66684022.jpg'),
(14, 'Pin\'s', 'tous les modeles', 1, 3, 4, 'web_site/static/services/40cfc9d2-8dbf-4472-9bd5-f5a8edb3ef2c.jpg'),
(15, 'Chapeaux', 'tous les modeles', 1, 3, 5, 'web_site/static/services/982bdb73-7563-4cf9-b5f9-65f829de645c.jpg'),
(16, 'Tampons', 'tous les modeles', 1, 3, 6, 'web_site/static/services/c0feb513-da04-4eb5-888d-504c48f620b1.jpg'),
(17, 'Tapis Personnalisés', 'tous les modeles', 1, 3, 7, 'web_site/static/services/c461a580-42b2-4a9c-ae53-9962a56fb360.jpg'),
(22, 'Gourdes', 'tous les modèles', 1, 3, 8, 'web_site/static/services/b5412357-d5eb-4d96-a30c-412681756d41.jpeg');

-- --------------------------------------------------------

--
-- Structure de la table `web_site_service_model`
--

DROP TABLE IF EXISTS `web_site_service_model`;
CREATE TABLE IF NOT EXISTS `web_site_service_model` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `unite_mesure` varchar(50) NOT NULL,
  `specifications_techniques` longtext NOT NULL,
  `disponible` tinyint(1) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `date_creation` datetime(6) NOT NULL,
  `date_modification` datetime(6) NOT NULL,
  `id_service_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `web_site_service_model_id_service_id_d84fb884` (`id_service_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `web_site_service_model`
--

INSERT INTO `web_site_service_model` (`id`, `nom`, `description`, `prix_unitaire`, `unite_mesure`, `specifications_techniques`, `disponible`, `image`, `date_creation`, `date_modification`, `id_service_id`) VALUES
(3, 'Vinyle Transparent', 'Support adhésif transparent cristallin permettant de créer des effets de superposition et de transparence. Idéal pour les applications sur vitres, surfaces transparentes ou pour créer des effets décoratifs sophistiqués. Conserve la transparence tout en offrant une impression de qualité pour logos, textes ou graphismes fins.', 3500.00, '1m', '*Type de matériau : PVC (polychlorure de vinyle) transparent\r\n*Épaisseur : 70 à 100 microns (±10 µm selon la gamme)\r\n*Aspect : Brillant ou mat (selon le choix)\r\n*Adhésif : Permanent ou semi-permanent, transparent à base d’acrylique\r\n*Mode d\'application : À sec ou par pose humide\r\n*Durabilité', 1, 'web_site/static/services/94f3fd18-68dc-44d4-91c0-ea2a7651864d.png', '2025-06-13 16:19:16.996143', '2025-06-14 14:32:10.676086', 1),
(11, 'Kakemono Géant XXXL - 3m/2m', 'Support d\'affichage de très grande dimension conçu pour maximiser l\'impact visuel à longue distance. Cette bâche technique permet de créer des communications monumentales pour façades d\'immeubles, événements majeurs et campagnes publicitaires d\'envergure. Alliant légèreté et résistance pour faciliter la manutention malgré les dimensions exceptionnelles.', 250000.00, '1', 'Matériau : Bâche PVC armée ou textile mesh\r\nGrammage : 440-680 g/m² selon version\r\nÉpaisseur : 0,4-0,7 mm\r\nDimensions max : Jusqu\'à 15m x 50m (750m²)\r\nLargeur de lés : 3,20m à 5,10m\r\nFinition : Mat ou brillant, anti-reflet\r\nArmure : Polyester haute ténacité 1000x1000D\r\nRésolution d\'impression : 360-720 dpi (optimisée distance)\r\nEncres : Solvant grand format, UV-LED\r\nRésistance UV : 3-7 ans selon exposition\r\nRésistance au vent : 150-200 km/h (version mesh)\r\nFinitions : Ourlets thermosoudés renforcés\r\nFixations : Œillets inox Ø15mm tous les 30-50cm\r\nAssemblage : Soudure haute fréquence étanche\r\nPoids total : 3-5 kg/m² selon version\r\nApplications : Façades, stades, événements XXL\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/4fd322a3-42db-4212-bfa8-61c829bc4ed2.jpeg', '2025-06-14 15:00:31.900645', '2025-06-14 15:00:31.900645', 2),
(8, 'Vinyle Opaque', 'Support d\'impression adhésif opaque idéal pour la signalétique intérieure et extérieure. Ce vinyle polymère offre une excellente opacité et une adhérence durable sur diverses surfaces lisses. Parfait pour les enseignes, véhicules, vitrines et applications décoratives nécessitant une couverture totale sans transparence.', 3000.00, '1m', 'Matériau : Vinyle polymère opaque\r\nÉpaisseur : 80-100 microns\r\nGrammage : 140-160 g/m²\r\nFinition : Mat ou brillant\r\nAdhésif : Permanent acrylique\r\nSupport : Papier siliconé 120g\r\nFormats disponibles : De A4 à 3,2m de largeur\r\nRésolution d\'impression : Jusqu\'à 1440 dpi\r\nRésistance UV : 3-5 ans en extérieur\r\nTempérature de pose : +10°C à +40°C\r\nApplications : Surfaces lisses (verre, métal, plastique)\r\nDécoupe : Compatible plotters de découpe\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/4cf9f571-5995-4fe0-98ce-a82ee57165ea.jpg', '2025-06-14 14:28:38.994471', '2025-06-14 14:28:38.994471', 1),
(9, 'Vinyle Micro-Perforé', 'Support adhésif micro-perforé permettant une vision unidirectionnelle. Idéal pour l\'habillage de vitrines et véhicules, il offre une visibilité totale depuis l\'intérieur tout en affichant votre communication côté extérieur. Solution parfaite pour allier discrétion et impact publicitaire sans compromettre la luminosité naturelle.', 4000.00, '1m', 'Matériau : Vinyle PVC micro-perforé\r\nÉpaisseur : 120-140 microns\r\nGrammage : 180-220 g/m²\r\nPerforation : 60/40 (60% surface pleine, 40% perforations)\r\nDiamètre des trous : 1,6 mm\r\nEspacement : 2,4 mm entre centres\r\nAdhésif : Repositionnable puis permanent\r\nSupport : Papier siliconé renforcé\r\nFormats disponibles : De A3 à 1,52m de largeur\r\nRésolution d\'impression : 720-1440 dpi\r\nRésistance UV : 2-3 ans en extérieur\r\nTempérature de pose : +15°C à +35°C\r\nApplications : Vitrines, véhicules, cloisons vitrées\r\nDécoupe : Contour uniquement (perforation fragile)\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/05fc7d92-d193-4dac-b713-9d74e103a767.jpg', '2025-06-14 14:31:25.622213', '2025-06-14 14:50:05.468240', 1),
(10, 'Kakemono Prémium-extérieur', 'Support textile haut de gamme spécialement conçu pour l\'affichage extérieur longue durée. Cette toile technique combine résistance aux intempéries et rendu d\'impression exceptionnel. Idéale pour événements, façades commerciales et communications temporaires nécessitant une présentation premium résistant aux conditions climatiques difficiles.', 80000.00, '1', 'Matériau : Toile polyester technique enduite PVC\r\nGrammage : 510-550 g/m²\r\nÉpaisseur : 0,5-0,6 mm\r\nFinition : Mat anti-reflet, surface lisse\r\nTraitement : Anti-UV, anti-moisissures, ignifugé M2\r\nArmure : Trame 1000x1000 deniers\r\nFormats disponibles : Jusqu\'à 5m de largeur\r\nRésolution d\'impression : 720-1440 dpi\r\nEncres : Solvant, latex, UV\r\nRésistance UV : 3-5 ans en extérieur\r\nRésistance au vent : Jusqu\'à 120 km/h\r\nFinitions : Ourlets soudés + œillets inox tous les 50cm\r\nFixations : Œillets Ø12mm, sangles renforcées disponibles\r\nTempérature d\'utilisation : -30°C à +70°C\r\nApplications : Façades, événements extérieurs, chantiers\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/5263479a-f617-4f51-976e-98db6ee284f0.jpg', '2025-06-14 14:49:49.822853', '2025-06-14 14:49:49.822853', 2),
(12, 'Bâche micro-perforé', 'Support textile technique micro-perforé offrant une résistance exceptionnelle au vent tout en conservant un excellent rendu d\'impression. Cette bâche permet de réduire considérablement la prise au vent (jusqu\'à 40%) tout en maintenant une visibilité optimale. Solution idéale pour les installations extérieures exposées aux vents forts et les façades nécessitant une ventilation.', 6000.00, '1m', 'Matériau : Toile PVC armée micro-perforée\r\nGrammage : 370-450 g/m²\r\nÉpaisseur : 0,45-0,55 mm\r\nPerforation : Micro-trous Ø0,3mm\r\nTaux de perforation : 8-15% de surface ouverte\r\nEspacement : Maillage régulier 2x2mm\r\nArmure : Polyester 500x500 ou 1000x500 deniers\r\nFormats disponibles : Jusqu\'à 5m de largeur\r\nRésolution d\'impression : 720-1080 dpi\r\nEncres : Solvant, éco-solvant, UV\r\nRésistance UV : 3-5 ans en extérieur\r\nRéduction prise au vent : 35-40%\r\nRésistance traction : 280/270 daN (chaîne/trame)\r\nFinitions : Ourlets soudés + œillets inox\r\nFixations : Œillets Ø12mm tous les 50cm\r\nApplications : Façades ventées, échafaudages, clôtures chantier\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 0, 'web_site/static/services/2969cbf4-7eda-4c18-ba41-f8c3761b1f11.jpg', '2025-06-14 15:09:03.444303', '2025-06-16 16:19:38.803277', 3),
(13, 'Bâche Publicitaire', 'Support d\'affichage polyvalent et économique, référence de la communication extérieure. Cette bâche PVC offre un excellent rapport qualité-prix pour tous types de campagnes publicitaires temporaires ou permanentes. Robuste et facilement manipulable, elle s\'adapte à tous les supports et environnements pour une visibilité maximale de votre message.', 4000.00, '1m', 'Matériau : Bâche PVC souple armée\r\nGrammage : 450-510 g/m²\r\nÉpaisseur : 0,45-0,5 mm\r\nFinition : Mat ou brillant au choix\r\nArmure : Polyester 1000x1000 deniers\r\nFormats disponibles : De A3 à 5m de largeur\r\nRésolution d\'impression : 720-1440 dpi\r\nEncres : Solvant, éco-solvant, latex\r\nRésistance UV : 2-5 ans selon exposition\r\nRésistance traction : 190/170 daN (chaîne/trame)\r\nTempérature d\'utilisation : -30°C à +70°C\r\nFinitions standards : Ourlets thermo-soudés\r\nFixations : Œillets laiton ou inox Ø12mm\r\nEspacement œillets : 50cm ou sur demande\r\nDécoupe : Forme libre possible\r\nApplications : Enseignes, événements, chantiers, commerces\r\nStockage : Pliable, résistant aux plis\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/ee32480c-e7d2-4379-bdb8-74b5aafd443f.jpg', '2025-06-14 15:12:42.373565', '2025-06-14 15:12:42.373565', 3),
(14, 'Carte de visite aux coins arrandis', 'Carte de visite avec découpe spéciale aux angles arrondis au lieu des coins droits traditionnels, donnant un aspect plus moderne et ergonomique.', 500.00, '100 pièces', 'Format : 85 x 54 mm standard\r\nRayon de courbure : 3 à 4 mm (standard), jusqu\'à 6 mm possible\r\nDécoupe : par matrice spéciale ou laser\r\nPapier : 300-400g/m² recommandé pour résister à la découpe\r\nCoût supplémentaire : +15 à 30% vs coins droits\r\nQuantité minimum : généralement 250 ex pour amortir les frais de découpe\r\nTemps de production : +1 à 2 jours ouvrés\r\nPelliculage conseillé avant découpe pour éviter l\'effilochage\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/ed26f33b-d0bd-4243-8d64-f7669a73f420.jpg', '2025-06-15 02:45:19.451034', '2025-06-15 13:55:59.519714', 4),
(15, 'Carte de visite recto', 'Support de communication imprimé présentant les informations essentielles d\'un restaurant (nom, adresse, contact, spécialités).', 5000.00, '100 pièces', 'Format standard : 85 x 54 mm (format carte bancaire)\r\nPapier : 300-350g/m² (carton)\r\nImpression : offset ou numérique 4 couleurs (CMJN)\r\nFinitions possibles : pelliculage mat/brillant, vernis UV, gaufrage\r\nZone de texte sécurisée : 3 mm de marge intérieure\r\nRésolution impression : 300 DPI minimum\r\nDécoupe aux angles arrondis optionnelle (rayon 3-4 mm)', 1, 'web_site/static/services/4b6a4cc8-90a9-4b87-bfe2-c18a4f37952e.jpg', '2025-06-15 02:47:13.580480', '2025-06-16 00:04:08.970072', 4),
(16, 'Carte de visite recto-verso', 'Carte de visite imprimée sur les deux faces, permettant d\'optimiser l\'espace d\'information ou de créer un design biface.', 8000.00, '100 pièces', 'Format : 85 x 54 mm\r\nImpression : quadrichromie recto-verso (8 couleurs total)\r\nPapier : 300-350g/m² minimum pour éviter la transparence\r\nOpacité papier : >95% recommandée\r\nRepérage : précision ±0,1 mm entre recto et verso\r\nSéchage : temps prolongé nécessaire entre les deux passes\r\nPelliculage : possible sur une ou deux faces\r\nCoût : +40 à 60% vs recto seul\r\nRésolution : 300 DPI pour chaque face\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/a7381e5b-8307-44a5-84fc-3b691fa7e8ac.jpg', '2025-06-15 02:50:38.889587', '2025-06-16 00:03:47.706821', 4),
(17, 'Carte de visite avec QR code', 'Carte de visite intégrant un code QR permettant l\'accès direct à des informations numériques (site web, vCard, réseaux sociaux).', 8000.00, '100 pièces', 'Taille QR code : minimum 15x15 mm pour lisibilité optimale\r\nRésolution QR : 300 DPI minimum, vectoriel recommandé\r\nZone de silence : 4 modules blancs autour du code\r\nNiveau de correction d\'erreur : M (15%) ou Q (25%) recommandé\r\nContraste : noir sur blanc ou couleurs contrastées (ratio 7:1 minimum)\r\nPosition : angle inférieur droit privilégié\r\nTest obligatoire : vérification scan avant impression\r\nDonnées encodées : maximum 2953 caractères alphanumériques\r\nFormat papier : 350g/m² pour rigidité et scan facilité\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/d6d5a08d-1998-460b-a806-b8781d089286.jpg', '2025-06-15 02:55:02.215149', '2025-06-15 02:55:02.215149', 4),
(18, 'Flayer format A6 recto', 'Support publicitaire au format A6 imprimé sur une seule face, utilisé pour la communication événementielle ou promotionnelle.', 50.00, '100 pièces', 'Format : 105 x 148 mm (A6)\r\nImpression : recto seul, quadrichromie (CMJN)\r\nPapier : 170-250g/m² (papier couché brillant/mat)\r\nZone de sécurité : 3 mm de marge sur tous les bords\r\nFond perdu : 2 mm supplémentaires sur chaque côté\r\nFormat de livraison : 109 x 152 mm (avec fonds perdus)\r\nRésolution : 300 DPI\r\nMode colorimétrique : CMJN\r\nPelliculage optionnel : mat ou brillant\r\nDécoupe : format fini après massicotage\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/5ebc9f54-3954-4385-be0e-9fe020318f64.jpg', '2025-06-15 03:08:08.339804', '2025-06-15 03:08:08.339804', 5),
(19, 'Flayer format A6 recto-verso', 'Support publicitaire au format A6 imprimé sur les deux faces, maximisant l\'espace d\'information pour la communication promotionnelle.', 75.00, '100 pièces', 'Format : 105 x 148 mm (A6)\r\nImpression : recto-verso, quadrichromie (8 couleurs total)\r\nPapier : 200-300g/m² recommandé (éviter transparence)\r\nOpacité papier : >90% minimum\r\nZone de sécurité : 3 mm de marge sur chaque face\r\nFond perdu : 2 mm sur tous les bords\r\nFormat de livraison : 109 x 152 mm (avec fonds perdus)\r\nRepérage : précision ±0,2 mm entre faces\r\nRésolution : 300 DPI pour chaque face\r\nSéchage : temps prolongé nécessaire\r\nCoût : +50 à 70% vs recto seul\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/0b1991f7-5102-4899-9340-97251947d6cc.jpg', '2025-06-15 03:10:55.353063', '2025-06-15 03:10:55.353063', 5),
(20, 'Flayer format DL 10*21', 'Support publicitaire au format DL (210 x 99 mm) en orientation portrait, format économique et pratique pour mailings et distributions.', 50.00, '100 pièces', 'Format : 210 x 99 mm (DL standard)\r\nNote : votre dimension 10x21cm correspond à 100x210mm (format non-standard)\r\nPapier : 135-200g/m² (papier couché)\r\nImpression : offset ou numérique CMJN\r\nZone de sécurité : 3 mm de marge intérieure\r\nFond perdu : 2 mm sur tous les bords\r\nFormat livraison : 214 x 103 mm (avec fonds perdus)\r\nRésolution : 300 DPI minimum\r\nCompatible : enveloppes DL (220 x 110 mm)\r\nPliage possible : en 2 ou 3 volets\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/6cb831ca-84eb-4fa1-b684-ea3fc43fceb6.jpg', '2025-06-15 03:14:32.699008', '2025-06-15 03:14:32.699008', 5),
(21, 'Dépliant A4 Ouvert / A5 Fermé', 'Dépliant publicitaire plié en deux, passant du format A4 ouvert (297 x 210 mm) au format A5 fermé (210 x 148 mm).', 700.00, '1 pièce', 'Format ouvert : 297 x 210 mm (A4)\r\nFormat fermé : 210 x 148 mm (A5)\r\nPliage : 1 pli central (pli roulé)\r\nPapier : 135-170g/m² (éviter gondolement au pliage)\r\nImpression : recto-verso recommandée (4 pages utilisables)\r\nZone de sécurité : 3 mm de marge sur chaque panneau\r\nFond perdu : 2 mm sur contour extérieur\r\nRésolution : 300 DPI\r\nSens de pliage : parallèle ou perpendiculaire au sens fibre\r\nRainage préalable nécessaire si papier >150g/m²\r\nFinition : pelliculage déconseillé (gêne le pliage)\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/75816bec-1369-42bb-b5c9-9e12bdfd8935.jpeg', '2025-06-15 10:26:24.950740', '2025-06-15 10:26:24.950740', 6),
(22, 'Dépliant A4 Ouvert 10 x 21 Fermé 3 Volets', 'Dépliant à 3 volets avec 2 plis parallèles, passant du format A4 ouvert (297 x 210 mm) à un format fermé de 10 x 21 cm.', 700.00, '1 pièce', 'Format ouvert : 297 x 210 mm (A4)\r\nFormat fermé : 100 x 210 mm (10 x 21 cm)\r\nPliage : 2 plis parallèles (pli roulé ou pli accordéon)\r\nLargeur des volets : 99 mm chacun (297 ÷ 3)\r\nPapier : 115-135g/m² maximum (souplesse pour pliage multiple)\r\nImpression : recto-verso (6 faces utilisables)\r\nZone de sécurité : 3 mm de marge par volet\r\nFond perdu : 2 mm sur contour extérieur\r\nRainage : obligatoire sur les 2 lignes de pli\r\nRésolution : 300 DPI\r\nAttention : volet central légèrement plus étroit (-2mm) pour faciliter pliage\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/ae7c8dd3-3034-4175-b65a-42c8afba1386.jpg', '2025-06-15 10:31:06.347479', '2025-06-15 10:31:06.347479', 6),
(23, 'Depliant en plaquette commerciale a 3 volets', 'Plaquette commerciale pliée en 3 volets avec 2 plis parallèles, format professionnel pour présentation d\'entreprise ou de produits.', 1200.00, '1 pièce', 'Format ouvert : 297 x 210 mm (A4) ou 210 x 297 mm\r\nFormat fermé : 99 x 210 mm (pli roulé) ou 70 x 297 mm (pli accordéon)\r\nPliage : 2 plis parallèles\r\nType de pli : roulé (volet intérieur -2mm) ou accordéon (volets égaux)\r\nPapier : 135-170g/m² (papier couché brillant/mat)\r\nImpression : recto-verso (6 faces utilisables)\r\nRainage : obligatoire avant pliage\r\nZone de sécurité : 3 mm par panneau\r\nFond perdu : 2 mm sur périphérie\r\nRésolution : 300 DPI\r\nPelliculage : mat recommandé (n\'entrave pas le pliage)\r\nBAT : maquette blanche conseillée avant impression\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/2eccd2a4-bab7-4fb8-9872-c28e53208a2f.jpeg', '2025-06-15 10:34:48.260813', '2025-06-15 10:40:15.363260', 6),
(24, 'sticker rond', 'Autocollant de forme circulaire utilisé pour marquage, décoration ou identification, adhésif repositionnable ou permanent.', 150.00, '1 pièce', 'Diamètres standards : 20, 25, 30, 40, 50, 60, 80, 100 mm\r\nSupport : vinyle blanc/transparent ou papier adhésif\r\nAdhésif : permanent, repositionnable ou removable\r\nImpression : numérique CMJN + vernis de protection\r\nDécoupe : à la forme par plotter de découpe\r\nRésolution : 300 DPI minimum\r\nPelliculage : optionnel (protection UV et rayures)\r\nÉpaisseur totale : 0,1 à 0,15 mm\r\nRésistance : intérieur/extérieur selon matériau\r\nApplication : surface lisse, propre et sèche\r\nTempérature de pose : +5°C à +40°C\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/e9574cf1-2ad7-47e1-be7b-b43abc365d3c.jpg', '2025-06-15 10:50:18.360956', '2025-06-15 10:50:18.360956', 8),
(25, 'sticker transparent', 'Autocollant en matériau transparent permettant un effet \"vitrophanie\" où seuls les éléments imprimés sont visibles sur la surface d\'application.', 200.00, '1 pièce', 'Support : vinyle polymère transparent ou PET cristal\r\nÉpaisseur : 50 à 100 microns\r\nAdhésif : acrylique permanent ou repositionnable\r\nImpression : sérigraphie, numérique UV ou éco-solvant\r\nCouleurs : encres opaques ou translucides selon effet recherché\r\nDécoupe : plotter ou laser selon forme\r\nRésistance UV : 3 à 7 ans en extérieur\r\nApplication : face interne (vitres) ou externe\r\nTempérature de pose : -10°C à +60°C\r\nRetrait : sans résidu selon adhésif choisi\r\nFormats : de 5x5 cm à plusieurs mètres\r\nFinition : avec ou sans pelliculage de protection\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/6e79488a-d057-4203-a5a5-d20652d0b1f4.jpg', '2025-06-15 10:52:38.571502', '2025-06-15 10:52:38.571502', 8),
(26, 'Etiquette d\'adresse', 'Étiquette adhésive préimprimée ou vierge destinée à l\'identification d\'adresses postales sur courriers, colis ou envois.', 300.00, '1 pièce', 'Formats standards : 70 x 25,4 mm, 99,1 x 38,1 mm, 105 x 37 mm\r\nSupport : papier blanc offset 80g/m² ou synthétique\r\nAdhésif : permanent ou repositionnable selon usage\r\nImpression : laser, jet d\'encre ou thermique directe\r\nConditionnement : planches A4 (21 ou 33 étiquettes) ou rouleaux\r\nPrédécoupe : emporte-pièce précis\r\nRésistance : manipulation postale standard\r\nCompatibilité : imprimantes bureautiques courantes\r\nZone imprimable : respecter marges de 2 mm\r\nPelliculage : optionnel pour protection\r\nNorme postale : conforme aux exigences de La Poste\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/c77cac8d-3916-450c-b92a-e3af1db6013f.jpg', '2025-06-15 10:57:13.945133', '2025-06-15 10:57:13.945133', 8),
(27, 'Etiquette Bouteille', 'Étiquette adhésive spécialement conçue pour l\'habillage et l\'identification de bouteilles (vin, bière, spiritueux, cosmétiques).', 400.00, '1 pièce', 'Formats courants : 90 x 120 mm, 83 x 100 mm, 70 x 105 mm\r\nSupport : papier couché blanc/crème ou synthétique (PP/PE)\r\nAdhésif : permanent résistant à l\'humidité et au froid\r\nImpression : flexographie, offset ou numérique\r\nRésistance : eau, condensation, réfrigération (+2°C)\r\nDécoupe : à la forme avec angles arrondis optionnels\r\nPelliculage : brillant/mat pour protection et aspect premium\r\nDorure/argenture : à chaud possible\r\nGaufrage/embossage : effets de relief\r\nAdhérence : sur verre, PET, métal\r\nDécollement : facilité selon adhésif (removable/permanent)\r\nRésolution : 300 DPI, repérage précis\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/81b2c526-a77c-48b6-a650-4797566e3420.jpg', '2025-06-15 11:00:16.638943', '2025-06-15 11:00:16.638943', 8),
(28, 'Carte d\'invitation Mariage', 'Faire-part de mariage élégant annonçant l\'union et invitant aux célébrations, support de communication personnalisé aux futurs époux.', 500.00, '1 pièce', 'Format : 105 x 148 mm (A6) ou 210 x 148 mm (DL) ou carré 150 x 150 mm\r\nPapier : 250-350g/m² (vergé, lin, texturé ou lisse)\r\nFinitions haut de gamme : dorure à chaud, gaufrage, embossage\r\nImpression : offset ou numérique haute qualité\r\nOptions : découpe laser, coins arrondis, perforation détachable\r\nEnveloppe : assortie, doublée tissus optionnelle\r\nPersonnalisation : noms, date, lieu, dress code\r\nCouleurs : harmonies pastel ou classiques (ivoire, blanc cassé)\r\nRésolution : 300 DPI\r\nDélai : 2-3 semaines pour finitions spéciales\r\nQuantité : par multiple de 25 ou 50\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/225c99e7-e6bb-4c51-ae94-05f0f4884810.jpg', '2025-06-15 11:11:31.982513', '2025-06-15 11:11:31.982513', 9),
(29, 'Carte d\'invitation Décès', 'Faire-part de décès sobre et respectueux annonçant le décès d\'une personne et informant sur les obsèques, envoyé aux proches et connaissances.', 500.00, '1 pièce', 'Format : 105 x 148 mm (A6) ou 148 x 210 mm (A5)\r\nPapier : 200-250g/m² blanc ou ivoire, aspect mat de préférence\r\nImpression : noir et blanc ou couleurs sobres (gris, bleu foncé)\r\nTypographie : classique, lisible (Times, Garamond)\r\nFinitions : liseré noir, cadre discret, sans dorure\r\nEnveloppe : blanche ou grise, format adapté\r\nContenu : nom, dates, lieu/heure obsèques, remerciements\r\nUrgence : impression rapide 24-48h\r\nRésolution : 300 DPI\r\nConditionnement : par 25, 50 ou 100 exemplaires\r\nLivraison : express selon délais de cérémonie\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/74bbeb10-9f21-4e09-b584-ac255434e217.jpg', '2025-06-15 11:14:10.781184', '2025-06-15 11:14:10.781184', 9),
(30, 'Bloc Note A4/A5/A6 couverture Rembordée', 'Support de prise de notes composé de feuilles détachables reliées par collage ou spirale, utilisé pour écriture manuscrite ou dessins.', 1000.00, '1 pièce', 'Formats : A4 (210 x 297 mm), A5 (148 x 210 mm), A6 (105 x 148 mm)\r\nPapier : 70-90g/m² offset blanc ou ligné/quadrillé\r\nNombre de feuilles : 50, 100 ou 200 pages\r\nReliure : collage dos carré, spirale métallique ou plastique\r\nCouverture : carton 300g/m² ou PVC souple\r\nPerforation : micro-perforations pour détachage net\r\nRéglure : ligné (8 mm), quadrillé (5 mm) ou uni\r\nImpression couverture : quadrichromie personnalisable\r\nFinition : pelliculage mat/brillant sur couverture\r\nConditionnement : à l\'unité ou par lots\r\nOptions : élastique de fermeture, marque-page\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/1d1b5c3b-0747-4a0a-b3d5-11a1456c3d1c.png', '2025-06-15 13:38:19.063708', '2025-06-15 13:38:19.063708', 10),
(31, 'Stylos (Grand public )', 'Instruments d\'écriture destinés au marché de masse, économiques et fonctionnels pour usage quotidien (bureau, école, domicile).', 350.00, '1 pièce', 'Types : bille (BIC), gel, feutre, roller\r\nEncre : 0,7-1,0 mm (bille), 0,5-0,7 mm (gel/roller)\r\nCorps : polystyrène ou polypropylène recyclable\r\nLongueur : 140-155 mm standard\r\nAutonomie : 1-3 km de trait selon type\r\nCouleurs : bleu, noir, rouge (standards), multicolores\r\nMécanisme : à capuchon ou rétractable (clic)\r\nPointe : tungstène (bille), céramique (gel), feutre (marqueur)\r\nTempérature d\'usage : -10°C à +50°C\r\nNorme : ISO 12757 (qualité encre)\r\nPrix : 0,20€ à 2€ l\'unité\r\nConditionnement : sachet, boîte 10/50/100 pièces\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/b7973c1e-3282-47d3-8ff5-c25aea699055.jpeg', '2025-06-15 13:43:02.414875', '2025-06-15 13:48:27.146839', 11),
(32, 'Stylos (Luxe)', 'Instruments d\'écriture haut de gamme alliant raffinement, matériaux nobles et performance d\'écriture exceptionnelle, souvent objets de collection ou cadeaux prestigieux.', 500.00, '1 pièce', 'Types : plume, roller, bille de luxe\r\nMatériaux : métal précieux (argent, or), laque, résine noble, bois exotique\r\nPlume : or 14K/18K, acier inoxydable, pointes variées (F, M, B)\r\nMécanisme : cartouche, convertisseur, système piston\r\nFinitions : gravure laser, guilloché, émaux, sertissage\r\nPoids : 15-40g selon matériaux\r\nLongueur : 130-145 mm (fermé)\r\nGarantie : à vie ou 2-25 ans constructeur\r\nMarques : Montblanc, Parker, Waterman, Cross', 1, 'web_site/static/services/94f5bf34-ec06-4ec7-aacb-aa4c5af8593c.jpeg', '2025-06-15 13:47:47.041673', '2025-06-15 13:53:20.691256', 11),
(33, 'T-Shirt anniversaire', 'Vêtement personnalisé conçu spécialement pour célébrer un anniversaire, avec message, âge ou design thématique imprimé.', 5000.00, '1 pièce', 'Textile : coton 100% ou mélange coton/polyester (150-180g/m²)\r\nTailles : XS à 5XL (coupe homme/femme/enfant)\r\nImpression : sérigraphie, flex/flock, transfert numérique, broderie\r\nZone d\'impression : 21 x 29,7 cm (face avant), 21 x 21 cm (dos)\r\nCouleurs textile : blanc, noir, gris, couleurs variées\r\nRésolution : 300 DPI pour impression numérique\r\nEncres : à base d\'eau (écologiques) ou plastisol\r\nLavage : résistance 30-60°C selon technique\r\nPersonnalisation : prénom, âge, photo, message', 1, 'web_site/static/services/1f384efd-924c-4be7-a368-a99bab8b1e30.png', '2025-06-15 14:02:22.931961', '2025-06-15 14:02:22.931961', 12),
(34, 'T-Shirt Mariage', 'Vêtement personnalisé pour événement de mariage, destiné aux mariés, témoins, invités ou enterrement de vie de garçon/fille, avec design thématique', 300.00, '1 pièce', 'Textile : coton peigné 150-180g/m² ou tri-blend (coton/polyester/modal)\r\nCoupes : ajustée, classique, oversize (homme/femme)\r\nTailles : XS à 5XL disponibles\r\nImpression : sérigraphie (durabilité), flex pailleté, transfert DTG\r\nZone imprimable : 28 x 35 cm (devant), 28 x 28 cm (dos)\r\nCouleurs populaires : blanc, rose gold, blush, marine, noir\r\nTechniques spéciales : dorure à chaud, strass, broderie\r\nRésistance : lavage 40°C, résistance UV\r\nPersonnalisation : noms couple, date, rôle (témoin, mariée...)', 1, 'web_site/static/services/287ca15c-f5c2-47ff-b4f3-bd562b36ba51.jpg', '2025-06-15 14:09:42.947490', '2025-06-15 14:09:42.947490', 12),
(35, 'T-Shirt Enfant', 'Vêtement pour enfants en coton doux et résistant, souvent personnalisé avec motifs colorés, dessins animés ou messages adaptés à l\'âge.', 3500.00, '1 pièce', 'Textile : coton 100% ou bio-coton (140-160g/m²)\r\nTailles : 3 mois à 14 ans (système européen/US)\r\nCoupes : droite avec emmanchures ajustées\r\nImpression : encres à base d\'eau (non-toxiques), transfert souple\r\nZone d\'impression : 15 x 20 cm max (proportionnel à la taille)\r\nCouleurs : palette vive et variée (rouge, bleu, jaune, rose)\r\nNormes : Oeko-Tex Standard 100 (sans substances nocives)\r\nLavage : résistance 40°C, séchage doux\r\nFinitions : coutures renforcées, col sans étiquette (confort)\r\nMotifs populaires : super-héros, animaux, éducatifs\r\nSécurité : sans petites pièces détachables\r\nConditionnement : emballage ludique optionnel\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses.', 1, 'web_site/static/services/f0f02113-ec06-4566-be09-499b2d126008.jpeg', '2025-06-15 14:13:24.851437', '2025-06-15 14:13:24.851437', 12),
(36, 'T-Shirt Campagne', 'Vêtement promotionnel utilisé lors de campagnes publicitaires, politiques ou événementielles, porteur de messages, logos ou slogans de sensibilisation.', 2500.00, '1 pièce', 'Textile : coton 150g/m² ou coton bio (image éco-responsable)\r\nCoupes : unisexe standard pour distribution massive\r\nTailles : S à XXL (stocks équilibrés)\r\nImpression : sérigraphie 1-3 couleurs (économique en série)\r\nZone principale : logo/slogan centré 25 x 20 cm\r\nCouleurs stratégiques : selon charte graphique campagne\r\nRésistance : lavages répétés, décoloration minimale\r\nQuantités : minimum 100-500 pièces (tarifs dégressifs)', 1, 'web_site/static/services/b7f293b0-712e-4021-8ae0-59f4ee40e78e.jpg', '2025-06-15 14:18:19.957859', '2025-06-15 14:18:19.957859', 12),
(37, 'Gillet', 'Vêtement sans manches porté par-dessus une chemise ou un pull, utilisé pour l\'élégance vestimentaire ou comme équipement de protection/signalisation', 700.00, '1 pièce', 'Types : costume (laine/polyester), sécurité (polyester haute-visibilité), matelassé (duvet/synthétique)\r\nMatières : laine, coton, polyester, mélanges techniques\r\nGrammage : 200-400g/m² selon usage\r\nTailles : XS à 5XL (coupes homme/femme)\r\nFermeture : boutonnage, zip, scratch selon modèle\r\nDoublure : viscose, polyester ou sans doublure\r\nCouleurs : classiques (noir, gris, marine) ou haute-visibilité (jaune, orange)\r\nNormes : EN ISO 20471 (haute-visibilité), EN 14058 (protection froid)\r\nPersonnalisation : broderie, sérigraphie, transfert\r\nPoches : poitrine, italiennes selon modèle\r\nEntretien : lavage 30-40°C selon matière\r\nRéessayerClaude peut faire des erreurs. Assurez-vous de vérifier ses réponses. Sonnet 4', 1, 'web_site/static/services/96e4e361-1c7b-43d5-bcd8-e24d13b0a3d5.jpg', '2025-06-15 14:33:22.185468', '2025-06-15 14:34:43.725587', 12),
(38, 'Tasse', 'Récipient à anse en céramique ou autres matériaux, utilisé pour boissons chaudes, souvent personnalisé à des fins promotionnelles ou cadeaux.', 5000.00, '1 pièce', 'Capacité : 300-400 ml (standard), 250 ml (petit), 450 ml (large)\r\nMatériaux : céramique, porcelaine, grès, métal, plastique\r\nDimensions : Ø 8-9 cm, hauteur 9-10 cm\r\nImpression : sublimation, sérigraphie, transfert céramique\r\nZone imprimable : 20 x 8 cm (tour complet possible)\r\nRésistance : lave-vaisselle, micro-ondes (selon matériau)\r\nTempérature : -20°C à +120°C (céramique)\r\nCouleurs : blanc (standard), couleurs unies variées\r\nFinitions : mate, brillante, effet métallisé\r\nAnse : ergonomique, résistance 2-3 kg\r\nConditionnement : emballage individuel sécurisé', 1, 'web_site/static/services/d10ff984-4c33-490f-9b7a-83dd3610884f.jpg', '2025-06-15 14:39:31.809746', '2025-06-28 13:06:09.860119', 13),
(39, 'Bol Personnalisé', 'Récipient rond et profond sans anse, personnalisé avec motifs, texte ou photos, utilisé pour petit-déjeuner, collations ou décoration.', 7000.00, '1 pièce', 'Capacité : 300-500 ml (standard), 250 ml (enfant)\r\nMatériaux : céramique, porcelaine, mélamine (enfant), bambou\r\nDimensions : Ø 11-14 cm, hauteur 6-8 cm\r\nImpression : sublimation 360°, sérigraphie, décalcomanie\r\nZone imprimable : surface externe complète\r\nRésistance : lave-vaisselle, micro-ondes (céramique)\r\nTempérature d\'usage : -10°C à +100°C', 1, 'web_site/static/services/5d3e8a9d-6178-46a5-a561-cd40a27d8dbf.jpg', '2025-06-15 14:46:17.093010', '2025-06-15 14:46:17.093010', 13),
(40, 'Modèle 1', 'Petit objet décoratif métallique à épingle, porté sur vêtements ou accessoires, utilisé pour identification, collection ou communication visuelle.', 250.00, '1 pièce', 'Dimensions : 15-30 mm (standard), jusqu\'à 50 mm possible\r\nMatériaux : laiton, fer, zamak, aluminium\r\nÉpaisseur : 1,2-2 mm selon technique\r\nTechniques : émail dur, émail mou, impression offset, gravure\r\nFinitions : nickelé, doré, argenté, antique, noir\r\nFixation : papillon standard, vis, aimant, clip\r\nCouleurs : Pantone ou quadrichromie selon technique\r\nRelief : 2D plat ou 3D avec relief\r\nRésistance : usage quotidien, résistant à l\'eau\r\nQuantité minimum : 50-100 pièces\r\nDélai : 10-15 jours selon complexité\r\nConditionnement : sachet individuel ou présentoir\r\nPersonnalisation : logo, texte, formes sur-mesure', 1, 'web_site/static/services/4fc439cf-60ec-464b-a3b0-e7468a88b8b2.jpg', '2025-06-15 15:08:42.090947', '2025-06-16 18:36:08.045636', 14),
(41, 'Modèle 2', 'Petit objet décoratif métallique à épingle, porté sur vêtements ou accessoires, utilisé pour identification, collection ou communication visuelle.', 250.00, '1 pièce', 'Dimensions : 15-30 mm (standard), jusqu\'à 50 mm possible\r\nMatériaux : laiton, fer, zamak, aluminium\r\nÉpaisseur : 1,2-2 mm selon technique\r\nTechniques : émail dur, émail mou, impression offset, gravure\r\nFinitions : nickelé, doré, argenté, antique, noir\r\nFixation : papillon standard, vis, aimant, clip\r\nCouleurs : Pantone ou quadrichromie selon technique\r\nRelief : 2D plat ou 3D avec relief\r\nRésistance : usage quotidien, résistant à l\'eau\r\nQuantité minimum : 50-100 pièces\r\nDélai : 10-15 jours selon complexité\r\nConditionnement : sachet individuel ou présentoir\r\nPersonnalisation : logo, texte, formes sur-mesure', 1, 'web_site/static/services/a5d936bf-ac4b-4358-aef9-ba0f0f06cce7.jpg', '2025-06-15 15:09:58.752707', '2025-06-15 15:09:58.752707', 14),
(42, 'Casquette Personnalisé', 'Couvre-chef à visière rigide, utilisé pour protection solaire ou communication visuelle, souvent personnalisé avec logos d\'entreprises ou événements.', 2000.00, '1 pièce', 'Matériaux : coton, polyester, coton/polyester, mesh (aéré)\r\nGrammage : 180-250g/m² selon qualité\r\nVisière : PE rigide, courbure 6 ou 8 panneaux\r\nFermeture : scratch velcro, boucle plastique, élastique, fitted\r\nTailles : réglable (54-60 cm) ou tailles fixes\r\nCouleurs : palette complète, bicolore possible\r\nImpression : broderie (durabilité), sérigraphie, transfert\r\nZone marquage : devant 10 x 6 cm, côtés, arrière\r\nStructure : 5 ou 6 panneaux cousus', 1, 'web_site/static/services/bafcddf5-ab36-431b-bc19-3c8e96f1f488.jpeg', '2025-06-15 15:20:21.491310', '2025-06-15 15:20:21.491310', 15),
(43, 'Casquette Simple', 'Couvre-chef à visière rigide, utilisé pour protection solaire ou communication visuelle, souvent personnalisé avec logos d\'entreprises ou événements.', 1500.00, '1 pièce', 'Matériaux : coton, polyester, coton/polyester, mesh (aéré)\r\nGrammage : 180-250g/m² selon qualité\r\nVisière : PE rigide, courbure 6 ou 8 panneaux\r\nFermeture : scratch velcro, boucle plastique, élastique, fitted\r\nTailles : réglable (54-60 cm) ou tailles fixes\r\nCouleurs : palette complète, bicolore possible\r\nImpression : broderie (durabilité), sérigraphie, transfert\r\nZone marquage : devant 10 x 6 cm, côtés, arrière\r\nStructure : 5 ou 6 panneaux cousus', 1, 'web_site/static/services/624a29fe-2e84-46ca-ae63-62a03c13b717.jpg', '2025-06-15 15:23:09.061677', '2025-06-15 15:23:09.061677', 15),
(44, 'Bonnet Avec ou Sans la personnalisation', 'Couvre-chef souple sans visière, tricot ou tissé, porté pour protection contre le froid ou comme accessoire de mode, souvent personnalisable.', 2000.00, '1 pièce', 'Matières : laine, acrylique, coton, polyester, mélanges techniques\r\nGrammage : 200-400g/m² selon épaisseur tricot\r\nTricotage : jersey, côtes 1x1 ou 2x2, jacquard\r\nTailles : unique élastique ou S/M/L/XL\r\nTour de tête : 54-60 cm (adulte), 48-54 cm (enfant)\r\nStyles : court, long, avec pompon, revers\r\nDoublure : polaire, sherpa ou sans doublure\r\nPersonnalisation : broderie, patch, jacquard intégré\r\nZone marquage : front 8 x 5 cm, tour complet possible\r\nCouleurs : unies ou bicolores, palette complète\r\nFinitions : surpiqûres, étiquette tissée\r\nLavage : 30°C délicat, séchage à plat', 1, 'web_site/static/services/ae058a62-b196-45c6-9c90-bb5f4737601e.jpeg', '2025-06-15 15:28:10.432140', '2025-06-15 15:28:10.432140', 15),
(45, 'Bonnet Femme Avec ou Sans la personnalisation', 'Couvre-chef souple sans visière, tricot ou tissé, porté pour protection contre le froid ou comme accessoire de mode, souvent personnalisable.', 2000.00, '1 pièce', 'Matières : laine, acrylique, coton, polyester, mélanges techniques\r\nGrammage : 200-400g/m² selon épaisseur tricot\r\nTricotage : jersey, côtes 1x1 ou 2x2, jacquard\r\nTailles : unique élastique ou S/M/L/XL\r\nTour de tête : 54-60 cm (adulte), 48-54 cm (enfant)\r\nStyles : court, long, avec pompon, revers\r\nDoublure : polaire, sherpa ou sans doublure\r\nPersonnalisation : broderie, patch, jacquard intégré\r\nZone marquage : front 8 x 5 cm, tour complet possible\r\nCouleurs : unies ou bicolores, palette complète\r\nFinitions : surpiqûres, étiquette tissée\r\nLavage : 30°C délicat, séchage à plat', 1, 'web_site/static/services/0d4f97d5-f867-4c6b-8e30-6f0321587eaa.jpg', '2025-06-15 15:30:03.904138', '2025-06-15 15:30:03.904138', 15),
(46, 'Tampons de Poche/Bic', 'Outils d\'impression manuelle utilisant encre et surface gravée pour reproduire textes, logos ou motifs sur documents, tissus ou autres supports.', 4000.00, '1 pièce', 'Types : automatique, traditionnel, dateur, numéroteur\r\nMatériaux : caoutchouc, photopolymère, laser rubber\r\nMonture : bois, plastique ABS, métal (automatiques)\r\nDimensions : 10x10 mm à 100x100 mm standard\r\nEncrage : coussin intégré (auto-encreur) ou tampon externe\r\nEncres : pigmentées, à séchage rapide, permanentes ou lavables\r\nRésolution : 300-600 DPI pour gravure laser\r\nDurée de vie : 10 000 à 100 000 impressions\r\nTempératures : -10°C à +50°C d\'utilisation\r\nPersonnalisation : texte, logo, QR code, signature\r\nDélai fabrication : 24h-72h selon complexité\r\nRechargeable : cartouches d\'encre de rechange', 1, 'web_site/static/services/0027ec0c-c46f-4ebe-bd07-e7784fe3981c.jpeg', '2025-06-15 15:40:56.453755', '2025-06-15 15:40:56.453755', 16),
(47, 'Tampons Rectangle', 'Outils d\'impression manuelle utilisant encre et surface gravée pour reproduire textes, logos ou motifs sur documents, tissus ou autres supports.', 5000.00, '1 pièce', 'Types : automatique, traditionnel, dateur, numéroteur\r\nMatériaux : caoutchouc, photopolymère, laser rubber\r\nMonture : bois, plastique ABS, métal (automatiques)\r\nDimensions : 10x10 mm à 100x100 mm standard\r\nEncrage : coussin intégré (auto-encreur) ou tampon externe\r\nEncres : pigmentées, à séchage rapide, permanentes ou lavables\r\nRésolution : 300-600 DPI pour gravure laser\r\nDurée de vie : 10 000 à 100 000 impressions\r\nTempératures : -10°C à +50°C d\'utilisation\r\nPersonnalisation : texte, logo, QR code, signature\r\nDélai fabrication : 24h-72h selon complexité\r\nRechargeable : cartouches d\'encre de rechange', 1, 'web_site/static/services/ffe52f84-01e2-4e36-ae56-32de0ba7c35e.jpeg', '2025-06-15 15:42:19.269067', '2025-06-15 15:46:04.555161', 16),
(48, 'Tampns Dateur', 'Outils d\'impression manuelle utilisant encre et surface gravée pour reproduire textes, logos ou motifs sur documents, tissus ou autres supports.', 5000.00, '1 pièce', 'Types : automatique, traditionnel, dateur, numéroteur\r\nMatériaux : caoutchouc, photopolymère, laser rubber\r\nMonture : bois, plastique ABS, métal (automatiques)\r\nDimensions : 10x10 mm à 100x100 mm standard\r\nEncrage : coussin intégré (auto-encreur) ou tampon externe\r\nEncres : pigmentées, à séchage rapide, permanentes ou lavables\r\nRésolution : 300-600 DPI pour gravure laser\r\nDurée de vie : 10 000 à 100 000 impressions\r\nTempératures : -10°C à +50°C d\'utilisation\r\nPersonnalisation : texte, logo, QR code, signature\r\nDélai fabrication : 24h-72h selon complexité\r\nRechargeable : cartouches d\'encre de rechange', 1, 'web_site/static/services/961e084c-a59d-4cb4-81bc-9c089da10879.jpeg', '2025-06-15 15:44:03.405331', '2025-06-15 15:44:03.405331', 16),
(49, 'Tampons Dateur Rectangle', 'Outils d\'impression manuelle utilisant encre et surface gravée pour reproduire textes, logos ou motifs sur documents, tissus ou autres supports.', 60000.00, '1 pièce', 'Types : automatique, traditionnel, dateur, numéroteur\r\nMatériaux : caoutchouc, photopolymère, laser rubber\r\nMonture : bois, plastique ABS, métal (automatiques)\r\nDimensions : 10x10 mm à 100x100 mm standard\r\nEncrage : coussin intégré (auto-encreur) ou tampon externe\r\nEncres : pigmentées, à séchage rapide, permanentes ou lavables\r\nRésolution : 300-600 DPI pour gravure laser\r\nDurée de vie : 10 000 à 100 000 impressions\r\nTempératures : -10°C à +50°C d\'utilisation\r\nPersonnalisation : texte, logo, QR code, signature\r\nDélai fabrication : 24h-72h selon complexité\r\nRechargeable : cartouches d\'encre de rechange', 1, 'web_site/static/services/767ea56a-de6a-4444-824c-948d31948943.jpeg', '2025-06-15 15:45:45.908137', '2025-06-15 15:45:45.908137', 16),
(50, 'Tapis de prière', 'Tapis de prière islamique personnalisé avec motifs religieux, calligraphie arabe ou éléments décoratifs respectant les traditions musulmanes.', 10000.00, '1 pièce', 'Dimensions : 70 x 110 cm (standard), 60 x 100 cm, 80 x 120 cm\r\nMatériaux : polyester, polypropylène, coton, laine\r\nÉpaisseur : 5-8 mm, mousse antidérapante\r\nImpression : sublimation, tufting, tissage jacquard\r\nMotifs : mihrab, mosquées, calligraphie, motifs géométriques\r\nCouleurs : verte, bleue, bordeaux, beige (couleurs traditionnelles)\r\nFinitions : bordures cousues, franges optionnelles\r\nBase : antidérapante en latex naturel\r\nRésistance : lavage délicat 30°C, usage intensif\r\nPersonnalisation : nom, mosquée locale, versets (avec respect religieux)\r\nConditionnement : emballage respectueux, housse de transport\r\nNormes : respectueuses des prescriptions islamiques', 1, 'web_site/static/services/a69e3b36-6701-4e23-8f63-439b99af6cf0.jpg', '2025-06-15 16:00:06.736236', '2025-06-15 16:00:06.736236', 17),
(51, 'Tapis Personnalisé modèle pour Couple', 'Tapis décoratif personnalisé pour couples, avec noms, dates importantes ou messages romantiques, utilisé comme élément de décoration intérieure.', 15000.00, '2 pièces', 'Dimensions : 70 x 110 cm (standard), 60 x 100 cm, 80 x 120 cm\r\nMatériaux : polyester, polypropylène, coton, laine\r\nÉpaisseur : 5-8 mm, mousse antidérapante\r\nImpression : sublimation, tufting, tissage jacquard\r\nMotifs : mihrab, mosquées, calligraphie, motifs géométriques\r\nCouleurs : verte, bleue, bordeaux, beige (couleurs traditionnelles)\r\nFinitions : bordures cousues, franges optionnelles\r\nBase : antidérapante en latex naturel\r\nRésistance : lavage délicat 30°C, usage intensif\r\nPersonnalisation : nom, mosquée locale, versets (avec respect religieux)\r\nConditionnement : emballage respectueux, housse de transport\r\nNormes : respectueuses des prescriptions islamiques', 1, 'web_site/static/services/7f780fbe-110a-42ee-99c6-b332b30d11d8.jpg', '2025-06-15 16:03:00.753822', '2025-06-15 16:03:00.753822', 17),
(52, 'Autre Modèle', 'Tapis décoratif personnalisé pour couples, avec noms, dates importantes ou messages romantiques, utilisé comme élément de décoration intérieure.', 10000.00, '1 pièce', 'Dimensions : 70 x 110 cm (standard), 60 x 100 cm, 80 x 120 cm\r\nMatériaux : polyester, polypropylène, coton, laine\r\nÉpaisseur : 5-8 mm, mousse antidérapante\r\nImpression : sublimation, tufting, tissage jacquard\r\nMotifs : mihrab, mosquées, calligraphie, motifs géométriques\r\nCouleurs : verte, bleue, bordeaux, beige (couleurs traditionnelles)\r\nFinitions : bordures cousues, franges optionnelles\r\nBase : antidérapante en latex naturel\r\nRésistance : lavage délicat 30°C, usage intensif\r\nPersonnalisation : nom, mosquée locale, versets (avec respect religieux)\r\nConditionnement : emballage respectueux, housse de transport\r\nNormes : respectueuses des prescriptions islamiques\r\nRéessayerCtapis pour coupleModifierDescription :\r\nTapis décoratif personnalisé pour couples, avec noms, dates importantes ou messages romantiques, utilisé comme élément de décoration intérieure.\r\nSpécificités techniques :\r\n\r\nDimensions : 60 x 90 cm, 80 x 120 cm, 120 x 160 cm\r\nMatériaux : polyester doux, microfibre, coton, velours\r\nÉpaisseur : 8-12 mm avec mousse mémoire\r\nImpression : sublimation haute définition, tufting\r\nMotifs : cœurs, initiales entrelacées, photos couple, citations\r\nCouleurs : tons romantiques (rose, rouge, blanc, pastel)\r\nBase : antidérapante en caoutchouc naturel\r\nFinitions : bordures surfilées, effet 3D optionnel\r\nRésistance : lavage machine 30°C, séchage doux\r\nPersonnalisation : prénoms, date mariage, \"Mr & Mrs\", photos\r\nZones d\'usage : chambre, salon, entrée\r\nConditionnement : emballage cadeau disponible', 1, 'web_site/static/services/2cc96908-c59a-49aa-8b7d-002634aa3f9d.jpg', '2025-06-15 16:05:47.223478', '2025-06-15 16:05:47.223478', 17),
(53, 'Tapis pour Enfant', 'Tapis de prière islamique personnalisé avec motifs religieux, calligraphie arabe ou éléments décoratifs respectant les traditions musulmanes.', 8000.00, '1 pièce', 'Dimensions : 70 x 110 cm (standard), 60 x 100 cm, 80 x 120 cm\r\nMatériaux : polyester, polypropylène, coton, laine\r\nÉpaisseur : 5-8 mm, mousse antidérapante\r\nImpression : sublimation, tufting, tissage jacquard\r\nMotifs : mihrab, mosquées, calligraphie, motifs géométriques\r\nCouleurs : verte, bleue, bordeaux, beige (couleurs traditionnelles)\r\nFinitions : bordures cousues, franges optionnelles\r\nBase : antidérapante en latex naturel\r\nRésistance : lavage délicat 30°C, usage intensif\r\nPersonnalisation : nom, mosquée locale, versets (avec respect religieux)\r\nConditionnement : emballage respectueux, housse de transport\r\nNormes : respectueuses des prescriptions islamiques\r\nRéessayerCtapis pour coupleModifierDescription :\r\nTapis décoratif personnalisé pour couples, avec noms, dates importantes ou messages romantiques, utilisé comme élément de décoration intérieure.\r\nSpécificités techniques :\r\n\r\nDimensions : 60 x 90 cm, 80 x 120 cm, 120 x 160 cm\r\nMatériaux : polyester doux, microfibre, coton, velours\r\nÉpaisseur : 8-12 mm avec mousse mémoire\r\nImpression : sublimation haute définition, tufting\r\nMotifs : cœurs, initiales entrelacées, photos couple, citations\r\nCouleurs : tons romantiques (rose, rouge, blanc, pastel)\r\nBase : antidérapante en caoutchouc naturel\r\nFinitions : bordures surfilées, effet 3D optionnel\r\nRésistance : lavage machine 30°C, séchage doux\r\nPersonnalisation : prénoms, date mariage, \"Mr & Mrs\", photos\r\nZones d\'usage : chambre, salon, entrée\r\nConditionnement : emballage cadeau disponible', 1, 'web_site/static/services/497a9f0c-06de-4a07-8a2a-375fe7669127.jpg', '2025-06-15 16:08:35.334592', '2025-06-15 16:08:35.334592', 17),
(54, 'Gourde Isotherme', 'Récipient portable étanche pour transport de liquides, réutilisable et souvent isotherme, utilisé pour hydratation nomade et activités sportives.', 4000.00, '1 pièce', 'Capacités : 250 ml, 500 ml, 750 ml, 1L (standards)\r\nMatériaux : inox 18/8, aluminium, plastique sans BPA, verre\r\nIsolation : double paroi (maintien 6-12h chaud/froid)\r\nDimensions : Ø 6-8 cm, hauteur 15-30 cm selon capacité\r\nBouchons : sport, vis, paille rétractable, bouton-poussoir\r\nÉtanchéité : joints silicone, norme IPX7\r\nTempérature : -20°C à +100°C (inox)\r\nPoids : 200-600g selon matériau et capacité\r\nMarquage : sérigraphie, gravure laser, sublimation', 1, 'web_site/static/services/31c9f405-7d1b-4b49-85e7-cfefd8c50052.jpg', '2025-06-15 21:25:11.124375', '2025-06-15 21:25:11.124375', 22),
(55, 'Gourde Personnalisée', 'Récipient portable étanche pour transport de liquides, réutilisable et souvent isotherme, utilisé pour hydratation nomade et activités sportives.', 5000.00, '1 pièce', 'Capacités : 250 ml, 500 ml, 750 ml, 1L (standards)\r\nMatériaux : inox 18/8, aluminium, plastique sans BPA, verre\r\nIsolation : double paroi (maintien 6-12h chaud/froid)\r\nDimensions : Ø 6-8 cm, hauteur 15-30 cm selon capacité\r\nBouchons : sport, vis, paille rétractable, bouton-poussoir\r\nÉtanchéité : joints silicone, norme IPX7\r\nTempérature : -20°C à +100°C (inox)\r\nPoids : 200-600g selon matériau et capacité\r\nMarquage : sérigraphie, gravure laser, sublimation', 1, 'web_site/static/services/e8b3c6f1-45da-4173-9551-270cd697648b.jpg', '2025-06-15 21:27:24.458720', '2025-06-15 21:27:24.458720', 22);

-- --------------------------------------------------------

--
-- Structure de la table `web_site_service_modeldetail`
--

DROP TABLE IF EXISTS `web_site_service_modeldetail`;
CREATE TABLE IF NOT EXISTS `web_site_service_modeldetail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom_option` varchar(100) NOT NULL,
  `type_option` varchar(10) NOT NULL,
  `valeurs_possibles` json DEFAULT NULL,
  `obligatoire` tinyint(1) NOT NULL,
  `prix_supplementaire` decimal(8,2) NOT NULL,
  `service_model_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_site_service_modelde_service_model_id_nom_opt_14133a47_uniq` (`service_model_id`,`nom_option`),
  KEY `web_site_service_modeldetail_service_model_id_d99ae21d` (`service_model_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_setting`
--

DROP TABLE IF EXISTS `web_site_setting`;
CREATE TABLE IF NOT EXISTS `web_site_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cle` varchar(100) NOT NULL,
  `valeur` longtext NOT NULL,
  `type_donnee` varchar(10) NOT NULL,
  `description` longtext NOT NULL,
  `date_modification` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cle` (`cle`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_testimonial`
--

DROP TABLE IF EXISTS `web_site_testimonial`;
CREATE TABLE IF NOT EXISTS `web_site_testimonial` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom_client` varchar(200) NOT NULL,
  `email_client` varchar(254) NOT NULL,
  `note` int UNSIGNED NOT NULL,
  `commentaire` longtext NOT NULL,
  `approuve` tinyint(1) NOT NULL,
  `affiche_public` tinyint(1) NOT NULL,
  `date_creation` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_site_testimonial_user_id_d444e1e1` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_user`
--

DROP TABLE IF EXISTS `web_site_user`;
CREATE TABLE IF NOT EXISTS `web_site_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nom_complet` varchar(200) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `role` varchar(10) NOT NULL,
  `date_creation` datetime(6) NOT NULL,
  `derniere_connexion` datetime(6) DEFAULT NULL,
  `actif` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `web_site_user`
--

INSERT INTO `web_site_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `nom_complet`, `telephone`, `role`, `date_creation`, `derniere_connexion`, `actif`) VALUES
(1, 'pbkdf2_sha256$1000000$DewQ22FBCb4DddNJfrGoBi$htdxhEKBoQIEuk4hUsdV6q1jF8snRLhc3LwNM01n2tk=', '2025-06-28 01:11:11.341520', 1, 'cisse', '', '', 'cisse@gmail.com', 1, 1, '2025-06-13 12:20:17.813516', '', '', 'CLIENT', '2025-06-13 12:20:19.129748', NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `web_site_user_groups`
--

DROP TABLE IF EXISTS `web_site_user_groups`;
CREATE TABLE IF NOT EXISTS `web_site_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_site_user_groups_user_id_group_id_8385cf8f_uniq` (`user_id`,`group_id`),
  KEY `web_site_user_groups_user_id_f91c23c3` (`user_id`),
  KEY `web_site_user_groups_group_id_8234795c` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `web_site_user_user_permissions`
--

DROP TABLE IF EXISTS `web_site_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `web_site_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_site_user_user_permi_user_id_permission_id_c101e79f_uniq` (`user_id`,`permission_id`),
  KEY `web_site_user_user_permissions_user_id_4e9f0162` (`user_id`),
  KEY `web_site_user_user_permissions_permission_id_012e34df` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
