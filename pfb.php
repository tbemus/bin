#!/usr/local/bin/php-cgi -f
<?php
require_once("globals.inc");
require_once("filter.inc");
require_once("util.inc");
require_once("config.inc");

global $config;

if (count($argv) == 1) exit;
$arg1 = $argv[1];

$config = parse_config(true);
foreach ($config[filter][rule] as &$value) {
    if (strpos(strtolower($value[descr]), 'pfb_') !== false) {
        if (strpos(strtolower($arg1), 'disable') !== false) {
            $value[disabled] = true;
        }
        if (strpos(strtolower($arg1), 'enable') !== false) {
            unset($value[disabled]);
        }
    }
}
write_config();
$retval |= filter_configure();
?>
