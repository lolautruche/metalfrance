<?php

$ini = eZINI::instance( 'site.ini' );
$googlesitemapsINI = eZINI::instance( 'xrowsitemap.ini' );

//getting custom set site access or default access
if ( $googlesitemapsINI->hasVariable( 'SitemapSettings', 'AvailableSiteAccessList' ) )
{
    $siteAccessArray = $googlesitemapsINI->variable( 'SitemapSettings', 'AvailableSiteAccessList' );
}
else
{
    $siteAccessArray = array(
        $ini->variable( 'SiteSettings', 'DefaultAccess' )
    );
}

if ( $googlesitemapsINI->variable( 'Settings', 'MFSitemap' ) === 'enabled' )
{
    if ( ! $isQuiet )
    {
        $cli->output( "Generating Regular MF Sitemaps...\n" );
    }
    xrowSitemapTools::siteaccessCallFunction( $siteAccessArray, 'MFFunctionCollection::createMFSitemap' );
}

xrowSitemapTools::ping();

?>