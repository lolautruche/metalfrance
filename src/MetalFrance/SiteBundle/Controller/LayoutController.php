<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use Symfony\Component\HttpFoundation\Response;

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
}
