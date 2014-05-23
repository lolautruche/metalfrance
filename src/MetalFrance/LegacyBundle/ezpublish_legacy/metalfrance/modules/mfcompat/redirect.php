<?php
/**
 * Vue permettant de rediriger les URLs de MF v2 vers celles de la v3
 * @copyright Copyright (C) 2010 - Metal France. All rights reserved
 * @author Jerome Vieilledent
 * @version 3.0
 * @package metalfrance
 * @subpackage mfcompat
 */

$Module = $Params['Module'];
$Result = array();
$http = eZHTTPTool::instance();
$mfINI = eZINI::instance( 'metalfrance.ini' );

try
{
    $url = MFCompat::getRedirectURL( $Params['Type'], $Params['ID'] );
    eZHTTPTool::redirect( '/'.$url, array(), '301' );
}
catch (Exception $e)
{
    $errMsg = $e->getMessage();
    eZLog::write( $errMsg, 'mfcompat-error.log' );
    eZDebug::writeError( $errMsg, 'MFCompat::Redirect' );
    return $Module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
}