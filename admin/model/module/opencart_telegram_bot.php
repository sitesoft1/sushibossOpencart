<?php
class ModelModuleOpencartTelegramBot extends Model {
	public function install() {
		$this->db->query('CREATE TABLE `'.DB_PREFIX.'telegram_customers` (`id` INT(11) NOT NULL AUTO_INCREMENT , `telegram_id` VARCHAR(50) DEFAULT "" , `customer_id` INT(11) NOT NULL DEFAULT "0" , `password` VARCHAR(20) DEFAULT "", `shipping_method` VARCHAR(100) DEFAULT "",  `payment_method` VARCHAR(100) DEFAULT "", `comment` TEXT DEFAULT "",`question` VARCHAR(50) DEFAULT "", `saved_cart` TEXT DEFAULT "", `latitude` VARCHAR(50) DEFAULT "", `longitude` VARCHAR(50) DEFAULT "", `selected_options` TEXT DEFAULT "",  `cart_ids` TEXT DEFAULT "", opened_profile TINYINT NOT NULL DEFAULT 0, PRIMARY KEY (`id`)) ENGINE = MyISAM');
	}
	public function uninstall() {
		$this->db->query('DROP TABLE `'.DB_PREFIX.'telegram_customers`');
	}	
}