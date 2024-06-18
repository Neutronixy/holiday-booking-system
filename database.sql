-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2022 at 05:19 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jet2holidays`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `address_road_name` varchar(255) NOT NULL,
  `address_building_number` varchar(255) NOT NULL,
  `address_postcode` varchar(255) NOT NULL,
  `city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_id`, `address_road_name`, `address_building_number`, `address_postcode`, `city_id`) VALUES
(1, 'Belfast International Airport', '', 'BT3 9JH', 1),
(2, 'Airport Rd', '', 'BT29 4AB', 1),
(3, 'Via Fontanarossa', '', '95121', 21),
(4, 'Cinisi', '', '90045', 22),
(8, 'Via Libeccio', '50', '95121', 21),
(9, 'Via Mar Nero, Vaccarizzo-delfino', '1', '95121', 21),
(10, 'Via Libeccio, Vaccarizzo-delfino', '45', '95121', 21),
(11, 'Piazza Trento', '13', '95129', 21);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `airport_id` int(11) NOT NULL,
  `airport_name` varchar(255) NOT NULL,
  `airport_latitude` decimal(8,6) NOT NULL,
  `airport_longitude` decimal(9,6) NOT NULL,
  `airport_code` varchar(255) NOT NULL,
  `address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`airport_id`, `airport_name`, `airport_latitude`, `airport_longitude`, `airport_code`, `address_id`) VALUES
(2, 'Belfast City Airport', '54.617708', '-5.871826', 'BHD', 1),
(3, 'Belfast International Airport', '54.658021', '-6.216714', 'BFS', 2),
(4, 'Palermo Airport', '38.180023', '13.098882', 'PMO', 4),
(5, 'Catania Airport', '37.467317', '15.065884', 'CTA', 3);

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_reference` varchar(255) NOT NULL,
  `booking_creation_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `booking_end_contract_date` date NOT NULL,
  `booking_paid_price` decimal(10,2) NOT NULL,
  `booking_payment_reference` varchar(255) NOT NULL,
  `booking_discount_code` varchar(255) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `customer_lead_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `booking_reference`, `booking_creation_timestamp`, `booking_end_contract_date`, `booking_paid_price`, `booking_payment_reference`, `booking_discount_code`, `payment_method_id`, `customer_lead_id`) VALUES
(1, 'FDHHUW356', '2022-11-28 15:51:02', '2023-01-15', '2530.00', '2346erge445', '656465', 3, 1),
(2, 'YYGYHUS24', '2022-11-28 16:12:05', '2023-04-01', '7750.00', 'h23h4gfjh42', '765645', 2, 1),
(3, 'DGWHW3246', '2022-12-01 16:07:13', '2023-01-16', '3034.00', 'si3bfu579dc', '263577', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `card_id` int(11) NOT NULL,
  `card_type` varchar(255) NOT NULL,
  `card_owner_name` varchar(255) NOT NULL,
  `card_owner_surname` varchar(255) NOT NULL,
  `card_expiration_date` date NOT NULL,
  `card_long_number_cvv` varbinary(255) NOT NULL,
  `customer_lead_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(255) NOT NULL,
  `city_description` text NOT NULL,
  `city_url` varchar(2048) NOT NULL,
  `county_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `city_name`, `city_description`, `city_url`, `county_id`, `region_id`, `country_id`) VALUES
(1, 'Belfast', 'Queen\'s university the best', 'https://www.belfastcity.gov.uk/cityhall', 1, 5, 1),
(2, 'Milazzo', 'The best sea ever, be careful with the coast restrictions, use the url', 'https://www.comune.milazzo.me.it/', 2, 6, 7),
(16, 'Altishane', '', '', NULL, 5, 1),
(17, 'Katesbridge', '', '', NULL, 5, 1),
(18, 'Inishrush', '', '', NULL, 5, 1),
(19, 'Newbuildings', '', '', NULL, 5, 1),
(20, 'Edenaveys', '', '', NULL, 5, 1),
(21, 'Catania', 'beautiful city, the second bigghest city in Sicily', '', 3, 6, 7),
(22, 'Palermo', 'Best Arancini', '', 4, 6, 7);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(255) NOT NULL,
  `country_description` text NOT NULL,
  `country_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`, `country_description`, `country_url`) VALUES
(1, 'United Kingdom', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.\n\nMorbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\n\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 'https://cnet.com/condimentum/neque/sapien.jpg?ante=malesuada&ipsum=in&primis=imperdiet&in=et&faucibus=commodo&orci=vulputate&luctus=justo&et=in&ultrices=blandit&posuere=ultrices&cubilia=enim&curae=lorem&mauris=ipsum&viverra=dolor&diam=sit&vitae=amet&quam=consectetuer&suspendisse=adipiscing&potenti=elit&nullam=proin&porttitor=interdum&lacus=mauris&at=non&turpis=ligula&donec=pellentesque&posuere=ultrices&metus=phasellus&vitae=id&ipsum=sapien&aliquam=in&non=sapien&mauris=iaculis&morbi=congue&non=vivamus&lectus=metus&aliquam=arcu&sit=adipiscing&amet=molestie&diam=hendrerit&in=at&magna=vulputate&bibendum=vitae&imperdiet=nisl&nullam=aenean&orci=lectus&pede=pellentesque&venenatis=eget&non=nunc&sodales=donec&sed=quis&tincidunt=orci&eu=eget&felis=orci&fusce=vehicula&posuere=condimentum&felis=curabitur&sed=in&lacus=libero&morbi=ut&sem=massa&mauris=volutpat&laoreet=convallis&ut=morbi'),
(2, 'France', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\r\n\r\nFusce consequat. Nulla nisl. Nunc nisl.\r\n\r\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'https://theatlantic.com/nec/euismod/scelerisque/quam/turpis.png?condimentum=vel&id=pede&luctus=morbi&nec=porttitor&molestie=lorem&sed=id&justo=ligula&pellentesque=suspendisse&viverra=ornare&pede=consequat&ac=lectus&diam=in&cras=est&pellentesque=risus&volutpat=auctor&dui=sed&maecenas=tristique&tristique=in&est=tempus&et=sit&tempus=amet&semper=sem&est=fusce&quam=consequat&pharetra=nulla&magna=nisl&ac=nunc&consequat=nisl&metus=duis&sapien=bibendum&ut=felis&nunc=sed&vestibulum=interdum&ante=venenatis&ipsum=turpis&primis=enim&in=blandit&faucibus=mi&orci=in&luctus=porttitor&et=pede&ultrices=justo&posuere=eu&cubilia=massa&curae=donec&mauris=dapibus&viverra=duis&diam=at&vitae=velit&quam=eu&suspendisse=est&potenti=congue&nullam=elementum&porttitor=in&lacus=hac&at=habitasse&turpis=platea&donec=dictumst&posuere=morbi&metus=vestibulum&vitae=velit&ipsum=id&aliquam=pretium&non=iaculis&mauris=diam&morbi=erat&non=fermentum&lectus=justo&aliquam=nec&sit=condimentum&amet=neque&diam=sapien&in=placerat&magna=ante&bibendum=nulla&imperdiet=justo&nullam=aliquam&orci=quis&pede=turpis'),
(3, 'China', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.\r\n\r\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\r\n\r\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 'https://nymag.com/commodo/vulputate/justo/in/blandit/ultrices.png?orci=velit&luctus=id&et=pretium&ultrices=iaculis&posuere=diam&cubilia=erat&curae=fermentum&donec=justo&pharetra=nec&magna=condimentum&vestibulum=neque&aliquet=sapien&ultrices=placerat&erat=ante&tortor=nulla&sollicitudin=justo&mi=aliquam&sit=quis&amet=turpis&lobortis=eget&sapien=elit&sapien=sodales&non=scelerisque&mi=mauris&integer=sit&ac=amet&neque=eros&duis=suspendisse&bibendum=accumsan'),
(4, 'Philippines', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'http://tinypic.com/aliquet.json?integer=vestibulum&pede=rutrum&justo=rutrum&lacinia=neque&eget=aenean&tincidunt=auctor&eget=gravida&tempus=sem&vel=praesent&pede=id&morbi=massa&porttitor=id&lorem=nisl&id=venenatis&ligula=lacinia&suspendisse=aenean&ornare=sit&consequat=amet&lectus=justo&in=morbi&est=ut&risus=odio&auctor=cras&sed=mi&tristique=pede&in=malesuada&tempus=in&sit=imperdiet&amet=et&sem=commodo&fusce=vulputate&consequat=justo&nulla=in&nisl=blandit&nunc=ultrices&nisl=enim&duis=lorem&bibendum=ipsum&felis=dolor&sed=sit&interdum=amet&venenatis=consectetuer&turpis=adipiscing&enim=elit&blandit=proin&mi=interdum&in=mauris&porttitor=non&pede=ligula&justo=pellentesque&eu=ultrices&massa=phasellus&donec=id&dapibus=sapien&duis=in&at=sapien&velit=iaculis&eu=congue&est=vivamus&congue=metus&elementum=arcu&in=adipiscing&hac=molestie&habitasse=hendrerit&platea=at&dictumst=vulputate&morbi=vitae&vestibulum=nisl&velit=aenean&id=lectus&pretium=pellentesque&iaculis=eget&diam=nunc&erat=donec&fermentum=quis&justo=orci&nec=eget&condimentum=orci&neque=vehicula&sapien=condimentum&placerat=curabitur&ante=in&nulla=libero'),
(5, 'Uruguay', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 'https://nasa.gov/ipsum/primis/in/faucibus/orci/luctus/et.png?nulla=in&ultrices=consequat&aliquet=ut&maecenas=nulla&leo=sed&odio=accumsan&condimentum=felis&id=ut&luctus=at&nec=dolor&molestie=quis&sed=odio&justo=consequat&pellentesque=varius&viverra=integer&pede=ac&ac=leo&diam=pellentesque&cras=ultrices&pellentesque=mattis&volutpat=odio&dui=donec&maecenas=vitae&tristique=nisi&est=nam&et=ultrices&tempus=libero&semper=non&est=mattis&quam=pulvinar&pharetra=nulla&magna=pede&ac=ullamcorper&consequat=augue&metus=a&sapien=suscipit&ut=nulla&nunc=elit&vestibulum=ac&ante=nulla&ipsum=sed&primis=vel&in=enim&faucibus=sit&orci=amet&luctus=nunc&et=viverra&ultrices=dapibus&posuere=nulla'),
(6, 'Malaysia', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.\r\n\r\nMaecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.\r\n\r\nMaecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 'https://theguardian.com/pulvinar/nulla/pede/ullamcorper.js?diam=at&id=velit&ornare=vivamus&imperdiet=vel&sapien=nulla&urna=eget&pretium=eros&nisl=elementum&ut=pellentesque&volutpat=quisque&sapien=porta&arcu=volutpat&sed=erat&augue=quisque&aliquam=erat&erat=eros&volutpat=viverra&in=eget&congue=congue&etiam=eget&justo=semper&etiam=rutrum&pretium=nulla&iaculis=nunc&justo=purus&in=phasellus&hac=in&habitasse=felis&platea=donec&dictumst=semper&etiam=sapien&faucibus=a&cursus=libero&urna=nam&ut=dui&tellus=proin&nulla=leo&ut=odio&erat=porttitor&id=id&mauris=consequat&vulputate=in&elementum=consequat&nullam=ut&varius=nulla&nulla=sed&facilisi=accumsan&cras=felis&non=ut&velit=at&nec=dolor&nisi=quis&vulputate=odio&nonummy=consequat&maecenas=varius&tincidunt=integer&lacus=ac&at=leo&velit=pellentesque&vivamus=ultrices&vel=mattis&nulla=odio&eget=donec&eros=vitae&elementum=nisi&pellentesque=nam&quisque=ultrices&porta=libero&volutpat=non&erat=mattis&quisque=pulvinar&erat=nulla&eros=pede&viverra=ullamcorper&eget=augue&congue=a&eget=suscipit&semper=nulla&rutrum=elit&nulla=ac&nunc=nulla&purus=sed&phasellus=vel&in=enim&felis=sit'),
(7, 'Italy', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\r\n\r\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 'http://census.gov/mauris/lacinia/sapien/quis/libero/nullam.html?consequat=luctus&metus=et&sapien=ultrices&ut=posuere&nunc=cubilia&vestibulum=curae&ante=duis&ipsum=faucibus&primis=accumsan&in=odio&faucibus=curabitur&orci=convallis&luctus=duis&et=consequat&ultrices=dui&posuere=nec&cubilia=nisi&curae=volutpat&mauris=eleifend&viverra=donec&diam=ut&vitae=dolor&quam=morbi&suspendisse=vel&potenti=lectus&nullam=in&porttitor=quam&lacus=fringilla&at=rhoncus&turpis=mauris&donec=enim&posuere=leo&metus=rhoncus&vitae=sed&ipsum=vestibulum&aliquam=sit');

-- --------------------------------------------------------

--
-- Table structure for table `county`
--

CREATE TABLE `county` (
  `county_id` int(11) NOT NULL,
  `county_name` varchar(255) NOT NULL,
  `county_description` text NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `county`
--

INSERT INTO `county` (`county_id`, `county_name`, `county_description`, `country_id`) VALUES
(1, 'Antrim', 'Lovely bricks architecture', 1),
(2, 'Messina', 'Northernmost point of Sicily', 7),
(3, 'Catania', '', 7),
(4, 'Palermo', '', 7);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `customer_first_name` varchar(255) NOT NULL,
  `customer_surname` varchar(255) NOT NULL,
  `customer_date_of_birth` date NOT NULL,
  `customer_title_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_first_name`, `customer_surname`, `customer_date_of_birth`, `customer_title_id`) VALUES
(1, 'Roberto', 'Lo Duca', '1995-03-11', 1),
(2, 'Anthony', 'Majorana', '1996-06-16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_booking`
--

CREATE TABLE `customer_booking` (
  `customer_booking_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_booking`
--

INSERT INTO `customer_booking` (`customer_booking_id`, `customer_id`, `booking_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 2),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `customer_lead`
--

CREATE TABLE `customer_lead` (
  `customer_lead_id` int(11) NOT NULL,
  `customer_lead_number` varchar(16) NOT NULL,
  `customer_lead_emergency_number` varchar(16) NOT NULL,
  `customer_lead_email` varchar(320) NOT NULL,
  `customer_lead_address_one` varchar(255) NOT NULL,
  `customer_lead_address_two` varchar(255) NOT NULL,
  `customer_lead_postcode` varchar(255) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_lead`
--

INSERT INTO `customer_lead` (`customer_lead_id`, `customer_lead_number`, `customer_lead_emergency_number`, `customer_lead_email`, `customer_lead_address_one`, `customer_lead_address_two`, `customer_lead_postcode`, `customer_id`, `city_id`) VALUES
(1, '+39 3456350165', '+39 3294027974', 'robertoloduca@hotmail.it', 'Via trieste 13', '', '98057', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `customer_title`
--

CREATE TABLE `customer_title` (
  `customer_title_id` int(11) NOT NULL,
  `customer_title_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_title`
--

INSERT INTO `customer_title` (`customer_title_id`, `customer_title_name`) VALUES
(1, 'Mr'),
(2, 'Mrs'),
(3, 'Miss'),
(4, 'Ms');

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `flight_id` int(11) NOT NULL,
  `flight_departure_time` datetime NOT NULL,
  `flight_arrival_time` datetime NOT NULL,
  `flight_price` decimal(10,2) NOT NULL,
  `flight_type_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`flight_id`, `flight_departure_time`, `flight_arrival_time`, `flight_price`, `flight_type_id`, `route_id`, `booking_id`) VALUES
(1, '2023-01-01 15:27:00', '2023-01-01 19:00:00', '70.00', 2, 3, 1),
(2, '2023-01-15 13:00:00', '2023-01-15 16:33:00', '90.00', 2, 2, 1),
(3, '2023-02-15 09:00:00', '2023-02-15 12:33:00', '150.00', 1, 3, 2),
(4, '2023-04-01 11:30:00', '2023-04-01 15:03:00', '130.00', 1, 2, 2),
(43, '2023-01-16 06:33:00', '2023-01-16 10:06:00', '210.00', 1, 3, 3),
(44, '2023-02-14 13:30:00', '2023-02-14 16:03:00', '150.00', 1, 4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `flight_type`
--

CREATE TABLE `flight_type` (
  `flight_type_id` int(11) NOT NULL,
  `flight_type_name` varchar(255) NOT NULL,
  `flight_type_description` text NOT NULL,
  `flight_type_luggage_pack` varchar(255) NOT NULL,
  `flight_type_meal` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `flight_type`
--

INSERT INTO `flight_type` (`flight_type_id`, `flight_type_name`, `flight_type_description`, `flight_type_luggage_pack`, `flight_type_meal`) VALUES
(1, 'All included', 'This pach include a variety of services and meals, and the priority in the boarding', '10kg hold luggage x 1\r\n25kg Cabin luggage X 2\r\nsport equipment x 1', 'curry with chicken'),
(2, 'Essential', 'only a small hold luggage and no priority', '10kg hold luggage x 1', 'water'),
(3, 'Only passenger', 'no boarding pass and only a bag', 'small bag 5kg x 1', '');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL,
  `login_email` varchar(320) NOT NULL,
  `login_password` varbinary(255) NOT NULL,
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `payment_method_id` int(11) NOT NULL,
  `payment_method_name` varchar(255) NOT NULL,
  `payment_method_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`payment_method_id`, `payment_method_name`, `payment_method_description`) VALUES
(1, 'Visa', ''),
(2, 'mastercard', ''),
(3, 'Paypal', '');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `region_id` int(11) NOT NULL,
  `region_name` varchar(255) NOT NULL,
  `region_description` text NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`region_id`, `region_name`, `region_description`, `country_id`) VALUES
(5, 'Northern Ireland', 'Be careful bla bla bla covid, beautiful view of the ambarabacicicoco', 1),
(6, 'Sicily', 'There are beautiful fish species. the etna is the biggest volcano in Italy and maybe europe?', 7);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `route_name` varchar(255) NOT NULL,
  `route_description` text NOT NULL,
  `departure_airport_id` int(11) NOT NULL,
  `destination_airport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `route_name`, `route_description`, `departure_airport_id`, `destination_airport_id`) VALUES
(1, 'Belfast International Airport to Catania Airport', 'Usually it takes around 3:30 hours', 3, 5),
(2, 'Catania Airport to Belfast International Airport', 'Usually it takes around 3:30 hours', 5, 3),
(3, 'Belfast City Airport to Catania Airport', '', 2, 5),
(4, 'Catania Airport to Belfast City Airport', '', 5, 2),
(5, 'Belfast City Airport to Palermo Airport', '', 2, 4),
(6, 'Palermo Airport to Belfast City Airport', '', 4, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `FK_city_id_address` (`city_id`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`airport_id`),
  ADD KEY `FK_address_id_airport` (`address_id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `FK_payment_method_id_booking` (`payment_method_id`),
  ADD KEY `FK_customer_lead_id_booking` (`customer_lead_id`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`card_id`),
  ADD KEY `FK_customer_lead_id_card` (`customer_lead_id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `FK_country_id_city` (`country_id`),
  ADD KEY `FK_county_id_city` (`county_id`),
  ADD KEY `FK_region_id_city` (`region_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `county`
--
ALTER TABLE `county`
  ADD PRIMARY KEY (`county_id`),
  ADD KEY `FK_country_id_county` (`country_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `FK_customer_title_id_customer` (`customer_title_id`);

--
-- Indexes for table `customer_booking`
--
ALTER TABLE `customer_booking`
  ADD PRIMARY KEY (`customer_booking_id`),
  ADD KEY `FK_customer_id_customer_booking` (`customer_id`),
  ADD KEY `FK_booking_id_customer_booking` (`booking_id`);

--
-- Indexes for table `customer_lead`
--
ALTER TABLE `customer_lead`
  ADD PRIMARY KEY (`customer_lead_id`),
  ADD KEY `FK_customer_id_customer_lead` (`customer_id`),
  ADD KEY `FK_city_id_customer_lead` (`city_id`);

--
-- Indexes for table `customer_title`
--
ALTER TABLE `customer_title`
  ADD PRIMARY KEY (`customer_title_id`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight_id`),
  ADD KEY `FK_flight_type_id_flight` (`flight_type_id`),
  ADD KEY `FK_booking_id_flight` (`booking_id`),
  ADD KEY `FK_route_id_flight` (`route_id`);

--
-- Indexes for table `flight_type`
--
ALTER TABLE `flight_type`
  ADD PRIMARY KEY (`flight_type_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`),
  ADD UNIQUE KEY `login_email` (`login_email`),
  ADD KEY `FK_customer_id_login` (`customer_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`region_id`),
  ADD KEY `FK_country_id_region` (`country_id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`),
  ADD KEY `FK_departure_airport_id_route` (`departure_airport_id`),
  ADD KEY `FK_destination_airport_id_route` (`destination_airport_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `county`
--
ALTER TABLE `county`
  MODIFY `county_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_booking`
--
ALTER TABLE `customer_booking`
  MODIFY `customer_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer_lead`
--
ALTER TABLE `customer_lead`
  MODIFY `customer_lead_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_title`
--
ALTER TABLE `customer_title`
  MODIFY `customer_title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `flight_type`
--
ALTER TABLE `flight_type`
  MODIFY `flight_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `region_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK_city_id_address` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `airport`
--
ALTER TABLE `airport`
  ADD CONSTRAINT `FK_address_id_airport` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `FK_customer_lead_id_booking` FOREIGN KEY (`customer_lead_id`) REFERENCES `customer_lead` (`customer_lead_id`),
  ADD CONSTRAINT `FK_payment_method_id_booking` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`);

--
-- Constraints for table `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `FK_customer_lead_id_card` FOREIGN KEY (`customer_lead_id`) REFERENCES `customer_lead` (`customer_lead_id`);

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `FK_country_id_city` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  ADD CONSTRAINT `FK_county_id_city` FOREIGN KEY (`county_id`) REFERENCES `county` (`county_id`) ON UPDATE SET NULL,
  ADD CONSTRAINT `FK_region_id_city` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`) ON UPDATE SET NULL;

--
-- Constraints for table `county`
--
ALTER TABLE `county`
  ADD CONSTRAINT `FK_country_id_county` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `FK_customer_title_id_customer` FOREIGN KEY (`customer_title_id`) REFERENCES `customer_title` (`customer_title_id`);

--
-- Constraints for table `customer_booking`
--
ALTER TABLE `customer_booking`
  ADD CONSTRAINT `FK_booking_id_customer_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK_customer_id_customer_booking` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `customer_lead`
--
ALTER TABLE `customer_lead`
  ADD CONSTRAINT `FK_city_id_customer_lead` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `FK_customer_id_customer_lead` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `FK_booking_id_flight` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK_flight_type_id_flight` FOREIGN KEY (`flight_type_id`) REFERENCES `flight_type` (`flight_type_id`),
  ADD CONSTRAINT `FK_route_id_flight` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`);

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `FK_customer_id_login` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `region`
--
ALTER TABLE `region`
  ADD CONSTRAINT `FK_country_id_region` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `FK_departure_airport_id_route` FOREIGN KEY (`departure_airport_id`) REFERENCES `airport` (`airport_id`),
  ADD CONSTRAINT `FK_destination_airport_id_route` FOREIGN KEY (`destination_airport_id`) REFERENCES `airport` (`airport_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
