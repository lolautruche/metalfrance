<?php

namespace MetalFrance\SiteBundle\Repository;

use eZ\Publish\API\Repository\ContentService;
use eZ\Publish\API\Repository\LocationService;
use eZ\Publish\API\Repository\Values\Content\Location;
use eZ\Publish\API\Repository\Values\Content\Query;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;

/**
 * Repository accessor class for main layout
 */
class LayoutRepository
{
    /**
     * @var \eZ\Publish\API\Repository\ContentService
     */
    private $contentService;

    /**
     * @var \eZ\Publish\API\Repository\LocationService
     */
    private $locationService;

    private $locationSettings;

    public function __construct( ContentService $contentService, LocationService $locationService, array $locationSettings )
    {
        $this->contentService = $contentService;
        $this->locationService = $locationService;
        $this->locationSettings = $locationSettings;
    }

    /**
     * Returns Location objects for main menu.
     *
     * @return Location[]
     */
    public function getMenu()
    {
        $locationService = $this->locationService;
        $menuLocations = [];
        foreach ( $this->locationSettings as $label => $locationId )
        {
            // Skip footer for menu
            if ( $label === 'footer' )
                continue;

            $menuLocations[$label] = $locationService->loadLocation( $locationId );
        }

        return $menuLocations;
    }

    /**
     * Returns footer content object.
     *
     * @return \eZ\Publish\API\Repository\Values\Content\Content
     */
    public function getFooter()
    {
        $location = $this->locationService->loadLocation( $this->locationSettings['footer'] );
        return $this->contentService->loadContentByContentInfo( $location->getContentInfo() );
    }
}
