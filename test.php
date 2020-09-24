<?php
class trick
{
      function doit()
      {
                echo __FUNCTION__;
      }
      function doitagain()
      {
                echo __METHOD__;
      }
}
$obj=new trick();
$obj->doit();
//$obj->doitagain();
