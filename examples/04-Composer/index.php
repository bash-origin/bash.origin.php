<?php

require_once 'vendor/ccampbell/chromephp/ChromePhp.php';

ChromePhp::log('Hello console!');
ChromePhp::log($_SERVER);
ChromePhp::warn('something went wrong!');

echo("Hello World from PHP [" . $_GET["rid"] . "]!");
