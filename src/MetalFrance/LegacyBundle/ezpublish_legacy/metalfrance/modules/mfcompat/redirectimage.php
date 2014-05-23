<?php
/**
 * Vue permettant de rediriger les URLs de MF v2 vers celles de la v3
 * @copyright Copyright (C) 2011 - Metal France. All rights reserved
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
    $url = MFCompat::getRedirectImage( $Params['Type'], $Params['Name'] );
    eZHTTPTool::redirect( '/'.$url, array(), '301' );
}
catch (Exception $e)
{
    $errMsg = $e->getMessage();
    eZLog::write( $errMsg, 'mfcompat-error.log' );
    eZDebug::writeError( $errMsg, 'MFCompat::Redirect' );
    return $Module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
}