<?php
/**
 * Fonctions Fetch pour MF
 */
class MFFunctionCollection
{
    /**
     * Retourne les facets pour le moteur de recherche
     */
    public static function getSearchFacets()
    {
        $limit = (int)eZINI::instance( 'metalfrance.ini' )->variable( 'SearchSettings', 'FacetLimit' );
        $facets = array();

        $facets[] = array(
            'field'		=> 'class',
            'limit'		=> $limit
        );

        return array( 'result' => $facets );
    }

    public static function createMFSitemap()
    {
        eZDebug::writeDebug( "Generating Standard Sitemap with images ...", __METHOD__ );
        $cli = $GLOBALS['cli'];
        global $cli, $isQuiet;
        if ( ! $isQuiet )
        {

            $cli->output( "Generating Sitemap for Siteaccess " . $GLOBALS['eZCurrentAccess']['name'] . " \n" );
        }
        $ini = eZINI::instance( 'site.ini' );
        $googlesitemapsINI = eZINI::instance( 'xrowsitemap.ini' );
        // Get the Sitemap's root node
        $contentINI = eZINI::instance( 'content.ini' );
        $rootNode = eZContentObjectTreeNode::fetch( $contentINI->variable( 'NodeSettings', 'RootNode' ) );

        if ( ! $rootNode instanceof eZContentObjectTreeNode )
        {
            $cli->output( "Invalid RootNode for Siteaccess " . $GLOBALS['eZCurrentAccess']['name'] . " \n" );
            continue;
        }

        // Settings variables
        if ( $googlesitemapsINI->hasVariable( 'MFSitemapSettings', 'ClassFilterType' ) and $googlesitemapsINI->hasVariable( 'MFSitemapSettings', 'ClassFilterArray' ) )
        {
            $params2 = array(
                'ClassFilterType' => $googlesitemapsINI->variable( 'MFSitemapSettings', 'ClassFilterType' ) ,
                'ClassFilterArray' => $googlesitemapsINI->variable( 'MFSitemapSettings', 'ClassFilterArray' )
            );
        }
        $max = 49997; // max. amount of links in 1 sitemap
        $limit = 50;

        // Fetch the content tree
        $params = array(
            'SortBy' => array(
                array(
                    'depth' ,
                    true
                ) ,
                array(
                    'published' ,
                    false
                )
            )
        );
        if ( isset( $params2 ) )
        {
            $params = array_merge( $params, $params2 );
        }

        $subtreeCount = eZContentObjectTreeNode::subTreeCountByNodeID( $params, $rootNode->NodeID );

        if ( $subtreeCount == 1 )
        {
            $cli->output( "No Items found under node #" . $contentINI->variable( 'NodeSettings', 'RootNode' ) . "." );
        }

        if ( ! $isQuiet )
        {
            $amount = $subtreeCount + 1; // +1 is root node
            $cli->output( "Adding $amount nodes to the sitemap." );
            $output = new ezcConsoleOutput();
            $bar = new ezcConsoleProgressbar( $output, $amount );
        }

        $addPrio = false;
        if ( $googlesitemapsINI->hasVariable( 'MFSitemapSettings', 'AddPriorityToSubtree' ) and $googlesitemapsINI->variable( 'MFSitemapSettings', 'AddPriorityToSubtree' ) == 'true' )
        {
            $addPrio = true;
        }

        $sitemap = new xrowSitemap();
        // Generate Sitemap
        /** START Adding the root node **/
        $object = $rootNode->object();

        $meta = xrowMetaDataFunctions::fetchByObject( $object );
        $extensions = array();
        $extensions[] = new xrowSitemapItemModified( $rootNode->attribute( 'modified_subnode' ) );

        $url = $rootNode->attribute( 'url_alias' );
        eZURI::transformURI( $url, true );
        if ( $ini->variable( 'SiteAccessSettings', 'RemoveSiteAccessIfDefaultAccess' ) == 'enabled' )
        {
            $url = 'http://' . xrowSitemapTools::domain() . $url;
        }
        else
        {
            $url = 'http://' . xrowSitemapTools::domain() . '/' . $GLOBALS['eZCurrentAccess']['name'] . $url;
        }

        if ( $meta and $meta->googlemap != '0' )
        {
            $extensions[] = new xrowSitemapItemFrequency( $meta->change );
            $extensions[] = new xrowSitemapItemPriority( $meta->priority );
            $sitemap->add( $url, $extensions );
        }
        elseif ( $meta === false and $googlesitemapsINI->variable( 'Settings', 'AlwaysAdd' ) == 'enabled' )
        {
            if ( $addPrio )
            {
                $extensions[] = new xrowSitemapItemPriority( '1' );
            }

            $sitemap->add( $url, $extensions );
        }

        if ( isset( $bar ) )
        {
            $bar->advance();
        }
        /** END Adding the root node **/
        $max = min( $max, $subtreeCount );
        $params['Limit'] = min( $max, $limit );
        $params['Offset'] = 0;
        while ( $params['Offset'] < $max )
        {
            $nodeArray = eZContentObjectTreeNode::subTreeByNodeID( $params, $rootNode->NodeID );
            foreach ( $nodeArray as $subTreeNode )
            {
                eZContentLanguage::expireCache();
                $object = $subTreeNode->object();
                $images = array();
                $meta = xrowMetaDataFunctions::fetchByObject( $object );
                $extensions = array();
                $extensions[] = new xrowSitemapItemModified( $subTreeNode->attribute( 'modified_subnode' ) );

                $url = $subTreeNode->attribute( 'url_alias' );
                eZURI::transformURI( $url, true );
                if ( $ini->variable( 'SiteAccessSettings', 'RemoveSiteAccessIfDefaultAccess' ) == 'enabled' )
                {
                    $url = 'http://' . xrowSitemapTools::domain() . $url;
                }
                else
                {
                    $url = 'http://' . xrowSitemapTools::domain() . '/' . $GLOBALS['eZCurrentAccess']['name'] . $url;
                }

                if ( $meta and $meta->googlemap != '0' )
                {
                    $extensions[] = new xrowSitemapItemFrequency( $meta->change );
                    $extensions[] = new xrowSitemapItemPriority( $meta->priority );
                }
                elseif ( $meta === false and $googlesitemapsINI->variable( 'Settings', 'AlwaysAdd' ) == 'enabled' )
                {

                    if ( $addPrio )
                    {
                        $rootDepth = $rootNode->attribute( 'depth' );
                        $prio = 1 - ( ( $subTreeNode->attribute( 'depth' ) - $rootDepth ) / 10 );
                        if ( $prio > 0 )
                        {
                            $extensions[] = new xrowSitemapItemPriority( $prio );
                        }
                    }
                }

                $images = self::getSitemapImageItems( $object );
                $sitemap->add( $url, array_merge( $extensions, $images ) );

                if ( isset( $bar ) )
                {
                    $bar->advance();
                }
            }
            eZContentObject::clearCache();
            $params['Offset'] += $params['Limit'];
        }
        // write XML Sitemap to file
        $dir = eZSys::storageDirectory() . '/sitemap/' . xrowSitemapTools::domain();
        if ( ! is_dir( $dir ) )
        {
            mkdir( $dir, 0777, true );
        }

        $filename = $dir . '/' . xrowSitemap::BASENAME . '_standard_' . $GLOBALS['eZCurrentAccess']['name'] . '.' . xrowSitemap::SUFFIX;

        $sitemap->save( $filename );

        if ( ! $isQuiet )
        {
            $cli->output( "\n" );
            $cli->output( "Sitemap $filename for siteaccess " . $GLOBALS['eZCurrentAccess']['name'] . " has been generated.\n" );
        }
    }

    /**
     * Retourne les éléments de sitemap image pour un content object $object donné
     * @param eZContentObject $object
     * @return array(xrowSitemapItemImage)
     */
    private static function getSitemapImageItems( eZContentObject $object )
    {
        $images = array();

        // D'abord depuis la datamap
        $images = array_merge( $images, self::getSitemapImageItemFromDataMap( $object->dataMap() ) );

        // Puis avec les related objects
        $aParamsRelated = array(
            'object_id'		=> $object->attribute( 'id' ),
            'all_relations'	=> true
        );
        $aImageObjectIDs = array();
        $relatedObjects = eZFunctionHandler::execute( 'content', 'related_objects', $aParamsRelated );
        $imagesRelated = array();
        foreach( $relatedObjects as $relatedObject )
        {
            switch( $relatedObject->attribute( 'class_identifier' ) )
            {
                case 'image':
                    $imagesRelated = array_merge( $imagesRelated, self::getSitemapImageItemFromDataMap( $relatedObject->dataMap() ) );
                break;
            }
        }

        // Puis les children (gallery)
        $imagesChildren = array();
        $aParamsChildren = array(
            'class_filter_type'		=> 'include',
        	'class_filter_array'	=> array( 'image' ),
            'parent_node_id'		=> $object->attribute( 'main_node_id' )
        );
        $aChildren = eZFunctionHandler::execute( 'content', 'list', $aParamsChildren );
        foreach ( $aChildren as $child )
        {
            $imagesChildren = array_merge( $imagesChildren, self::getSitemapImageItemFromDataMap( $child->object()->dataMap() ) );
        }

        return array_merge( $images, $imagesRelated, $imagesChildren );
    }

    private static function getSitemapImageItemFromDataMap( array $dataMap )
    {
        $images = array();
        foreach ( $dataMap as $attributeIdentifier => $attribute )
        {
            switch ( $attribute->DataTypeString )
            {
                case 'ezimage':
                    if ( $attribute->hasContent() )
                    {

                        $imagedata = $attribute->content();
                        $image = new xrowSitemapItemImage();
    					$aliasdata = $imagedata->attribute( 'large' );
    					$image->url = 'http://' . xrowSitemapTools::domain() . '/' . $aliasdata['url'];

                        if ( $imagedata->attribute( 'alternative_text' ) )
                        {
                        	$image->caption = $imagedata->attribute( 'alternative_text' );
                        }

                        $images[] = $image;
                    }
                break;
            }
        }

        return $images;
    }
}
?>
