<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<div class="page-header">
    <div class="container-fluid">
        <div class="pull-right">
            <?php if($page_form){ ?>
            <button class="btn btn-primary" id="get_save_button" data-toggle="tooltip" title="<?php echo $button_save; ?>">
                <i class="fa fa-save"></i>
            </button>
            <?php }  ?>
            <a class="btn btn-default" href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>">
                <i class="fa fa-reply"></i>
            </a>
        </div>
        <h1><?php echo $heading_title; ?></h1>
        <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
    </div>
</div>
<div class="container-fluid">
<?php if(isset($errors_warning)) { ?>
	<?php foreach($errors_warning as $error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
	<?php } ?>
<?php } ?>
<?php if(isset($success)) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if(isset($attentions)) { ?>
<div class="alert alert-attentions"><i class="fa fa-exclamation-circle"></i> <?php echo $attentions; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title_sub; ?></h3>
    </div>
    <div class="panel-body">

        <form action="<?php echo $action ?>" method="post" accept-charset="utf-8" id="form_link">
            <input id="terminal_id" type="hidden" name="terminal_id" value="0">
            <input type="hidden" name="page_host" id="page_host" value="<?php echo $page_host; ?>">
            <input type="hidden" name="one_price_total" id="one_price_total" value="<?php echo $one_price_total; ?>">


            <div class="form-group row">
                    <label class="col-sm-2 control-label"><?php echo $get_order_id_label; ?></label>

                    <div class="col-sm-6">
                        <input type="text" name="get_order_id" value="<?php echo $get_order_id; ?>" id="get_order_id" class="form-control"/>
                    </div>
                    <div class="col-sm-4">
                        <?php if($page_form) { ?>
                        <button type="button" id="get_order_id_button" class="btn btn-primary"><?php echo $get_order_id_button_label;?></button>
                        <?php } else { ?>
                        <button type="button" id="get_order_id_link_button" class="btn btn-primary"><?php echo $get_order_id_button_label;?></button>
                        <?php } ?>
                    </div>
            </div>

            <?php if(!$page_form) { ?>

            <div class="form-group row"">
                <label class="col-sm-2 control-label"><?php echo $link_pay2pay_label; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="link_pay2pay" value="<?php echo $link_pay2pay; ?>" id="link_pay2pay" class="form-control"/>
                </div>
            </div>

            <div class="form-group row"">
                <label class="col-sm-2 control-label"><?php echo $link_interkassa_label; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="link_robokassa" value="<?php echo $link_robokassa; ?>" id="link_robokassa" class="form-control"/>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $link_interkassa_label; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="link_interkassa" value="<?php echo $link_interkassa; ?>" id="link_interkassa" class="form-control"/>
                </div>
            </div>
            <button type="button" id="get_link_button" class="btn btn-primary"><?php echo $button_get_link_label;?></button>
            <?php } ?>

            <div class="form-group row required">
                    <label class="col-sm-2 control-label"><?php echo $order_id_label; ?></label>

                    <div class="col-sm-10">
                        <input type="text" name="order_id" value="<?php echo $order_id; ?>" id="order_id" class="form-control"/>
                    </div>
            </div>

            <?php if($page_form){ ?>

            <div class="form-group row required">
                <label class="col-sm-2 control-label"><?php echo $name_page_label; ?></label>

                <div class="col-sm-6">
                    <input type="text" id="name_page0" class="form-control" name="name_page" value="<?php echo $name_page; ?>" disabled/>
                    <input type="hidden" id="name_page1" class="form-control" name="name_page" value="<?php echo $name_page; ?>"/>
                </div>
                <div class="col-sm-4">
                    <button type="button" id="name_page_button" class="btn btn-primary"><?php echo $change_name_page_label;?></button>
                </div>
            </div>

            <div class="form-group row required">
                <label class="col-sm-2 control-label"><?php echo $page_host_label; ?></label>
                <div class="col-sm-10">
                    <p id="path_page_text_full"></p>
                </div>
            </div>

            <div class="form-group row required">
                <label class="col-sm-2 control-label"><?php echo $order_site_id_label; ?></label>

                <div class="col-sm-5">
                    <input type="text" name="order_site_id" value="<?php echo $order_site_id; ?>" id="order_site_id" class="form-control"/>
                </div>
                <div class="col-sm-5">
                    <input type="checkbox" name="order_site_check" id="order_site_check" <?php if($order_site_check) { ?> checked <?php }?>>
                    <?php echo $order_site_check_label; ?>
                </div>
            </div>

            <?php } ?>

            <div class="form-group row required">
                <label class="col-sm-2 control-label"><?php echo $currency_code_label; ?></label>
                <?php if($page_form){ ?>
                <div class="col-sm-5">
                    <input type="text" name="currency_code" value="<?php echo $currency_code; ?>" class="form-control"/>
                </div>
                <div class="col-sm-5">
                    <input type="checkbox" name="currency_code_check" id="currency_code_check" <?php if($currency_code_check) { ?> checked <?php }?>>
                    <?php echo $currency_code_check_label; ?>
                </div>
                <?php } else { ?>
                <div class="col-sm-10">
                    <input type="text" name="currency_code" value="<?php echo $currency_code; ?>" class="form-control"/>
                </div>
                <?php } ?>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $type_of_presentation_label; ?></label>

                <div class="col-sm-10">
                    <input type="radio" name="type_of_presentation" value="0"
                    <?php if($type_of_presentation==0) { ?> checked="checked <?php } ?>" />
                    <?php echo $one_visible_label; ?>
                    <input type="radio" name="type_of_presentation" value="1"
                    <?php if($type_of_presentation==1) { ?> checked="checked <?php } ?>" />
                    <?php echo $several_radio_visible_label; ?>
                    <input type="radio" name="type_of_presentation" value="2"
                    <?php if($type_of_presentation==2) { ?> checked="checked <?php } ?>" />
                    <?php echo $several_link_visible_label; ?>
                </div>
            </div>

            <div class="form-group row required">
                <label class="col-sm-2 control-label" id="price_label"><?php echo $price_label; ?></label>

                <div class="col-sm-5">
                    <input type="text" name="price" value="<?php echo $price; ?>" class="form-control"/>
                </div>
                <div class="col-sm-5">
                    <select name="one_percent" id="one_percent_select" class="form-control">
                        <?php for ($i = 10; $i <= 100; $i+=10) { ?>
                        <option value="<?php echo $i ?>"
                        <?php if($one_percent==$i) { ?>
                        selected="selected" <?php } ?> ><?php echo $i ?>%</option>
                        <?php } ?>
                    </select>
                            <span id="one_percent_text">
                                <?php if(isset($one_price_total_text)) { echo $one_price_total_text; } ?>
                            </span>
                </div>
            </div>

            <?php if($page_form){ ?>
            <div class="form-group row" id="several_percent">
                <label class="col-sm-2 control-label" id="price_label"><?php echo $option_client_percent_label; ?></label>

                <div class="col-sm-10">
                    <div id="option_client_percent_block row">
                        <?php for ($i = 10; $i <= 100; $i+=10) { ?>
                        <div class="row" style="padding: 5px;">
                                    <span>
                                        <?php echo $option_client_percent_default_label; ?>
                                    </span>
                                <input type="radio" name="several_percent_default" value="<?php echo $i ?>" class="form-control" style="display: inline-block;" <?php if($several_percent_default==$i){ ?> checked="checked" <?php } ?> />
                                <input type="checkbox" name="several_percent[]" value="<?php echo $i ?>" class="form-control" style="margin-left: 10px; display: inline-block;"
                                <?php if($several_percent!=null) {
                                        if(array_search($i,$several_percent)!==false) { ?> checked="checked"<?php } } ?>>
                                <span><?php echo $i ?>%</span>
                        </div>




                        <?php } ?>
                    </div>
                </div>
            </div>
            <?php } ?>

            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $receiver_of_product_label; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="receiver_of_product" value="<?php echo $receiver_of_product; ?>" class="form-control"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $description_order_label; ?></label>

                <div class="col-sm-10">
                    <textarea type="text"
                              id="description_order"
                              name="description_order"
                              class="form-control"
                              style="margin: 0px; height: 92px;"><?php echo $description_order; ?></textarea>
                </div>
            </div>

            <?php if($page_form) { ?>

            <div class="form-group row">
                <div class="col-sm-2">
                    <input type="text" name="variable_name" value="<?php echo $variable_name; ?>" class="form-control"/>
                </div>
                <div class="col-sm-10">
                    <input type="text" name="variable_value" value="<?php echo $variable_value; ?>" class="form-control"/>
                    <spane style="padding-left: 5px"><?php echo $variable_text; ?></spane>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $delivery_address_label; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="delivery_address" value="<?php echo $delivery_address; ?>" class="form-control"/>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $delivery_method_label; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="delivery_method" value="<?php echo $delivery_method; ?>" class="form-control"/>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 control-label"><?php echo $notes_label; ?></label>
                <div class="col-sm-5" id="notes_box">
                    <textarea type="text"
                              class="form-control"
                              id="notes"
                              name="notes"
                              style="margin: 0px; width: 100%; height: 50px;"><?php echo $notes; ?></textarea>
                    <?php if(isset($notes_client)) { ?>
                    <p><ins><?php echo $notes_client;?></ins></p>
                    <?php } ?>
                </div>
                <div class="col-sm-5">
                    <?php if ($notes_up_position) { ?>
                    <input type="radio" name="notes_up_position" value="1" checked="checked" />
                    <?php echo $text_notes_up; ?><br><br>
                    <input type="radio" name="notes_up_position" value="0" />
                    <?php echo $text_notes_down; ?>
                    <?php } else { ?>
                    <input type="radio" name="notes_up_position" value="1" />
                    <?php echo $text_notes_up; ?><br><br>
                    <input type="radio" name="notes_up_position" value="0"  checked="checked"/>
                    <?php echo $text_notes_down; ?>
                    <?php } ?>
                </div>
            </div>

            <?php } ?>


            <div class="form-group col-sm-12 row">
                <input type="checkbox" name="pay2pay_check" id="pay2pay_check" <?php if($pay2pay_check) { ?>checked <?php }?>>
                <?php echo $name_payment_pay2pay_label; ?>
            </div>
            <div class="pay2pay">
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $identifier_shop_pay2pay_label; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="pay2pay_identifier_shop" value="<?php echo $pay2pay_identifier_shop; ?>" class="form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $key_secret_pay2pay_label; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="pay2pay_key_secret" value="<?php echo $pay2pay_key_secret; ?>" class="form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $test_mode_pay2pay_label; ?></label>
                    <div class="col-sm-10">
                        <?php if ($pay2pay_test_mode) { ?>
                        <input type="radio" name="pay2pay_test_mode" value="1" checked="checked" /><?php echo $text_yes; ?>
                        <input type="radio" name="pay2pay_test_mode" value="0" /><?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="pay2pay_test_mode" value="1" /><?php echo $text_yes; ?>
                        <input type="radio" name="pay2pay_test_mode" value="0"  checked="checked"/><?php echo $text_no; ?>
                        <?php } ?>
                    </div>
                </div>
            </div>


            <div class="form-group col-sm-12 row">
                <input type="checkbox" name="robokassa_check" id="robokassa_check" <?php if($robokassa_check) { ?>checked <?php }?>>
                <?php echo $name_payment_robokassa_label; ?>
            </div>
            <div class="robokassa">
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $identifier_shop_robokassa_label; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="robokassa_identifier_shop" value="<?php echo $robokassa_identifier_shop; ?>" class="form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $key_secret_robokassa_label; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="robokassa_key_secret" value="<?php echo $robokassa_key_secret; ?>" class="form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $test_mode_robokassa_label; ?></label>
                    <div class="col-sm-10">
                        <?php if ($robokassa_test_mode) { ?>
                        <input type="radio" name="robokassa_test_mode" value="1" checked="checked" /><?php echo $text_yes; ?>
                        <input type="radio" name="robokassa_test_mode" value="0" /><?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="robokassa_test_mode" value="1" /><?php echo $text_yes; ?>
                        <input type="radio" name="robokassa_test_mode" value="0"  checked="checked"/><?php echo $text_no; ?>
                        <?php } ?>
                    </div>
                </div>
            </div>


            <div class="form-group col-sm-12 row">
                <input type="checkbox" name="interkassa_check" id="interkassa_check" <?php if($interkassa_check) { ?>checked <?php }?>>
                <?php echo $name_payment_interkassa_label; ?>
            </div>
            <div class="interkassa">
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $identifier_shop_interkassa_label; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="interkassa_identifier_shop" value="<?php echo $interkassa_identifier_shop; ?>" class="form-control"/>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-sm-2 control-label"><?php echo $test_mode_interkassa_label; ?></label>
                    <div class="col-sm-10">
                        <?php if ($interkassa_test_mode) { ?>
                        <input type="radio" name="interkassa_test_mode" value="1" checked="checked" /><?php echo $text_yes; ?>
                        <input type="radio" name="interkassa_test_mode" value="0" /><?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="interkassa_test_mode" value="1" /><?php echo $text_yes; ?>
                        <input type="radio" name="interkassa_test_mode" value="0"  checked="checked"/><?php echo $text_no; ?>
                        <?php } ?>
                    </div>
                </div>
            </div>

            <?php if($page_form) { ?>
                <div class="form-group col-sm-12 row">
                    <input type="checkbox" name="alter_payment_check" id="alter_payment_check" <?php if($alter_payment_check) { ?>checked <?php }?>>
                    <?php echo $alter_payment_label; ?>
                </div>
                <div class="alter_payment">
                    <div class="row form-group">
                        <label class="col-sm-2 control-label"><?php echo $alter_payment_text_label; ?></label>
                        <div class="col-sm-10">
                            <textarea
                                    type="text"
                                    name="alter_payment_text"
                                    class="form-control"
                                    style="margin: 0px; width: 450px; height: 50px;"><?php echo $alter_payment_text; ?></textarea>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </form>
    </div>
</div>
</div>
</div>
<?php echo $footer; ?>

<script type="text/javascript">

var page_form = '<?php echo $page_form; ?>';
var pay2pay_check = '<?php echo $pay2pay_check; ?>';
var robokassa_check ='<?php echo $robokassa_check;?>';
var interkassa_check ='<?php echo $interkassa_check;?>';
var alter_payment_check ='<?php echo $alter_payment_check;?>';
var name_page_seo ='<?php echo $name_page_seo ?>';
var price_new_label='<?php echo $price_new_label ?>';
var price_label='<?php echo $price_label ?>';
var one_price_total='<?php echo $one_price_total; ?>';
var one_percent='<?php  $e=($one_percent!=null) ? 1 : 0; echo $e; ?>';
var old_price;

function postPercentOne(json){
    // Get data, sent by the server, and display
    $('#description_order').val(json.description_order);
    if($('#one_percent_select option:selected').text()=='100%') {
        $('#price_label').text(price_label);
        $('[name="price"]').val(one_price_total);
        $('#one_percent_text').text(json.one_price_total_text);
    }else
    {
        $('#price_label').text(price_new_label);
        $('[name="price"]').val(json.price);
        $('#one_percent_text').text(json.one_price_total_text);
    }
}

function visibleTypeOfPresentation() {
    switch($('[name = "type_of_presentation"]:checked').val()) {
        case '0':
            $('#one_percent_text, [name = "one_percent"]').fadeIn();
            $('#several_percent').fadeOut();
            $.ajax({
                url: "<?php echo $post_link; ?>",
                dataType: 'json',
                data: 'price=' + one_price_total + '&one_percent=' +
                $('#one_percent_select option:selected').text() +
                '&description_order=' + $('#description_order').val() +
				'&currency_code=' + $('[name = "currency_code"]').val(),
                type:'post',
                success: postPercentOne
            });
            break;
        case '1':
        case '2':
            $('#several_percent').fadeIn();
            $('#one_percent_text, [name = "one_percent"]').fadeOut();
            $.ajax({
                url: "<?php echo $post_link; ?>",
                dataType: 'json',
                data: 'price=' + one_price_total + '&one_percent=' +
                '100%' +
                '&description_order=' + $('#description_order').val() +
				'&currency_code=' + $('[name = "currency_code"]').val(),
                type:'post',
                success: postPercentOne
            });

            break;
    }
}

$(document).ready(function () {

    $('#path_page_text_full').text($('#page_host').val() + $('[name = "name_page"]:first').val());
    if(!page_form || page_form==0) {
        $('[name="type_of_presentation"]').prop('disabled', true);
    }

    visibleTypeOfPresentation();

    if (!pay2pay_check || pay2pay_check==0) {
        $(".pay2pay").fadeOut(1000);
    }
    if (!robokassa_check || robokassa_check==0) {
        $(".robokassa").fadeOut(1000);
    }
    if (!interkassa_check || interkassa_check==0) {
        $(".interkassa").fadeOut(1000);
    }
    if (!alter_payment_check || alter_payment_check==0) {
        $(".alter_payment").fadeOut(1000);
    }

    $('#pay2pay_check').change(function () {
        $(".pay2pay").fadeToggle();
    });
    $('#robokassa_check').change(function () {
        $(".robokassa").fadeToggle();
    });
    $('#interkassa_check').change(function () {
        $(".interkassa").fadeToggle();
    });
    $('#alter_payment_check').change(function () {
        $(".alter_payment").fadeToggle();
    });


    $('[name = "order_id"]').keyup(function (eventObject) {
        var textSeo=name_page_seo.replace('%s',$('[name = "order_id"]:first').val());
        $('[name = "name_page"]').val(textSeo);
        $('#path_page_text_full').text($('#page_host').val() + textSeo);
    });
    $('[name = "name_page"]').keyup(function (eventObject) {
        $('#path_page_text_full').text($('#page_host').val() + $('[name = "name_page"]:first').val());
    });

    //Validation
    $('#get_order_id').keypress(function(key) {
        if(key.charCode < 48 || key.charCode > 57) {
            return false;
        }
    });
    $('[name = "order_id"]').keypress(function(key) {
        if(key.charCode < 48 || key.charCode > 57) {
            return false;
        }
    });
    $('[name = "order_site_id"]').keypress(function(key) {
        if(key.charCode < 48 || key.charCode > 57) {
            return false;
        }
    });

    $('[name = "price"]').keypress(function(key) {
        if( key.charCode!=46 && (key.charCode < 48 || key.charCode > 57)) {
            return false;
        }
    });

    $('[name = "price"]').blur(function() {
        if($('[name = "price"]').val()!=old_price && $('#one_percent_select option:selected').text()!='100%')
        {
            alert('<?php echo $price_modif_alert ?>');
            $('[name = "price"]').val(old_price);
        } else {
            if($('[name = "price"]').val()!=old_price)
            {
                $.ajax({
                    url: "<?php echo $post_link; ?>",
                    dataType: 'json',
                    data: 'price=' + $('[name = "price"]').val() + '&one_percent=' + $('#one_percent_select ' +
					'option:selected').text() + '&description_order=' + $('#description_order').val() +
					'&currency_code=' + $('[name = "currency_code"]').val(),
                    type:'post',
                    success: function(json){
                        // Здесь мы получаем данные, отправленные сервером и выводим их на экран.
                        $('#description_order').val(json.description_order);
                        $('#price_label').text(price_label);
                        $('[name="price"]').val(json.price);
                        $('#one_percent_text').text(json.one_price_total_text);
                        one_price_total=json.price;
                        $('#one_price_total').val(json.price);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert('error');
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }

        }
    });
    $('[name = "price"]').focus(function() {
        old_price=$('[name = "price"]').val();
    });
    //Validation end


    $('#one_percent_select').change(function() {
        $.ajax({
            url: "<?php echo $post_link; ?>",
            dataType: 'json',
            data: 'price=' + one_price_total + '&one_percent=' +
            $('#one_percent_select option:selected').text() +
            '&description_order=' + $('#description_order').val() +
			'&currency_code=' + $('[name = "currency_code"]').val(),
            type:'post',
            success: postPercentOne,
            error: function(xhr, ajaxOptions, thrownError) {
                alert('error1');
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#name_page_button').click(function () {
        $('#name_page0').prop('disabled',false);
        $('#name_page1').remove();
    });


    /*( terminal_id )
     0 - save page,
     1 - to make the data from the number order,
     2 - create link,
     3 - to make the data from the number order (form link) */
    $('#get_save_button').click(function()
            {
                $('#terminal_id').val(0);
                $('#form_link').submit();
            }
    );
    $('#get_order_id_button').click(function()
            {
                $('#terminal_id').val(1);
                $('#form_link').submit();
            }
    );
    $('#get_link_button').click(function()
            {
                $('#terminal_id').val(2);
                $('#form_link').submit();
            }
    );
    $('#get_order_id_link_button').click(function()
            {
                $('#terminal_id').val(3);
                $('#form_link').submit();
            }
    );
    $('[name = "type_of_presentation"]').click(visibleTypeOfPresentation);
});

</script>

