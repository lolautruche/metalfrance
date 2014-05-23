<?php
/**
 * File containing the MFRestApiProvider class.
 *
 * @copyright Copyright (C) 2011 Metal France. All rights reserved.
 * @author Jérôme Vieilledent
 * @package metalfrance
 * @subpackage rest
 */

class MFRestApiProvider implements ezpRestProviderInterface
{
    /**
     * Returns registered versioned routes for provider
     *
     * @return array Associative array. Key is the route name (beware of name collision !). Value is the versioned route.
     */
    public function getRoutes()
    {
        $routes = array(
            'mfHeader'           => new ezpRestVersionedRoute( new ezpMvcRailsRoute( '/assets/all', 'MFRestAssetController', 'getall' ), 1 ),
        );
        return $routes;
    }

    /**
     * Returns associated with provider view controller
     *
     * @return ezpRestViewController
     */
    public function getViewController()
    {
        return new ezpRestApiViewController();
    }
}
