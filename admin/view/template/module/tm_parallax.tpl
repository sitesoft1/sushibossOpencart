<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-parallax" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary">
					<i class="fa fa-save"></i>
				</button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
					<i class="fa fa-reply"></i>
				</a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li>
					<a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
				</li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger">
			<i class="fa fa-exclamation-circle"></i>
			<?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="fa fa-pencil"></i>
					<?php echo $text_edit; ?>
				</h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-parallax" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
						<div class="col-sm-10">
							<input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control"/>
							<?php if ($error_name) { ?>
							<div class="text-danger"><?php echo $error_name; ?></div>
							<?php } ?>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
						<div class="col-sm-10">
							<a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
								<img src="<?php if ($image) {
									echo $image_thumb;
								} else {
									echo $placeholder;
								} ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"/>
							</a>
							<input class="form-control" type="hidden" name="image" value="<?php echo $image; ?>" id="input-image">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
						<div class="col-sm-10">
							<input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control"/>
							<?php if ($error_width) { ?>
							<div class="text-danger">
								<?php echo $error_width; ?>
							</div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
						<div class="col-sm-10">
							<input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control"/>
							<?php if ($error_height) { ?>
							<div class="text-danger"><?php echo $error_height; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-blur"><?php echo $entry_blur; ?></label>
						<div class="col-sm-10">
							<select name="blur" id="input-blur" class="form-control">
								<?php if ($blur) { ?>
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
						<label class="col-sm-2 control-label" for="input-direction"><?php echo $entry_direction; ?></label>
						<div class="col-sm-10">
							<select name="direction" id="input-direction" class="form-control">
								<?php if ($direction) { ?>
								<option value="1" selected="selected"><?php echo $text_normal; ?></option>
								<option value="0"><?php echo $text_inverse; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_normal; ?></option>
								<option value="0" selected="selected"><?php echo $text_inverse; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-speed"><?php echo $entry_speed; ?></label>
						<div class="col-sm-10">
							<input type="text" name="speed" value="<?php echo $speed; ?>" placeholder="<?php echo $entry_speed; ?>" id="input-speed" class="form-control"/>
							<?php if ($error_speed) { ?>
							<div class="text-danger"><?php echo $error_speed; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
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
					<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
						<?php if ($layers) { ?>
						<?php for ($l = 0; $l < sizeof($layers); $l++) { ?>
						<div id="layer-<?php echo $l; ?>" class="panel-group">
							<div class="panel panel-default">
								<div class="panel-heading" role="tab" id="heading<?php echo $l; ?>">
									<h4 class="panel-title">
										<a style="display: inline-block" class="well-s" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<?php echo $l; ?>" aria-expanded="true" aria-controls="collapse<?php echo $l; ?>">
											<?php echo $entry_layer . " " . ($l + 1); ?>
										</a>
										<button type="button" data-toggle="tooltip" title="<?php echo $text_remove_layer; ?>" class="btn btn-danger pull-right" onclick="removeLayer($(this));">
											<i class="fa fa-minus-circle"></i>
										</button>
										<div class="clearfix"></div>
									</h4>
								</div>
								<div id="collapse<?php echo $l; ?>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<?php echo $l ?>">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-type<?php echo $l; ?>"><?php echo $entry_type; ?></label>
											<div class="col-sm-10">
												<select name="layers[<?php echo $l; ?>][type]" id="input-type<?php echo $l; ?>" class="form-control">
													<?php if ($layers[$l]['type']) { ?>
													<option value="1" selected="selected"><?php echo $text_media; ?></option>
													<option value="0"><?php echo $text_html; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_media; ?></option>
													<option value="0" selected="selected"><?php echo $text_html; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="tab-pane">
											<div class="row">
												<div class="col-sm-10 col-sm-offset-2">
													<ul class="nav nav-tabs" id="language<?php echo $l ?>">
														<?php foreach ($languages as $language) { ?>
														<li>
															<a href="#language<?php echo $l . $language['language_id']; ?>" data-toggle="tab">
																<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/>
																<?php echo $language['name']; ?>
															</a>
														</li>
														<?php } ?>
													</ul>
												</div>
											</div>
											<div class="tab-content">
												<?php foreach ($languages as $language) { ?>
												<div class="tab-pane" id="language<?php echo $l . $language['language_id']; ?>">
													<div class="form-group">
														<label class="col-sm-2 control-label" for="input-description<?php echo $l . $language['language_id']; ?>"><?php echo $entry_description; ?></label>

														<div class="col-sm-10">
															<textarea name="layers[<?php echo $l; ?>][description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $l . $language['language_id']; ?>" class="form-control"><?php echo isset($layers[$l]['description'][$language['language_id']]) ? $layers[$l]['description'][$language['language_id']] : "" ?></textarea>
														</div>
													</div>
												</div>
												<?php } ?>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-image<?php echo $l; ?>"><?php echo $entry_image; ?></label>
											<div class="col-sm-10">
												<a href="" id="thumb-image<?php echo $l; ?>" data-toggle="image" class="img-thumbnail">
													<img src="<?php if ($layers[$l]['image']) { echo $layer_thumb[$l]; } else { echo $placeholder; } ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"/>
												</a>
												<input class="form-control" type="hidden" name="layers[<?php echo $l; ?>][image]" value="<?php echo (isset($layers[$l]['image'])) ? $layers[$l]['image'] : ''; ?>" id="input-image<?php echo $l; ?>">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-width<?php echo $l; ?>"><?php echo $entry_width; ?></label>
											<div class="col-sm-10">
												<input type="text" name="layers[<?php echo $l; ?>][width]" value="<?php echo $layers[$l]['width']; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width<?php echo $l; ?>" class="form-control"/>
												<?php if (isset($error_layer_image_width[$l]) && $error_layer_image_width[$l]) { ?>
												<div class="text-danger"><?php echo $error_layer_image_width[$l]; ?></div>
												<?php } ?>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-height<?php echo $l; ?>"><?php echo $entry_height; ?></label>
											<div class="col-sm-10">
												<input type="text" name="layers[<?php echo $l; ?>][height]" value="<?php echo $layers[$l]['height']; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height<?php echo $l; ?>" class="form-control"/>
												<?php if (isset($error_layer_image_height[$l]) && $error_layer_image_height[$l]) { ?>
												<div class="text-danger"><?php echo $error_layer_image_height[$l]; ?></div>
												<?php } ?>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-speed<?php echo $l; ?>"><?php echo $entry_speed; ?></label>
											<div class="col-sm-10">
												<input type="text" name="layers[<?php echo $l; ?>][speed]" value="<?php echo $layers[$l]['speed']; ?>" placeholder="<?php echo $entry_speed; ?>" id="input-speed<?php echo $l; ?>" class="form-control"/>
												<?php if (isset($error_layer_speed[$l]) && $error_layer_speed[$l]) { ?>
												<div class="text-danger"><?php echo $error_layer_speed[$l]; ?></div>
												<?php } ?>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-fade<?php echo $l; ?>"><?php echo $entry_fade; ?></label>
											<div class="col-sm-10">
												<select name="layers[<?php echo $l; ?>][fade]" id="input-fade<?php echo $l; ?>" class="form-control">
													<?php if ($layers[$l]['fade']) { ?>
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
											<label class="col-sm-2 control-label" for="input-blur<?php echo $l; ?>"><?php echo $entry_blur; ?></label>
											<div class="col-sm-10">
												<select name="layers[<?php echo $l; ?>][blur]" id="input-blur<?php echo $l; ?>" class="form-control">
													<?php if ($layers[$l]['blur']) { ?>
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
											<label class="col-sm-2 control-label" for="input-direction<?php echo $l; ?>"><?php echo $entry_direction; ?></label>
											<div class="col-sm-10">
												<select name="layers[<?php echo $l; ?>][direction]" id="input-direction<?php echo $l; ?>" class="form-control">
													<?php if ($layers[$l]['direction']) { ?>
													<option value="1" selected="selected"><?php echo $text_normal; ?></option>
													<option value="0"><?php echo $text_inverse; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_normal; ?></option>
													<option value="0" selected="selected"><?php echo $text_inverse; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div id="modules-<?php echo $l; ?>">
											<?php if (isset($layers[$l]['module_id']) && $layers[$l]['module_id']) { ?>
											<?php for ($i = 0; $i < sizeof($layers[$l]['module_id']); $i++) { ?>
											<div id="module-<?php echo $l . "-" . $i; ?>">
												<div class="form-group">
													<h4 class="col-sm-2 text-right">Module</h4>
													<div class="col-sm-10 text-right">
														<button type="button" onclick="removeModule($(this));" data-toggle="tooltip" title="<?php echo $text_remove_module; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
													</div>
													<div class="clearfix"></div>
												</div>
												<div class="form-group required">
													<label class="col-sm-2 control-label" for="input-module<?php echo $l . $i; ?>"><?php echo $entry_module; ?></label>
													<div class="col-sm-10">
														<select name="layers[<?php echo $l; ?>][module_id][<?php echo $i; ?>]" id="input-module<?php echo $l . $i; ?>" class="form-control">
															<?php foreach ($modules as $module) { ?>
															<?php if ($module['module_id'] == $layers[$l]['module_id'][$i]) { ?>
															<option value="<?php echo $module['module_id']; ?>" selected="selected"><?php echo $module['name']; ?></option>
															<?php } else { ?>
															<option value="<?php echo $module['module_id']; ?>"><?php echo $module['name']; ?></option>
															<?php } ?>
															<?php } ?>
														</select>
													</div>
												</div>
											</div>
											<?php } ?>
											<?php } ?>
										</div>
										<div class="text-right">
											<button type="button" onclick="addModule(<?php echo $l; ?>);" data-toggle="tooltip" title="<?php echo $text_add_module; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<?php } ?>
						<?php } ?>
					</div>
					<div class="col-sm-12 text-right">
						<button id="btn-add" type="button" onclick="addLayer($(this));" data-toggle="tooltip" title="<?php echo $text_add_layer; ?>" class="btn btn-primary">
							<i class="fa fa-plus-circle"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>
<script type="text/javascript">
	var layers_count;
	var modules_count;
	function addLayer() {
		if ($('#accordion').find('[id^="layer-"]').length) {
			layers_count = $('#accordion').find('[id^="layer-"]:last').attr('id').split("-")[1];
			layers_count++;
		}
		else {
			layers_count = 0;
		}
		layerHtml = '<div id="layer-'+ layers_count +'" class="panel-group">';
		layerHtml += '<div class="panel panel-default">';
		layerHtml += '<div class="panel-heading" role="tab" id="heading' + layers_count + '">';
		layerHtml += '	<h4 class="panel-title">';
		layerHtml += '		<a style="display: inline-block" class="well-s" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse' + layers_count + '" aria-expanded="true" aria-controls="collapse' + layers_count + '"><?php echo $entry_layer; ?> ' + (layers_count + 1) +'</a>';
		layerHtml += '		<button type="button" data-toggle="tooltip" title="<?php echo $text_remove_layer; ?>" class="btn btn-danger pull-right" onclick="removeLayer($(this));">';
		layerHtml += '			<i class="fa fa-minus-circle"></i>';
		layerHtml += '		</button>';
		layerHtml += '		<div class="clearfix"></div>';
		layerHtml += '	</h4>';
		layerHtml += '</div>';
		layerHtml += '<div id="collapse' + layers_count + '" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading' + layers_count + '">';
		layerHtml += '<div class="panel-body">';
		layerHtml += '<div class="form-group">';
		layerHtml += 	'<label class="col-sm-2 control-label" for="input-type' + layers_count + '"><?php echo $entry_type; ?></label>';
		layerHtml += 	'<div class="col-sm-10">';
		layerHtml += 		'<select name="layers[' + layers_count + '][type]" id="input-type' + layers_count + '" class="form-control">';
		layerHtml += 			'<option value="1"><?php echo $text_media; ?></option>';
		layerHtml += 			'<option value="0" selected="selected"><?php echo $text_html; ?></option>';
		layerHtml += 		'</select>';
		layerHtml += 	'</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="tab-pane">';
		layerHtml += '	<div class="row">';
		layerHtml += '		<div class="col-sm-10 col-sm-offset-2">';
		layerHtml += '			<ul class="nav nav-tabs" id="language' + layers_count + '">';
		<?php foreach ($languages as $language) { ?>
		layerHtml += '					<li>';
		layerHtml += '						<a href="#language' + layers_count + '<?php echo $language['language_id']; ?>" data-toggle="tab">';
		layerHtml += '							<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/>';
		layerHtml += '							<?php echo $language['name']; ?>';
		layerHtml += '						</a>';
		layerHtml += '					</li>';
		<?php } ?>
		layerHtml += '			</ul>';
		layerHtml += '		</div>';
		layerHtml += '	</div>';
		layerHtml += '	<div class="tab-content">';
		<?php foreach ($languages as $language) { ?>
		layerHtml += '			<div class="tab-pane" id="language' + layers_count + '<?php echo $language['language_id']; ?>">';
		layerHtml += '				<div class="form-group">';
		layerHtml += '					<label class="col-sm-2 control-label" for="input-description' + layers_count + '<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>';
		layerHtml += '					<div class="col-sm-10">';
		layerHtml += '						<textarea name="layers[' + layers_count + '][description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $entry_description; ?>" id="input-description' + layers_count + '<?php echo $language['language_id']; ?>" class="form-control"></textarea>';
		layerHtml += '					</div>';
		layerHtml += '				</div>';
		layerHtml += '			</div>';
		<?php } ?>
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-image' + layers_count + '"><?php echo $entry_image; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<a href="" id="thumb-image' + layers_count + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"/></a>';
		layerHtml += '		<input class="form-control" type="hidden" name="layers[' + layers_count + '][image]" value="" id="input-image' + layers_count + '">';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-width' + layers_count + '"><?php echo $entry_width; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<input type="text" name="layers[' + layers_count + '][width]" value="" placeholder="<?php echo $entry_width; ?>" id="input-width' + layers_count + '" class="form-control"/>';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-height' + layers_count + '"><?php echo $entry_height; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<input type="text" name="layers[' + layers_count + '][height]" value="" placeholder="<?php echo $entry_height; ?>" id="input-height' + layers_count + '" class="form-control"/>';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-speed' + layers_count + '"><?php echo $entry_speed; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<input type="text" name="layers[' + layers_count + '][speed]" value="" placeholder="<?php echo $entry_speed; ?>" id="input-speed' + layers_count + '" class="form-control"/>';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-fade' + layers_count + '"><?php echo $entry_fade; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<select name="layers[' + layers_count + '][fade]" id="input-fade' + layers_count + '" class="form-control">';
		layerHtml += '			<option value="1"><?php echo $text_enabled; ?></option>';
		layerHtml += '			<option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
		layerHtml += '		</select>';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-blur' + layers_count + '"><?php echo $entry_blur; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<select name="layers[' + layers_count + '][blur]" id="input-blur' + layers_count + '" class="form-control">';
		layerHtml += '			<option value="1"><?php echo $text_enabled; ?></option>';
		layerHtml += '			<option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
		layerHtml += '		</select>';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div class="form-group">';
		layerHtml += '	<label class="col-sm-2 control-label" for="input-direction' + layers_count + '"><?php echo $entry_direction; ?></label>';
		layerHtml += '	<div class="col-sm-10">';
		layerHtml += '		<select name="layers[' + layers_count + '][direction]" id="input-direction' + layers_count + '" class="form-control">';
		layerHtml += '			<option value="1"><?php echo $text_normal; ?></option>';
		layerHtml += '			<option value="0" selected="selected"><?php echo $text_inverse; ?></option>';
		layerHtml += '		</select>';
		layerHtml += '	</div>';
		layerHtml += '</div>';
		layerHtml += '<div id="modules-' + layers_count + '">';
		layerHtml += '	</div>';
		layerHtml += '<div class="col-sm-12 text-right">';
		layerHtml += '	<button type="button" onclick="addModule(' + layers_count + ');" data-toggle="tooltip" title="<?php echo $text_add_module; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>';
		layerHtml += '</div>';
		layerHtml += '</div>';
		layerHtml += '</div>';
		layerHtml += '</div>';
		$('#accordion').append(layerHtml);
	}
	function addModule(layer) {
		if ($('[id^="modules-'+ layer +'"]').find('[id^="module-"]').length) {
			modules_count = $('[id^="modules-'+ layer +'"]').find('[id^="module-"]:last').attr('id').split("-")[2];
			modules_count++;
		}
		else {
			modules_count = 0;
		}
		moduleHtml = '<div id="module-' + layer + '-' + modules_count + '">';
		moduleHtml += '	<div class="form-group">';
		moduleHtml += '<h4 class="col-sm-2 text-right">Module</h4>';
		moduleHtml += '		<div class="col-sm-10 text-right">';
		moduleHtml += '			<button type="button" onclick="removeModule($(this));" data-toggle="tooltip" title="<?php echo $text_remove_module; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>';
		moduleHtml += '		</div>';
		moduleHtml += '		<div class="clearfix"></div>';
		moduleHtml += '	</div>';
		moduleHtml += '	<div class="form-group required">';
		moduleHtml += '		<label class="col-sm-2 control-label" for="input-module' + layer + modules_count + '"><?php echo $entry_module; ?></label>';
		moduleHtml += '		<div class="col-sm-10">';
		moduleHtml += '			<select name="layers[' + layer + '][module_id][' + modules_count + ']" id="input-module' + layer + modules_count + '" class="form-control">';
		<?php foreach ($modules as $module) { ?>
		moduleHtml+= '					<option value="<?php echo $module['module_id']; ?>"><?php echo $module['name']; ?></option>';
		<?php } ?>
		moduleHtml+= '			</select>';
		moduleHtml+= '		</div>';
		moduleHtml+= '	</div>';
		moduleHtml+= '</div>';
		$('#modules-' + layer + '').append(moduleHtml);
	}
	function removeLayer(e) {
		e.closest('[id*="layer-"]').remove();
	}
	function removeModule(e) {
		e.closest('[id*="module-"]').remove();
	}
	;(function ($) {
		$(document).ready(UpdateDescription);
		$('#btn-add').on('click', UpdateDescription);
		function UpdateDescription() {
			if (!$('#accordion').find('.nav').hasClass('active')) {
				$('#accordion').find('.nav').find('a:first').tab('show');
			}
			if (!$('#accordion').find('.nav').hasClass('active')) {
				$('#accordion').find('.nav').find('a:first').tab('show');
			}
			$('#accordion').find('.tab-content').find('[id^="input-description"]').each(function(){
				if (!$(this).attr('style')) {
					$(this).summernote({height: 300});
				}
			});
		}
	})(jQuery);
</script>