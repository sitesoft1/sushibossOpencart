<?php
class ModelCatalogPopuptemplate extends Model {
	public function createTables() {
		$show_tables_query = $this->db->query("SHOW TABLES FROM `" . DB_DATABASE . "` WHERE `Tables_in_" . DB_DATABASE . "` = '" . DB_PREFIX . "popuptemplate'");

		if(!$show_tables_query->num_rows) {
			$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "popuptemplate` (`popuptemplate_id` int(11) NOT NULL AUTO_INCREMENT, `sort_order` tinyint(4) NOT NULL, `coupon_id` int(11) NOT NULL, `status` tinyint(4) NOT NULL, `logo` varchar(255) NOT NULL, `background_image` varchar(255) NOT NULL, `show_title` tinyint(4) NOT NULL, `show_caption` tinyint(4) NOT NULL, `show_closebutton` tinyint(4) NOT NULL, `show_account` varchar(255) NOT NULL, `show_version` varchar(255) NOT NULL, `popup_reopen` tinyint(4) NOT NULL, `popup_minutes` int(11) NOT NULL, `css` text NOT NULL, `margin_top` varchar(10) NOT NULL, PRIMARY KEY (`popuptemplate_id`) ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;");
			
			$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "popuptemplate_description` (`popuptemplate_id` int(11) NOT NULL, `language_id` int(11) NOT NULL, `title` varchar(255) NOT NULL, `description` longtext NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

			$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "popuptemplate_to_product` (`popuptemplate_id` int(11) NOT NULL, `product_id` int(11) NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
			
			$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "popuptemplate_to_setting_layout` (`popuptemplate_id` int(11) NOT NULL, `layout_id` int(11) NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
			
			$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "popuptemplate_to_setting_product` (`popuptemplate_id` int(11) NOT NULL, `product_id` int(11) NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

			$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "popuptemplate_to_setting_store` (`popuptemplate_id` int(11) NOT NULL, `store_id` int(11) NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
		}
	}

	public function addPopuptemplate($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', coupon_id = '" . (int)$data['coupon_id'] . "', background_image = '" . $this->db->escape($data['background_image']) . "', logo = '" . $this->db->escape($data['logo']) . "', show_title = '" . (int)$data['show_title'] . "', show_caption = '" . (int)$data['show_caption'] . "', show_closebutton = '" . (int)$data['show_closebutton'] . "', show_account = '" . (!empty($data['show_account']) ? $this->db->escape(json_encode($data['show_account'])) : '') . "', show_version = '" . (!empty($data['show_version']) ? $this->db->escape(json_encode($data['show_version'])) : '') . "', css = '" . $this->db->escape($data['css']) . "', popup_reopen = '" . $this->db->escape($data['popup_reopen']) . "', popup_minutes = '" . $this->db->escape($data['popup_minutes']) . "', margin_top = '" . $this->db->escape($data['margin_top']) . "'");

		$popuptemplate_id = $this->db->getLastId();

		foreach ($data['popuptemplate_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_description SET popuptemplate_id = '" . (int)$popuptemplate_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		if (isset($data['product'])) {
			foreach ($data['product'] as $product_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_product SET product_id = '" . (int)$product_id . "', popuptemplate_id = '" . (int)$popuptemplate_id . "'");
			}
		}

		if (isset($data['setting_product'])) {
			foreach ($data['setting_product'] as $product_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_setting_product SET product_id = '" . (int)$product_id . "', popuptemplate_id = '" . (int)$popuptemplate_id . "'");
			}
		}

		if (isset($data['popuptemplate_store'])) {
			foreach ($data['popuptemplate_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_setting_store SET store_id = '" . (int)$store_id . "', popuptemplate_id = '" . (int)$popuptemplate_id . "'");
			}
		}

		if (isset($data['setting_layout'])) {
			foreach ($data['setting_layout'] as $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_setting_layout SET popuptemplate_id = '" . (int)$popuptemplate_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		return $popuptemplate_id;
	}

	public function editPopuptemplate($popuptemplate_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "popuptemplate SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', coupon_id = '" . (int)$data['coupon_id'] . "', background_image = '" . $this->db->escape($data['background_image']) . "', logo = '" . $this->db->escape($data['logo']) . "', show_title = '" . (int)$data['show_title'] . "', show_caption = '" . (int)$data['show_caption'] . "', show_account = '" . (!empty($data['show_account']) ? $this->db->escape(json_encode($data['show_account'])) : '') . "', show_version = '" . (!empty($data['show_version']) ? $this->db->escape(json_encode($data['show_version'])) : '') . "', show_closebutton = '" . (int)$data['show_closebutton'] . "', css = '" . $this->db->escape($data['css']) . "', popup_reopen = '" . $this->db->escape($data['popup_reopen']) . "', popup_minutes = '" . $this->db->escape($data['popup_minutes']) . "', margin_top = '" . $this->db->escape($data['margin_top']) . "' WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_description WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		foreach ($data['popuptemplate_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_description SET popuptemplate_id = '" . (int)$popuptemplate_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_product WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		if (isset($data['product'])) {
			foreach ($data['product'] as $product_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_product SET product_id = '" . (int)$product_id . "', popuptemplate_id = '" . (int)$popuptemplate_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_setting_product WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		if (isset($data['setting_product'])) {
			foreach ($data['setting_product'] as $product_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_setting_product SET product_id = '" . (int)$product_id . "', popuptemplate_id = '" . (int)$popuptemplate_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_setting_store WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		if (isset($data['popuptemplate_store'])) {
			foreach ($data['popuptemplate_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_setting_store SET store_id = '" . (int)$store_id . "', popuptemplate_id = '" . (int)$popuptemplate_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_setting_layout WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		if (isset($data['setting_layout'])) {
			foreach ($data['setting_layout'] as $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "popuptemplate_to_setting_layout SET popuptemplate_id = '" . (int)$popuptemplate_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}
	}

	public function deletePopuptemplate($popuptemplate_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_description WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_product WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_setting_product WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_setting_layout WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "popuptemplate_to_setting_store WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");
	}

	public function getPopuptemplate($popuptemplate_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "popuptemplate WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		return $query->row;
	}

	public function getPopuptemplateProducts($popuptemplate_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "popuptemplate_to_product WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		$products = array();
		foreach ($query->rows as $result) {
			$products[] = $result['product_id'];
		}

		return $products;
	}

	public function getPopuptemplateSettingProducts($popuptemplate_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "popuptemplate_to_setting_product WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		$setting_products = array();
		foreach ($query->rows as $result) {
			$setting_products[] = $result['product_id'];
		}

		return $setting_products;
	}

	public function getPopuptemplateStores($popuptemplate_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "popuptemplate_to_setting_store WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		$setting_stores = array();
		foreach ($query->rows as $result) {
			$setting_stores[] = $result['store_id'];
		}

		return $setting_stores;
	}

	public function getPopuptemplateSettingLayouts($popuptemplate_id) {
		$setting_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "popuptemplate_to_setting_layout WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		foreach ($query->rows as $result) {
			$setting_layout_data[] = $result['layout_id'];
		}

		return $setting_layout_data;
	}

	public function getPopuptemplates($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "popuptemplate i LEFT JOIN " . DB_PREFIX . "popuptemplate_description id ON (i.popuptemplate_id = id.popuptemplate_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		$sort_data = array(
			'id.title',
			'i.status',
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY id.title";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getPopuptemplateDescriptions($popuptemplate_id) {
		$popuptemplate_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "popuptemplate_description WHERE popuptemplate_id = '" . (int)$popuptemplate_id . "'");

		foreach ($query->rows as $result) {
			$popuptemplate_description_data[$result['language_id']] = array(
				'title'            => $result['title'],
				'description'      => $result['description']
			);
		}

		return $popuptemplate_description_data;
	}

	public function getTotalPopuptemplates() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "popuptemplate");

		return $query->row['total'];
	}
}