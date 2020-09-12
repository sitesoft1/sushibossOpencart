<?php
class ControllerCatalogPopuptemplate extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/popuptemplate');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/popuptemplate');

		$this->model_catalog_popuptemplate->createTables();

		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/popuptemplate');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/popuptemplate');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_popuptemplate->addPopuptemplate($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/popuptemplate');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/popuptemplate');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_popuptemplate->editPopuptemplate($this->request->get['popuptemplate_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/popuptemplate');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/popuptemplate');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $popuptemplate_id) {
				$this->model_catalog_popuptemplate->deletePopuptemplate($popuptemplate_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'id.title';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/popuptemplate/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/popuptemplate/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['popuptemplates'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$popuptemplate_total = $this->model_catalog_popuptemplate->getTotalPopuptemplates();

		$results = $this->model_catalog_popuptemplate->getPopuptemplates($filter_data);

		foreach ($results as $result) {
			$data['popuptemplates'][] = array(
				'popuptemplate_id' 	=> $result['popuptemplate_id'],
				'title'          	=> $result['title'],
				'status'     		=> ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'edit'           	=> $this->url->link('catalog/popuptemplate/edit', 'token=' . $this->session->data['token'] . '&popuptemplate_id=' . $result['popuptemplate_id'] . $url, true)
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_title'] = $this->language->get('column_title');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_setting'] = $this->language->get('button_setting');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_title'] = $this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . '&sort=id.title' . $url, true);
		$data['sort_status'] = $this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . '&sort=i.status' . $url, true);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $popuptemplate_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($popuptemplate_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($popuptemplate_total - $this->config->get('config_limit_admin'))) ? $popuptemplate_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $popuptemplate_total, ceil($popuptemplate_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/popuptemplate_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['popuptemplate_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_guest'] = $this->language->get('text_guest');
		$data['text_both'] = $this->language->get('text_both');
		$data['text_popup_codes'] = $this->language->get('text_popup_codes');
		$data['text_pc_logo'] = $this->language->get('text_pc_logo');
		$data['text_pc_store'] = $this->language->get('text_pc_store');
		$data['text_pc_products'] = $this->language->get('text_pc_products');
		$data['text_pc_productsinfo'] = $this->language->get('text_pc_productsinfo');
		$data['text_pc_coupneinfo'] = $this->language->get('text_pc_coupneinfo');
		$data['text_pc_coupon'] = $this->language->get('text_pc_coupon');
		$data['text_pc_coupon_discount'] = $this->language->get('text_pc_coupon_discount');
		$data['text_pc_total_amount'] = $this->language->get('text_pc_total_amount');
		$data['text_pc_coupon_enddate'] = $this->language->get('text_pc_coupon_enddate');
		$data['text_short_name'] = $this->language->get('text_short_name');
		$data['text_short_codes'] = $this->language->get('text_short_codes');

		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_coupon'] = $this->language->get('entry_coupon');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_show_title'] = $this->language->get('entry_show_title');
		$data['entry_show_account'] = $this->language->get('entry_show_account');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_show_closebutton'] = $this->language->get('entry_show_closebutton');
		$data['entry_logo'] = $this->language->get('entry_logo');
		$data['entry_background_image'] = $this->language->get('entry_background_image');
		$data['entry_settingproduct'] = $this->language->get('entry_settingproduct');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_css'] = $this->language->get('entry_css');
		$data['entry_minutes'] = $this->language->get('entry_minutes');
		$data['entry_margin_top'] = $this->language->get('entry_margin_top');
		$data['entry_popup_reopen'] = $this->language->get('entry_popup_reopen');
		$data['entry_show_version'] = $this->language->get('entry_show_version');
		$data['entry_show_caption'] = $this->language->get('entry_show_caption');
		
		$data['text_minutes'] = $this->language->get('text_minutes');
		$data['text_desktop'] = $this->language->get('text_desktop');
		$data['text_mobile'] = $this->language->get('text_mobile');
		
		$data['button_shortcodes'] = $this->language->get('button_shortcodes');

		$data['help_title'] = $this->language->get('help_title');
		$data['help_description'] = $this->language->get('help_description');
		$data['help_settingproduct'] = $this->language->get('help_settingproduct');
		$data['help_product'] = $this->language->get('help_product');
		$data['help_coupon'] = $this->language->get('help_coupon');
		$data['help_status'] = $this->language->get('help_status');
		$data['help_show_title'] = $this->language->get('help_show_title');
		$data['help_show_account'] = $this->language->get('help_show_account');
		$data['help_show_closebutton'] = $this->language->get('help_show_closebutton');
		$data['help_logo'] = $this->language->get('help_logo');
		$data['help_background_image'] = $this->language->get('help_background_image');
		$data['help_css'] = $this->language->get('help_css');
		$data['help_layout'] = $this->language->get('help_layout');
		$data['help_store'] = $this->language->get('help_store');
		$data['help_popup_reopen'] = $this->language->get('help_popup_reopen');
		$data['help_minutes'] = $this->language->get('help_minutes');
		$data['help_margin_top'] = $this->language->get('help_margin_top');
		$data['help_show_version'] = $this->language->get('help_show_version');
		$data['help_show_caption'] = $this->language->get('help_show_caption');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_product'] = $this->language->get('tab_product');
		$data['tab_coupon'] = $this->language->get('tab_coupon');
		$data['tab_setting'] = $this->language->get('tab_setting');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = array();
		}

		if (isset($this->error['description'])) {
			$data['error_description'] = $this->error['description'];
		} else {
			$data['error_description'] = array();
		}

		if (isset($this->error['setting_layout'])) {
			$data['error_setting_layout'] = $this->error['setting_layout'];
		} else {
			$data['error_setting_layout'] = '';
		}

		if (isset($this->error['show_account'])) {
			$data['error_show_account'] = $this->error['show_account'];
		} else {
			$data['error_show_account'] = '';
		}

		if (isset($this->error['show_version'])) {
			$data['error_show_version'] = $this->error['show_version'];
		} else {
			$data['error_show_version'] = '';
		}

		if (isset($this->error['popup_minutes'])) {
			$data['error_popup_minutes'] = $this->error['popup_minutes'];
		} else {
			$data['error_popup_minutes'] = '';
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['popuptemplate_id'])) {
			$data['action'] = $this->url->link('catalog/popuptemplate/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/popuptemplate/edit', 'token=' . $this->session->data['token'] . '&popuptemplate_id=' . $this->request->get['popuptemplate_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/popuptemplate', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['popuptemplate_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$popuptemplate_info = $this->model_catalog_popuptemplate->getPopuptemplate($this->request->get['popuptemplate_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('design/layout');
		$data['layouts'] = $this->model_design_layout->getLayouts();

		if (isset($this->request->post['setting_layout'])) {
			$data['setting_layout'] = $this->request->post['setting_layout'];
		} elseif (!empty($popuptemplate_info)) {
			$data['setting_layout'] = $this->model_catalog_popuptemplate->getPopuptemplateSettingLayouts($popuptemplate_info['popuptemplate_id']);
		} else {
			$data['setting_layout'] = array(0);
		}


		$this->load->model('marketing/coupon');
		$data['coupons'] = $this->model_marketing_coupon->getCoupons();

		if (isset($this->request->post['popuptemplate_description'])) {
			$data['popuptemplate_description'] = $this->request->post['popuptemplate_description'];
		} elseif (isset($this->request->get['popuptemplate_id'])) {
			$data['popuptemplate_description'] = $this->model_catalog_popuptemplate->getPopuptemplateDescriptions($this->request->get['popuptemplate_id']);
		} else {
			$data['popuptemplate_description'] = array();
		}

		// Background Image
		if (isset($this->request->post['background_image'])) {
			$data['background_image'] = $this->request->post['background_image'];
		} elseif (!empty($popuptemplate_info)) {
			$data['background_image'] = $popuptemplate_info['background_image'];
		} else {
			$data['background_image'] = '';
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['background_image']) && is_file(DIR_IMAGE . $this->request->post['background_image'])) {
			$data['background_thumb'] = $this->model_tool_image->resize($this->request->post['background_image'], 100, 100);
		} elseif (!empty($popuptemplate_info) && is_file(DIR_IMAGE . $popuptemplate_info['background_image'])) {
			$data['background_thumb'] = $this->model_tool_image->resize($popuptemplate_info['background_image'], 100, 100);
		} else {
			$data['background_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		// Logo
		if (isset($this->request->post['logo'])) {
			$data['logo'] = $this->request->post['logo'];
		} elseif (!empty($popuptemplate_info)) {
			$data['logo'] = $popuptemplate_info['logo'];
		} else {
			$data['logo'] = '';
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['logo']) && is_file(DIR_IMAGE . $this->request->post['logo'])) {
			$data['logo_thumb'] = $this->model_tool_image->resize($this->request->post['logo'], 100, 100);
		} elseif (!empty($popuptemplate_info) && is_file(DIR_IMAGE . $popuptemplate_info['logo'])) {
			$data['logo_thumb'] = $this->model_tool_image->resize($popuptemplate_info['logo'], 100, 100);
		} else {
			$data['logo_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($popuptemplate_info)) {
			$data['sort_order'] = $popuptemplate_info['sort_order'];
		} else {
			$data['sort_order'] = '0';
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($popuptemplate_info)) {
			$data['status'] = $popuptemplate_info['status'];
		} else {
			$data['status'] = '1';
		}

		if (isset($this->request->post['show_account'])) {
			$data['show_account'] = $this->request->post['show_account'];
		} elseif (!empty($popuptemplate_info)) {
			$data['show_account'] = (!empty($popuptemplate_info['show_account']) ? json_decode($popuptemplate_info['show_account']) : array());
		} else {
			$data['show_account'] = ($data['error_show_account']) ? array() : array('register', 'guest');
		}

		if (isset($this->request->post['show_version'])) {
			$data['show_version'] = $this->request->post['show_version'];
		} elseif (!empty($popuptemplate_info)) {
			$data['show_version'] = (!empty($popuptemplate_info['show_version']) ? json_decode($popuptemplate_info['show_version']) : array());
		} else {
			$data['show_version'] = ($data['error_show_version']) ? array() : array('desktop', 'mobile');
		}

		if (isset($this->request->post['show_title'])) {
			$data['show_title'] = $this->request->post['show_title'];
		} elseif (!empty($popuptemplate_info)) {
			$data['show_title'] = $popuptemplate_info['show_title'];
		} else {
			$data['show_title'] = '1';
		}

		if (isset($this->request->post['show_caption'])) {
			$data['show_caption'] = $this->request->post['show_caption'];
		} elseif (!empty($popuptemplate_info)) {
			$data['show_caption'] = $popuptemplate_info['show_caption'];
		} else {
			$data['show_caption'] = '1';
		}

		if (isset($this->request->post['show_closebutton'])) {
			$data['show_closebutton'] = $this->request->post['show_closebutton'];
		} elseif (!empty($popuptemplate_info)) {
			$data['show_closebutton'] = $popuptemplate_info['show_closebutton'];
		} else {
			$data['show_closebutton'] = '1';
		}

		if (isset($this->request->post['css'])) {
			$data['css'] = $this->request->post['css'];
		} elseif (!empty($popuptemplate_info)) {
			$data['css'] = $popuptemplate_info['css'];
		} else {
			$data['css'] = '';
		}

		if (isset($this->request->post['popup_reopen'])) {
			$data['popup_reopen'] = $this->request->post['popup_reopen'];
		} elseif (!empty($popuptemplate_info)) {
			$data['popup_reopen'] = $popuptemplate_info['popup_reopen'];
		} else {
			$data['popup_reopen'] = '';
		}

		if (isset($this->request->post['popup_minutes'])) {
			$data['popup_minutes'] = $this->request->post['popup_minutes'];
		} elseif (!empty($popuptemplate_info)) {
			$data['popup_minutes'] = $popuptemplate_info['popup_minutes'];
		} else {
			$data['popup_minutes'] = '';
		}

		if (isset($this->request->post['margin_top'])) {
			$data['margin_top'] = $this->request->post['margin_top'];
		} elseif (!empty($popuptemplate_info)) {
			$data['margin_top'] = $popuptemplate_info['margin_top'];
		} else {
			$data['margin_top'] = '';
		}

		if (isset($this->request->post['coupon_id'])) {
			$data['coupon_id'] = $this->request->post['coupon_id'];
		} elseif (!empty($popuptemplate_info)) {
			$data['coupon_id'] = $popuptemplate_info['coupon_id'];
		} else {
			$data['coupon_id'] = '';
		}

		$this->load->model('catalog/product');

		$data['products'] = array();

		if (!empty($this->request->post['product'])) {
			$products = $this->request->post['product'];
		} elseif (!empty($popuptemplate_info)) {
			$products = $this->model_catalog_popuptemplate->getPopuptemplateProducts($popuptemplate_info['popuptemplate_id']);
		} else {
			$products = array();
		}

		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				$data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}

		$data['setting_products'] = array();

		if (!empty($this->request->post['setting_product'])) {
			$setting_products = $this->request->post['setting_product'];
		} elseif (!empty($popuptemplate_info)) {
			$setting_products = $this->model_catalog_popuptemplate->getPopuptemplateSettingProducts($popuptemplate_info['popuptemplate_id']);
		} else {
			$setting_products = array();
		}

		foreach ($setting_products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				$data['setting_products'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}

		$this->load->model('setting/store');
		$data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['popuptemplate_store'])) {
			$data['popuptemplate_store'] = $this->request->post['popuptemplate_store'];
		} elseif (isset($this->request->get['popuptemplate_id'])) {
			$data['popuptemplate_store'] = $this->model_catalog_popuptemplate->getPopuptemplateStores($this->request->get['popuptemplate_id']);
		} else {
			$data['popuptemplate_store'] = array(0);
		}


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/popuptemplate_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/popuptemplate')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['popuptemplate_description'] as $language_id => $value) {
			if ((utf8_strlen($value['title']) < 3) || (utf8_strlen($value['title']) > 255)) {
				$this->error['title'][$language_id] = $this->language->get('error_title');
			}
		}

		if(empty($this->request->post['show_account'])) {
			$this->error['show_account'] = $this->language->get('error_show_account');
		}

		if(empty($this->request->post['show_version'])) {
			$this->error['show_version'] = $this->language->get('error_show_version');
		}


		if(!empty($this->request->post['popup_reopen'])) {
			if(!isset($this->request->post['popup_minutes']) || (int)$this->request->post['popup_minutes'] < '0') {
				$this->error['popup_minutes'] = $this->language->get('error_popup_minutes');
			}
		}

		if(empty($this->request->post['setting_layout'])) {
			$this->error['setting_layout'] = $this->language->get('error_setting_layout');
		}

		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/popuptemplate')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}