<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">

      <h1><?php echo "Geo rules"; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo "Geo rule"; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-exchange"></i> <?php echo "Geo rules"; ?></h3>
      </div>
      <div class="panel-body">
  <?php
    $old_log_level = error_reporting(0);
    include_once $_SERVER['DOCUMENT_ROOT']."/geo/add_rule.php";
    error_reporting($old_log_level);
  ?>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>