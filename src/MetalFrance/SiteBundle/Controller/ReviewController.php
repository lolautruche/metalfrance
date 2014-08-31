<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use eZ\Publish\Core\Pagination\Pagerfanta\LocationSearchAdapter;
use Pagerfanta\Pagerfanta;
use Symfony\Component\HttpFoundation\Request;

class ReviewController extends Controller
{
    public function listReviewsAction( $locationId, $viewType, Request $request, $layout = false, array $params = [] )
    {
        $pager = new Pagerfanta(
            new LocationSearchAdapter(
                $this->get( 'metalfrance.repository.review' )->getReviewListQuery( $locationId, $request->query->get( 'type' ) === 'decouvertes' ),
                $this->getRepository()->getSearchService()
            )
        );
        $pager->setMaxPerPage( $this->getConfigResolver()->getParameter( 'review.list_limit', 'metalfrance' ) );
        $pager->setCurrentPage( $request->query->get( 'page', 1 ) );

        return $this->get( 'ez_content' )->viewLocation(
            $locationId, $viewType, $layout,
            [ 'reviews' => $pager ] + $params
        );
    }
}
