<?php
/**
 * Module MF
 */
$Module = array('name' => 'mf');

/**
 * Vue gérant les redirections de liens référencés dans eZ Publish
 * Utile pour les liens sponsorisés, pour notamment éviter les problèmes de validation HTML
 */
$ViewList['gateway'] = array(
    'script'                    =>  'gateway.php',
    'params'                    =>  array( 'LinkID' ),
    'unordered_params'          =>  array(),
    'single_post_actions'       =>  array(),
    'post_action_parameters'    =>  array(),
);