<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <!-- Header-->
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $link_form; ?>" class="btn btn-primary" data-toggle="tooltip" title="<?php echo $button_link_form_label; ?>"><i class="fa fa-link"></i></a>
                <a href="<?php echo $insert; ?>" class="btn btn-primary" data-toggle="tooltip" title="<?php echo $button_insert_label; ?>"><i class="fa fa-plus"></i></a>
                <a onclick="$('form').submit();" class="btn btn-danger" data-toggle="tooltip" title="<?php echo $button_delete_label; ?>"><i class="fa fa-trash-o"></i></a>
            </div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <!-- /Header-->
    <!-- Content -->
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title_sub; ?></h3>
            </div>
            <div class="panel-body">
                <!-- ListContent -->
                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-article">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <td width="1" lass="text-center"><input type="checkbox"
                                                                                 onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"/>
                                </td>
                                <td class="center" style="width: 50px;"><?php if ($sort == 'opd.page_id') { ?>
                                    <a href="<?php echo $sort_page_id; ?>"
                                       class="<?php echo strtolower($order); ?>"><?php echo $column_page_id_label; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_page_id; ?>"><?php echo $column_page_id_label; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="left"><?php if ($sort == 'opd.order_id') { ?>
                                    <a href="<?php echo $sort_sort_order_id; ?>"
                                       class="<?php echo strtolower($order); ?>"><?php echo $column_order_id_label; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_sort_order_id; ?>"><?php echo $column_order_id_label; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="left"><?php echo $column_link_page_label; ?></td>
                                <td class="right"><?php echo $column_receiver_of_product_label; ?></td>
                                <td class="right"><?php echo $column_price_label; ?></td>
                                <td class="text-right"><?php echo $column_action_label; ?></td>

                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($pages) { ?>
                            <?php foreach ($pages as $page) { ?>
                            <tr>
                                <td style="text-align: center;">
                                    <input type="checkbox" name="selected[]" value="<?php echo $page['page_id']; ?>"/>
                                </td>
                                <td class="center"><?php echo $page['page_id']; ?></td>
                                <td class="left"><?php echo $page['order_id']; ?></td>
                                <td class="left"><a href="<?php echo $page['column_link_page']; ?>" target="_blank">
                                        <?php echo $page['column_link_page']; ?></a>
                                </td>
                                <td class="right"><?php echo $page['receiver_of_product']; ?></td>
                                <td class="right"><?php echo $page['price']; ?></td>
                                <td class="text-right">
                                    <?php foreach ($page['action'] as $action) { ?>
                                    <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?php echo $action['text']; ?>"><i class="fa fa-pencil"></i></a>
                                    <?php } ?>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php } else { ?>
                            <tr>
                                <td class="center" colspan="7"><?php echo $text_no_results_label; ?></td>
                            </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </form>
                <!-- /ListContent -->
                <div class="row">
                    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                </div>
            </div>
        </div>
    </div>
    <!-- /Content -->
<?php echo $footer; ?>