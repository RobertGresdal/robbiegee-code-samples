<?php
/**
 * Script for creating and loading database
 */

// use bootstrap (contains prepared db adapter and prepared table 
// component)
// @todo move this zend loading to the bootstrap.php file
set_include_path(dirname(__FILE__) . '/../../../library' . PATH_SEPARATOR . get_include_path());
require_once 'Zend/Loader.php';
Zend_Loader::registerAutoload();


include_once dirname(__FILE__) . '/../../../application/bootstrap.php';

echo 'Generating models from schemas'.PHP_EOL;
try {
    Doctrine::generateModelsFromYaml('user.yml', APPLICATION_PATH.'/models');
    Doctrine::createTablesFromArray(array('User'));
} catch( Exception $e) {
    echo 'AN ERROR HAS OCCURED:'.PHP_EOL;
    echo $e->getMessage().PHP_EOL;
    return false;
}

// Generally speaking, this script will be run from the command line
return true;