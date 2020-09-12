<?php
class ControllerShippingmultipickup extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('shipping/multipickup');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('multipickup', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_none'] = $this->language->get('text_none');

		$data['entry_multipickup'] = $this->language->get('entry_multipickup');
		$data['entry_cost'] = $this->language->get('entry_cost');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_multiStore'] = $this->language->get('entry_multiStore');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_refresh'] = $this->language->get('button_refresh');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['column_action'] = $this->language->get('column_action');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();

		foreach ($languages as $language) {
			if (isset($this->error['bank' . $language['language_id']])) {
				$data['error_bank' . $language['language_id']] = $this->error['bank' . $language['language_id']];
			} else {
				$data['error_bank' . $language['language_id']] = '';
			}
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_shipping'),
			'href' => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('shipping/multipickup', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('shipping/multipickup', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['refresh'] = $this->url->link('shipping/multipickup', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->load->model('localisation/language');

		foreach ($languages as $language) {
			if (isset($this->request->post['multipickup_' . $language['language_id']])) {
				$data['multipickup_' . $language['language_id']] = $this->request->post['multipickup_' . $language['language_id']];
			} else {
				$data['multipickup_' . $language['language_id']] = $this->config->get('multipickup_' . $language['language_id']);
			}
		}

		$data['languages'] = $languages;
		
		//get number of store		
		$query = $this->db->query("SELECT count(*) AS a FROM " . DB_PREFIX . "setting WHERE code='multipickup' AND `key` LIKE '%_cost'");

		$data['multiStore_array'] = array();		
		$x = 0; 
		$row=0;

		while($row < $query->row['a']) {
			$response = $this->config->get('multipickup_' . $x . '_status');
			if (!empty($response)) 
			{
			foreach ($languages as $language)
				$data['multiStore_array'][$row]['Store' . $language['language_id']]   = $this->config->get('multipickup_' . $x . '_Store_' . $language['language_id']);
			$data['multiStore_array'][$row]['cost']   = $this->config->get('multipickup_' . $x . '_cost');
			$data['multiStore_array'][$row]['sort']   = $this->config->get('multipickup_' . $x . '_sort');
			$data['multiStore_array'][$row]['status']   = $this->config->get('multipickup_' . $x . '_status');
			$row++;
			}
			$x++;
		} 

		if (isset($this->request->post['multipickup_geo_zone_id'])) {
			$data['multipickup_geo_zone_id'] = $this->request->post['multipickup_geo_zone_id'];
		} else {
			$data['multipickup_geo_zone_id'] = $this->config->get('multipickup_geo_zone_id');
		}

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['multipickup_status'])) {
			$data['multipickup_status'] = $this->request->post['multipickup_status'];
		} else {
			$data['multipickup_status'] = $this->config->get('multipickup_status');
		}

		if (isset($this->request->post['multipickup_sort_order'])) {
			$data['multipickup_sort_order'] = $this->request->post['multipickup_sort_order'];
		} else {
			$data['multipickup_sort_order'] = $this->config->get('multipickup_sort_order');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('shipping/multipickup.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'shipping/multipickup')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}