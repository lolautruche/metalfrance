<?php

namespace MetalFrance\SiteBundle\Repository;

use eZ\Publish\API\Repository\Repository;
use eZ\Publish\API\Repository\Values\Content\Location;

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
            $menuLocations[$label] = $locationService->loadLocation( $locationId );
        }

        return $menuLocations;
    }
}
