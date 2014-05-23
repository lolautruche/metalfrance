<?php
/**
 * Module de compatibilite avec MF v2
 */
$Module = array('name' => 'mfcompat');

/**
 * Vue permettant de rediriger les anciennes URL vers les nouvelles
 */
$ViewList['redirect'] = array(
    'script'                    =>  'redirect.php',
    'params'                    =>  array(),
    'unordered_params'          =>  array(
        'type'      => 'Type',
        'id'        => 'ID'
    ),
    'single_post_actions'       =>  array(),
    'post_action_parameters'    =>  array(),
);

/**
 * Vue permettant de rediriger les images de l'ancien site vers celles du nouveau
 * Note : Toutes les images ne fonctionneront pas pour des raisons de compatibilité
 */
$ViewList['redirectimage'] = array(
    'script'                    =>  'redirectimage.php',
    'params'                    =>  array(),
    'unordered_params'          =>  array(
        'type'      => 'Type',
        'name'      => 'Name'
    ),
    'single_post_actions'       =>  array(),
    'post_action_parameters'    =>  array(),
);
