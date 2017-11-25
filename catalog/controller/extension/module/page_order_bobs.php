<?php

/**
 * Class ControllerModulePageOrderBobs front class controller
 *
 * @author  Bobs
 * @license GPL
 */
class ControllerExtensionModulePageOrderBobs extends Controller
{

    /**
     * Return link for radio type presentation
     */
    public function post()
    {
        $this->load->model('extension/module/page_order_bobs');
        $json = $this->model_extension_module_page_order_bobs->getPostLink(
            $this->request->post['order_id'],
            $this->request->post['percent']
        );
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }


    /**
     * Main point
     *
     */
    public function index()
    {
        $this->loadModelAndCssStyle();
        $page_id = (int)$this->request->get['page_order_bobs_id'];
        $page = $this->model_extension_module_page_order_bobs->getPage($page_id);

        if ($page) {
            $this->viewPage($page, $page_id);
        } else { //Error
            $this->viewErrorNonFound($page_id);
        }
    }


    /**
     * Load modul and css style
     *
     */
    private function loadModelAndCssStyle()
    {
        $this->language->load('extension/module/page_order_bobs');
        $this->load->model('tool/image');
        $this->load->model('account/order');
        $this->load->model('catalog/product');
        $this->load->model('extension/module/page_order_bobs');
    }


    /**
     * View page
     *
     * @param array $page
     * @param int   $page_id
     */
    private function viewPage($page, $page_id)
    {
	    $data1=$this->pageIsDataHeader($page, $page_id);
	    $data2=$this->pageIsDataOrder($page['order_site_id'], $page['order_site_check'], $page['description_order']);
	    $data3=$this->pageIsDataBody($page);
	    $data4=$this->pageIsDataFooter();
	    $dataGl=array_merge($data1, $data2, $data3, $data4);

        $this->response->setOutput($this->load->view('extension/module/page_order_bobs', $dataGl));

    }


    /**
     * Record variable for Header
     *
     * @param array $page
     * @param   int    $page_id
     */
    private function pageIsDataHeader(array &$page, $page_id)
    {
        $name_page = $this->language->get('title') . $page['order_id'];
        $this->document->setTitle($name_page);
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );
        $data['breadcrumbs'][] = array(
            'text' => $name_page,
            'href' => $this->url->link('extension/module/page_order_bobs', 'page_order_bobs_id=' . $page_id),
            'separator' => $this->language->get('text_separator')
        );
        $data['heading_title'] = $name_page;
        return $data;
    }


	/**
	 * Record variable for Order
	 *
	 * @param $order_site_id
	 *
	 * @return array
	 */
    private function pageIsDataOrder($order_site_id, $order_site_check, $description_order)
    {
        if(!$order_site_check)
        {
            return $this->noTableDescription($description_order);
        }
	    $data=array();
        $order = $this->getOrder($order_site_id);
        if ($order) {
            $data['column_image'] = $this->language->get('column_image');
            $data['column_name'] = $this->language->get('column_name');
            $data['column_model'] = $this->language->get('column_model');
            $data['column_quantity'] = $this->language->get('column_quantity');
            $data['column_price'] = $this->language->get('column_price');
            $data['column_total'] = $this->language->get('column_total');

            $data['order'] = true;
            $order_products = $this->model_account_order->getOrderProducts($order[0]['order_id']);
            $products = Array();
            foreach ($order_products as $key => $order_product) {
                $products[] = $order_product;
                $product = $this->model_catalog_product->getProduct($order_product['product_id']);
                $products[$key]['image'] = $product['image'];
                $products[$key]['tax_class_id'] = $product['tax_class_id'];
                $products[$key]['option'] = $this->model_account_order->getOrderOptions($order_product['order_id'],
                    $order_product['order_product_id']);
            }

            foreach ($products as $product) {
                $option_data = array();
                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {
                        $value = $option['value'];
                    } else {
                        $encryption = new Encryption($this->config->get('config_encryption'));
                        $option_value = $encryption->decrypt($option['value']);
                        $filename = substr($option_value, 0, strrpos($option_value, '.'));
                        $value = $filename;
                    }
                    $option_data[] = array(
                        'name' => $option['name'],
                        'value' => (utf8_strlen($value) > 200 ? utf8_substr($value, 0, 20) . '..' : $value)
                    );
                }

                if ($product['image']) {
                    $image_cart_width = $this->config->get('config_image_cart_width');
                    $image_cart_width = $image_cart_width ? $image_cart_width : 40;
                    $image_cart_height = $this->config->get('config_image_cart_height');
                    $image_cart_height = $image_cart_height ? $image_cart_height : 40;
                    $image = $this->model_tool_image->resize($product['image'], $image_cart_width, $image_cart_height);
                } else {
                    $image = '';
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price_no_format=$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
                    $price = $this->currency->format($price_no_format, $order[0]['currency_code'], 1);
                } else {
                    $price = false;
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price_no_format=$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'];
                    $total = $this->currency->format($price_no_format, $order[0]['currency_code'], 1);
                } else {
                    $total = false;
                }

                $data['products'][] = array(
                    'thumb' => $image,
                    'name' => $product['name'],
                    'model' => $product['model'],
                    'option' => $option_data,
                    'quantity' => $product['quantity'],
                    'price' => $price,
                    'total' => $total,
                    'href' => $this->url->link('product/product', 'product_id=' . $product['product_id'])
                );

            }

            $data['price_total_mod'] = $this->getPriceTotalMod($order,count($order_products));

            return $data;

        } else  //no order product free page order
        {
            return $this->noTableDescription($description_order);
        }

    }

    private function noTableDescription($description_order)
    {
        return array('description_order' => $description_order);
    }

    /**
     * Get price mod if they are
     *
     */
    private function getPriceTotalMod($order, $count_products)
    {
        $price_total_mod=array();
        $total_price=0;
        $net_price=0;
        foreach($order as $key=>$price_mod)
        {
            if($price_mod['code']=='total')
            {
                $total_price=$price_mod['value'];
            }
            if($price_mod['code']=='sub_total')
            {
                $net_price=$price_mod['value'];
            }
        }
        if($total_price!=$net_price && $total_price!==false)
        {
            $i=0;
            foreach($order as $key=>$price_mod)
            {
                $price_total_mod[$i] = array();
                $price_total_mod[$i]['title'] = $price_mod['title'];
                $price_total_mod[$i]['text'] = $this->currency->format($price_mod['value'], $price_mod['currency_code'], 1);
                $i++;
            }
        } else {
            if($count_products>1)
            {
                $price_total_mod[0]['title'] = $price_mod['title'];
                $price_total_mod[0]['text'] = $this->currency->format($price_mod['value'], $price_mod['currency_code'], 1);
            }

        }
        return $price_total_mod;
    }


    /**
     * Return order array
     *
     * @param int $order_site_id
     * @return array
     */
    private function getOrder($order_site_id)
    {

        $order = $this->model_account_order->getOrderTotals($order_site_id);
        $orderMas = $this->model_account_order->getOrder($order_site_id);
        foreach($order as $key=>$order_sub)
        {
            $order[$key]['currency_code'] = $orderMas['currency_code'];
        }
        if (!$order) {
            $order = 0; //No tabl, if no tabl programm
        }
        return $order;
    }


    private function pageIsDataBody(array $page)
    {
	    $data=array();
        $data['list_payment_label'] = $this->language->get('list_payment_label');
        $data['link_pay2pay_label'] = $this->language->get('link_pay2pay_label');
        $data['link_robokassa_label'] = $this->language->get('link_robokassa_label');
        $data['link_interkassa_label'] = $this->language->get('link_interkassa_label');

        $data['currency_code_label'] = $this->language->get('currency_code_label');
        $data['price_label'] = $this->language->get('price_label');
        $data['several_percent_label'] = $this->language->get('several_percent_label');


        $data['variable_name'] = $page['variable_name'];
        $data['receiver_of_product_label'] = $this->language->get('receiver_of_product_label');
        $data['delivery_address_label'] = $this->language->get('delivery_address_label');
        $data['delivery_method_label'] = $this->language->get('delivery_method_label');
        $data['notes_label'] = $this->language->get('notes_label');

        $data['order_id'] = $page['order_id'];
        $data['type_of_presentation'] = $page['type_of_presentation'];
        $data['price_label'] = $this->language->get('price_before_one_percent_label');
        switch ($page['type_of_presentation']) {
            case 0:
                if ($page['price'] == $page['one_price_total']) {
                    $data['price'] = $this->currency->format($page['price'], $page['currency_code'], 1);
                } else {
                    $data['price'] =
                        $this->currency->format($page['price'], $page['currency_code'], 1) .
                        $this->language->get('price_after_one_percent_label') .
                        $page['one_percent'] .
                        '%)';
                }
                foreach ($page['links'] as $link) {
                    if ($link['default']) {
                        $data[$link['type']] = $link['link'];
                    }
                }
                break;
            case 1:
                $data['several_percent_default'] = $page['several_percent_default'];
                $data['several_percent'] = $page['several_percent'];
                if ($page['several_percent'] != null) {
                    $several_percent = unserialize($page['several_percent']);
                    $options_client_percent_general = array();
                    foreach ($several_percent as $key => $percent) {
                        $options_client_percent_general[$key]['percent'] = $percent;
                        $options_client_percent_general[$key]['price'] =
                            $this->currency->format(
                                ($page['one_price_total'] * $percent) / 100, $page['currency_code'], 1
                            );
                    }
                    $data['several_percent'] = $options_client_percent_general;
                } else {
                    $data['several_percent'] = '';
                }
                $data['price'] = null;
                foreach ($page['links'] as $link) {
                    if ($link['default']) {
                        $data[$link['type']] = $link['link'];
                    }
                }
                break;
            case 2:

                $data['price'] = null;
                $links_structure = array();
                foreach ($page['links'] as $link) {
                    if (array_key_exists($link['percent'], $links_structure)) {
                        $links_structure[$link['percent']][] = $link;
                    } else {
                        $links_structure[$link['percent']] = array();
                        $links_structure[$link['percent']][] = $link;
                        $links_structure[$link['percent']]['text'] =
                        $this->getPriceTextPresentationSeveral($page['one_price_total'], $link['percent'], $page['currency_code']);
                    }
                }
                krsort($links_structure);
                $data['links_structure'] = $links_structure;
                break;
        }

        $data['pay2pay_check'] = $page['pay2pay_check'];
        $data['robokassa_check'] = $page['robokassa_check'];
        $data['interkassa_check'] = $page['interkassa_check'];
        $data['alter_payment_check'] = $page['alter_payment_check'];

        $data['alter_payment_text'] = $page['alter_payment_text'];

        $data['currency_code'] = $page['currency_code'];
        $data['currency_code_check'] = $page['currency_code_check'];
        $data['receiver_of_product'] = $page['receiver_of_product'];
        $data['delivery_address'] = $page['delivery_address'];
        $data['delivery_method'] = $page['delivery_method'];

        $data['notes'] = $page['notes'];
        $data['notes_up_position'] = $page['notes_up_position'];

        $data['button_continue'] = $this->language->get('button_continue');

        $data['description_order'] = $page['description_order'];
        $data['variable_value'] = $page['variable_value'];

        $data['continue'] = $this->url->link('common/home');

        $data['footer_small_label'] = $this->language->get('footer_small_label');
        $data['footer_label'] = $this->language->get('footer_label');
        $data['email_support'] = $this->config->get('config_email');
	    return $data;
    }


    private function getPriceTextPresentationSeveral($price_total, $percent, $currency_code)
    {
        $price=$this->currency->format(($price_total * $percent) / 100, $currency_code, 1);
        $several_percent_variable=$this->language->get('several_percent_variable');
        return sprintf($several_percent_variable, $percent, $price);
    }


	/**
	 * Record variable for Footer
	 * @return array
	 */
    private function pageIsDataFooter()
    {
	    $data['column_left'] = $this->load->controller('common/column_left');
	    $data['column_right'] = $this->load->controller('common/column_right');
	    $data['content_top'] = $this->load->controller('common/content_top');
	    $data['content_bottom'] = $this->load->controller('common/content_bottom');
	    $data['footer'] = $this->load->controller('common/footer');
	    $data['header'] = $this->load->controller('common/header');
	    return $data;
    }


    /**
     * View page non Found
     *
     * @param $page_id
     */
    private function viewErrorNonFound($page_id)
    {

        $data1=$this->pageErrorNonFoundIsDataHeader($page_id);
        $data2=$this->pageErrorNonFoundIsDataBody();
        $data3=$this->pageErrorNonFoundIsDataFooter();
        $dataGl=array_merge($data1, $data2, $data3);

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found', $dataGl));
        } else {
            $this->response->setOutput($this->load->view('default/template/error/not_found', $dataGl));
        }
    }


    /**
     * Record variable for Header Non Found
     *
     * @param int $page_id
     */
    private function pageErrorNonFoundIsDataHeader($page_id)
    {
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_error'),
            'href' => $this->url->link('page_order_bobs', 'page_order_bobs_id=' . $page_id),
            'separator' => $this->language->get('text_separator')
        );

        $this->document->setTitle($this->language->get('text_error'));

        $data['heading_title'] = $this->language->get('text_error');

        return $data;
    }


    /**
     * Record variable for Body  Non Found
     */
    private function pageErrorNonFoundIsDataBody()
    {
        $data['text_error'] = $this->language->get('text_error');
        $data['button_continue'] = $this->language->get('button_continue');
        $data['continue'] = $this->url->link('common/home');

        return $data;
    }


    /**
     * Record variable for Footer Non Found
     */
    private function pageErrorNonFoundIsDataFooter()
    {
        return $this->pageIsDataFooter();
    }


}


?>