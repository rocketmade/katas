#!/usr/bin/env php
<?php
	/*	Fibonacci Solution 	**
	**	by Bradyn Poulsen 	**
	**						**
	**	January 31, 2014	**
	**
	**	Usage: ./fibonacci.php [--test] <n> [<n....>]
	**		--test Test using all passed values (strings use the ASCII value of the first character)
	*/

	function get_fibonacci($n){
		$prev = 0;
		$curr = 1;
		for($i = 0;$i < $n;$i++):
			$old_prev = $prev;
			$prev = $curr;
			$curr = $old_prev + $prev;
		endfor;
		return $curr;
	}

	if($argv[1] == "--test"):
		$test_on = array(0,1,2,3,4,5,10,30,50,100);
		if($argv[2]):
			$test_on = $argv;
			unset($test_on[0], $test_on[1]);
		endif;

		$start = microtime();
		foreach($test_on as $value):
			echo 'Fibonacci '.number_format($value).': '.number_format(get_fibonacci($value)).PHP_EOL;
		endforeach;
		echo 'Tested '.sizeof($test_on).' values in '.number_format(microtime() - $start,5).' seconds'.PHP_EOL;
	elseif(is_numeric($argv[1])):
		echo get_fibonacci($argv[1]).PHP_EOL;
	else:
		echo 'Nothing to do.'.PHP_EOL;
	endif;
?>