-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 24 Lis 2016, 19:10
-- Wersja serwera: 5.5.50
-- Wersja PHP: 5.4.45-0+deb7u4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `db_19747`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `og_characters`
--

CREATE TABLE IF NOT EXISTS `og_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `name` text COLLATE utf8_bin NOT NULL,
  `money` int(11) NOT NULL DEFAULT '50',
  `skin` int(11) NOT NULL DEFAULT '26',
  `reputation` int(11) NOT NULL DEFAULT '0',
  `weave` int(11) NOT NULL DEFAULT '50',
  `mandate` int(11) NOT NULL DEFAULT '0',
  `licenseA` int(11) NOT NULL DEFAULT '0',
  `licenseB` int(11) NOT NULL DEFAULT '0',
  `licenseC` int(11) NOT NULL DEFAULT '0',
  `licenseD` int(11) NOT NULL DEFAULT '0',
  `licenseL` int(11) NOT NULL DEFAULT '0',
  `licenseH` int(11) NOT NULL DEFAULT '0',
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `og_texts`
--

CREATE TABLE IF NOT EXISTS `og_texts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_bin NOT NULL,
  `pos` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0, 0, 0',
  `scale` double NOT NULL DEFAULT '1',
  `interior` int(11) NOT NULL DEFAULT '0',
  `dimension` int(11) NOT NULL DEFAULT '0',
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `og_texts`
--

INSERT INTO `og_texts` (`id`, `name`, `pos`, `scale`, `interior`, `dimension`, `added`) VALUES
(1, 'Witamy na serwerze ourGame.\r\nReaktywacja serwera sprzed 2 lat.\r\n\r\nJeżeli jesteś tu nowy/a podejdź do przewodnika\r\naby uzyskać więcej informacji.\r\n\r\nŻyczymy miłej gry.\r\nAdministracja serwera :)', '-1970.23535, 137.76846, 27.68750', 1, 0, 0, '2016-11-18 16:22:08');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `og_users`
--

CREATE TABLE IF NOT EXISTS `og_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text COLLATE utf8_bin NOT NULL,
  `password` text COLLATE utf8_bin NOT NULL,
  `serial` text COLLATE utf8_bin NOT NULL,
  `premium` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `visited` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;