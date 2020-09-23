<?php
var_dump($_POST);
file_put_contents(__DIR__.'/log.txt', var_export($_POST, true));