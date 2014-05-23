<?php
/**
 * File containing the MFRestApiProvider class.
 *
 * @copyright Copyright (C) 2011 Metal France. All rights reserved.
 * @author Jérôme Vieilledent
 * @package metalfrance
 * @subpackage rest
 */

class MFRestAssetController extends ezpRestMvcController
{
    public function __construct( $action, $request )
    {
        $moduleRepositories = eZModule::activeModuleRepositories();
        eZModule::setGlobalPathList( $moduleRepositories );

        parent::__construct( $action, $request );
    }

    public function doGetAll()
    {
        $result = new ezpRestMvcResult();

        // Header
        $tpl = eZTemplate::factory();
        $tpl->setVariable( 'current_user', eZUser::currentUser() );
        $result->variables['menu'] = $tpl->fetch( 'design:page_topmenu.tpl' );
        $result->variables['news'] = $tpl->fetch( 'design:parts/news_header.tpl' );
        $result->variables['styles_ie'] = $tpl->fetch( 'design:page_head_style_ie.tpl' );
        $result->variables['footer'] = $tpl->fetch( 'design:page_footer.tpl' );

        return $result;
    }
}