<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use Symfony\Component\HttpFoundation\Response;

class SidebarController extends Controller
{
    /**
     * Displays related content for given locationId, using legacy template.
     *
     * @param mixed $locationId
     *
     * @return Response
     */
    public function relatedContentAction( $locationId )
    {
        return $this->render( '@MetalFranceSite/Sidebar/related_content.html.twig', ['locationId' => $locationId] );
    }
}
