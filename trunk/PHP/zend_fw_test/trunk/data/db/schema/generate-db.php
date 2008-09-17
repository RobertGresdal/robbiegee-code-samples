<?php
/**
 * Script for creating and loading database
 */

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