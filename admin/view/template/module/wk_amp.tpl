<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
      	<a href="<?php echo $cancel; ?>" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"><i class="fa fa-reply"></i> </a>
      	<button onclick="$('form').submit()" class="btn btn-primary" data-toggle="tooltip" title="<?php echo $button_save; ?>"><i class="fa fa-save"></i> </button>
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
	<?php if($error_warning) { ?>
	    <div class="alert alert-danger">
	      <i class="fa fa-exclamation-circle"></i>
	      <?php echo $error_warning; ?>
	    </div>
	<?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="POST" enctype="text/form-data" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-2 control-label">
					<?php echo $entry_status; ?>
				</label>
				<div class="col-sm-10">
					<select class="form-control" name="wk_amp_status">
						<option value="0" <?php if(isset($wk_amp_status) && !$wk_amp_status) echo "selected"; ?>  ><?php echo $text_disabled; ?></option>
						<option value="1" <?php if(isset($wk_amp_status) && $wk_amp_status) echo "selected"; ?> ><?php echo $text_enabled; ?></option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" >
					<span  data-toggle="tooltip" title="<?php echo $entry_sub_menu_help; ?>">
						<?php echo $entry_sub_menu; ?>
					</span>
				</label>
				<div class="col-sm-10">
					<select class="form-control" name="wk_amp_sub_menu">
						<option value="0" <?php if(isset($wk_amp_sub_menu) && !$wk_amp_sub_menu) echo "selected"; ?> ><?php echo $text_disabled; ?></option>
						<option value="1" <?php if(isset($wk_amp_sub_menu) && $wk_amp_sub_menu) echo "selected"; ?> ><?php echo $text_enabled; ?></option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" >
					<span  data-toggle="tooltip" title="<?php echo $entry_menu_images_help; ?>">
						<?php echo $entry_menu_images; ?>
					</span>
				</label>
				<div class="col-sm-10">
					<select class="form-control" name="wk_amp_menu_image">
						<option value="0" <?php if(isset($wk_amp_menu_image) && !$wk_amp_menu_image) echo "selected"; ?> ><?php echo $text_disabled; ?></option>
						<option value="1" <?php if(isset($wk_amp_menu_image) && $wk_amp_menu_image) echo "selected"; ?> ><?php echo $text_enabled; ?></option>
					</select>
				</div>
			</div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>