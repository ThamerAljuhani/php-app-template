<?php
declare(strict_types=1);

//------------------------------------------------------------------------------
// 1) DEV ERROR REPORTING — turn off in production
//------------------------------------------------------------------------------
ini_set('display_errors', '1');
error_reporting(E_ALL);

//------------------------------------------------------------------------------
// 2) PROJECT ROOT
//------------------------------------------------------------------------------
define('BASE_PATH', dirname(__DIR__));   // `/var/www/html`

//------------------------------------------------------------------------------
// 3) PARSE THE REQUEST URI
//------------------------------------------------------------------------------
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Redirect to /home.php if accessing / or /index.php
if ($uri === '/' || preg_match('#/index\.php$#i', $uri)) {
    header('Location: /home.php');
    exit;
}

// Strip any leading/trailing slashes, default to 'home'
$route = trim($uri, '/') ?: 'home';

// Allow routes like 'home', 'add_todos', or 'home.php'
if (!preg_match('/^[a-z0-9_-]+(\.php)?$/i', $route)) {
    http_response_code(400);
    exit('Bad request');
}

// Remove .php extension if present
$route = preg_replace('/\.php$/i', '', $route);

//------------------------------------------------------------------------------
// 4) DETERMINE THE FILE TO INCLUDE
//------------------------------------------------------------------------------
$appFile = BASE_PATH . '/src/' . $route . '.php';

// Debug: Uncomment the next line to see what file is being checked
// echo "Looking for: $appFile"; exit;

if (is_file($appFile)) {
    include $appFile;
    exit;
}

//------------------------------------------------------------------------------
// 5) FALLBACK TO 404
//------------------------------------------------------------------------------
http_response_code(404);
include BASE_PATH . '/404.php';
exit;