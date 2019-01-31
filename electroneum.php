<?php
/**
 * NOTICE OF LICENSE
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2015-2016 Electroneum
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  @author    JoomlaPro <info@JoomlaPro.com>
 *  @copyright 2015-2016 JoomlaPro

 */
use PrestaShop\PrestaShop\Core\Payment\PaymentOption;
if (!defined('_PS_VERSION_')) {
    exit;
}

require_once _PS_MODULE_DIR_ . '/electroneum/vendor/Vendor.php';
require_once _PS_MODULE_DIR_ . '/electroneum/vendor/Exception/VendorException.php';

class Electroneum extends PaymentModule
{
    private $html = '';
    private $postErrors = array();

    public $api_auth_token;
    public $receive_currency;
    public $test;

    public function __construct()
    {
        $this->name = 'electroneum';
        $this->tab = 'payments_gateways';
        $this->version = '1.0.1';
        $this->author = 'JoomlaPro.com';
        $this->is_eu_compatible = 1;
        $this->controllers = array('payment', 'redirect', 'callback', 'cancel');
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
		
		
	 
		
		$ajaxtask = Tools::getValue('ajaxtask');
		if($ajaxtask == 'getresponse')
		{
			$paymentid   = Tools::getValue('paymentid');
			$outlet  = Tools::getValue('outlet');
			$apikey  = Tools::getValue('apikey');
			$secret  = Tools::getValue('secret');
			$id_order  = Tools::getValue('id_order');
	
			
			 
			 $vendor = new \Electroneum\Vendor\Vendor($apikey, $secret);
			 
			 $payload = array();
			 $payload['payment_id'] = $paymentid;
 	         $payload['vendor_address'] = 'etn-it-'.$outlet;
			 
			 $result = $vendor->checkPaymentPoll(json_encode($payload));
			
			 $etnshouldreceive = '';
			 session_start();
             if(!empty($_SESSION['etnvalue']))
			 {
			 	$etnshouldreceive = $_SESSION['etnvalue'];
			 }
			 
			 $return = array();
			 $return['showerror'] = 0;
			 
			 if($etnshouldreceive == '')
			 {
				  $return['success'] = 0;
				  $return['showerror'] = 1;
				  $return['message'] = 'Your session Timed out Please  Reload page and try again';
			 }
			 else if($result['status'] == 1) 
			 {
				 if($result['amount'] ==  $etnshouldreceive)
				 {
					 $return['success'] = 1;
					 $return['amount'] = $result['amount'];
					 $result['message'] = '';
					
					 
					 $objOrder = new Order($id_order); 
					 $history = new OrderHistory();
					 $history->id_order = (int)$objOrder->id;
					 $history->changeIdOrderState(Configuration::get('ELECTRONEUM_CONFIRMING'), (int)($objOrder->id));  
					 $_SESSION['etnvalue'] = "";
				 }
				 else
				 {
					  $return['success'] = 0;
					  $return['showerror'] = 1;
				      $return['message'] = 'ETN Response Amount Not matched to Order Amount';
				 }
				 
			 } 
			 else if (!empty($result['message']))  
			 {
				 $return['success'] = 0;
				 $return['message'] = $result['message'];
			 }
			 else
			 {
				  $return['success'] = 0;
				  $return['message'] = 'Unknown Error was found';
			 }
			echo json_encode($return);
			exit;
		}


        $this->currencies = true;
        $this->currencies_mode = 'checkbox';

        $this->bootstrap = true;

        $config = Configuration::getMultiple(
            array(
                'apikey',
                'secret',
                'outlet',
            )
        );
		
		
        if (!empty($config['apikey'])) {
            $this->apikey = $config['apikey'];
        }

        if (!empty($config['secret'])) {
            $this->secret = $config['secret'];
        }

        if (!empty($config['outlet'])) {
            $this->outlet = $config['outlet'];
        }

        parent::__construct();

        $this->displayName = $this->l('Electroneum Payment Method');
        $this->description = $this->l('Accept Payment from Electroneum Wallet');
        $this->confirmUninstall = $this->l('Are you sure you want to delete your details?');

      
    }

    public function install()
    {
        if (!function_exists('curl_version')) {
            $this->_errors[] = $this->l('This module requires cURL PHP extension in order to function normally.');

            return false;
        }

		$order_confirming = new OrderState();
        $order_confirming->name = array_fill(0, 10, 'Payment confirmation Done');
        $order_confirming->send_email = 0;
        $order_confirming->invoice = 0;
        $order_confirming->color = '#d9ff94';
        $order_confirming->unremovable = false;
        $order_confirming->logable = 0;
		
		$order_confirming->add();
		
		Configuration::updateValue('ELECTRONEUM_CONFIRMING', $order_confirming->id);
   

        if (!parent::install()
            || !$this->registerHook('payment')
            || !$this->registerHook('displayPaymentEU')
            || !$this->registerHook('paymentReturn')
            || !$this->registerHook('paymentOptions')) {
            return false;
        }

        return true;
    }

    public function uninstall()
    {
        $order_state_confirming = new OrderState(Configuration::get('ELECTRONEUM_CONFIRMING'));

        return (
            Configuration::deleteByName('apikey') &&
            $order_state_confirming->delete() &&
            parent::uninstall()
        );
    }

    private function postValidation()
    {
        if (Tools::isSubmit('btnSubmit')) 
		{
			if (!Tools::getValue('apikey'))
			{
                $this->postErrors[] = $this->l('Api Key is required.');
            }
			if (!Tools::getValue('secret')) 
			{
                $this->postErrors[] = $this->l('API Secret Key is required.');
            }
			if (!Tools::getValue('outlet')) 
			{
                $this->postErrors[] = $this->l('Vendor Id is required.');
            }
        }
    }

    private function postProcess()
    {
        if (Tools::isSubmit('btnSubmit')) {
            Configuration::updateValue('apikey', Tools::getValue('apikey'));
            Configuration::updateValue('secret', Tools::getValue('secret'));
		    Configuration::updateValue('outlet', Tools::getValue('outlet'));
        }

        $this->html .= $this->displayConfirmation($this->l('Settings updated'));
    }

    private function displayElectroneum()
    {
        return $this->display(__FILE__, 'infos.tpl');
    }

    private function displayElectroneumInformation($renderForm)
    {
        $this->html .= $this->displayElectroneum();
        $this->context->smarty->assign('form', $renderForm);
        return $this->display(__FILE__, 'information.tpl');
    }

    public function getContent()
    {
        if (Tools::isSubmit('btnSubmit')) {
            $this->postValidation();
            if (!count($this->postErrors)) {
                $this->postProcess();
            } else {
                foreach ($this->postErrors as $err) {
                    $this->html .= $this->displayError($err);
                }
            }
        } else {
            $this->html .= '<br />';
        }

        $renderForm = $this->renderForm();
        $this->html .= $this->displayElectroneumInformation($renderForm);

        return $this->html;
    }

    public function hookPayment($params)
    {
        if (_PS_VERSION_ >= 1.7) {
            return;
        }

        if (!$this->active) {
            return;
        }

        if (!$this->checkCurrency($params['cart'])) {
            return;
        }

        $this->smarty->assign(array(
            'this_path'     => $this->_path,
            'this_path_bw'  => $this->_path,
            'this_path_ssl' => Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'modules/' . $this->name . '/',
        ));

        return $this->display(__FILE__, 'payment.tpl');
    }


    public function hookDisplayOrderConfirmation($params)
    {
        if (_PS_VERSION_ <= 1.7) {
            return;
        }

        if (!$this->active) {
            return;
        }

        if (!$this->checkCurrency($params['cart'])) {
            return;
        }

        $this->smarty->assign(array(
            'this_path'     => $this->_path,
            'this_path_bw'  => $this->_path,
            'this_path_ssl' => Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'modules/' . $this->name . '/',
        ));

        return $this->context->smarty->fetch(__FILE__, 'payment.tpl');
    }

	public function hookPaymentReturn($params)
	{
		if (!$this->active) {
            return;
        }
		$this->context->controller->addCSS($this->_path.'/vendor/custom.css', 'all');
        $this->context->controller->addJS($this->_path.'/vendor/custom.js', 'all');
		
		
		$apikey = Configuration::get('apikey');
		$secret = Configuration::get('secret');
		$outlet = Configuration::get('outlet');
		
		global $currency;
		$currencycode = $currency->iso_code;
		
		$amtval = $params['order']->getOrdersTotalPaid();
		
		$link = new Link;
		$parameters = array("action" => "check_response");
		$ajax_link = $link->getModuleLink('electroneum','controller', $parameters);
		

		
		
		
		
	
		 	$vendor = new \Electroneum\Vendor\Vendor($apikey, $secret);
			
			$qrImgUrl = $vendor->getQr($amtval, $currencycode, $outlet);
			
			session_start();
			$_SESSION['etnvalue'] =  $vendor->getEtn();

			
            $etnvalue = $vendor->getEtn();

		  $this->smarty->assign(array(
                'orderTotal' => Tools::displayPrice(
                    $params['order']->getOrdersTotalPaid(),
                    new Currency($params['order']->id_currency),
                    false
                ),
				'ajax_link' => $ajax_link,
				'etnTotal' => $vendor->getEtn(),
				'etnvalue' => $vendor->getEtn(),
				'etnpaymentid' => $vendor->getPaymentId(),
				'apikey' => $apikey,
				'qrImgUrl' => $qrImgUrl,
				'currencycode' => $currencycode,
				'secret' => $secret,
				'outlet' => $outlet,
				'htmlcontent' =>  Tools::htmlentitiesUTF8($html),
                'shop_name' => $this->context->shop->name,
                'checkName' => $this->checkName,
                'checkAddress' => Tools::nl2br($this->address),
                'status' => 'ok',
				'loadingimg' => $this->_path.'img/loading.gif',
                'id_order' => $params['order']->id
            ));
            if (isset($params['order']->reference) && !empty($params['order']->reference)) {
                $this->smarty->assign('reference', $params['order']->reference);
            }
			

		return $this->fetch('module:electroneum/views/templates/hook/payment.tpl');
	}

    public function hookPaymentOptions($params)
    {
        if (!$this->active) {
            return;
        }

        if (!$this->checkCurrency($params['cart'])) {
            return;
        }
		
		$this->smarty->assign(
            $this->getTemplateVars()
        );
		
        $newOption = new PrestaShop\PrestaShop\Core\Payment\PaymentOption();
        $newOption->setCallToActionText('Electronuem')
            ->setAction($this->context->link->getModuleLink($this->name, 'redirect', array(), true))
            ->setAdditionalInformation(  $this->fetch('module:electroneum/views/templates/front/info.tpl')
            );

        $payment_options = array($newOption);

        return $payment_options;
    }

    public function checkCurrency($cart)
    {
        $currency_order = new Currency($cart->id_currency);
        $currencies_module = $this->getCurrency($cart->id_currency);

        if (is_array($currencies_module)) {
            foreach ($currencies_module as $currency_module) {
                if ($currency_order->id == $currency_module['id_currency']) {
                    return true;
                }
            }
        }

        return false;
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Electroneum Payment Settings'),
                ),
                'input'  => array(
                    array(
                        'type'     => 'text',
                        'label'    => $this->l('API Key'),
                        'name'     => 'apikey',
                        'desc'     => $this->l('Api Key for Electorneum'),
                        'required' => true,
                    ),
					  array(
                        'type'     => 'text',
                        'label'    => $this->l('API Secret'),
                        'name'     => 'secret',
                        'desc'     => $this->l('Api Secret for Electorneum'),
                        'required' => true,
                    ),
					  array(
                        'type'     => 'text',
                        'label'    => $this->l('Vendor Id'),
                        'name'     => 'outlet',
                        'desc'     => $this->l('Vendor Id For Store'),
                        'required' => true,
                    ),
                  
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                ),
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int) Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = (Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG')
            ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0);
        $this->fields_form = array();
        $helper->id = (int) Tools::getValue('id_carrier');
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'btnSubmit';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
        . '&configure=' . $this->name . '&tab_module='
        . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
            'languages'    => $this->context->controller->getLanguages(),
            'id_language'  => $this->context->language->id,
			
        );


        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
           
            'outlet' => Tools::getValue(
                'outlet',
                Configuration::get('outlet')
            ),
            'secret' => Tools::getValue(
                'secret',
                Configuration::get('secret')
            ),
			'apikey' => Tools::getValue(
                'apikey',
                Configuration::get('apikey')
            ),
        );
    }
	public function getTemplateVars()
    {
		global $currency;
		
		$currencycode = $currency->iso_code;
		
		
		$this->context->controller->addCSS($this->_path.'/vendor/custom.css', 'all');
        $this->context->controller->addJS($this->_path.'/vendor/custom.js', 'all');
		 
        $cart = $this->context->cart;
		$totalamt  = $cart->getOrderTotal();
		
        $total = $this->trans(
            '%amount% (tax incl.)',
            array(
                '%amount%' => $cart->getOrderTotal(true, Cart::BOTH),
            ),
            'Modules.Checkpayment.Admin'
        );
		
		$urlsupply = 'https://supply.electroneum.com/app-value-v2.json';
	    $json = file_get_contents($urlsupply);
			 
		$jsonsarray = json_decode($json, true);
		$etnvalue = $jsonsarray['price_'.strtolower($currencycode)];
		
	    $convertedamount = number_format(floatval($totalamt) / $etnvalue, 2, '.', ''); 
		
		
		$return = array();
		$return['orderTotal'] = $totalamt." ".$currencycode;
		$return['etnTotal'] = $convertedamount;
		
		return $return;
    }

    private function stripString($item)
    {
        return preg_replace('/\s+/', '', $item);
    }
}
