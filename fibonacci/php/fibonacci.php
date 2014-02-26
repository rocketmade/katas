<?php
	$_FIBONACCI = array(0,1);
	function fibonacci($n){
		global $_FIBONACCI;
		if(!isset($_FIBONACCI[$n])) $_FIBONACCI[$n] = fibonacci($n-1) + fibonacci($n-2);
		return $_FIBONACCI[$n];
	}
?>