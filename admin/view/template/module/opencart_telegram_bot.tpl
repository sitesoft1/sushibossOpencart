<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-account" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
     <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-account" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-token"><?php echo $entry_token; ?></label>
            <div class="col-sm-10">
              <input type="text" name="module_opencart_telegram_bot_token" id="input-token" class="form-control" value="<?php echo $module_opencart_telegram_bot_token; ?>">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-webhook-key"><?php echo $entry_webhook_key; ?></label>
            <div class="col-sm-10">
              <input type="text" name="module_opencart_telegram_bot_webhook_key" id="input-webhook-key" class="form-control" value="<?php echo $module_opencart_telegram_bot_webhook_key; ?>">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-inquiry-telegram-id"><?php echo $entry_inquiry_telegram_id; ?></label>
            <div class="col-sm-10">
              <input type="text" name="module_opencart_telegram_bot_inquiry_telegram_id" id="input-inquiry-telegram-id" class="form-control" value="<?php echo $module_opencart_telegram_bot_inquiry_telegram_id; ?>">
            </div>
          </div>		  
          <div class="form-group">
            <label class="col-sm-2 control-label" ><?php echo $entry_allowed_shipping_methods; ?></label>
            <div class="col-sm-10">
			<?php foreach($shipping_methods as $shipping_method) { ?>
			<div class="row">
              <div class="col-sm-1">
			   <input type="checkbox" name="module_opencart_telegram_bot_allowed_shipping_methods[]" id="allowed-shipping-methods-<?php echo $shipping_method['code']; ?>" class="form-control" value="<?php echo $shipping_method['code']; ?>" <?php if( $shipping_method['allowed']) { ?>checked<?php } ?>>
			  </div>
			  <div class="col-sm-11"><label class="" for="allowed-shipping-methods-<?php echo $shipping_method['code']; ?>"><?php echo $shipping_method['title']; ?> </label></div>
			</div>
			<?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" ><?php echo $entry_allowed_payment_methods; ?></label>
            <div class="col-sm-10">
			<?php foreach($payment_methods as $payment_method) { ?>
			<div class="row">
              <div class="col-sm-1">
			   <input type="checkbox" name="module_opencart_telegram_bot_allowed_payment_methods[]" id="allowed-payment-methods-<?php echo $payment_method['code']; ?>" class="form-control" value="<?php echo $payment_method['code']; ?>" <?php if( $payment_method['allowed']) { ?>checked<?php } ?>>
			  </div>
			  <div class="col-sm-11"><label class="" for="allowed-payment-methods-<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></div>
			</div>
			<?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-page-limit"><?php echo $entry_page_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="module_opencart_telegram_bot_page_limit" id="input-page-limit" class="form-control" value="<?php echo $module_opencart_telegram_bot_page_limit; ?>">              
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" ><?php echo $entry_show_product_fields; ?></label>
            <div class="col-sm-10">
			<?php foreach($product_fields as $product_field) { ?>
			<div class="row">
              <div class="col-sm-1">
			   <input type="checkbox" name="module_opencart_telegram_bot_show_product_fields[]" id="show-product-fields-<?php echo $product_field['name']; ?>" class="form-control" value="<?php echo $product_field['name']; ?>" <?php if( $product_field['show']) { ?>checked<?php } ?>>
			  </div>
			  <div class="col-sm-11"><label class="" for="show-product-fields-<?php echo $product_field['name']; ?>"><?php echo $product_field['title']; ?></label></div>
			</div>
			<?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" ><?php echo $entry_show_attributes; ?></label>
            <div class="col-sm-10">
			   <input type="checkbox" name="module_opencart_telegram_bot_show_attributes" id="show-attributes" class="form-control" value="1" <?php if($module_opencart_telegram_bot_show_attributes) { ?>checked<?php } ?>>
            </div>
          </div>		  
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="module_opencart_telegram_bot_status" id="input-status" class="form-control">
                <?php if($module_opencart_telegram_bot_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled;?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
		  
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>