<?php
spl_autoload_register(function ($class_name) {
	if(file_exists(str_replace("\\", "/", $class_name) . '.php')) {
		include_once(str_replace("\\", "/", $class_name) . '.php');
	} else if(file_exists('../'.str_replace("\\", "/", $class_name) . '.php')) {
		include_once('../'.str_replace("\\", "/", $class_name) . '.php');
	}
});

class ControllerModuleOpencartTelegramBot extends Controller {
	private $error = array();
	
	public function install() {
		$this->load->model('module/opencart_telegram_bot');
		$this->model_module_opencart_telegram_bot->install();
	}
	
	public function uninstall() {
		$this->load->model('module/opencart_telegram_bot');
		$this->model_module_opencart_telegram_bot->uninstall();		
	}
	
	public function index() {
		$this->load->language('module/opencart_telegram_bot');
		$data['heading_title'] = $this->language->get('heading_title');
		$data['entry_token'] = $this->language->get('entry_token');
		$data['entry_webhook_key'] = $this->language->get('entry_webhook_key');
		$data['entry_allowed_shipping_methods'] = $this->language->get('entry_allowed_shipping_methods');
		$data['entry_allowed_payment_methods'] = $this->language->get('entry_allowed_payment_methods');	
		$data['text_edit'] = $this->language->get('text_edit');			
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_page_limit'] = $this->language->get('entry_page_limit');
		$data['entry_inquiry_telegram_id'] = $this->language->get('entry_inquiry_telegram_id');
		$data['entry_show_product_fields'] = $this->language->get('entry_show_product_fields');
		$data['entry_show_attributes'] = $this->language->get('entry_show_attributes');		
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$old_key=$this->config->get('module_opencart_telegram_bot_webhook_key');
		
		$token='';
		if(!empty($this->request->post['module_opencart_telegram_bot_token'])) {
			$token=$this->request->post['module_opencart_telegram_bot_token'];
		} else {
			$token=$this->config->get('module_opencart_telegram_bot_token');			
		}
		

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('module_opencart_telegram_bot', $this->request->post);
			
			if(isset($this->request->post['module_opencart_telegram_bot_webhook_key']) &&
				!empty($token) &&
			$this->request->post['module_opencart_telegram_bot_webhook_key']!=$old_key) {
				try {
					$bot = new \TelegramBot\Api\BotApi($token);
					$answer=$bot->setWebhook('');
					//$this->session->data['success']='var answer='.json_encode($answer);
					if($answer) {
						$answer2=$bot->setWebhook('https://'.$_SERVER['SERVER_NAME'].'/telegram_bot.php?key='.urlencode($this->request->post['module_opencart_telegram_bot_webhook_key']));
						if($answer2) {
							$this->session->data['success'] = $this->language->get('text_success');
						} else {
							$this->session->data['error']=$this->language->get('error_webhook');
							//$this->session->data['success'] ='var answer2='.json_encode($answer2); 
						}
					} else {
						
						$this->session->data['error']=$this->language->get('error_webhook');
						//$this->session->data['success']=$this->language->get('error_webhook');
					}
				} catch (\TelegramBot\Api\Exception $e) {
					$this->session->data['error']=$e->getMessage();
				} 
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/opencart_telegram_bot', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('module/opencart_telegram_bot', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$settings=$this->model_setting_setting->getSetting('module_opencart_telegram_bot');
		
		if (isset($this->request->post['module_opencart_telegram_bot_status'])) {
			$data['module_opencart_telegram_bot_status'] = $this->request->post['module_opencart_telegram_bot_status'];
		} else {
			$data['module_opencart_telegram_bot_status'] = $this->config->get('module_opencart_telegram_bot_status');
		}
		
		if (isset($this->request->post['module_opencart_telegram_bot_token'])) {
			$data['module_opencart_telegram_bot_token'] = $this->request->post['module_opencart_telegram_bot_token'];
		} else if(isset($settings['module_opencart_telegram_bot_token']))  {
			$data['module_opencart_telegram_bot_token'] = $settings['module_opencart_telegram_bot_token'];
		} else {
			$data['module_opencart_telegram_bot_token'] = '';
		}		
		
		if (isset($this->request->post['module_opencart_telegram_bot_webhook_key'])) {
			$data['module_opencart_telegram_bot_webhook_key'] = $this->request->post['module_opencart_telegram_bot_webhook_key'];
		} else if(isset($settings['module_opencart_telegram_bot_webhook_key']))  {
			$data['module_opencart_telegram_bot_webhook_key'] = $settings['module_opencart_telegram_bot_webhook_key'];
		} else {
			$data['module_opencart_telegram_bot_webhook_key'] = '';
		}
		
		if (isset($this->request->post['module_opencart_telegram_bot_allowed_shipping_methods'])) {
			$data['module_opencart_telegram_bot_allowed_shipping_methods'] = $this->request->post['module_opencart_telegram_bot_allowed_shipping_methods'];
		} else if(isset($settings['module_opencart_telegram_bot_allowed_shipping_methods']))  {
			$data['module_opencart_telegram_bot_allowed_shipping_methods'] = is_array($settings['module_opencart_telegram_bot_allowed_shipping_methods'])?$settings['module_opencart_telegram_bot_allowed_shipping_methods']:array($settings['module_opencart_telegram_bot_allowed_shipping_methods']);
			
		} else {
			$data['module_opencart_telegram_bot_allowed_shipping_methods'] = array();
		}
		
		if (isset($this->request->post['module_opencart_telegram_bot_allowed_payment_methods'])) {
			$data['module_opencart_telegram_bot_allowed_payment_methods'] = $this->request->post['module_opencart_telegram_bot_allowed_payment_methods'];
		} else if(isset($settings['module_opencart_telegram_bot_allowed_payment_methods']))  {
			$data['module_opencart_telegram_bot_allowed_payment_methods'] = is_array($settings['module_opencart_telegram_bot_allowed_payment_methods'])?$settings['module_opencart_telegram_bot_allowed_payment_methods']:array($settings['module_opencart_telegram_bot_allowed_payment_methods']);
			
		} else {
			$data['module_opencart_telegram_bot_allowed_payment_methods'] = array();
		}
		
		if (isset($this->request->post['module_opencart_telegram_bot_page_limit'])) {
			$data['module_opencart_telegram_bot_page_limit'] = (int)$this->request->post['module_opencart_telegram_bot_page_limit'];
		} else if(isset($settings['module_opencart_telegram_bot_page_limit']))  {
			$data['module_opencart_telegram_bot_page_limit'] = $settings['module_opencart_telegram_bot_page_limit'];
			
		} else {
			$data['module_opencart_telegram_bot_page_limit'] = 5;
		}
		
		if (isset($this->request->post['module_opencart_telegram_bot_inquiry_telegram_id'])) {
			$data['module_opencart_telegram_bot_inquiry_telegram_id'] = $this->request->post['module_opencart_telegram_bot_inquiry_telegram_id'];
		} else {
			$data['module_opencart_telegram_bot_inquiry_telegram_id'] = $this->config->get('module_opencart_telegram_bot_inquiry_telegram_id');
		}
		if (isset($this->request->post['module_opencart_telegram_bot_show_attributes'])) {
			$data['module_opencart_telegram_bot_show_attributes'] = $this->request->post['module_opencart_telegram_bot_show_attributes'];
		} else {
			$data['module_opencart_telegram_bot_show_attributes'] = $this->config->get('module_opencart_telegram_bot_show_attributes');
		}		
		
		if (isset($this->request->post['module_opencart_telegram_bot_show_product_fields'])) {
			$data['module_opencart_telegram_bot_show_product_fields'] = $this->request->post['module_opencart_telegram_bot_show_product_fields'];
		} else {
			$data['module_opencart_telegram_bot_show_product_fields'] = $this->config->get('module_opencart_telegram_bot_show_product_fields');
		}
		$this->load->language('catalog/product');
		$product_field_names=array('weight', 'length', 'width', 'height', 'sku', 'upc', 'ean', 'jan', 'isbn', 'mpn', 'description');
		$product_fields=array();
		foreach($product_field_names as $product_field_name) {
			$product_fields[]=array(
				'name'=>$product_field_name,
				'title'=>$this->language->get('entry_'.$product_field_name),
				'show'=>in_array($product_field_name, $data['module_opencart_telegram_bot_show_product_fields'])?true:false,
			);			
		}
		$data['product_fields']=$product_fields;
		
		$methods=array('payment','shipping');
		foreach($methods as $method) {
			$data[$method.'_methods']=array();
			$files = glob(DIR_APPLICATION . 'controller/'.$method.'/*.php');
			if ($files) {
				foreach ($files as $file) {
					$extension = basename($file, '.php');
					$this->load->language($method. '/' . $extension);
					if($this->config->get($extension . '_status')) {
					$data[$method.'_methods'][] = array(
						'title' => $this->language->get('heading_title'),
						'code' => $extension,
						'allowed'=>in_array($extension, $data['module_opencart_telegram_bot_allowed_'.$method.'_methods'])
						);
					}
				}
			}			
		}		

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/opencart_telegram_bot.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/opencart_telegram_bot')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}	

}