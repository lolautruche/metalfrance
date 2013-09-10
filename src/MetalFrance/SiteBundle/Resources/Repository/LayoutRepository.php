<?php

namespace MetalFrance\SiteBundle\Repository;

use eZ\Publish\API\Repository\Repository;
use eZ\Publish\API\Repository\Values\Content\Location;
use eZ\Publish\API\Repository\Values\Content\Query;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;

/**
 * Repository accessor class for main layout
 */
class LayoutRepository
{
    /**
     * @var \eZ\Publish\API\Repository\Repository
     */
    private $repository;

    private $locationSettings;

    public function __construct( Repository $repository, array $locationSettings )
    {
        $this->repository = $repository;
        $this->locationSettings = $locationSettings;
    }

    /**
     * Returns Location objects for main menu.
     *
     * @return Location[]
     */
    public function getMenu()
    {
        $locationService = $this->repository->getLocationService();
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
        $location = $this->repository->getLocationService()->loadLocation( $this->locationSettings['footer'] );
        return $this->repository->getContentService()->loadContentByContentInfo( $location->getContentInfo() );
    }
}
