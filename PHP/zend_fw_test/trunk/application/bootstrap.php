<?php
// APPLICATION CONSTANTS - Set the constants to use in this application.
// These constants are accessible throughout the application, even in ini 
// files. We optionally set APPLICATION_PATH here in case our entry point 
// isn't index.php (e.g., if required from our test suite or a script).
defined('APPLICATION_PATH')
    or define('APPLICATION_PATH', dirname(__FILE__));

defined('APPLICATION_ENVIRONMENT')
    or define('APPLICATION_ENVIRONMENT', 'development');


// INCLUDE PATH - Add the "library" directory to the include_path, so 
// that PHP can find our Zend Framework classes.
set_include_path(
    APPLICATION_PATH . '/../library' 
    . PATH_SEPARATOR . get_include_path()
);

// AUTOLOADER - Set up autoloading.
// This is a nifty trick that allows ZF to load classes automatically so
// that you don't have to litter your code with 'include' or 'require'
// statements.
require_once "Zend/Loader.php";
Zend_Loader::registerAutoload();


// FRONT CONTROLLER - Get the front controller.
// The Zend_Front_Controller class implements the Singleton pattern, which is a
// design pattern used to ensure there is only one instance of
// Zend_Front_Controller created on each request.
$frontController = Zend_Controller_Front::getInstance();

// CONTROLLER DIRECTORY SETUP - Point the front controller to your action
// controller directory.
$frontController->setControllerDirectory(APPLICATION_PATH . '/controllers');

// APPLICATION ENVIRONMENT - Set the current environment.
// Set a variable in the front controller indicating the current environment --
// commonly one of development, staging, testing, production, but wholly
// dependent on your organization's and/or site's needs.
$frontController->setParam('env', APPLICATION_ENVIRONMENT);

// LAYOUT SETUP - Setup the layout component
// The Zend_Layout component implements a composite (or two-step-view) pattern
// With this call we are telling the component where to find the layouts scripts.
Zend_Layout::startMvc(APPLICATION_PATH . '/layouts/scripts');

// VIEW SETUP - Initialize properties of the view object
// The Zend_View component is used for rendering views. Here, we grab a "global" 
// view instance from the layout object, and specify the doctype we wish to 
// use. In this case, XHTML1 Strict.
$view = Zend_Layout::getMvcInstance()->getView();
$view->doctype('XHTML1_STRICT');

// CONFIGURATION - Setup the configuration object
// The Zend_Config_Ini component will parse the ini file, and resolve all of
// the values for the given section.  Here we will be using the section name
// that corresponds to the APP's Environment
$configuration = new Zend_Config_Ini(
    APPLICATION_PATH . '/config/app.ini', 
    APPLICATION_ENVIRONMENT
);

// DATABASE ADAPTER - Setup the database adapter
// Zend_Db implements a factory interface that allows developers to pass in an 
// adapter name and some parameters that will create an appropriate database 
// adapter object.  In this instance, we will be using the values found in the 
// "database" section of the configuration obj.
// @todo Remove Zend_Db? we're using Doctrine
$dbAdapter = Zend_Db::factory($configuration->database);

// DATABASE TABLE SETUP - Setup the Database Table Adapter
// Since our application will be utilizing the Zend_Db_Table component, we need 
// to give it a default adapter that all table objects will be able to utilize 
// when sending queries to the db.
// @todo Remove Zend_Db? we're using Doctrine
Zend_Db_Table_Abstract::setDefaultAdapter($dbAdapter);

// DOCTRINE SETUP
// Set Doctrines autoloading, configure the database with the  DSN specified in 
// the ini file and enable conservative model loading. 
// @todo: do some error checking here
// @todo: specify conservative or aggressive model loading in the ini file
// @see http://www.doctrine-project.org/documentation/manual/1_0?chapter=getting-started#auto-loading-models:conservative
spl_autoload_register(array('Doctrine','autoload'));
Doctrine_Manager::connection($configuration->database->dsn); 
// @todo handle error when we can't connect
Doctrine_Manager::getInstance()->setAttribute('model_loading', 'aggressive');
Doctrine::loadModels(APPLICATION_PATH.'/models'); // This call will now require the found .php files

// REGISTRY - setup the application registry
// An application registry allows the application to store application 
// necessary objects into a safe and consistent (non global) place for future 
// retrieval.  This allows the application to ensure that regardless of what 
// happends in the global scope, the registry will contain the objects it 
// needs.
$registry = Zend_Registry::getInstance();
$registry->configuration = $configuration;
// @todo Remove Zend_Db? we're using Doctrine
// @todo Add the doctrine connection
$registry->dbAdapter     = $dbAdapter;

// CLEANUP - remove items from global scope
// This will clear all our local boostrap variables from the global scope of 
// this script (and any scripts that called bootstrap).  This will enforce 
// object retrieval through the Applications's Registry
unset($frontController, $view, $configuration, $dbAdapter, $registry);