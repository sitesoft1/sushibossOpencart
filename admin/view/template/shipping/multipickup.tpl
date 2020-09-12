<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
		<a href="<?php echo $refresh; ?>" data-toggle="tooltip" title="<?php echo $button_refresh; ?>" class="btn btn-info"><i class="fa fa-refresh"></i></a>
        <button type="submit" form="form-multipickup" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-multipickup" class="form-horizontal">         
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="multipickup_status" id="input-status" class="form-control">
                <?php if ($multipickup_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="multipickup_sort_order" value="<?php echo $multipickup_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
            <div class="col-sm-10">
              <select name="multipickup_geo_zone_id" id="input-geo-zone" class="form-control">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $multipickup_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
		  <?php foreach ($languages as $language) { ?>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-bank<?php echo $language['language_id']; ?>"><?php echo $entry_multipickup; ?>:</label>
            <div class="col-sm-10">
              <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
			  <input type="text" name="multipickup_<?php echo $language['language_id']; ?>" value="<?php echo isset(${'multipickup_' . $language['language_id']}) ? ${'multipickup_' . $language['language_id']} : ''; ?>" placeholder="<?php echo $entry_multipickup; ?>" id="input-multipickup-<?php echo $language['language_id']; ?>" class="form-control" />
              </div>
              <?php if (${'error_bank' . $language['language_id']}) { ?>
              <div class="text-danger"><?php echo ${'error_bank' . $language['language_id']}; ?></div>
              <?php } ?>
            </div>
          </div>
          <?php } ?>
		  <div class="form-group">
		  <div class="table-responsive">
		  <table id="Store" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<td class="text-left" style="width: 90%;"><?php echo $entry_multiStore; ?></td>	
					<td class="text-right"><?php echo $column_action; ?></td>
				</tr>
            </thead>
            <tbody>    
				<?php $Store_row = 0; ?>				  
				<?php foreach ($multiStore_array as $multiStores) { ?>
                    <tr id="Store-row<?php echo $Store_row; ?>"><td >
					<?php foreach ($languages as $language) { ?>
                      <label class="col-sm-2 control-label" for="input-cost"><?php echo $entry_multiStore; ?></label>
					  <div class="col-sm-10"><div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
					  <input type="text" name="multipickup_<?php echo $Store_row; ?>_Store_<?php echo $language['language_id'] ?>" value="<?php echo $multiStores["Store" . $language['language_id']]; ?>" placeholder="<?php echo $entry_multiStore; ?>" class="form-control" /></div></div>
					  <?php } ?>
					  <label class="col-sm-2 control-label" for="input-cost"><?php echo $entry_cost; ?></label>
					  <div class="col-sm-10"><input type="text" name="multipickup_<?php echo $Store_row; ?>_cost" value="<?php echo $multiStores['cost']; ?>" placeholder="<?php echo $entry_cost; ?>" class="form-control" /></div>
					  <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
					  <div class="col-sm-10"><input type="text" name="multipickup_<?php echo $Store_row; ?>_sort" value="<?php echo $multiStores['sort']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></div>
					  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
					  <div class="col-sm-10"><select name="multipickup_<?php echo $Store_row; ?>_status" class="form-control">
					  <?php if (($multiStores['status'])=='10') { ?><option value="10" selected="selected"><?php echo $text_enabled; ?></option><option value="20"><?php echo $text_disabled; ?></option>
					  <?php } else { ?><option value="10"><?php echo $text_enabled; ?></option><option value="20" selected="selected"><?php echo $text_disabled; ?></option><?php } ?></option></select></div>
					  </td><td class="text-right"><button type="button" onclick="$('#Store-row<?php echo $Store_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
					</tr>
                <?php $Store_row++; ?>
                <?php } ?>					
             </tbody>
             <tfoot>
                <tr>
					<td ></td>
                    <td class="text-right"><button type="button" onclick="addStore();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                </tr>
              </tfoot>
              </table>				
            </div>
			</div>		  
        </form>
      </div>
    </div>
  </div>
    <script type="text/javascript"><!--
	
var Store_row = <?php echo $Store_row; ?>;

function addStore() {
	html  = '<tr id="Store-row' + Store_row + '"> <td >';
	<?php foreach ($languages as $language) { ?>
	html += '  <label class="col-sm-2 control-label" for="input-cost"><?php echo $entry_multiStore; ?></label>';
	html += '  <div class="col-sm-10"><div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>';
	html += '  <input type="text" name="multipickup_' + Store_row + '_Store_<?php echo $language['language_id'] ?>" value="" placeholder="<?php echo $entry_multiStore; ?>" class="form-control" /></div></div>';
	<?php } ?>
	html += '  <label class="col-sm-2 control-label" for="input-cost"><?php echo $entry_cost; ?></label>';
	html += '  <div class="col-sm-10"><input type="text" name="multipickup_' + Store_row + '_cost" value="" placeholder="<?php echo $entry_cost; ?>" class="form-control" /></div>';
    html += '  <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>';
	html += '  <div class="col-sm-10"><input type="text" name="multipickup_' + Store_row + '_sort" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></div>';
	html += '  <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>';
	html += '  <div class="col-sm-10"><select name="multipickup_' + Store_row + '_status" class="form-control"><option value="10"><?php echo $text_enabled; ?></option><option value="20" selected="selected"><?php echo $text_disabled; ?></option></select></div>';
	html += '  </td><td class="text-right"><button type="button" onclick="$(\'#Store-row' + Store_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';

	$('#Store tbody').append(html);

	$('.date').datetimepicker({
		pickTime: false
	});
	Store_row++;
}
//--></script>
</div>
<?php echo $footer; ?>