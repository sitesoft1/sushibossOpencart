<?php
//set_time_limit(0);
class ModelCatalogProduct extends Model {
	public function addProduct($data) {
		$this->event->trigger('pre.admin.product.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', location = '" . $this->db->escape($data['location']) . "', quantity = '" . (int)$data['quantity'] . "', minimum = '" . (int)$data['minimum'] . "', subtract = '" . (int)$data['subtract'] . "', stock_status_id = '" . (int)$data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', shipping = '" . (int)$data['shipping'] . "', price = '" . (float)$data['price'] . "', points = '" . (int)$data['points'] . "', weight = '" . (float)$data['weight'] . "', weight_class_id = '" . (int)$data['weight_class_id'] . "', length = '" . (float)$data['length'] . "', width = '" . (float)$data['width'] . "', height = '" . (float)$data['height'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', tax_class_id = '" . (int)$data['tax_class_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', date_added = NOW()");

		$product_id = $this->db->getLastId();
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($data['image']) . "' WHERE product_id = '" . (int)$product_id . "'");
		}

		foreach ($data['product_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
					}
				}
			}
		}

		if (isset($data['product_option'])) {
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
					if (isset($product_option['product_option_value'])) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "'");

						$product_option_id = $this->db->getLastId();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int)$product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float)$product_option_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
						}
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', value = '" . $this->db->escape($product_option['value']) . "', required = '" . (int)$product_option['required'] . "'");
				}
			}
		}

		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}

		if (isset($data['product_image'])) {
			foreach ($data['product_image'] as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
		}

		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}

		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}
		}

		if (isset($data['product_filter'])) {
			foreach ($data['product_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int)$product_id . "', filter_id = '" . (int)$filter_id . "'");
			}
		}

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $product_reward) {
				if ((int)$product_reward['points'] > 0) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$product_reward['points'] . "'");
				}
			}
		}

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		if (isset($data['keyword'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		if (isset($data['product_recurrings'])) {
			foreach ($data['product_recurrings'] as $recurring) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "product_recurring` SET `product_id` = " . (int)$product_id . ", customer_group_id = " . (int)$recurring['customer_group_id'] . ", `recurring_id` = " . (int)$recurring['recurring_id']);
			}
		}

		$this->cache->delete('product');

		$this->event->trigger('post.admin.product.add', $product_id);
		
		
        try {
            //Send product to WooCommerce
            $wc_product_id = $this->addProductToWc($data, $product_id);
            //Send product to WooCommerce END
        }
        catch(Exception $e){
            $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
            $err = $info . $e->getMessage();
            $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
        }

		return $product_id;
	}

	public function editProduct($product_id, $data) {
	 
		$this->event->trigger('pre.admin.product.edit', $data);

		$this->db->query("UPDATE " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', location = '" . $this->db->escape($data['location']) . "', quantity = '" . (int)$data['quantity'] . "', minimum = '" . (int)$data['minimum'] . "', subtract = '" . (int)$data['subtract'] . "', stock_status_id = '" . (int)$data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', shipping = '" . (int)$data['shipping'] . "', price = '" . (float)$data['price'] . "', points = '" . (int)$data['points'] . "', weight = '" . (float)$data['weight'] . "', weight_class_id = '" . (int)$data['weight_class_id'] . "', length = '" . (float)$data['length'] . "', width = '" . (float)$data['width'] . "', height = '" . (float)$data['height'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', tax_class_id = '" . (int)$data['tax_class_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', date_modified = NOW() WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($data['image']) . "' WHERE product_id = '" . (int)$product_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");

		foreach ($data['product_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");

		if (!empty($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
					}
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_option'])) {
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
					if (isset($product_option['product_option_value'])) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int)$product_option['product_option_id'] . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "'");

						$product_option_id = $this->db->getLastId();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_value_id = '" . (int)$product_option_value['product_option_value_id'] . "', product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int)$product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float)$product_option_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
						}
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_option_id = '" . (int)$product_option['product_option_id'] . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', value = '" . $this->db->escape($product_option['value']) . "', required = '" . (int)$product_option['required'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_image'])) {
			foreach ($data['product_image'] as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_filter'])) {
			foreach ($data['product_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int)$product_id . "', filter_id = '" . (int)$filter_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $value) {
				if ((int)$value['points'] > 0) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$value['points'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_recurring` WHERE product_id = " . (int)$product_id);

		if (isset($data['product_recurring'])) {
			foreach ($data['product_recurring'] as $product_recurring) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "product_recurring` SET `product_id` = " . (int)$product_id . ", customer_group_id = " . (int)$product_recurring['customer_group_id'] . ", `recurring_id` = " . (int)$product_recurring['recurring_id']);
			}
		}

		$this->cache->delete('product');

		$this->event->trigger('post.admin.product.edit', $product_id);
        
        //Send product to WooCommerce
        try {
            $wc_product_id = $this->updateProductToWc($data, $product_id);
        }
        catch(Exception $e){
            $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
            $err = $info . $e->getMessage();
            $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
        }
        //Send product to WooCommerce END
	}

	public function copyProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		if ($query->num_rows) {
			$data = $query->row;

			$data['sku'] = '';
			$data['upc'] = '';
			$data['viewed'] = '0';
			$data['keyword'] = '';
			$data['status'] = '0';

			$data['product_attribute'] = $this->getProductAttributes($product_id);
			$data['product_description'] = $this->getProductDescriptions($product_id);
			$data['product_discount'] = $this->getProductDiscounts($product_id);
			$data['product_filter'] = $this->getProductFilters($product_id);
			$data['product_image'] = $this->getProductImages($product_id);
			$data['product_option'] = $this->getProductOptions($product_id);
			$data['product_related'] = $this->getProductRelated($product_id);
			$data['product_reward'] = $this->getProductRewards($product_id);
			$data['product_special'] = $this->getProductSpecials($product_id);
			$data['product_category'] = $this->getProductCategories($product_id);
			$data['product_download'] = $this->getProductDownloads($product_id);
			$data['product_layout'] = $this->getProductLayouts($product_id);
			$data['product_store'] = $this->getProductStores($product_id);
			$data['product_recurrings'] = $this->getRecurrings($product_id);

			$this->addProduct($data);
		}
	}
 
	//wc
    public function copyWcProduct($product_id)
    {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
        
        if ($query->num_rows) {
            $data = $query->row;
            
            $data['product_attribute'] = $this->getProductAttributes($product_id);
            $data['product_description'] = $this->getProductDescriptions($product_id);
            $data['product_discount'] = $this->getProductDiscounts($product_id);
            $data['product_filter'] = $this->getProductFilters($product_id);
            $data['product_image'] = $this->getProductImages($product_id);
            $data['product_option'] = $this->getProductOptions($product_id);
            $data['product_related'] = $this->getProductRelated($product_id);
            $data['product_reward'] = $this->getProductRewards($product_id);
            $data['product_special'] = $this->getProductSpecials($product_id);
            $data['product_category'] = $this->getProductCategories($product_id);
            $data['product_download'] = $this->getProductDownloads($product_id);
            $data['product_layout'] = $this->getProductLayouts($product_id);
            $data['product_store'] = $this->getProductStores($product_id);
            $data['product_recurrings'] = $this->getRecurrings($product_id);
            
           return $data;
        }
    }
	
	public function wcImport($data)
    {
        $wc_products_arr = json_decode($data['wc_products_arr']);
        $i=1;
        foreach ($wc_products_arr as $product_id){
            $product_data = $this->copyWcProduct($product_id);
            
            try {
                $wc_product_id = $this->updateProductToWc($product_data, $product_id);
                //Попробуем освободить память
                $product_data = null; unset($product_data);
            }
            catch(Exception $e){
                $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
                $err = $info . $e->getMessage();
                $this->wcLog('wcImport_err_log', $err, false);
            }
            
            //$this->wcLog($product_id, $product_data, false);
            //Пауза для сборки мусора
    
            //time_nanosleep(0, 100000000);// 1/10-я секунды
            time_nanosleep(0, 10000000);// 1/100-я секунды.
            gc_collect_cycles();
            
            /*
            $check = $i%10;
            if($check == 0){
                time_nanosleep(0, 100000000);// 1/10-я секунды
                gc_collect_cycles();
            }else{
                time_nanosleep(0, 10000000);// 1/100-я секунды
            }
            */
            
            $i++;
        }
    
        $this->wcLog('wc_import_final', 'wc import end !!!', false);
        return true;
    }
    //wc END

	public function deleteProduct($product_id) {
	    
        try {
            //wc
            $this->deleteWcProduct($product_id);
            //wc end
        }
        catch(Exception $e){
            $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
            $err = $info . $e->getMessage();
            $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
        }
	    
		$this->event->trigger('pre.admin.product.delete', $product_id);

		$this->db->query("DELETE FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_recurring WHERE product_id = " . (int)$product_id);
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");

		$this->cache->delete('product');

		$this->event->trigger('post.admin.product.delete', $product_id);
		
	}

	public function getProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "') AS keyword FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getProducts($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . (int)$data['filter_quantity'] . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}
		
		$sql .= " GROUP BY p.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'p.price',
			'p.quantity',
			'p.status',
			'p.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY pd.name";
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

	public function getProductsByCategoryId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2c.category_id = '" . (int)$category_id . "' ORDER BY pd.name ASC");

		return $query->rows;
	}

	public function getProductDescriptions($product_id) {
		$product_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
				'description'      => $result['description'],
				'meta_title'       => $result['meta_title'],
				'meta_description' => $result['meta_description'],
				'meta_keyword'     => $result['meta_keyword'],
				'tag'              => $result['tag']
			);
		}

		return $product_description_data;
	}

	public function getProductCategories($product_id) {
		$product_category_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_category_data[] = $result['category_id'];
		}

		return $product_category_data;
	}

	public function getProductFilters($product_id) {
		$product_filter_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_filter_data[] = $result['filter_id'];
		}

		return $product_filter_data;
	}

	public function getProductAttributes($product_id) {
		$product_attribute_data = array();

		$product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' GROUP BY attribute_id");

		foreach ($product_attribute_query->rows as $product_attribute) {
			$product_attribute_description_data = array();

			$product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");

			foreach ($product_attribute_description_query->rows as $product_attribute_description) {
				$product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
			}

			$product_attribute_data[] = array(
				'attribute_id'                  => $product_attribute['attribute_id'],
				'product_attribute_description' => $product_attribute_description_data
			);
		}

		return $product_attribute_data;
	}

	public function getProductOptions($product_id) {
		$product_option_data = array();

		$product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option` po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		foreach ($product_option_query->rows as $product_option) {
			$product_option_value_data = array();

			$product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int)$product_option['product_option_id'] . "'");

			foreach ($product_option_value_query->rows as $product_option_value) {
				$product_option_value_data[] = array(
					'product_option_value_id' => $product_option_value['product_option_value_id'],
					'option_value_id'         => $product_option_value['option_value_id'],
					'quantity'                => $product_option_value['quantity'],
					'subtract'                => $product_option_value['subtract'],
					'price'                   => $product_option_value['price'],
					'price_prefix'            => $product_option_value['price_prefix'],
					'points'                  => $product_option_value['points'],
					'points_prefix'           => $product_option_value['points_prefix'],
					'weight'                  => $product_option_value['weight'],
					'weight_prefix'           => $product_option_value['weight_prefix']
				);
			}

			$product_option_data[] = array(
				'product_option_id'    => $product_option['product_option_id'],
				'product_option_value' => $product_option_value_data,
				'option_id'            => $product_option['option_id'],
				'name'                 => $product_option['name'],
				'type'                 => $product_option['type'],
				'value'                => $product_option['value'],
				'required'             => $product_option['required']
			);
		}

		return $product_option_data;
	}

	public function getProductImages($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "' ORDER BY sort_order ASC");

		return $query->rows;
	}

	public function getProductDiscounts($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' ORDER BY quantity, priority, price");

		return $query->rows;
	}

	public function getProductSpecials($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' ORDER BY priority, price");

		return $query->rows;
	}

	public function getProductRewards($product_id) {
		$product_reward_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_reward_data[$result['customer_group_id']] = array('points' => $result['points']);
		}

		return $product_reward_data;
	}

	public function getProductDownloads($product_id) {
		$product_download_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_download_data[] = $result['download_id'];
		}

		return $product_download_data;
	}

	public function getProductStores($product_id) {
		$product_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_store_data[] = $result['store_id'];
		}

		return $product_store_data;
	}

	public function getProductLayouts($product_id) {
		$product_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $product_layout_data;
	}

	public function getProductRelated($product_id) {
		$product_related_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_related_data[] = $result['related_id'];
		}

		return $product_related_data;
	}

	public function getRecurrings($product_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_recurring` WHERE product_id = '" . (int)$product_id . "'");

		return $query->rows;
	}

	public function getTotalProducts($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . (int)$data['filter_quantity'] . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalProductsByTaxClassId($tax_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE tax_class_id = '" . (int)$tax_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByStockStatusId($stock_status_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE stock_status_id = '" . (int)$stock_status_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByWeightClassId($weight_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE weight_class_id = '" . (int)$weight_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByLengthClassId($length_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE length_class_id = '" . (int)$length_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByDownloadId($download_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_download WHERE download_id = '" . (int)$download_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByManufacturerId($manufacturer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByAttributeId($attribute_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = '" . (int)$attribute_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByOptionId($option_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_option WHERE option_id = '" . (int)$option_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByProfileId($recurring_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_recurring WHERE recurring_id = '" . (int)$recurring_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
	
	//wc #################################################
    public function wcCurl($queryData, $queryUrl)
    {
        $queryData = http_build_query($queryData);
    
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_POST => 1,
            CURLOPT_HEADER => 0,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL => $queryUrl,
            CURLOPT_POSTFIELDS => $queryData,
        ));
    
        try {
            $product_id = curl_exec($curl);
        }
        catch(Exception $e){
            $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
            $err = $info . $e->getMessage();
            $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
            return false;
        }
        
        curl_close($curl);
        
        //$this->wcLog('wc_log', $product_id, false);
        return $product_id;
    }
    
    public function wcLog($filename, $data, $append=false)
    {
        if(!$append){
            file_put_contents(DIR_LOGS . '/'. $filename . '.txt', var_export($data,true));
        }else{
            file_put_contents(DIR_LOGS . '/'. $filename . '.txt', var_export($data,true).PHP_EOL, FILE_APPEND);
        }
        
    }
    
    public function addProductToWc($data, $product_id)
    {
        //$this->wcLog('data_log',$data);
        $lang = 2;//Язык данные из которого будем передавать
        
        //form product data
        $wc_price = (float)$data['price'];
        $wc_price = round($wc_price);
    
        $product_special = end($data['product_special']);
        $wc_special_price = (float)$product_special['price'];
        $wc_special_price = round($wc_special_price);

        $wc_model = $data['model'];
        $wc_product_images = [];
        if(!empty($data['status'])){
            $status = 'publish';
        }else{
            $status = 'draft';
        }
        
        
        foreach ($data['product_description'] as $language_id => $value) {
            if($language_id == $lang){
                $wc_product_name = $value['name'];
                $wc_product_description = htmlspecialchars_decode($value['description']);
            
            }
        }
    
        if (isset($data['image']) and !empty($data['image'])) {
            $image = str_replace(' ', '%20', $data['image']);
            $wc_product_images[] = HTTPS_CATALOG . 'image/' . $image;// FOR PRODUCTION
            //$wc_product_images[] = 'https://sushiboss.od.ua/' . 'image/' . $data['image'];// FOR LOCALHOST
        }
    
        if (isset($data['product_image']) and !empty($data['product_image'])) {
            foreach ($data['product_image'] as $product_image) {
                $image = str_replace(' ', '%20', $product_image['image']);
                $wc_product_images[] = HTTPS_CATALOG . 'image/' . $image;// FOR PRODUCTION
                //$wc_product_images[] = 'https://sushiboss.od.ua/' . 'image/' . $product_image['image'];// FOR LOCALHOST
            }
        }
    
        $wc_categories = [];
        if (isset($data['product_category'])) {
            foreach ($data['product_category'] as $category_id) {
               $query = $this->db->query("SELECT wc_category_id FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");
               $wc_categories[] = $query->row['wc_category_id'];
            }
        }
        
        if(empty($wc_categories)){
            $wc_categories[] = 22;//uncategorized
        }
        //$this->wcLog('wc_cats_log', $wc_categories);
    
        //attributes
        $wc_attributes = [];
        if (isset($data['product_attribute'])) {
            //$this->wcLog('data_product_attribute_log', $data['product_attribute'], false);
            
            foreach ($data['product_attribute'] as $product_attribute) {
                //$this->wcLog('product_attribute_log', $product_attribute, true);
                $attribute_id = $product_attribute['attribute_id'];
                if(isset($product_attribute['name']) and !empty($product_attribute['name'])){
                    $attribute_name = $product_attribute['name'];
                }else{
                    $query = $this->db->query("SELECT name FROM " . DB_PREFIX . "attribute_description WHERE attribute_id = '" . (int)$attribute_id . "' AND language_id='".(int)$lang."'");
                    $attribute_name = $query->row['name'];
                }
                
                $attribute_value = $product_attribute['product_attribute_description'][$lang]['text'];
                if(isset($attribute_value) and !empty($attribute_value)){
                    $wc_attributes[$attribute_name] = $attribute_value;
                }
                
            }
            //$this->wcLog('wc_product_attribute_log', $wc_attributes, false);
        }
        //attributes END
    
        if (isset($data['product_option'])) {
            $option_add_to_dish = false;//Добавить к блюду
            foreach ($data['product_option'] as $product_option) {
                //$this->wcLog('product_option', $product_option, true);
                $quantity = $product_option['quantity'];
                $option_name = $product_option['name'];
                $option_id = $product_option['option_id'];
                $product_option_value = $product_option['product_option_value'];
                if($option_name=='Добавить к блюду'){
                    $option_add_to_dish = true;
                    continue;
                }
                
                foreach ($product_option_value as $option_value){
                    
                    $option_value_id = $option_value['option_value_id'];
                    //$this->wcLog('wc_option_log', $option_value_id, true);
                    
                    $product_option_value_id = $option_value['product_option_value_id'];
                    //$this->wcLog('wc_option_log', $product_option_value_id, true);
                    
                    $product_option_image = $option_value['image'];
                    //$this->wcLog('wc_option_log', $product_option_image, true);
                    
                    $product_option_price = $option_value['price'];
                    //$this->wcLog('wc_option_log', $product_option_price, true);
    
                    $product_option_price_prefix = $option_value['price_prefix'];
                    //$this->wcLog('wc_option_log', $product_option_price_prefix, true);
                    
                    $query = $this->db->query("SELECT name FROM " . DB_PREFIX . "option_value_description WHERE option_value_id='".(int)$option_value_id."' AND language_id='".(int) $lang."' AND option_id='".(int)$option_id."'");
                    $product_option_value_name = $query->row['name'];
                    //$this->wcLog('wc_option_log', $product_option_value_name, true);
    
                    
                    $wc_form_variations[$option_name][] = array(
                        'value' => $product_option_value_name,
                        'price' => $product_option_price,
                        'price_prefix' => $product_option_price_prefix,
                    );
                    
                    $wc_variations[$option_name][] = $product_option_value_name;
                }
                
                //$this->wcLog('wc_option_log', '--------------------', true);
                //$this->wcLog('wc_product_options_log', $product_option, true);
            }
        }
        
        //form product data END
    
        //form request data
        $queryUrl = 'https://sushisetboss.com/add_oc_product.php';
        //$queryUrl = 'http://test.sushisetboss.com/add_oc_product.php';
        
        $queryData = [];
        if(isset($wc_product_name) and !empty($wc_product_name)){
            $queryData['wc_product_name'] = $wc_product_name;
        }
        
        if(isset($wc_price) and !empty($wc_price)){
            $queryData['wc_price'] = $wc_price;
        }
        if(isset($wc_special_price) and !empty($wc_special_price)){
            $queryData['wc_special_price'] = $wc_special_price;
        }
        
        if(isset($wc_product_description) and !empty($wc_product_description)){
            $queryData['wc_product_description'] = $wc_product_description;
        }
        if(isset($wc_model) and !empty($wc_model)){
            $queryData['wc_model'] = $wc_model;
        }
        if(isset($wc_product_images) and !empty($wc_product_images)){
            $queryData['wc_product_images'] = $wc_product_images;
        }
        if(isset($wc_categories) and !empty($wc_categories)){
            $queryData['wc_categories'] = $wc_categories;
        }
        if(isset($wc_attributes) and !empty($wc_attributes)){
            $queryData['wc_attributes'] = $wc_attributes;
        }
        if(isset($wc_variations) and !empty($wc_variations)){
            $queryData['wc_variations'] = $wc_variations;
        }
        if(isset($wc_form_variations) and !empty($wc_form_variations)){
            $queryData['wc_form_variations'] = $wc_form_variations;
        }
        //Добавить к блюду
        $queryData['wc_option_add_to_dish'] = $option_add_to_dish;
        $queryData['status'] = $status;
        
        
        try {
            //form request data END
            //send request
            $wc_product_id = $this->wcCurl($queryData, $queryUrl);
            
            $queryData = null; unset($queryData);
            $data = null; unset($data);
        }
        catch(Exception $e){
            $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
            $err = $info . $e->getMessage();
            $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
        }
        
        if(is_numeric($wc_product_id)){
            $this->db->query("UPDATE " . DB_PREFIX . "product SET mpn = '" . (integer)$wc_product_id . "' WHERE product_id = '" . (int)$product_id . "'");
        }
        
        return $wc_product_id;
    }
    
    public function updateProductToWc($data, $product_id)
    {
        //$this->wcLog('mpn_log', $data['mpn'], false);
        if (isset($data['mpn']) and !empty($data['mpn']) and is_numeric($data['mpn'])) {
            
            //form request data
            $queryData = [];
            $queryUrl = 'https://sushisetboss.com/update_oc_product.php';
            //$queryUrl = 'http://test.sushisetboss.com/update_oc_product.php';
            
            $wc_product_id = $data['mpn'];
            $queryData['wc_product_id'] = $wc_product_id;
            
            $lang = 2;//Язык данные из которого будем передавать
            //form product data
            $wc_price = (float)$data['price'];
            $wc_price = round($wc_price);
    
            $product_special = end($data['product_special']);
            $wc_special_price = (float)$product_special['price'];
            $wc_special_price = round($wc_special_price);
            
            $wc_model = $data['model'];
            $wc_product_images = [];
    
            if(!empty($data['status'])){
                $status = 'publish';
            }else{
                $status = 'draft';
            }
    
            foreach ($data['product_description'] as $language_id => $value) {
                if($language_id == $lang){
                    $wc_product_name = $value['name'];
                    $wc_product_description = htmlspecialchars_decode($value['description']);
            
                }
            }
    
            if (isset($data['image']) and !empty($data['image'])) {
                $image = str_replace(' ', '%20', $data['image']);
                $wc_product_images[] = HTTPS_CATALOG . 'image/' . $image;// FOR PRODUCTION
                //$wc_product_images[] = 'https://sushiboss.od.ua/' . 'image/' . $data['image'];// FOR LOCALHOST
            }
    
            if (isset($data['product_image']) and !empty($data['product_image'])) {
                foreach ($data['product_image'] as $product_image) {
                    $image = str_replace(' ', '%20', $product_image['image']);
                    $wc_product_images[] = HTTPS_CATALOG . 'image/' . $image;// FOR PRODUCTION
                    //$wc_product_images[] = HTTPS_CATALOG . 'image/' . $product_image['image'];// FOR PRODUCTION
                    //$wc_product_images[] = 'https://sushiboss.od.ua/' . 'image/' . $product_image['image'];// FOR LOCALHOST
                }
            }
    
            $wc_categories = [];
            if (isset($data['product_category'])) {
                foreach ($data['product_category'] as $category_id) {
                    $query = $this->db->query("SELECT wc_category_id FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");
                    $wc_categories[] = $query->row['wc_category_id'];
                }
            }
    
            if(empty($wc_categories)){
                $wc_categories[] = 22;//uncategorized
            }
            //$this->wcLog('wc_cats_log', $wc_categories);
    
            //attributes
            $wc_attributes = [];
            if (isset($data['product_attribute'])) {
                //$this->wcLog('data_product_attribute_log', $data['product_attribute'], false);
        
                foreach ($data['product_attribute'] as $product_attribute) {
                    //$this->wcLog('product_attribute_log', $product_attribute, true);
                    $attribute_id = $product_attribute['attribute_id'];
                    if(isset($product_attribute['name']) and !empty($product_attribute['name'])){
                        $attribute_name = $product_attribute['name'];
                    }else{
                        $query = $this->db->query("SELECT name FROM " . DB_PREFIX . "attribute_description WHERE attribute_id = '" . (int)$attribute_id . "' AND language_id='".(int)$lang."'");
                        $attribute_name = $query->row['name'];
                    }
            
                    $attribute_value = $product_attribute['product_attribute_description'][$lang]['text'];
                    if(isset($attribute_value) and !empty($attribute_value)){
                        $wc_attributes[$attribute_name] = $attribute_value;
                    }
            
                }
                //$this->wcLog('wc_product_attribute_log', $wc_attributes, false);
            }
            //attributes END
    
            if (isset($data['product_option'])) {
                $option_add_to_dish = false;//Добавить к блюду
                foreach ($data['product_option'] as $product_option) {
                    $option_name = $product_option['name'];
                    $option_id = $product_option['option_id'];
                    $product_option_value = $product_option['product_option_value'];
                    if($option_name=='Добавить к блюду'){
                        $option_add_to_dish = true;
                        continue;
                    }
            
                    foreach ($product_option_value as $option_value){
                
                        $option_value_id = $option_value['option_value_id'];
                        //$this->wcLog('wc_option_log', $option_value_id, true);
                
                        $product_option_value_id = $option_value['product_option_value_id'];
                        //$this->wcLog('wc_option_log', $product_option_value_id, true);
                
                        $product_option_image = $option_value['image'];
                        //$this->wcLog('wc_option_log', $product_option_image, true);
                
                        $product_option_price = $option_value['price'];
                        //$this->wcLog('wc_option_log', $product_option_price, true);
                
                        $product_option_price_prefix = $option_value['price_prefix'];
                        //$this->wcLog('wc_option_log', $product_option_price_prefix, true);
                
                        $query = $this->db->query("SELECT name FROM " . DB_PREFIX . "option_value_description WHERE option_value_id='".(int)$option_value_id."' AND language_id='".(int) $lang."' AND option_id='".(int)$option_id."'");
                        $product_option_value_name = $query->row['name'];
                        //$this->wcLog('wc_option_log', $product_option_value_name, true);
                
                
                        $wc_form_variations[$option_name][] = array(
                            'value' => $product_option_value_name,
                            'price' => $product_option_price,
                            'price_prefix' => $product_option_price_prefix,
                        );
                
                        $wc_variations[$option_name][] = $product_option_value_name;
                    }
            
                    //$this->wcLog('wc_option_log', '--------------------', true);
                    //$this->wcLog('wc_product_options_log', $product_option, true);
                }
            }
            //form product data END
            
            if(isset($wc_product_name) and !empty($wc_product_name)){
                $queryData['wc_product_name'] = $wc_product_name;
            }
            if(isset($wc_price) and !empty($wc_price)){
                $queryData['wc_price'] = $wc_price;
            }
            if(isset($wc_special_price) and !empty($wc_special_price)){
                $queryData['wc_special_price'] = $wc_special_price;
            }
            if(isset($wc_product_description) and !empty($wc_product_description)){
                $queryData['wc_product_description'] = $wc_product_description;
            }
            if(isset($wc_model) and !empty($wc_model)){
                $queryData['wc_model'] = $wc_model;
            }
            if(isset($wc_product_images) and !empty($wc_product_images)){
                $queryData['wc_product_images'] = $wc_product_images;
            }
            if(isset($wc_categories) and !empty($wc_categories)){
                $queryData['wc_categories'] = $wc_categories;
            }
            if(isset($wc_attributes) and !empty($wc_attributes)){
                $queryData['wc_attributes'] = $wc_attributes;
            }
            if(isset($wc_variations) and !empty($wc_variations)){
                $queryData['wc_variations'] = $wc_variations;
            }
            if(isset($wc_form_variations) and !empty($wc_form_variations)){
                $queryData['wc_form_variations'] = $wc_form_variations;
            }
            //Добавить к блюду
            $queryData['wc_option_add_to_dish'] = $option_add_to_dish;
            $queryData['status'] = $status;
            //form request data END
    
            try {
                //send request
                $result = $this->wcCurl($queryData, $queryUrl);
                $queryData = null; unset($queryData);
                $data = null; unset($data);
            }
            catch(Exception $e){
                $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
                $err = $info . $e->getMessage();
                $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
            }
            
            if(is_numeric($wc_product_id)){
                $this->db->query("UPDATE " . DB_PREFIX . "product SET mpn = '" . (integer)$wc_product_id . "' WHERE product_id = '" . (int)$product_id . "'");
            }
            return $wc_product_id;
        }
        else{
            
            try {
                //если не прописан mpn то добавляем как новый товар
                $wc_product_id = $this->addProductToWc($data, $product_id);
                $data = null; unset($data);
                return $wc_product_id;
            }
            catch(Exception $e){
                $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
                $err = $info . $e->getMessage();
                $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
                return false;
            }
        }
        
    }
    
    public function deleteWcProduct($product_id)
    {
        $queryUrl = 'https://sushisetboss.com/del_oc_product.php';
        $queryData = [];
        $query = $this->db->query("SELECT mpn FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
        $wc_product_id = $query->row['mpn'];
        
        if(isset($wc_product_id) and !empty($wc_product_id) and is_numeric($wc_product_id)){
            $queryData['wc_product_id'] = $wc_product_id;
            try {
                $result = $this->wcCurl($queryData, $queryUrl);
            }
            catch(Exception $e){
                $info = 'В методе: ' . __FUNCTION__ . ' около строки: ' .  __LINE__ . ' произошла ошибка API: ';
                $err = $info . $e->getMessage();
                $this->wcLog(__FUNCTION__ .'_err_log', $err, false);
            }
            //$this->wcLog('wc_delete_log', $result, false);
            return $result;
        }
        
    }
	//wc END ###############################################
}
