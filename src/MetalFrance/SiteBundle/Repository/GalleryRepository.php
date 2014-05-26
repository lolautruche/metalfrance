<?php

namespace MetalFrance\SiteBundle\Repository;

use eZ\Publish\API\Repository\SearchService;
use eZ\Publish\API\Repository\Values\Content\Query;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;

class GalleryRepository
{
    /**
     * @var array
     */
    private $locationSettings;

    /**
     * @var \eZ\Publish\API\Repository\SearchService
     */
    private $searchService;

    public function __construct( array $locationSettings, SearchService $searchService )
    {
        $this->locationSettings = $locationSettings;
        $this->searchService = $searchService;
    }

    /**
     * Returns the content search Query to list blog posts.
     *
     * @param mixed|null $parentLocationId
     *
     * @return Query
     */
    public function getGalleriesListQuery( $parentLocationId = null )
    {
        $parentLocationId = $parentLocationId ?: $this->locationSettings['photos'];

        $query = new Query();
        $query->criterion = new Criterion\LogicalAnd(
            [
                new Criterion\Visibility( Criterion\Visibility::VISIBLE ),
                new Criterion\ParentLocationId( $parentLocationId ),
                new Criterion\ContentTypeIdentifier( ['mf_gallerie'] ),
            ]
        );
        $query->sortClauses = [ new Query\SortClause\DatePublished( Query::SORT_DESC ) ];

        return $query;
    }

    /**
     * Returns first image item of a gallery, as Content object.
     *
     * @param $galleryLocationId
     *
     * @return \eZ\Publish\API\Repository\Values\Content\Content
     */
    public function getFirstGalleryItem( $galleryLocationId )
    {
        $query = $this->generateGalleryItemsQuery( $galleryLocationId );
        $query->limit = 1;
        $result = $this->searchService->findContent( $query );

        return $result->searchHits[0]->valueObject;
    }

    /**
     * Returns image items for a gallery, as Content objects.
     *
     * @param mixed $galleryLocationId
     *
     * @return \eZ\Publish\API\Repository\Values\Content\Content[]
     */
    public function getGalleryItems( $galleryLocationId )
    {
        $result = $this->searchService->findContent( $this->generateGalleryItemsQuery( $galleryLocationId ) );
        $contentObjects = [];
        foreach ( $result->searchHits as $hit )
        {
            $contentObjects[] = $hit->valueObject;
        }

        return $contentObjects;
    }

    /**
     * Generates the query for gallery items.
     *
     * @param mixed $galleryLocationId
     *
     * @return Query
     */
    private function generateGalleryItemsQuery( $galleryLocationId )
    {
        $query = new Query();
        $query->criterion = new Criterion\LogicalAnd(
            [
                new Criterion\Visibility( Criterion\Visibility::VISIBLE ),
                new Criterion\ParentLocationId( $galleryLocationId ),
                new Criterion\ContentTypeIdentifier( ['image'] ),
            ]
        );
        $query->sortClauses = [ new Query\SortClause\DatePublished( Query::SORT_DESC ) ];

        return $query;
    }
}
