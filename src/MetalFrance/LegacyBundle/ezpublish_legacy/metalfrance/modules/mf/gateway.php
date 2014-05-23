<?php
/**
 * Vue gérant les redirections de liens référencés dans eZ Publish
 * Utile pour les liens sponsorisés, notamment pour éviter les problèmes de validation HTML
 * ou pour cacher les régies publicitaires
 * @copyright Copyright (C) 2011 - Metal France. All rights reserved
 * @author Jerome Vieilledent
 * @version 3.0
 * @package metalfrance
 * @subpackage mf
 */

$Module = $Params['Module'];
$Result = array();
$http = eZHTTPTool::instance();
$mfINI = eZINI::instance( 'metalfrance.ini' );

$url = eZURL::url( (int)$Params['LinkID'] );
eZHTTPTool::redirect( $url, array(), '302' );
