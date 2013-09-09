<?php

namespace MetalFrance\SiteBundle\Utils;

use eZ\Publish\API\Repository\ContentTypeService;
use eZ\Publish\API\Repository\LocationService;

class AnalyticsService
{
    /**
     * Category names, indexed by ContentType identifier
     *
     * @var array
     */
    private $categoryByContentType;

    /**
     * @var \eZ\Publish\API\Repository\LocationService
     */
    private $locationService;

    /**
     * @var \eZ\Publish\API\Repository\ContentTypeService
     */
    private $contentTypeService;

    public function __construct( array $categoryByContentType, LocationService $locationService, ContentTypeService $contentTypeService )
    {
        $this->categoryByContentType = $categoryByContentType;
        $this->locationService = $locationService;
        $this->contentTypeService = $contentTypeService;
    }

    /**
     * Returns tracking category name by locationId.
     *
     * @param int $locationId
     *
     * @return null|string
     */
    public function getCategoryByLocationId( $locationId )
    {
        $location = $this->locationService->loadLocation( $locationId );
        $contentType = $this->contentTypeService->loadContentType( $location->getContentInfo()->contentTypeId );
        return $this->getCategoryByContentTypeIdentifier( $contentType->identifier );
    }

    /**
     * Returns tracking category name, by contentType identifier.
     * Will return null If there is no defined category.
     *
     * @param string $contentTypeIdentifier
     *
     * @return string|null
     */
    public function getCategoryByContentTypeIdentifier( $contentTypeIdentifier )
    {
        if ( !isset( $this->categoryByContentType[$contentTypeIdentifier] ) )
        {
            return;
        }

        return $this->categoryByContentType[$contentTypeIdentifier];
    }
}
