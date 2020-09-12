<?php echo $header; ?><?php echo $column_left; ?>

<?php

	$HTTP_URL = '';
	
	if( class_exists( 'MijoShop' ) ) {
		$HTTP_URL = HTTP_CATALOG . 'opencart/admin/';
	}

?>

<div id="content">
	<link type="text/css" href="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/css/bootstrap.css" rel="stylesheet" />
	<link type="text/css" href="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/css/jquery-ui.min.css" rel="stylesheet" />
	<link type="text/css" href="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/css/style.css" rel="stylesheet" />

	<script type="text/javascript">
		$ = jQuery = $.noConflict(true);
	</script>

	<script type="text/javascript" src="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/js/jquery.min.js"></script>

	<script type="text/javascript">
		var $$			= $.noConflict(true),
			$jQuery		= $$;
		
		$().ready(function(){
			$('[data-toggle="dropdown"]').dropdown();
		});
	</script>

	<script type="text/javascript" src="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/js/bootstrap.js"></script>
	<script type="text/javascript" src="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/js/json.js"></script>

	<script type="text/javascript" src="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/js/jquery.form.js"></script>
	<script type="text/javascript" src="<?php echo $HTTP_URL; ?>view/stylesheet/tmfilter/js/jquery-ui.min.js"></script>

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button id="mf-save-form" type="submit" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $back; ?>" data-toggle="tooltip" title="<?php echo $button_back; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			
			<script type="text/javascript">
				jQuery('#mf-save-form').click(function(){
					if( jQuery('#form').attr('data-to-ajax')!='1' ) {
						jQuery('#form').submit();
						
						return false;
					}
				});
			</script>
			
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ( ! empty( $_error_warning ) ) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $_error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		<?php if ( ! empty( $_success ) ) { ?>
			<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $_success; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body tm-filter-pro" id="mf-main-content">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">