<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use eZ\Publish\Core\Pagination\Pagerfanta\ContentSearchAdapter;
use Pagerfanta\Pagerfanta;
use Symfony\Component\HttpFoundation\Request;

/**
 * Gallery related controller
 *
 * @author Jérôme Vieilledent <lolautruche@gmail.com>
 */
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

    /**
     * Action to display a gallery, regardless its viewType.
     * Used for both line and full view types.
     *
     * @param mixed $locationId
     * @param string $viewType
     * @param bool $layout
     * @param array $params
     *
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function showGalleryAction( $locationId, $viewType, $layout = false, array $params = [] )
    {
        $galleryRepository = $this->get( 'metalfrance.repository.gallery' );

        return $this->get( 'ez_content' )->viewLocation(
            $locationId,
            $viewType,
            $layout,
            [
                'first_photo' => $galleryRepository->getFirstGalleryItem( $locationId ),
                // Only retrieve gallery items for full view.
                'gallery_items' => $viewType === 'full' ? $galleryRepository->getGalleryItems( $locationId ) : []
            ] + $params
        );
    }
}
