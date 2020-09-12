<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-popuptemplate" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-popuptemplate" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><i class="fa fa-file-o"  aria-hidden="true"></i> <?php echo $tab_general; ?></a></li>
            <li><a href="#tab-setting" data-toggle="tab"><i class="fa fa-cogs" aria-hidden="true"></i> <?php echo $tab_setting; ?></a></li>
            <li><a href="#tab-product" data-toggle="tab"><i class="fa fa-share-alt" aria-hidden="true"></i> <?php echo $tab_product; ?></a></li>
            <li><a href="#tab-coupon" data-toggle="tab"><i class="fa fa-gift" aria-hidden="true"></i> <?php echo $tab_coupon; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
                <li>
                  <a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab">
                    <?php if(VERSION >= '2.2.0.0') { ?>
                    <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> 
                    <?php } else{ ?>
                    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                    <?php } ?>
                    <?php echo $language['name']; ?>
                   </a>
                 </li>
                <?php } ?>
              </ul>
              <div class="tab-content col-sm-9">
                <?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-title"><span data-toggle="tooltip" title="<?php echo $help_title; ?>"><?php echo $entry_title; ?></span></label>
                    <div class="col-sm-10">
                      <input type="text" name="popuptemplate_description[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($popuptemplate_description[$language['language_id']]) ? $popuptemplate_description[$language['language_id']]['title'] : ''; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
                      <?php if (isset($error_title[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_title[$language['language_id']]; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-description"><span data-toggle="tooltip" title="<?php echo $help_description; ?>"><?php echo $entry_description; ?></span></label>
                    <div class="col-sm-10">
                      <textarea name="popuptemplate_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control summernote"><?php echo isset($popuptemplate_description[$language['language_id']]) ? $popuptemplate_description[$language['language_id']]['description'] : ''; ?></textarea>
                      <?php if (isset($error_description[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_description[$language['language_id']]; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
                <?php } ?>
              </div>
              <div class="col-sm-3">
                <br/>
                <table class="table table-bordered">
                  <thead>
                    <tr><td><?php echo $text_short_name; ?></td><td><?php echo $text_short_codes; ?></td>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><?php echo $text_pc_logo; ?></td><td>{LOGO}</td>
                    </tr>
                    <tr>
                      <td><?php echo $text_pc_store; ?></td><td>{STORE_NAME}</td>
                    </tr>
                  </tbody>
                  <thead>
                    <tr> 
                      <td colspan="2"><?php echo $text_pc_productsinfo; ?></td> 
                    </tr>
                  </thead>  
                  <tbody>
                    <tr>  
                      <td><?php echo $text_pc_products; ?></td><td>{PRODUCTS}</td>
                    </tr>
                  </tbody>  
                  <thead>
                    <tr> 
                      <td colspan="2"><?php echo $text_pc_coupneinfo; ?></td> 
                    </tr>
                  </thead>  
                  <tbody>    
                    <tr>  
                      <td><?php echo $text_pc_coupon; ?></td><td>{COUPON_CODE}</td>
                    </tr>
                    <tr>  
                      <td><?php echo $text_pc_coupon_discount; ?></td><td>{DISCOUNT}</td>
                    </tr>  
                    <tr>
                      <td><?php echo $text_pc_total_amount; ?></td><td>{TOTAL}</td>
                    </tr> 
                    <tr> 
                      <td><?php echo $text_pc_coupon_enddate; ?></td><td>{DATE_END}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <div class="tab-pane" id="tab-setting">
              <div class="form-group hide">
                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_show_title; ?>"><?php echo $entry_show_title; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($show_title) { ?>
                    <input type="radio" name="show_title" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="show_title" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$show_title) { ?>
                    <input type="radio" name="show_title" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="show_title" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_show_closebutton; ?>"><?php echo $entry_show_closebutton; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($show_closebutton) { ?>
                    <input type="radio" name="show_closebutton" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="show_closebutton" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$show_closebutton) { ?>
                    <input type="radio" name="show_closebutton" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                      <input type="radio" name="show_closebutton" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_show_account; ?>"><?php echo $entry_show_account; ?></span></label>
                <div class="col-sm-10">
                  <div class="checkbox-inline">
                    <label>
                      <input type="checkbox" name="show_account[]" value="register" <?php echo (in_array('register', $show_account)) ? 'checked="checked"' : ''; ?> />
                      <?php echo $text_register; ?>
                    </label>
                  </div>
                  <div class="checkbox-inline">
                    <label>
                      <input type="checkbox" name="show_account[]" value="guest" <?php echo (in_array('guest', $show_account)) ? 'checked="checked"' : ''; ?> />
                      <?php echo $text_guest; ?>
                    </label>
                  </div>
                  <?php if($error_show_account) { ?>
                  <div class="text-danger"><?php echo $error_show_account; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_show_version; ?>"><?php echo $entry_show_version; ?></span></label>
                <div class="col-sm-10">
                  <div class="checkbox-inline">
                    <label>
                      <input type="checkbox" name="show_version[]" value="desktop" <?php echo (in_array('desktop', $show_version)) ? 'checked="checked"' : ''; ?> />
                      <?php echo $text_desktop; ?>
                    </label>
                  </div>
                  <div class="checkbox-inline">
                    <label>
                      <input type="checkbox" name="show_version[]" value="mobile" <?php echo (in_array('mobile', $show_version)) ? 'checked="checked"' : ''; ?> />
                      <?php echo $text_mobile; ?>
                    </label>
                  </div>
                  <?php if($error_show_version) { ?>
                  <div class="text-danger"><?php echo $error_show_version; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_popup_reopen; ?>"><?php echo $entry_popup_reopen; ?></span></label>
                <div class="col-sm-3">
                  <label class="radio-inline">
                    <?php if ($popup_reopen) { ?>
                    <input type="radio" name="popup_reopen" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="popup_reopen" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$popup_reopen) { ?>
                    <input type="radio" name="popup_reopen" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="popup_reopen" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group required minutes-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minutes ?>"><?php echo $entry_minutes; ?></span></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <input type="text" name="popup_minutes" class="form-control" value="<?php echo $popup_minutes; ?>" />
                    <span class="input-group-addon"><?php echo $text_minutes; ?></span>
                  </div>
                  <?php if($error_popup_minutes) { ?>
                  <div class="text-danger"><?php echo $error_popup_minutes; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-logo"><span data-toggle="tooltip" title="<?php echo $help_logo; ?>"><?php echo $entry_logo; ?></span></label>
                <div class="col-sm-10"><a href="" id="thumb-logo" data-toggle="image" class="img-thumbnail"><img src="<?php echo $logo_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="logo" value="<?php echo $logo; ?>" id="input-logo" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image"><span data-toggle="tooltip" title="<?php echo $help_background_image; ?>"><?php echo $entry_background_image; ?></span></label>
                <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $background_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="background_image" value="<?php echo $background_image; ?>" id="input-image" />
                </div>
              </div>              
              <div class="form-group required">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_layout; ?>"><?php echo $entry_layout; ?></span></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($layouts as $layout) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($layout['layout_id'], $setting_layout)) { ?>
                        <input type="checkbox" name="setting_layout[]" value="<?php echo $layout['layout_id']; ?>" checked="checked" />
                        <?php echo $layout['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="setting_layout[]" value="<?php echo $layout['layout_id']; ?>" />
                        <?php echo $layout['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                  <?php if($error_setting_layout) { ?>
                  <div class="text-danger"><?php echo $error_setting_layout; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-settingproduct"><span data-toggle="tooltip" title="<?php echo $help_settingproduct; ?>"><?php echo $entry_settingproduct; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="setting_product_name" value="" placeholder="<?php echo $entry_settingproduct; ?>" id="input-settingproduct" class="form-control" />
                  <div id="popuptemplate-settingproduct" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($setting_products as $setting_product) { ?>
                    <div id="popuptemplate-settingproduct<?php echo $setting_product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $setting_product['name']; ?>
                      <input type="hidden" name="setting_product[]" value="<?php echo $setting_product['product_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>   
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_margin_top; ?>"><?php echo $entry_margin_top; ?></span></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <input type="text" name="margin_top" class="form-control" value="<?php echo $margin_top; ?>" />
                    <span class="input-group-addon">%</span>
                  </div>
                </div>
              </div>           
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-css"><span data-toggle="tooltip" title="<?php echo $help_css; ?>"><?php echo $entry_css; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="css" value="" rows="10" placeholder="<?php echo $entry_css; ?>" id="input-css" class="form-control"><?php echo $css; ?></textarea>
                </div>
              </div> 
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <div class="checkbox">
                      <label>
                        <?php if (in_array(0, $popuptemplate_store)) { ?>
                        <input type="checkbox" name="popuptemplate_store[]" value="0" checked="checked" />
                        <?php echo $text_default; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="popuptemplate_store[]" value="0" />
                        <?php echo $text_default; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php foreach ($stores as $store) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($store['store_id'], $popuptemplate_store)) { ?>
                        <input type="checkbox" name="popuptemplate_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                        <?php echo $store['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="popuptemplate_store[]" value="<?php echo $store['store_id']; ?>" />
                        <?php echo $store['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><span data-toggle="tooltip" title="<?php echo $help_status; ?>"><?php echo $entry_status; ?></span></label>
                <div class="col-sm-10">
                  <select name="status" id="input-status" class="form-control">
                    <?php if ($status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-product">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-product"><span data-toggle="tooltip" title="<?php echo $help_product; ?>"><?php echo $entry_product; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="product_name" value="" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />
                  <div id="popuptemplate-product" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($products as $product) { ?>
                    <div id="popuptemplate-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                      <input type="hidden" name="product[]" value="<?php echo $product['product_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_show_caption; ?>"><?php echo $entry_show_caption; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($show_caption) { ?>
                    <input type="radio" name="show_caption" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="show_caption" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$show_caption) { ?>
                    <input type="radio" name="show_caption" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="show_caption" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-coupon">
              <div class='form-group"'>
                <label class="col-sm-2 control-label" for="input-coupon"><span data-toggle="tooltip" title="<?php echo $help_coupon; ?>"><?php echo $entry_coupon; ?></span></label>
                <div class="col-sm-10">
                  <select name="coupon_id" class="form-control"> 
                    <option value=""><?php echo $text_select; ?></option>
                    <?php foreach($coupons as $coupon) { ?>
                    <?php if($coupon['coupon_id'] == $coupon_id) { ?>
                    <option value="<?php echo $coupon['coupon_id']; ?>" selected="selected"><?php echo $coupon['name']; ?></option>
                    <?php } else{ ?>
                    <option value="<?php echo $coupon['coupon_id']; ?>"><?php echo $coupon['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>  
<script type="text/javascript"><!--
$('#language a:first').tab('show');
<?php if(VERSION <= '2.2.0.0') { ?>
<?php foreach ($languages as $language) { ?>
$('#input-description<?php echo $language['language_id']; ?>').summernote({
  height: 300
});
<?php } ?>
<?php } ?>
//--></script>
<script type="text/javascript"><!--
$('input[name=\'product_name\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['product_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'product_name\']').val('');
    
    $('#popuptemplate-product' + item['value']).remove();
    
    $('#popuptemplate-product').append('<div id="popuptemplate-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');  
  }
});
  
$('#popuptemplate-product').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('input[name=\'setting_product_name\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['product_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'setting_product_name\']').val('');
    
    $('#popuptemplate-settingproduct' + item['value']).remove();
    
    $('#popuptemplate-settingproduct').append('<div id="popuptemplate-settingproduct' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="setting_product[]" value="' + item['value'] + '" /></div>');  
  }
});
  
$('#popuptemplate-settingproduct').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('input[name=\'popup_reopen\']').click(function() {
  if($('input[name=\'popup_reopen\']:checked').val() == 1) {
    $('.minutes-group').show('slow');
  }else{
    $('.minutes-group').hide('slow');
  }
});
$('input[name=\'popup_reopen\']:checked').trigger('click');
//--></script>
</div>
<?php echo $footer; ?>