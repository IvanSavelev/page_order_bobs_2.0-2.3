<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <div class="row">
        <?php echo $column_left; ?>

        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>

        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

        <input type="hidden" name="order_id" value="<?php echo $order_id; ?>">


        <div class="row">
        <div class="col-sm-12 pos-9">
        <h1><?php echo $heading_title; ?></h1>
        <br/>

        <!-- BEGIN ORDER -->
        <?php if(isset($order)) { ?>
<div class="table-responsive">
        <table class="table table-bordered">
            <colgroup>
                <col class="image">
                <col class="name">
                <col class="model">
                <col class="quantity">
                <col class="price">
                <col class="total">
            </colgroup>
            <thead>
            <tr>
                <th class="text-center"><?php echo $column_image; ?></th>
                <th class="text-left"><?php echo $column_name; ?></th>
                <th class="text-left"><?php echo $column_model; ?></th>
                <th class="text-left"><?php echo $column_quantity; ?></th>
                <th class="text-right"><?php echo $column_price; ?></th>
                <th class="text-right"><?php echo $column_total; ?></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($products as $product) { ?>
            <?php if (!empty($product['recurring'])) { ?>
            <tr>
                <td class="simplecheckout-recurring-product" style="border:none;"><img
                            src="<?php echo $additional_path ?>catalog/view/theme/default/image/reorder.png"
                            alt="" title="" style="float:left;"/>
                                <span style="float:left;line-height:18px; margin-left:10px;">
                                <strong><?php echo $text_recurring_item ?></strong>
                                    <?php echo $product['profile_description'] ?>
                                </span>
                </td>
            </tr>
            <?php } ?>
            <tr>
                <td class="text-center">
                    <?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img
                                                               class="img-thumbnail"
                                                               src="<?php echo $product['thumb']; ?>"
                                                               alt="<?php echo $product['name']; ?>"
                                                               title="<?php echo $product['name']; ?>"/>
                    </a>
                    <?php } ?>
                </td>
                <td class="name">
                    <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                    <div class="options">
                        <?php foreach ($product['option'] as $option) { ?>
                        &nbsp;
                        <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                        <br/>
                        <?php } ?>
                        <?php if (!empty($product['recurring'])) { ?>
                        -
                        <small><?php echo $text_payment_profile ?>
                            : <?php echo $product['profile_name'] ?></small>
                        <?php } ?>
                    </div>
                </td>
                <td class="model"><?php echo $product['model']; ?></td>
                <td class="quantity"><?php echo $product['quantity']; ?></td>
                <td class="text-right"><?php echo $product['price']; ?></td>
                <td class="text-right"><?php echo $product['total']; ?></td>
            </tr>
            <?php } ?>
            <?php if(isset($price_total_mod)) { ?>
            <?php foreach($price_total_mod as $price_mod) { ?>
            <tr>
                <td class="right" colspan="5">
                    <?php echo $price_mod['title']; ?>
                </td>
                <td class="text-right">
                    <?php echo $price_mod['text']; ?>
                </td>
            </tr>
            <?php } ?>
            <?php } ?>
            </tbody>
        </table>
</div>
        <?php } else  { ?>
        <?php if(isset($description_order)) { ?>
        <p id="description"><?php echo $description_order; ?></p>
        <?php } ?>
        <?php } ?>

        <?php if($notes!='' && $notes_up_position) { ?>
        <TABLE>
            <tr>
                <td style="width: 100px;"><? echo $notes_label; ?></td>
                <td><? echo $notes; ?></td>
            </tr>
        </TABLE>
        <?php } ?>

        <!-- END ORDER -->
        <?php switch($type_of_presentation) {
                    case 0: ?>
        <h3><?php echo $list_payment_label; ?></h3>
        <ul>
            <?php if(!empty($alter_payment_check)) { ?>
            <li><?php echo $alter_payment_text; ?></a></li>
            <?php } ?>
            <?php if(!empty($pay2pay_check)) { ?>
            <li><a id="link_pay2pay" target="_blank" href="<?php echo $link_pay2pay; ?>">
                    <?php echo $link_pay2pay_label; ?></a></li>
            <?php } ?>
            <?php if(!empty($robokassa_check)) { ?>
            <li><a id="link_robokassa" target="_blank" href="<?php echo $link_robokassa; ?>">
                    <?php echo $link_robokassa_label; ?></a></li>
            <?php } ?>
            <?php if(!empty($interkassa_check)) { ?>
            <li><a id="link_interkassa" target="_blank" href="<?php echo $link_interkassa; ?>">
                    <?php echo $link_interkassa_label; ?></a></li>
            <?php } ?>
        </ul>
        <?php break;
                    case 1: ?>
        <h3><?php echo $several_percent_label ?></h3>
        <div style="padding-left: 15px;">
            <?php foreach ($several_percent as $percent) { ?>
                                    <span id="several_percent">
                                        <input type="radio"
                                               name="several_percent_radio"
                                               value="<?php echo $percent['percent'] ?>"
                                        <?php if($several_percent_default==$percent['percent']){
                                        ?> checked="checked" <?php } ?> />
                                        <?php echo $percent['percent'] ?>% - <?php echo $percent['price']?>
                                    </span>
            <?php } ?>
        </div>
        </br>
        <h3><?php echo $list_payment_label; ?></h3>
        <ul>
            <?php if(!empty($alter_payment_check)) { ?>
            <li><?php echo $alter_payment_text; ?></a></li>
            <?php } ?>
            <?php if(!empty($pay2pay_check)) { ?>
            <li><a id="link_pay2pay" target="_blank" href="<?php echo $link_pay2pay; ?>">
                    <?php echo $link_pay2pay_label; ?></a></li>
            <?php } ?>
            <?php if(!empty($robokassa_check)) { ?>
            <li><a id="link_robokassa" target="_blank" href="<?php echo $link_robokassa; ?>">
                    <?php echo $link_robokassa_label; ?></a></li>
            <?php } ?>
            <?php if(!empty($interkassa_check)) { ?>
            <li><a id="link_interkassa" target="_blank" href="<?php echo $link_interkassa; ?>">
                    <?php echo $link_interkassa_label; ?></a></li>
            <?php } ?>
        </ul>
        <?php break;
                        case 2: ?>
        <h3><?php echo $list_payment_label; ?></h3>
        <ul>
            <?php if(!empty($alter_payment_check)) { ?>
            <li><?php echo $alter_payment_text; ?></a></li>
        </ul>
        <?php } ?>
        <ul class="link_box_general">
            <?php foreach($links_structure as $key => $links) { ?>
            <li class="link_box">
                <h5><?php echo $links['text'] ?></h5>
                <ul>
                    <?php foreach($links as $link) {
                    if(!is_array($link)) {
                            continue;
                            }
                                            switch($link['type']) {
                                            case 'link_pay2pay': ?>
                    <?php if(!empty($pay2pay_check)) { ?>
                    <li><a id="link_pay2pay<?php echo $link['percent'] ?>"
                           target="_blank"
                           href="<?php echo $link['link']; ?>">
                            <?php echo $link_pay2pay_label; ?></a></li>
                    <?php } ?>
                    <?php break;
                                            case 'link_robokassa': ?>
                    <?php if(!empty($robokassa_check)) { ?>
                    <li><a id="link_robokassa<?php echo $link['percent'] ?>"
                           target="_blank"
                           href="<?php echo $link['link']; ?>">
                            <?php echo $link_robokassa_label; ?></a></li>
                    <?php } ?>
                    <?php break;
                                            case 'link_interkassa': ?>
                    <?php if(!empty($interkassa_check)) { ?>
                    <li><a id="link_interkassa<?php echo $link['percent'] ?>"
                           target="_blank"
                           href="<?php echo $link['link']; ?>">
                            <?php echo $link_interkassa_label; ?></a></li>
                    <?php } ?>
                    <?php break; ?>
                    <?php } ?>
                    <?php } ?>
                </ul>
            </li>
            <?php } ?>
        </ul>
        <?php break;
                        } ?>

        <!-- PARAMETERS PAGE -->
        <div class="col-sm-12">
                <?php if($currency_code_check!=0) { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $currency_code_label; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $currency_code; ?></p>
                    </div>
                </div>
                <?php } ?>

                <?php if(isset($price) || $price!='') { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $price_label; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $price; ?></p>
                    </div>
                </div>
                <?php } ?>

                <?php if($receiver_of_product!='') { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $receiver_of_product_label; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $receiver_of_product; ?></p>
                    </div>
                </div>
                <?php } ?>

                <?php if($variable_value!='') { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $variable_name; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $variable_value; ?></p>
                    </div>
                </div>
                <?php } ?>

                <?php if($delivery_address!='') { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $delivery_address_label; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $delivery_address; ?></p>
                    </div>
                </div>
                <?php } ?>

                <?php if($delivery_method!='') { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $delivery_method_label; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $delivery_method; ?></p>
                    </div>
                </div>
                <?php } ?>

                <?php if($notes!='' && !$notes_up_position) { ?>
                <div class="form-group row">
                    <strong class="col-sm-4 control-label"><?php echo $notes_label; ?></strong>
                    <div class="col-sm-8">
                        <p id="path_page_text_full"><?php echo $notes; ?></p>
                    </div>
                </div
                <?php } ?>

        </div>


       <!-- <p><?php echo $footer_label;?>
            <a href="mailto:<?php echo $email_support; ?>"><?php echo $email_support; ?></a>
        </p>
        <small><?php echo $footer_small_label; ?></small> -->

        </div>
        </div>

            <?php echo $content_bottom; ?>
        </div>

        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript">
    var type_of_presentation = '<?php echo $type_of_presentation; ?>';
    $(document).ready(function () {
        if(type_of_presentation==1) {
            $("<style type='text/css'>.disabled_link{pointer-events: none; cursor:default; color:#999;} </style>").appendTo("head");
            getPercentOption();
            $('[name = "several_percent_radio"]').bind('change',function() {
                getPercentOption();
            });
        }
    });
    function getPercentOption() {
        $.ajax({
            url: 'index.php?route=extension/module/page_order_bobs/post',
            dataType: 'json',
            data: 'percent=' + $("[name = 'several_percent_radio']").filter(':checked').val()+'&order_id='+
            $('[name = "order_id"]').val(),
            type:'post',
            beforeSend: function(){
                $('#link_pay2pay').addClass('disabled_link'); //link_disabled
                $('#link_robokassa').addClass('disabled_link'); //link_disabled
                $('#link_interkassa').addClass('disabled_link'); //link_disabled
            },
            success: function(json){
                // Здесь мы получаем данные, отправленные сервером и выводим их на экран.

                if(json.link_pay2pay!== undefined)
                {
                    $('#link_pay2pay').removeClass('disabled_link').attr("href", json.link_pay2pay);
                }
                if(json.link_robokassa!== undefined)
                {
                    $('#link_robokassa').removeClass('disabled_link').attr("href", json.link_robokassa);
                }
                if(json.link_interkassa!== undefined)
                {
                    $('#link_interkassa').removeClass('disabled_link').attr("href", json.link_interkassa);
                }

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert('error');
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
//--></script>