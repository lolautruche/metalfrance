<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use eZ\Publish\API\Repository\Values\Content\Query;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;
use Symfony\Component\HttpFoundation\Response;
use DateTime;

/**
 * Controller for pagelayout actions
 */
class LayoutController extends Controller
{
    /**
     * Renders analytics tag
     *
     * @param string|null $category
     *
     * @return Response
     */
    public function analyticsAction( $category = null )
    {
        $locationId = $this->getRequest()->attributes->get( 'locationId' );
        if ( !$category && $locationId )
        {
            $category = $this->get( 'metalfrance.analytics' )->getCategoryByLocationId( $locationId );
        }

        $userType = $this->get( 'security.context' )->getToken()->isAuthenticated() ? 'ezpublish' : 'Anonymous';

        return $this->render(
            '@MetalFranceSite/Layout/analytics.html.twig',
            [
                'category' => $category,
                'userType' => $userType,
                'google_account' => $this->container->getParameter( 'metalfrance.analytics.google_account' ),
                'domain' => $this->container->getParameter( 'metalfrance.analytics.domain' ),
            ]
        );
    }

    /**
     * Renders the news header.
     *
     * @return Response
     */
    public function newsHeaderAction()
    {
        $newsLocationId = $this->container->getParameter( 'metalfrance.location_settings' )['news'];
        $response = new Response();
        $response->setSharedMaxAge( 86400 );
        $response->headers->set( 'X-Location-Id', $newsLocationId );

        // Fetching blog posts
        // TODO: Refactor in a service
        $query = new Query();
        $query->criterion = new Criterion\LogicalAnd(
            [
                new Criterion\ParentLocationId( $newsLocationId ),
                new Criterion\ContentTypeIdentifier( 'blog_post' )
            ]
        );
        $query->sortClauses = [new Query\SortClause\DatePublished( Query::SORT_DESC )];
        $query->limit = 7;
        $res = $this->getRepository()->getSearchService()->findContent( $query );

        return $this->render( '@MetalFranceSite/Layout/newsHeader.html.twig', ['news' => $res->searchHits], $response );
    }

    /**
     * Renders the top menu
     *
     * @return Response
     */
    public function topMenuAction()
    {
        $response = new Response();
        // Menu should be kept long in cache as it won't change that much
        $response->setExpires( new DateTime( 'first day of next month' ) );

        return $this->render(
            '@MetalFranceSite/Layout/topMenu.html.twig',
            [
                'menuLocations' => $this->get( 'metalfrance.repository.layout' )->getMenu(),
                'linkSettings' => $this->container->getParameter( 'metalfrance.links' )
            ]
        );
    }
}
