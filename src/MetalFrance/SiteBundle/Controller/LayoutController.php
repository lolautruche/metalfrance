<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
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
     * @param mixed|null $locationId
     *
     * @return Response
     */
    public function analyticsAction( $category = null, $locationId = null )
    {
        if ( !$category && $locationId )
        {
            $category = $this->get( 'metalfrance.analytics' )->getCategoryByLocationId( $locationId );
        }

        $userType = $this->get( 'security.context' )->isGranted( 'IS_AUTHENTICATED_REMEMBERED' ) ? 'ezpublish' : 'Anonymous';

        return $this->render(
            'MetalFranceSiteBundle:Layout:analytics.html.twig',
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
        $query = $this->get( 'metalfrance.repository.news' )->getBlogPostsListQuery( $newsLocationId );
        $query->limit = 7;
        $res = $this->getRepository()->getSearchService()->findContent( $query );

        return $this->render( 'MetalFranceSiteBundle:Layout:newsHeader.html.twig', ['news' => $res->searchHits], $response );
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
            'MetalFranceSiteBundle:Layout:topMenu.html.twig',
            [
                'menuLocations' => $this->get( 'metalfrance.repository.layout' )->getMenu(),
                'linkSettings' => $this->container->getParameter( 'metalfrance.links' )
            ],
            $response
        );
    }

    /**
     * Renders the footer
     *
     * @return Response
     */
    public function footerAction()
    {
        $footerContent = $this->get( 'metalfrance.repository.layout' )->getFooter();
        $response = new Response();
        $response->setExpires( new DateTime( 'next year' ) );
        $response->headers->set( 'X-Location-Id', $footerContent->contentInfo->mainLocationId );


        return $this->render(
            'MetalFranceSiteBundle:Layout:footer.html.twig',
            [
                'footer_content' => $footerContent
            ],
            $response
        );
    }
}
