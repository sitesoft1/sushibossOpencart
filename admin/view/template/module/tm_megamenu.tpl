<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-tm_category_menu" data-toggle="tooltip"
                        title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i>
                </button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a>
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
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($error_name) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_name; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($error_columns) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_columns; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($error_columns_per_row) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_columns_per_row; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($error_image_size) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_image_size; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data"
                      id="form-tm_category_menu" class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>

                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?php echo $name; ?>"
                                   placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="input-status"><?php echo $entry_status; ?></label>

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
                        <div id="menu-items">
                            <?php $items_count = 0;
                            if (($menu_item)) { ?>
                                <?php for ($i = 0; $i < sizeof($menu_item); $i++) { ?>
                                    <div class="panel panel-default menu-item_<?php echo $items_count; ?>">
                                        <div class="panel-heading" role="tab" id="heading<?php echo $i; ?>">
                                            <h4 class="panel-title">
                                                <a style="display: inline-block" class="well-sm" role="button"
                                                   data-toggle="collapse" data-parent="#accordion"
                                                   href="#collapse<?php echo $i; ?>" aria-expanded="true"
                                                   aria-controls="collapse<?php echo $i; ?>">
                                                    <?php echo $text_menu_item . ($i + 1); ?>
                                                </a>

                                                <button id="remove-<?php echo $i ?>" type="button"
                                                        data-toggle="tooltip"
                                                        title="<?php echo $text_remove_item; ?>"
                                                        class="btn btn-danger pull-right"><i
                                                        class="fa fa-minus-circle"></i></button>

                                                <div class="clearfix "></div>
                                            </h4>
                                        </div>
                                        <div id="collapse<?php echo $i; ?>" class="panel-collapse collapse"
                                             role="tabpanel"
                                             aria-labelledby="heading<?php echo $i ?>">
                                            <div class="panel-body">

                                                <div class="form-group required">
                                                    <label class="col-sm-2 control-label"
                                                           for="input-menu-item-type_<?php echo $i; ?>"><?php echo $entry_menu_item_type; ?></label>

                                                    <div class="col-sm-10">
                                                        <select name="menu_item[<?php echo $i; ?>][type]"
                                                                id="input-menu-item-type_<?php echo $i; ?>"
                                                                class="form-control">
                                                            <?php if ($menu_item[$i]['type']) { ?>
                                                                <option value="1"
                                                                        selected="selected"><?php echo $text_type_custom; ?></option>
                                                                <option
                                                                    value="0"><?php echo $text_type_category; ?></option>
                                                            <?php } else { ?>
                                                                <option
                                                                    value="1"><?php echo $text_type_custom; ?></option>
                                                                <option value="0"
                                                                        selected="selected"><?php echo $text_type_category; ?></option>
                                                            <?php } ?>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div id="custom-<?php echo $i; ?>">


                                                    <div class="tab-pane">
                                                        <div class="row">
                                                            <div class="col-sm-10 col-sm-offset-2">
                                                                <ul class="nav nav-tabs" id="language">
                                                                    <?php foreach ($languages as $language) { ?>
                                                                        <li>
                                                                            <a href="#language<?php echo $i . $language['language_id']; ?>"
                                                                               data-toggle="tab"><img
                                                                                    src="view/image/flags/<?php echo $language['image']; ?>"
                                                                                    title="<?php echo $language['name']; ?>"/> <?php echo $language['name']; ?>
                                                                            </a>
                                                                        </li>
                                                                    <?php } ?>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="tab-content">
                                                            <?php foreach ($languages as $language) { ?>
                                                                <div class="tab-pane"
                                                                     id="language<?php echo $i . $language['language_id']; ?>">
                                                                    <div class="form-group required">
                                                                        <label class="col-sm-2 control-label"
                                                                               for="input-description<?php echo $i . $language['language_id']; ?>"><?php echo $entry_menu_title; ?></label>

                                                                        <div class="col-sm-10">
                                            <input
                                                name="menu_item[<?php echo $i; ?>][<?php echo $language['language_id']; ?>][title]"
                                                placeholder="<?php echo $entry_menu_title; ?>"
                                                id="input-description<?php echo $i . $language['language_id']; ?>"
                                                class="form-control"
                                                value="<?php echo isset($menu_item[$i][$language['language_id']]['title']) ? $menu_item[$i][$language['language_id']]['title'] : ''; ?>"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            <?php } ?>
                                                        </div>

                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label"
                                                               for="input-menu-link_<?php echo $i; ?>"><?php echo $entry_menu_link; ?></label>

                                                        <div class="col-sm-10">
                                                            <input type="text" name="menu_item[<?php echo $i; ?>][link]"
                                                                   value="<?php if (isset($menu_item[$i]['link'])) {
                                                                       echo $menu_item[$i]['link'];
                                                                   } else {
                                                                       echo '';
                                                                   } ?>"
                                                                   placeholder="<?php echo $entry_menu_link; ?>"
                                                                   id="input-menu-link_<?php echo $i; ?>"
                                                                   class="form-control"/>

                                                        </div>
                                                    </div>


                                                    <div class="form-group required">
                                                        <label class="col-sm-2 control-label"
                                                               for="input-menu-item-submenu-show_<?php echo $i; ?>"><?php echo $entry_menu_item_submenu_show; ?></label>

                                                        <div class="col-sm-10">
                                                            <select name="menu_item[<?php echo $i; ?>][submenu_show]"
                                                                    id="input-menu-item-submenu-show_<?php echo $i; ?>"
                                                                    class="form-control">
                                                                <?php if ($menu_item[$i]['submenu_show']) { ?>
                                                                    <option value="1"
                                                                            selected="selected"><?php echo $text_yes; ?></option>
                                                                    <option
                                                                        value="0"><?php echo $text_no; ?></option>
                                                                <?php } else { ?>
                                                                    <option
                                                                        value="1"><?php echo $text_yes; ?></option>
                                                                    <option value="0"
                                                                            selected="selected"><?php echo $text_no; ?></option>
                                                                <?php } ?>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="category-<?php echo $i; ?>">
                                                    <div class="form-group required">
                                                        <label class="col-sm-2 control-label"
                                                               for="input-menu-item-submenu-type_<?php echo $i; ?>"><?php echo $entry_menu_item_submenu_type; ?></label>

                                                        <div class="col-sm-10">
                                                            <select name="menu_item[<?php echo $i; ?>][submenu_type]"
                                                                    id="input-menu-item-submenu-type_<?php echo $i; ?>"
                                                                    class="form-control">
                                                                <?php if ($menu_item[$i]['submenu_type']) { ?>
                                                                    <option value="1"
                                                                            selected="selected"><?php echo $text_type_megamenu; ?></option>
                                                                    <option
                                                                        value="0"><?php echo $text_type_multilevel; ?></option>
                                                                <?php } else { ?>
                                                                    <option
                                                                        value="1"><?php echo $text_type_megamenu; ?></option>
                                                                    <option value="0"
                                                                            selected="selected"><?php echo $text_type_multilevel; ?></option>
                                                                <?php } ?>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="megamenu-<?php echo $i ?>">
                                                    <div class="form-group required">
                                                        <label class="col-sm-2 control-label"
                                                               for="input-menu-item-columns_<?php echo $i; ?>"><?php echo $entry_columns; ?></label>

                                                        <div class="col-sm-10">
                                                            <input type="text"
                                                                   name="menu_item[<?php echo $i; ?>][columns]"
                                                                   value="<?php echo $menu_item[$i]['columns']; ?>"
                                                                   placeholder="<?php echo $entry_columns; ?>"
                                                                   id="input-menu-item-columns_<?php echo $i; ?>"
                                                                   class="form-control"/>
                                                        </div>
                                                    </div>

                                                    <div class="form-group required">
                                                        <label class="col-sm-2 control-label"
                                                               for="input-menu-item-columns-per-row_<?php echo $i; ?>"><?php echo $entry_columns_per_row; ?></label>

                                                        <div class="col-sm-10">
                                                            <input type="text"
                                                                   name="menu_item[<?php echo $i; ?>][columns-per-row]"
                                                                   value="<?php echo $menu_item[$i]['columns-per-row']; ?>"
                                                                   placeholder="<?php echo $entry_columns_per_row; ?>"
                                                                   id="input-menu-item-columns-per-row_<?php echo $i; ?>"
                                                                   class="form-control"/>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="input-image_<?php echo $i; ?>"><?php echo $entry_background_image; ?></label>

                                                        <div class="col-sm-10">
                                                            <a href="" id="thumb-image<?php echo $i; ?>" data-toggle="image" class="img-thumbnail"><img
                                                                    src="<?php if ($menu_item[$i]['image']) { echo $image_thumb[$i]; } else { echo $placeholder; } ?>" alt="" title=""
                                                                    data-placeholder="<?php echo $placeholder; ?>"/></a>
                                                            <input class="form-control" type="hidden" name="menu_item[<?php echo $i; ?>][image]"
                                                                   value="<?php echo (isset($menu_item[$i]['image'])) ? $menu_item[$i]['image'] : ''; ?>" id="input-image_<?php echo $i; ?>">
                                                        </div>
                                                    </div>

                                                    <div id="image-<?php echo $i ?>" style="display: none;">
                                                        <div class="form-group required">
                                                            <label class="col-sm-2 control-label" for="input-menu-item-background-width_<?php echo $i; ?>"><?php echo $entry_background_image_width; ?></label>

                                                            <div class="col-sm-10">
                                                                <input type="text" name="menu_item[<?php echo $i; ?>][image_width]" value="<?php echo (isset($menu_item[$i]['image_width'])) ? $menu_item[$i]['image_width'] : ''; ?>"
                                                                       placeholder="<?php echo $entry_background_image_width; ?>" id="input-menu-item-background-width_<?php echo $i; ?>" class="form-control"/>
                                                            </div>
                                                        </div>


                                                        <div class="form-group required">
                                                            <label class="col-sm-2 control-label"
                                                                   for="input-menu-item-background-height_<?php echo $i; ?>"><?php echo $entry_background_image_height; ?></label>

                                                            <div class="col-sm-10">
                                                                <input type="text" name="menu_item[<?php echo $i; ?>][image_height]" value="<?php echo (isset($menu_item[$i]['image_height'])) ? $menu_item[$i]['image_height'] : ''; ?>"
                                                                       placeholder="<?php echo $entry_background_image_height; ?>" id="input-menu-item-background-height_<?php echo $i; ?>"
                                                                       class="form-control"/>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="megamenu-columns-<?php echo $i ?>">

                                                            <!-- Nav tabs -->
                                                            <ul class="nav nav-tabs" role="tablist">
                                                                <?php if (isset($menu_item[$i]['column'])) { ?>
                                                                <?php for ($j = 0; $j < sizeof($menu_item[$i]['column']); $j++) { ?>
                                                                    <li>
                                                                        <a href="#column<?php echo $i . $j ?>"
                                                                           role="tab"
                                                                           data-toggle="tab"><?php echo $text_column . ' ' . ($j + 1) ?></a>
                                                                    </li>
                                                                <?php } ?>
                                                                <?php } ?>
                                                            </ul>

                                                            <!-- Tab panes -->
                                                            <div class="tab-content">
                                                                <?php if (isset($menu_item[$i]['column'])) { ?>
                                                                <?php for ($j = 0; $j < sizeof($menu_item[$i]['column']); $j++) { ?>
                                                                    <div role="tabpanel" class="tab-pane"
                                                                         id="column<?php echo $i . $j ?>">
                                                                        <div class="form-group required">
                                                                            <label class="col-sm-2 control-label"
                                                                                   for="input-menu-item-column_<?php echo $i . $j ?>"><?php echo $entry_column_width; ?></label>

                                                                            <div class="col-sm-10">
                                                                                <input type="text"
                                                                                       name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][width]"
                                                                                       value="<?php echo $menu_item[$i]['column'][$j]['width']; ?>"
                                                                                       placeholder="<?php echo $entry_column_width; ?>"
                                                                                       id="input-menu-item-column_<?php echo $i . $j ?>"
                                                                                       class="form-control"/>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group required">
                                                                            <label class="col-sm-2 control-label"
                                                                                   for="input-menu-item-column-content_<?php echo $i . $j; ?>"><?php echo $entry_menu_item_column_content; ?></label>

                                                                            <div class="col-sm-10">
                                                                                <select
                                                                                    name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][content]"
                                                                                    id="input-menu-item-column-content_<?php echo $i . $j; ?>"
                                                                                    class="form-control">
                                                                                    <?php switch ($menu_item[$i]['column'][$j]['content']) {
                                                                                        case 4: ?>
                                                                                            <option value="4"
                                                                                                    selected="selected"><?php echo $text_type_products; ?></option>
                                                                                            <option value="3"
                                                                                                ><?php echo $text_type_sub_with_sub; ?></option>
                                                                                            <option
                                                                                                value="2"><?php echo $text_type_sub_with_prod; ?></option>
                                                                                            <option
                                                                                                value="1"><?php echo $text_type_subcategories; ?></option>
                                                                                            <option
                                                                                                value="0"><?php echo $text_type_module; ?></option>
                                                                                            <?php break;
                                                                                        case 3: ?>
                                                                                            <option
                                                                                                value="4"><?php echo $text_type_products; ?></option>
                                                                                            <option value="3"
                                                                                                    selected="selected"><?php echo $text_type_sub_with_sub; ?></option>
                                                                                            <option
                                                                                                value="2"><?php echo $text_type_sub_with_prod; ?></option>
                                                                                            <option
                                                                                                value="1"><?php echo $text_type_subcategories; ?></option>
                                                                                            <option
                                                                                                value="0"><?php echo $text_type_module; ?></option>
                                                                                            <?php break;
                                                                                        case 2: ?>
                                                                                            <option
                                                                                                value="4"><?php echo $text_type_products; ?></option>
                                                                                            <option
                                                                                                value="3"><?php echo $text_type_sub_with_sub; ?></option>
                                                                                            <option
                                                                                                value="2"
                                                                                                selected="selected"><?php echo $text_type_sub_with_prod; ?></option>
                                                                                            <option
                                                                                                value="1"><?php echo $text_type_subcategories; ?></option>
                                                                                            <option
                                                                                                value="0"><?php echo $text_type_module; ?></option>
                                                                                            <?php break;
                                                                                        case 1: ?>
                                                                                            <option
                                                                                                value="4"><?php echo $text_type_products; ?></option>
                                                                                            <option
                                                                                                value="3"><?php echo $text_type_sub_with_sub; ?></option>
                                                                                            <option
                                                                                                value="2"><?php echo $text_type_sub_with_prod; ?></option>
                                                                                            <option
                                                                                                value="1"
                                                                                                selected="selected"><?php echo $text_type_subcategories; ?></option>
                                                                                            <option
                                                                                                value="0"><?php echo $text_type_module; ?></option>
                                                                                            <?php break;
                                                                                        case 0: ?>
                                                                                            <option
                                                                                                value="4"><?php echo $text_type_products; ?></option>
                                                                                            <option
                                                                                                value="3"><?php echo $text_type_sub_with_sub; ?></option>
                                                                                            <option
                                                                                                value="2"><?php echo $text_type_sub_with_prod; ?></option>
                                                                                            <option
                                                                                                value="1"><?php echo $text_type_subcategories; ?></option>
                                                                                            <option
                                                                                                value="0"
                                                                                                selected="selected"><?php echo $text_type_module; ?></option>
                                                                                            <?php break;
                                                                                    } ?>
                                                                                </select>
                                                                            </div>
                                                                        </div>

                                                                        <div id="subcategory_<?php echo $i . $j ?>">
                                                                            <div class="form-group required">
                                                                                <label class="col-sm-2 control-label"
                                                                                       for="input-menu-item-list-limit_<?php echo $i . $j ?>"><?php echo $entry_list_limit; ?></label>

                                                                                <div class="col-sm-10">
                                                                                    <input type="text"
                                                                                           name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][limit]"
                                                                                           value="<?php echo $menu_item[$i]['column'][$j]['limit']; ?>"
                                                                                           placeholder="<?php echo $entry_list_limit; ?>"
                                                                                           id="input-menu-item-list-limit_<?php echo $i . $j ?>"
                                                                                           class="form-control"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div id="product_<?php echo $i . $j ?>">
                                                                            <div class="form-group required">
                                                                                <label class="col-sm-2 control-label"
                                                                                       for="input-menu-item-product-limit_<?php echo $i . $j ?>"><?php echo $entry_product_limit; ?></label>

                                                                                <div class="col-sm-10">
                                                                                    <input type="text"
                                                                                           name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][prod_limit]"
                                                                                           value="<?php echo $menu_item[$i]['column'][$j]['prod_limit']; ?>"
                                                                                           placeholder="<?php echo $entry_product_limit; ?>"
                                                                                           id="input-menu-item-product-limit_<?php echo $i . $j ?>"
                                                                                           class="form-control"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div id="module_<?php echo $i . $j ?>">
                                                                            <div class="form-group required">
                                                                                <label class="col-sm-2 control-label"
                                                                                       for="input-module_<?php echo $i . $j; ?>"><?php echo $entry_module; ?></label>

                                                                                <div class="col-sm-10">
                                                                                    <select
                                                                                        name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][module_id]"
                                                                                        id="input-module_<?php echo $i . $j; ?>"
                                                                                        class="form-control">
                                                                                        <?php foreach ($modules as $module) { ?>
                                                                                            <?php if ($module['module_id'] == $menu_item[$i]['column'][$j]['module_id']) { ?>
                                                                                                <option
                                                                                                    value="<?php echo $module['module_id']; ?>"
                                                                                                    selected="selected"><?php echo $module['name']; ?></option>
                                                                                            <?php } else { ?>
                                                                                                <option
                                                                                                    value="<?php echo $module['module_id']; ?>"><?php echo $module['name']; ?></option>
                                                                                            <?php } ?>
                                                                                        <?php } ?>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div id="categories_<?php echo $i . $j ?>">
                                                                            <div class="form-group required">
                                                                                <label class="col-sm-2 control-label"
                                                                                       for="input-category_<?php echo $i . $j; ?>"><?php echo $entry_category; ?></label>

                                                                                <div class="col-sm-10">
                                                                                    <select
                                                                                        name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][category_id]"
                                                                                        id="input-category_<?php echo $i . $j; ?>"
                                                                                        class="form-control">
                                                                                        <?php foreach ($categories as $category) { ?>
                                                                                            <?php if ($category['category_id'] == $menu_item[$i]['column'][$j]['category_id']) { ?>
                                                                                                <option
                                                                                                    value="<?php echo $category['category_id']; ?>"
                                                                                                    selected="selected"><?php echo $category['name']; ?></option>
                                                                                            <?php } else { ?>
                                                                                                <option
                                                                                                    value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                                                                                            <?php } ?>
                                                                                        <?php } ?>
                                                                                    </select>
                                                                                </div>
                                                                            </div>

                                                                            <div class="form-group required">
                                                                                <label class="col-sm-2 control-label"
                                                                                       for="input-menu-item-category-show_<?php echo $i . $j; ?>"><?php echo $entry_menu_item_category_name_show; ?></label>

                                                                                <div class="col-sm-10">
                                                                                    <select
                                                                                        name="menu_item[<?php echo $i; ?>][column][<?php echo $j; ?>][category_show]"
                                                                                        id="input-menu-item-category-show_<?php echo $i . $j; ?>"
                                                                                        class="form-control">
                                                                                        <?php if ($menu_item[$i]['column'][$j]['category_show']) { ?>
                                                                                            <option value="1"
                                                                                                    selected="selected"><?php echo $text_yes; ?></option>
                                                                                            <option
                                                                                                value="0"><?php echo $text_no; ?></option>
                                                                                        <?php } else { ?>
                                                                                            <option
                                                                                                value="1"><?php echo $text_yes; ?></option>
                                                                                            <option value="0"
                                                                                                    selected="selected"><?php echo $text_no; ?></option>
                                                                                        <?php } ?>
                                                                                    </select>
                                                                                </div>
                                                                            </div>


                                                                        </div>


                                                                    </div>


                                                                <?php } ?>
                                                                <?php } ?>
                                                            </div>


                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <?php $items_count++; ?>
                                <?php } ?>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="text-right">
                        <button id="btn-add" type="button" data-toggle="tooltip"
                                title="<?php echo $text_add_item; ?>" class="btn btn-primary"><i
                                class="fa fa-plus-circle"></i></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript">
    var items_count =<?php echo $items_count; ?>;
    ;
    (function ($) {
        $('body').delegate('[id*="input-menu-item-submenu-type"],[id*="input-menu-item-type"],[id*="input-menu-item-submenu-show"]', 'change', function () {
            megamenuToggle($(this));
        });

        $('body').delegate('[id*="input-menu-item-type"]', 'change', function () {
            menuTypeToggle($(this));
        });

        $('body').delegate('[id*="input-menu-item-columns_"]', 'change', function () {
            columnGenerate($(this));
        });

        $('body').delegate('[id*="input-menu-item-column-content"]', 'change', function () {
            contentShow($(this));
        });

        $('body').delegate('[id*="input-image_"]', 'change', function () {
            imageShow($(this));
        });

        $('body').delegate('.thumbnail,#button-clear', 'click', function () {
            $('[id*="input-image_"]').trigger('change');
        })

        $('body').delegate('[id*="remove-"]', 'click', function () {
            var index = $(this).attr('id').split('-');
            removeItem(index[1]);
        });


        $(document).ready(function () {
            $('#btn-add').click(function () {
                addItem();
            });
            $('[id*="input-menu-item-column-content"]').each(function () {
                contentShow($(this));
            });
            $('[id*="input-menu-item-type"]').each(function () {
                menuTypeToggle($(this));
                megamenuToggle($(this));
            });
            $('[id*="megamenu-columns-"]').each(function () {
                $(this).find('.nav a:first').tab('show');
            });
            $('[id*="input-image_"]').each(function () {
                imageShow($(this));
            });
            $('[id*="custom-"]').each(function () {
                $(this).find('.nav a:first').tab('show');
            });
        });

        function menuTypeToggle(el) {
            var index = el.attr('id').split('_');

            if (el.val() == 1) {
                $('#custom-' + index[1]).css('display', 'block');
                $('#category-' + index[1]).css('display', 'none');
                $('#custom-' + index[1] + ' .nav a:first').tab('show');
            } else {
                $('#custom-' + index[1]).css('display', 'none');
                $('#category-' + index[1]).css('display', 'block');
            }
        }
        function imageShow(el) {
            var index = el.attr('id').split('_');

            if (el.val().length) {
                $('#image-' + index[1]).css('display', 'block');
            } else {
                $('#image-' + index[1]).css('display', 'none');
            }
        }

        function contentShow(el) {
            var doubleIndex = el.attr('id').split('_'),
                index = el.parents('[class*="menu-item"]').attr('class').split('_'),
                module = $('#module_' + doubleIndex[1]),
                category = $('#categories_' + doubleIndex[1]),
                subcategory = $('#subcategory_' + doubleIndex[1]),
                product = $('#product_' + doubleIndex[1]),
                type = $('#input-menu-item-type_' + index[1]).val();
            if (type == 1) {
                category.css('display', 'block');
            } else {
                category.css('display', 'none');
            }

            if (el.val() == 0) {
                module.css('display', 'block');
                category.css('display', 'none');
                product.css('display', 'none');
                subcategory.css('display', 'none');
            } else if (el.val() == 4 || el.val() == 2) {
                module.css('display', 'none');
                subcategory.css('display', 'none');
                product.css('display', 'block');
            } else if (el.val() == 1 || el.val() == 3) {
                module.css('display', 'none');
                subcategory.css('display', 'block');
                product.css('display', 'none');
            }
        }


        function megamenuToggle(el) {
            var index = el.attr('id').split('_'),
                inputType = $('#input-menu-item-type_' + index[1]),
                inputSubmenuType = $('#input-menu-item-submenu-type_' + index[1]),
                inputSubmenuShow = $('#input-menu-item-submenu-show_' + index[1]);

            if ((inputType.val() == 0 && inputSubmenuType.val() == 1) || (inputType.val() == 1 && inputSubmenuShow.val() == 1)) {
                $('#megamenu-' + index[1]).css('display', 'block');
            } else {
                $('#megamenu-' + index[1]).css('display', 'none');

            }
        }

        function columnGenerate(el) {
            var index = el.attr('id').split('_');

            index = index[1];
            if (el.val() > 0 && el.val() < 12) {
                var wrap = $('#megamenu-columns-' + index),
                    column_count = wrap.find('.nav li').length,
                    html_nav_title = '',
                    html_content = '';
                if (column_count < el.val()) {
                    while (column_count < el.val()) {
                        html_nav_title = '';
                        html_content = '';
                        html_nav_title += ' <li>';
                        html_nav_title += '<a href="#column' + index + (column_count + 1) + '" role="tab" data-toggle="tab"><?php echo $text_column; ?>' + (column_count + 1) + '</a>';
                        html_nav_title += ' </li>';
                        html_content += '<div role="tabpanel" class="tab-pane" id="column' + index + (column_count + 1) + '">';
                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-menu-item-column_' + index + (column_count) + '"><?php echo $entry_column_width; ?></label>';
                        html_content += '<div class="col-sm-10">';
                        html_content += '<input type="text" name="menu_item[' + index + '][column][' + (column_count) + '][width]" value="0" placeholder="<?php echo $entry_column_width; ?>" id="input-menu-item-column_' + index + (column_count + 1) + '" class="form-control"/>';
                        html_content += '</div>';
                        html_content += '</div>';

                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-menu-item-column-content_' + index + column_count + '"><?php echo $entry_menu_item_column_content; ?></label>';
                        html_content += '<div class="col-sm-10">';
                        html_content += '<select name="menu_item[' + index + '][column][' + column_count + '][content]" id="input-menu-item-column-content_' + index + column_count + '" class="form-control">';
                        html_content += '<option value="4" selected="selected"><?php echo $text_type_products; ?></option>';
                        html_content += '<option value="3"><?php echo $text_type_sub_with_sub; ?></option>';
                        html_content += '<option value="2"><?php echo $text_type_sub_with_prod; ?></option>';
                        html_content += '<option value="1"><?php echo $text_type_subcategories; ?></option>';
                        html_content += '<option value="0"><?php echo $text_type_module; ?></option>';
                        html_content += '</select>';
                        html_content += '</div>';
                        html_content += '</div>';

                        html_content += '<div id="subcategory_' + index + column_count + '">';
                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-menu-item-list-limit_' + index + column_count + '"><?php echo $entry_list_limit; ?></label>';
                        html_content += '<div class="col-sm-10">';
                        html_content += '<input type="text" name="menu_item[' + index + '][column][' + column_count + '][limit]" value="0" placeholder="<?php echo $entry_list_limit; ?>" id="input-menu-item-list-limit_' + index + column_count + '" class="form-control"/>';
                        html_content += '</div>';
                        html_content += '</div>';
                        html_content += '</div>';

                        html_content += '<div id="product_' + index + column_count + '">';
                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-menu-item-product-limit_' + index + column_count + '"><?php echo $entry_product_limit; ?></label>';
                        html_content += '<div class="col-sm-10">';
                        html_content += '<input type="text" name="menu_item[' + index + '][column][' + column_count + '][prod_limit]" value="0" placeholder="<?php echo $entry_product_limit; ?>" id="input-menu-item-product-limit_' + index + column_count + '" class="form-control"/>';
                        html_content += '</div>';
                        html_content += '</div>';
                        html_content += '</div>';


                        html_content += '<div id="module_' + index + column_count + '" style="display:none">';
                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-module_' + index + '"><?php echo $entry_module; ?></label>';
                        html_content += '	<div class="col-sm-10">';
                        html_content += '<select name="menu_item[' + index + '][column][' + (column_count) + '][module_id]"  id="input-module_' + index + '" class="form-control">';
                        html_content += '  <option value="" selected="selected"><?php echo $text_none; ?></option>';
                        <?php foreach ($modules as $module) { ?>
                        html_content += '<option value="<?php echo $module['module_id']; ?>"><?php echo $module['name']; ?></option>';
                        <?php } ?>
                        html_content += '</select>';
                        html_content += '	</div>';
                        html_content += '</div>';
                        html_content += '</div>';

                        html_content += '<div id="categories_' + index + column_count + '">';

                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-category_' + index + column_count + '"><?php echo $entry_category; ?></label>';
                        html_content += '	<div class="col-sm-10">';
                        html_content += '<select name="menu_item[' + index + '][column][' + column_count + '][category_id]" id="input-category_' + index + column_count + '" class="form-control">';
                        html_content += '  <option value="" selected="selected"><?php echo $text_none; ?></option>';
                        <?php foreach ($categories as $category) { ?>
                        html_content += '<option value="<?php echo $category['category_id']; ?>"><?php echo htmlspecialchars($category['name'], ENT_QUOTES); ?></option>';
                        <?php } ?>
                        html_content += '</select>';
                        html_content += '	</div>';
                        html_content += '</div>';

                        html_content += '<div class="form-group required">';
                        html_content += '<label class="col-sm-2 control-label" for="input-menu-item-category-show_' + index + column_count + '"><?php echo $entry_menu_item_category_name_show; ?></label>';
                        html_content += '	<div class="col-sm-10">';
                        html_content += '<select name="menu_item[' + index + '][column][' + column_count + '][category_show]" id="input-menu-item-category-show_' + index + column_count + '" class="form-control">';
                        html_content += '<option value="1"><?php echo $text_yes; ?></option>';
                        html_content += '<option value="0" selected="selected"><?php echo $text_no; ?></option>';
                        html_content += '</select>';
                        html_content += '	</div>';
                        html_content += '</div>';


                        html_content += '</div>';


                        wrap.find('.nav').append(html_nav_title);
                        wrap.find('.tab-content').append(html_content);
                        if (wrap.find('.nav .active').length == 0) {
                            wrap.find('.nav').find('a:first').tab('show');
                        }
                        contentShow(wrap.find('#input-menu-item-column-content_' + index + column_count));
                        column_count++;
                    }
                } else {
                    var remove_count = column_count - el.val();
                    for (var i = 0; i < remove_count; i++) {
                        wrap.find('.nav li').last().remove();
                        wrap.find('.tab-content .tab-pane').last().remove();
                        column_count--;
                    }
                }


            }
        }

        function addItem() {
            html = '<div class="panel panel-default menu-item_' + items_count + '">';

            html += '<div class="panel-heading" role="tab" id="heading' + items_count + '">';
            html += '<h4 class="panel-title">';
            html += '<a style="display: inline-block" class="well-sm" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse' + items_count + '" aria-expanded="true" aria-controls="collapse' + items_count + '"><?php echo $text_menu_item ?> ' + (items_count + 1) + '</a>';
            html += '<button id="remove-' + items_count + '" type="button" data-toggle="tooltip" title="<?php echo $text_remove_item; ?>" class="btn btn-danger pull-right"><i class="fa fa-minus-circle"></i></button>';
            html += '</h4>';

            html += '</div>';


            html += '<div id="collapse' + items_count + '" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading' + items_count + '">';
            html += '<div class="panel-body">';
            html += '<div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-menu-item-type_' + items_count + '"><?php echo $entry_menu_item_type; ?></label>';
            html += '<div class="col-sm-10">';
            html += ' <select name="menu_item[' + items_count + '][type]" id="input-menu-item-type_' + items_count + '" class="form-control">';
            html += '<option value="1"><?php echo $text_type_custom; ?></option>';
            html += '<option value="0" selected="selected"><?php echo $text_type_category; ?></option>';
            html += '</select>';
            html += '</div>';
            html += '</div>';


            html += '<div id="custom-' + items_count + '">';

            html += '<div class="tab-pane">';
            html += '<div class="row">';
            html += '<div class="col-sm-10 col-sm-offset-2">';
            html += '<ul class="nav nav-tabs" id="language">';
            <?php foreach ($languages as $language) { ?>
            html += '<li>';
            html += '<a href="#language' + items_count + '<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/> <?php echo $language['name']; ?> </a>';
            html += '</li>';
            <?php } ?>
            html += '</ul>';
            html += '</div>';
            html += '</div>';
            html += '<div class="tab-content">';
            <?php foreach ($languages as $language) { ?>
            html += '<div class="tab-pane" id="language' + items_count + '<?php echo $language['language_id']; ?>">';
            html += '<div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-description' + items_count + '<?php echo $language['language_id']; ?>"><?php echo $entry_menu_title; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<input name="menu_item[' + items_count + '][<?php echo $language['language_id']; ?>][title]"  placeholder="<?php echo $entry_menu_title; ?>" id="input-description' + items_count + '<?php echo $language['language_id']; ?>" class="form-control" value="" />';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            <?php } ?>
            html += '</div>';
            html += '</div>';

            html += '<div class="form-group">';
            html += '<label class="col-sm-2 control-label" for="input-menu-link_"><?php echo $entry_menu_link; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<input type="text" name="menu_item[' + items_count + '][link]" value="" placeholder="<?php echo $entry_menu_link; ?>" id="input-menu-link_" class="form-control"/>';
            html += '</div>';
            html += '</div>';

            html += '<div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-menu-item-submenu-show_' + items_count + '"><?php echo $entry_menu_item_submenu_show; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<select name="menu_item[' + items_count + '][submenu_show]" id="input-menu-item-submenu-show_' + items_count + '" class="form-control">';
            html += '<option value="1"><?php echo $text_yes; ?></option>';
            html += '<option value="0" selected="selected"><?php echo $text_no; ?></option>';
            html += '</select>';
            html += '</div>';
            html += '</div>';
            html += '</div>';


            html += '<div id="category-' + items_count + '">';
            html += '<div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-menu-item-submenu-type_' + items_count + '"><?php echo $entry_menu_item_submenu_type; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<select name="menu_item[' + items_count + '][submenu_type]" id="input-menu-item-submenu-type_' + items_count + '" class="form-control">';
            html += '<option value="1"><?php echo $text_type_megamenu; ?></option>';
            html += '<option value="0" selected="selected"><?php echo $text_type_multilevel; ?></option>';
            html += '</select>';
            html += '</div>';
            html += '</div>';
            html += '</div>';

            html += '<div id="megamenu-' + items_count + '">';
            html += ' <div class="form-group required">';
            html += ' <label class="col-sm-2 control-label" for="input-menu-item-columns_' + items_count + '"><?php echo $entry_columns; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<input type="text" name="menu_item[' + items_count + '][columns]" value="0" placeholder="<?php echo $entry_columns; ?>" id="input-menu-item-columns_' + items_count + '" class="form-control"/>';
            html += '</div>';
            html += '</div>';

            html += ' <div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-menu-item-columns-per-row_' + items_count + '"><?php echo $entry_columns_per_row; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<input type="text" name="menu_item[' + items_count + '][columns-per-row]" value="0" placeholder="<?php echo $entry_columns_per_row; ?>" id="input-menu-item-columns-per-row_' + items_count + '" class="form-control"/>';
            html += '</div>';
            html += '</div>';

            html += ' <div class="form-group">';
            html += '<label class="col-sm-2 control-label" for="input-image_' + items_count + '"><?php echo $entry_background_image; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<a href="" id="thumb-image' + items_count + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"/></a>';
            html += '<input class="form-control" type="hidden" name="menu_item[' + items_count + '][image]" value="" id="input-image_' + items_count + '">';
            html += '</div>';
            html += '</div>';

            html += '<div id="image-' + items_count + '" style="display:none">';
            html += ' <div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-menu-item-background-width_' + items_count + '"><?php echo $entry_background_image_width; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<input type="text" name="menu_item[' + items_count + '][image_width]" value="" placeholder="<?php echo $entry_background_image_width; ?>" id="input-menu-item-background-width_' + items_count + '" class="form-control"/>';
            html += '</div>';
            html += '</div>';

            html += ' <div class="form-group required">';
            html += '<label class="col-sm-2 control-label" for="input-menu-item-background-height_' + items_count + '"><?php echo $entry_background_image_height; ?></label>';
            html += '<div class="col-sm-10">';
            html += '<input type="text" name="menu_item[' + items_count + '][image_height]" value="" placeholder="<?php echo $entry_background_image_height; ?>" id="input-menu-item-background-height_' + items_count + '" class="form-control"/>';
            html += '</div>';
            html += '</div>';
				html += '</div>';


            html += '<div id="megamenu-columns-' + items_count + '">';
            html += '<ul class="nav nav-tabs" role="tablist">';
            html += '</ul>';
            html += '<div class="tab-content">';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            $('#menu-items').append(html);
            var type = $('#input-menu-item-type_' + items_count);
            megamenuToggle(type);
            menuTypeToggle(type);
            items_count++;
        }

        function removeItem(index) {
            var el = '.menu-item_' + index;
            $(el).remove();
            $('.tooltip').remove();
            items_count--;
        }


    })(jQuery)

</script>


