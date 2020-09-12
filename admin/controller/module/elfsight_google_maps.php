<?php

function saveParams($params) {
	$configFile = './controller/extension/module/elfsight-portal-params.json';
	file_put_contents($configFile, json_encode($params));
}

if (!empty($_POST) && !empty($_POST['params'])) {
	saveParams($_POST['params']);
}

class ControllerModuleElfsightGoogleMaps extends Controller {
	private $error = array();

	public $params = NULL;
    
    public $ELFSIGHT_EMBED_URL = 'https://apps.elfsight.com/embed/google-maps/?utm_source=portals&utm_medium=opencart&utm_campaign=google-maps&utm_content=sign-up';
    
    public function getParams() {
        $configFile = './controller/extension/module/elfsight-portal-params.json';
        $params = file_get_contents($configFile);
        return $params;
    }

	public function index() {
		$this->load->language('module/elfsight_google_maps');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('module_elfsight_google_maps', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('marketplace/module', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$params = json_encode([
                    'user' => [
                        'configEmail' => $this->config->get('config_email')
                    ]
                ]);
        
        $data['url'] = $this->ELFSIGHT_EMBED_URL;
        
        if (!empty($params)) {
            $data['url'] .= (parse_url($data['url'], PHP_URL_QUERY) ? '&' : '?') . 'params=' . rawurlencode($params);
        }

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['action'] = $this->url->link('module/elfsight_google_maps', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('marketplace/module', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['module_elfsight_google_maps_status'])) {
			$data['module_elfsight_google_maps_status'] = $this->request->post['module_elfsight_google_maps_status'];
		} else {
			$data['module_elfsight_google_maps_status'] = $this->config->get('module_elfsight_google_maps_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');

		$this->response->setOutput($this->load->view('module/elfsight_google_maps.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/elfsight_google_maps')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}