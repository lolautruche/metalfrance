<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use eZ\Publish\Core\Pagination\Pagerfanta\ContentSearchAdapter;
use Pagerfanta\Pagerfanta;
use Symfony\Component\HttpFoundation\Request;

class GalleryController extends Controller
{
    public function listGalleriesAction( $locationId, $viewType, Request $request, $layout = false, array $params = [] )
    {
        // Initialize pagination.
        $pager = new Pagerfanta(
            new ContentSearchAdapter(
                $this->get( 'metalfrance.repository.gallery' )->getGalleriesListQuery( $locationId ),
                $this->getRepository()->getSearchService()
            )
        );
        $pager->setMaxPerPage( $this->getConfigResolver()->getParameter( 'gallery.list_limit', 'metalfrance' ) );
        $pager->setCurrentPage( $request->query->get( 'page', 1 ) );

        // Forward to built-in ViewController and enrich default parameters passed to template.
        return $this->get( 'ez_content' )->viewLocation(
            $locationId,
            $viewType,
            $layout,
            [ 'galleries' => $pager ] + $params
        );
    }

    public function showGalleryAction( $locationId, $viewType, $layout = false, array $params = [] )
    {
        $firstGalleryItem = $this->get( 'metalfrance.repository.gallery' )->getFirstGalleryItem( $locationId );

        return $this->get( 'ez_content' )->viewLocation(
            $locationId,
            $viewType,
            $layout,
            [ 'first_photo' => $firstGalleryItem ]
        );
    }
}
