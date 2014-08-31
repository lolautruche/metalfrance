<?php

namespace MetalFrance\SiteBundle\Repository;

use eZ\Publish\API\Repository\Values\Content\LocationQuery;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;
use eZ\Publish\API\Repository\Values\Content\Query\SortClause;

class ReviewRepository
{
    /**
     * @var array
     */
    private $locationSettings;

    public function __construct ( array $locationSettings )
    {
        $this->locationSettings = $locationSettings;
    }

    /**
     * Returns the LocationQuery for review list.
     *
     * @param int $parentLocationId
     * @param bool $isDiscovery
     *
     * @return LocationQuery
     */
    public function getReviewListQuery( $parentLocationId = null, $isDiscovery = false )
    {
        $parentLocationId = $parentLocationId ?: $this->locationSettings['reviews'];

        $query = new LocationQuery();
        $criteria = [
            new Criterion\Visibility( Criterion\Visibility::VISIBLE ),
            new Criterion\ContentTypeIdentifier( 'mf_chronique_cd' ),
            new Criterion\ParentLocationId( $parentLocationId )
        ];
        if ( $isDiscovery )
        {
            $criteria[] = new Criterion\Field( 'decouverte', Criterion\Operator::EQ, true );
        }

        $query->criterion = new Criterion\LogicalAnd( $criteria );
        $query->sortClauses = [ new SortClause\DatePublished( LocationQuery::SORT_DESC ) ];

        return $query;
    }
}
 