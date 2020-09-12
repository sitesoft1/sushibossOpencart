<?php require DIR_TEMPLATE . 'module/' . $_name . '-header.tpl'; ?>

<div class="col-xs-2">
	<ul class="nav nav-tabs tabs-left" id="nav-tabs">
		<?php $module_row = 1; ?>

		<?php foreach ($modules as $row => $module) { ?>
			<li<?php echo $module_row == 1 ? ' class="active"' : ''; ?>>
				<a href="#tab-module-<?php echo $row; ?>" id="module-<?php echo $row; ?>">
					<b style="font-weight:normal"><?php echo ! empty( $module['name'] ) ? $module['name'] : $tab_module . ' ' . $row; ?></b>
					<span class="btn btn-danger btn-xs pull-right"><i class="glyphicon glyphicon-remove"></i></span>
				</a>
			</li>
			<?php $module_row++; ?>
		<?php } ?>
		<li id="module-add"><a style="background: none !important; border:none !important;" id="add-new-module" class="pull-right"><span class="btn btn-success btn-xs pull-right"><i class="glyphicon glyphicon-plus-sign"></i> <?php echo $button_add_module; ?></span></a></li>
	</ul>
</div>

<div class="col-xs-10">
	<div class="tab-content" id="tab-content"></div>
</div>

<div class="clearfix"></div>

<script type="text/javascript">
	var MF_AJAX_PARAMS = '<?php echo $HTTP_URL ? "&option=com_mijoshop&format=raw" : ""; ?>';
	
////////////////////////////////////////////////////////////////////////////////

	$jQuery(document).on('click', '.scrollbox div a', function() {
		var $self	= jQuery(this),
			$parent	= $self.parent(),
			$box	= $parent.parent();

		$parent.remove();

		$box.find('div:odd').attr('class', 'odd');
		$box.find('div:even').attr('class', 'even');
	});

	if( typeof Array.prototype.indexOf == 'undefined' ) {
		Array.prototype.indexOf = function(obj, start) {
			for( var i = ( start || 0 ), j = this.length; i < j; i++ ) {
				if( this[i] === obj ) { return i; }
			}
			return -1;
		};
	}

////////////////////////////////////////////////////////////////////////////////

jQuery('#mf-save-form').click(function(){
	MFP.save( '<?php echo $text_saving_please_wait; ?>', function(){
		var $form = $$('#form');
		
		$form.after($$('<form id="mf-form">')
			.attr('method', 'post')
			.attr('action', $form.attr('action'))
		);
	
		$$('#mf-form').submit();
	});
});

jQuery('#form').attr('data-to-ajax','1');

var MFP = {
	_cnt		: null,
	_cntId		: '#tab-content',
	_row		: 1,
	_tab		: 1,
	_name		: '<?php echo $_name; ?>',
	_hasFilters	: <?php echo isset( $tab_filters_link ) ? 'true' : 'false'; ?>,
	_langs		: null,
	_layouts	: null,
	_settings	: null,	

	init: function( modules, firstModule ) {
		var self = this;
		
		self._cnt		= jQuery(self._cntId);
		
		jQuery('#add-new-module').click(function(){
			self._row = jQuery('#nav-tabs > li:not([id="module-add"]):last');
			
			if( self._row.length ) {
				self._row = parseInt( self._row.find('> a').attr('id').split('-')[1] ) + 1;
			} else {
				self._row = 1;
			}
			
			(function( row ){
				var $li = jQuery('<li>')
					.append(jQuery('<a>')
						.attr({
							'href'	: '#tab-module-' + row,
							'id'	: 'module-' + row
						})
						.append(jQuery('<b>')
							.css('font-weight', 'normal')
							.text('<?php echo $tab_module; ?> ' + row)
						)
						.append(jQuery('<span>')
							.addClass('btn btn-danger btn-xs pull-right')
							.append(jQuery('<i>')
								.addClass('glyphicon glyphicon-remove')
							)
						)
					);

				jQuery('#module-add')
					.before( $li );
				
				self._initTab( $li );
				self._selectTab( $li, false );
				
				self.addModule('', null);
			})( self._row );
			
			return false;
		});
		
		$$('#nav-tabs > li:not([id=module-add])').each(function(){
			self._initTab( $$(this) );
		});
		
		$$('#nav-tabs > li:not([id=module-add]):first a').trigger('click');
	},
	
	_selectTab: function( $tab, load ) {
		if( ! $tab.length ) return;
	
		var self = this,
			newId = $tab.find('a').attr('id').split('-')[1],
			currId = $$('#tab-content > div.active');
		
		if( ! currId.length ) {
			currId = null;
		} else {
			currId = currId.attr('id').split('-')[2];
		}
		
		if( currId == newId )
			return;
		
		function selectTab() {
			function showTab( data ) {
				$$('#nav-tabs > li.active').removeClass('active');
				$$('#tab-content > div').remove();

				$tab.addClass('active');
				
				self._row = newId;
				
				self.addModule(data.name, data);
			}
			
			if( load ) {
				var $progress = self.createProgress('<?php echo $text_loading_please_wait; ?>');
				
				$$.get( '<?php echo $action_get_data; ?>'.replace(/&amp;/g,'&') + MF_AJAX_PARAMS + '&mf_id=' + newId, {}, function( response ){
					$progress.remove();
					showTab( $$.parseJSON( response ) );
				});
			} else {
				showTab({name:''});
			}
		}
		
		if( currId !== null ) {
			self.save( '<?php echo $text_loading_please_wait; ?>', function(){
				selectTab();
				
				return true;
			});
		} else {
			selectTab();
		}
	},
	
	_initTab: function( $tab ) {
		var self = this;
		
		$tab.find('> a').each(function(){
			var row = $$(this).attr('id').split('-')[1];
			
			$$(this).find('.btn-danger').click(function(){				
				jQuery('#module-'+row).parent().remove();
				jQuery('#tab-module-'+row).remove();
				
				$$.get( '<?php echo $action_remove_data; ?>'.replace(/&amp;/g,'&') + MF_AJAX_PARAMS + '&mf_id=' + row );
				
				if( row == self._row ) {
					self._selectTab( $$('#nav-tabs li:not([id=module-add]):first'), true );
				}
				
				return false;
			});
			
			$$(this).click(function(){
				self._selectTab( $tab, true );
				
				return false;
			});
		});
	},
	
	createProgress: function( text ){
		return jQuery('<div style="position:absolute; z-index:99; left: 0; top: 0; background: rgba(255,255,255,0.5);" class="tm-filter-pro">')
			.append('<div style="color: #fff; margin: 0 auto; margin-top:100px; width: 300px; background: rgba(0,0,0,0.6); padding: 10px; border-radius: 5px; text-align: center;">' + text + '</div>')
			.width( jQuery('#mf-main-content').outerWidth(true)+30 )
			.height( jQuery('#content').outerHeight(true) )
			.prependTo( jQuery('#mf-main-content') );
	},
	
	save: function( txt, fn, pager ) {
		var $module = $$('#tab-content > .tab-pane.active');
		
		if( ! $module.length ) {
			if( fn() === true ) {
				$progress.remove();
			}
			
			return;
		}
		
		var
			$progress = this.createProgress( txt ),
			id = $module.attr('id').split('-')[2],
			perPage = 500,
			tmp = jQuery('#form').formToArray(),
			pages = Math.ceil( tmp.length / perPage )-1;
			pager = typeof pager == 'undefined' || ! pager ? 0 : 1;
			
		function getData( idx ) {
			var data = [];
			
			for( var i = idx * perPage; i < idx * perPage + perPage; i++ ) {
				if( typeof tmp[i] == 'undefined' ) break;
				
				data.push( tmp[i] );
			}
			
			return $$.param( data );
		}
		
		function save( idx ) {
			$$.post( '<?php echo $action_save_data; ?>'.replace(/&amp;/g,'&') + MF_AJAX_PARAMS + '&mf_idx=' + idx + '&mf_count=' + pages + '&mf_id=' + id + '&mf_pager=' + pager, getData( idx ), function(){
				if( idx < pages ) {
					save( idx + 1 );
				} else {
					if( fn() === true ) {
						$progress.remove();
					}
				}
			});
		}
		
		save( 0 );
	},
	
	addModule: function( name, data, row ){		
			var self	= this,

			$name	= jQuery('<table class="table table-tbody">')
				.append(jQuery('<tr>')
					.append( '<td><?php echo $entry_name; ?></td>' )
					.append(jQuery('<td>')
						.append( self.createField( 'text', '[name]', name, { 'class' : 'mf_tab_name', 'id' : 'name-' + self._row } ) )
					)
				),

			$title	= jQuery('<div>')
				.append((function(){
					var $ul = jQuery('<ul id="language-' + self._row + '" class="nav nav-tabs">'),
						k = 0, i;
					
					for( i in self._langs ) {
						if( typeof self._langs[i] == 'function' ) continue;
						
						$ul.append(jQuery('<li' + ( k ? '' : ' class="active"' ) + '>')
							.append(jQuery('<a data-toggle="tab" href="#tab-language-' + self._row + '-' + self._langs[i].language_id + '">')
								.append(jQuery('<img src="view/image/flags/' + self._langs[i].image + '" title="' + self._langs[i].name + '">'))
								.append( ' ' + self._langs[i].name )
							)
						);
						k++;
					}
					
					return $ul;
				})())
				.append((function(){
					var $tc = jQuery('<div class="tab-content">'),
						k = 0, i;
					
					for( i in self._langs ) {
						if( typeof self._langs[i] == 'function' ) continue;
						
						$tc.append(jQuery('<div class="tab-pane' + ( k ? '' : ' active' ) + '" id="tab-language-' + self._row + '-' + self._langs[i].language_id + '">')
							.append(jQuery('<table class="table table-tbody">')
								.append(jQuery('<tr>')
									.append(jQuery('<td width="200"><?php echo $entry_title; ?></td>'))
									.append(jQuery('<td data-name="title-' + i + '">'))
								)
							)
						);
						k++;
					}
					
					return $tc;
				})()), 
			$tabs	= jQuery('<ul id="c-tabs-' + self._row + '" class="nav nav-tabs">')
				.append('<li class="active"><a data-toggle="tab" href="#tab-' + self._row + '-settings"><i class="glyphicon glyphicon-cog"></i> <?php echo $tab_settings; ?></a></li>')
				.append('<li><a data-toggle="tab" href="#tab-' + self._row + '-base-attributes"><i class="glyphicon glyphicon-wrench"></i> <?php echo $tab_base_attributes; ?></a></li>')
				.append('<li><a data-toggle="tab" href="#tab-' + self._row + '-attribs"><i class="glyphicon glyphicon-list"></i> <?php echo $tab_attributes; ?></a></li>')
				.append('<li><a data-toggle="tab" href="#tab-' + self._row + '-options"><i class="glyphicon glyphicon-list"></i> <?php echo $tab_options; ?></a></li>')
				.append(self._hasFilters?'<li><a data-toggle="tab" href="#tab-' + self._row + '-filters"><i class="glyphicon glyphicon-filter"></i> <?php echo $tab_filters; ?></a></li>':''),
			$tc		= jQuery('<div class="tab-content">')


				.append(jQuery('<div id="tab-' + self._row + '-settings" class="tab-pane active">')
					.append(jQuery('<table class="table table-tbody">')
						.append(jQuery('<tr>')
							.append('<td width="200"><?php echo $entry_layout; ?><span class="help"><?php echo $text_checkbox_guide; ?></span></td>')
							.append(jQuery('<td data-name="layout">'))
						)
						.append(jQuery('<tr>')
							.append('<td><?php echo $entry_store; ?></td>')
							.append('<td data-name="store-id"></td>')
						)
						.append(jQuery('<tr>')
							.append('<td><?php echo $entry_position; ?></td>')
							.append('<td data-name="position"></td>')
						)
						.append(jQuery('<tr>')
							.append('<td><?php echo $entry_display_options_inline_horizontal; ?></td>')
							.append('<td data-name="inline-horizontal"></td>')
						)
						.append(jQuery('<tr>')
							.append('<td><?php echo $entry_status; ?></td>')
							.append('<td data-name="status"></td>')
						)
						.append(jQuery('<tr>')
							.append('<td><?php echo $entry_sort_order; ?></td>')
							.append('<td data-name="sort-order"></td>')
						)
					)
				)

				.append( self.createContainer( 'base-attributes', 'base_attribs' ) )
				.append( self.createContainer( 'attribs' ) )
				.append( self.createContainer( 'options' ) )
				.append( self._hasFilters ? self.createContainer( 'filters' ) : '' ),

			$module = jQuery('<div id="tab-module-' + self._row + '" class="tab-pane">')
				.append( $name )
				.append( $title )
				.append( $tabs )
				.append( $tc );
		
		self._cnt.append( $module );
		
		if( data !== null ) {
			self._initModule( $module, data );
		}
	},
	
	_initModule: function( $module, data ) {
		var self = this,
			row = $module.attr('id').split('-')[1];
		
		$module.addClass('active');
		

		for( var i in self._langs ) {
			if( typeof self._langs[i] == 'function' ) continue;

			$module.find('[data-name="title-' + i + '"]').append( self.createField( 
				'text', 
				'[title][' + self._langs[i].language_id + ']',
				typeof data['title'] != 'undefined' && typeof data['title'][self._langs[i].language_id] != 'undefined' ? data['title'][self._langs[i].language_id] : '',
				{ 'style' : 'width:400px' }
			));
		}
	
		
		$module.find('[data-name="layout"]').append( self.createScrollbox( 'checkbox', '[layout_id][]', self._layouts, 'layout_id', typeof data['layout_id'] != 'undefined' ? data['layout_id'] : [] ) );
		
		$module.find('[data-name="layout-1"]')[typeof data['layout_id'] == 'undefined' || data['layout_id'].indexOf( self._settings['layout_c'] ) < 0?'hide':'show']();

		$module.find('[data-name="store-id"]')
			.append( self.createScrollbox( 'checkbox', '[store_id][]', self._stores, 'store_id', typeof data['store_id'] != 'undefined' ? data['store_id'] : [] ) );
		
		

		$module.find('[data-name="position"]')
			.append( self.createField( 'select', '[position]', data['position'], {
				'multiOptions' : {
				'items' : {
				'column_left'	: '<?php echo $text_column_left; ?>',
				'column_right'	: '<?php echo $text_column_right; ?>',
				'content_top'	: '<?php echo $text_content_top; ?>'
				}
			}
		}));
		

		$module.find('[data-name="inline-horizontal"]')
			.append( self.createField( 'checkbox', '[inline_horizontal]', '1' ).attr( 'checked', typeof data['inline_horizontal'] != 'undefined' && data['inline_horizontal'] ? true : false ) );
		

		$module.find('[data-name="status"]')
			.append( self.createField( 'select', '[status]', data['status'], {
				'multiOptions' : {
				'items' : {
					'1' : '<?php echo $text_enabled; ?>',
					'0' : '<?php echo $text_disabled; ?>'
				}
			}
		}));
		

		$module.find('[data-name="sort-order"]')
			.append( self.createField( 'text', '[sort_order]', data['sort_order'], {
				'size' : '3'
			}
		));
		
		////////////////////////////////////////////////////////////////////////
		

		$module.find('[data-load-type]').bind('click',function(){
			var _this		= jQuery(this),
				parent		= _this.parent(),
				type		= _this.attr('data-load-type'),
				row			= parent.attr('id').split('-')[1],
				container	= parent.find('> .cnt'),
				$progress	= null;
				
			if( _this.attr('data-loaded') && ! confirm( '<?php echo $text_are_you_sure; ?>' ) ) {
				return false;
			}
				
			parent.find('.mf-filter button').unbind('click').bind('click', function(){
				self.save('<?php echo $text_loading_please_wait; ?>', function(){
					load('&filter=' + encodeURIComponent( parent.find('.mf-filter input').val() ) );
					
					return true;
				});
			});

			container.html( '<center><?php echo $text_loading; ?></center>' );
			
			function load( params ) {
				var url = '<?php echo $action_ldv; ?>'.replace(/&amp;/g,'&')+MF_AJAX_PARAMS;
				
				if( ! params && _this.attr('data-loaded') ) {
					url += '&mf_default=1';
				}
				
				_this.attr('data-loaded', 1);
				
				jQuery.get( url+params, { 'name' : '<?php echo $_name; ?>_module[' + type + ']', 'type' : type, 'idx' : row }, function( response ){
					container.html( response );
					
					if( $progress != null ) {
						$progress.remove();
						$progress = null;
					}

					container.find('.pagination a').click(function(){
						var page = jQuery(this).attr('href').match(/page=([0-9]+)/)[1];

						self.save( '<?php echo $text_loading_please_wait; ?>', function(){
							$progress = self.createProgress( '<?php echo $text_loading_please_wait; ?>' );

							load( '&page=' + page );

							return true;
						});

						return false;
					});
				});
			}
			
			load('');

			return false;
		});
		



		$module.find('input.mf_tab_name').bind('change keyup', function(){
			var val = jQuery(this).val(),
				id	= jQuery(this).attr('id').split('-')[1];
			
			if( ! val ) {
				val = '<?php echo $tab_module; ?> ' + id;
			}
			
			jQuery('#module-' + id).find('b').text( val );
		}).trigger('change');
		
		$module.find('select[name="tm_filter_module[position]"]').change(function(){
			$module.find('[data-name="inline-horizontal"]').parent()[jQuery(this).val()=='content_top'?'show':'hide']();
		}).trigger('change');
		
		$module.find('a[data-load-type]').trigger('click');
 },
	
	render_btn_group: function( name, enabled ) {
		var html = '';
		
		html += '<div class="btn-group" data-toggle="fm-buttons">';
		html += '<label class="btn btn-primary btn-xs' + ( enabled ? ' active' : '' ) + '">';
		html += '<input type="radio" name="' + name + '"' + ( enabled ? ' checked="checked"' : '' ) + ' value="1">' + '<?php echo $text_yes; ?>';
		html += '</label>';
		html += '<label class="btn btn-primary btn-xs' + ( ! enabled ? ' active' : '' ) + '">';
		html += '<input type="radio" name="' + name + '"' + ( ! enabled ? ' checked="checked"' : '' ) + ' value="0">' + '<?php echo $text_no; ?>';
		html += '</label>';
		html += '</div>';
		
		return html;
	},
	
	render_btn_collapsed: function( name, value ) {
		var html = '';
		
		html += '<div class="btn-group" data-toggle="fm-buttons">';
		html += '<label class="btn btn-primary btn-xs' + ( value == '1' ? ' active' : '' ) + '">';
		html += '<input type="radio" name="' + name + '"' + ( value == '1' ? ' checked="checked"' : '' ) + ' value="1">' + '<?php echo $text_yes; ?>';
		html += '</label>';
		html += '<label class="btn btn-primary btn-xs' + ( ! value || value == '0' ? ' active' : '' ) + '">';
		html += '<input type="radio" name="' + name + '"' + ( ! value || value == '0' ? ' checked="checked"' : '' ) + ' value="0">' + '<?php echo $text_no; ?>';
		html += '</label>';
		html += '<label class="btn btn-primary btn-xs' + ( value == 'pc' ? ' active' : '' ) + '">';
		html += '<input type="radio" name="' + name + '"' + ( value == 'pc' ? ' checked="checked"' : '' ) + ' value="pc">' + '<?php echo $text_pc; ?>';
		html += '</label>';
		html += '<label class="btn btn-primary btn-xs' + ( value == 'mobile' ? ' active' : '' ) + '">';
		html += '<input type="radio" name="' + name + '"' + ( value == 'mobile' ? ' checked="checked"' : '' ) + ' value="mobile">' + '<?php echo $text_mobile; ?>';
		html += '</label>';
		html += '</div>';
		
		return html;
	},
	
	createContainer: function( id, type ) {
		var self	= this,
			cnt		= jQuery('<div class="cnt">'),
			tmp;
	
		if( typeof type == 'undefined' )
			type = id;
		
		tmp = jQuery('#tmp-' + self._row + '-' + type);
		
		if( tmp.length ) {
			cnt.append( tmp );
			tmp.removeAttr('style');
		}
		
		var placeholder = {
			'attribs' : '<?php echo $text_attribute_name; ?>',
			'options' : '<?php echo $text_option_name; ?>',
			'filters' : '<?php echo $text_filter_name; ?>'
		};
		
		return jQuery('<div id="tab-' + self._row + '-' + id + '" class="tab-pane">')
			.append(type=='base_attribs'?'':jQuery('<div class="pull-left input-group mf-filter" style="padding:5px">')
				.append('<input type="text" class="form-control pull-left input-sm" placeholder="' + ( typeof placeholder[type] == 'undefined' ? '' : placeholder[type] ) + '" style="width:200px" />')
				.append('<span class="input-group-btn pull-left"><button type="button" class="btn btn-primary btn-sm"><i class="glyphicon glyphicon-search"></i></button></span>')
			)
			.append('<a href="#" data-load-type="' + type + '" class="btn btn-xs btn-danger" style="float:right; margin: 4px 0;"><i class="glyphicon glyphicon-trash"></i> <?php echo $text_reset_to_default_values; ?></a><div class="clearfix"></div>')
			.append( cnt );
	},
	
	createScrollbox: function( type, name, items, key, values ) {
		var self	= this,
			cnt		= jQuery('<div class="scrollbox">'),
			k = 0, i;
			
		if( ! jQuery.isArray( values ) )
			values = [ values ];
			
		for( i in items ) {
			if( typeof items[i] == 'function' ) continue;
			
			var $div = jQuery('<div>')
				.addClass( k % 2 ? 'odd' : 'even' );
				
			switch( type ) {
				case 'checkbox' : {					
					$div.append( self.createField( 'checkbox', name, items[i][key], {
						'id'		: 'layout_id-' + self._row,
						'checked'	: self.indexOf( values, items[i][key] ) > -1 ? true : false,
						'style'		: 'vertical-align: middle; margin: 0;'
					})).append( ' ' + items[i]['name'] );
					
					break;
				}
				case 'delete' : {
					$div.append( items[i] )
					$div.append( '<a class="btn btn-xs btn-danger pull-right"><i class="fa fa-remove"></i></a>' );
					$div.append( self.createField( 'hidden', name, i ) );
					
					break;
				}
			}
			
			cnt.append( $div );
				
			k++;
		}
		
		var $div = jQuery('<div>')
			.append( cnt );
		
		if( type == 'checkbox' ) {
			$div.append(jQuery('<a onclick="jQuery(this).parent().find(\':checkbox\').prop(\'checked\', true).trigger(\'change\');">')
				.text( '<?php echo $text_select_all; ?>' )
			)
			.append( ' / ' )
			.append(jQuery('<a onclick="jQuery(this).parent().find(\':checkbox\').prop(\'checked\', false).trigger(\'change\');">')
				.text( '<?php echo $text_unselect_all; ?>' )
			);
		}
			
		return $div;
	},
	

	indexOf: function( arr, val ) {
		for( var i in arr ) {
			if( typeof arr[i] == 'function' ) continue;
			
			if( arr[i] == val ) return i;
		}

		return -1;
	},
	

	createField: function( type, name, value, attribs ) {
		var self	= this,
			cnt;
			
		if( typeof value == 'undefined' )
			value = '';
		
		switch( type ) {
			case 'select' : {
				cnt = jQuery('<select>');
				
				for( var i in attribs['multiOptions'].items ) {
					if( typeof attribs['multiOptions'].items[i] == 'function' ) continue;
					
					var k = typeof attribs['multiOptions'].key != 'undefined' ? attribs['multiOptions'].items[i][attribs['multiOptions'].key] : i,
						l = typeof attribs['multiOptions'].label != 'undefined' ? attribs['multiOptions'].items[i][attribs['multiOptions'].label] : attribs['multiOptions'].items[i];
				
					cnt.append(jQuery('<option>')
						.attr('value', k)
						.attr('selected', k == value ? true : false)
						.text(l)
					);
				}
				
				delete attribs['multiOptions'];
				
				break;
			}
			default : {
				cnt = jQuery('<input>')
					.attr('type', type)
					.attr('value', value);
				
				break;
			}
		}
		
		if( name !== null )
			cnt.attr('name', self._name + '_module' + name);
		
		for( var i in attribs ) {
			if( typeof attribs[i] == 'function' ) continue;
			
			cnt.attr( i, attribs[i] );
		}
		
		return cnt;
	}
};

MFP._langs				= <?php echo json_encode( $languages ); ?>;
MFP._layouts			= <?php echo json_encode( $layouts ); ?>;
MFP._settings			= <?php echo json_encode( $settings ); ?>;
MFP._stores				= <?php echo json_encode( $stores ); ?>;

MFP.init( <?php echo json_encode( $modules ); ?> );
</script> 

<?php require DIR_TEMPLATE . 'module/' . $_name . '-footer.tpl'; ?>