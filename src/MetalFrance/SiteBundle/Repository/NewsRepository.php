<?php

namespace MetalFrance\SiteBundle\Repository;

use eZ\Publish\API\Repository\Values\Content\Query;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;

class NewsRepository
{
    /**
     * @var array
     */
    private $locationSettings;

    public function __construct( array $locationSettings )
    {
        $this->locationSettings = $locationSettings;
    }

    /**
     * Returns the content search Query to list blog posts.
     *
     * @param mixed|null $parentLocationId
     *
     * @return Query
     */
    public function getBlogPostsListQuery( $parentLocationId = null )
    {
        $parentLocationId = $parentLocationId ?: $this->locationSettings['news'];

        $query = new Query();
        $query->criterion = new Criterion\LogicalAnd(
            [
                new Criterion\Visibility( Criterion\Visibility::VISIBLE ),
                new Criterion\ParentLocationId( $parentLocationId ),
                new Criterion\ContentTypeIdentifier( ['blog_post'] ),
            ]
        );
        $query->sortClauses = [ new Query\SortClause\DatePublished( Query::SORT_DESC ) ];

        return $query;
    }
}
