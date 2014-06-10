<?php

namespace MetalFrance\SiteBundle\Controller;

use eZ\Bundle\EzPublishCoreBundle\Controller;
use eZ\Publish\Core\Pagination\Pagerfanta\ContentSearchAdapter;
use Pagerfanta\Pagerfanta;
use Symfony\Component\HttpFoundation\Request;

class BlogController extends Controller
{
    /**
     * Lists blog posts.
     *
     * @param mixed $locationId
     * @param string $viewType
     * @param bool $layout
     * @param array $params
     * @param Request $request
     *
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function listBlogPostsAction( $locationId, $viewType, $layout = false, array $params = [], Request $request )
    {
        $configResolver = $this->getConfigResolver();

        // Initialize pagination.
        $pager = new Pagerfanta(
            new ContentSearchAdapter(
                $this->get( 'metalfrance.repository.news' )->getBlogPostsListQuery( $locationId ),
                $this->getRepository()->getSearchService()
            )
        );
        $pager->setMaxPerPage( $configResolver->getParameter( 'news.list_limit', 'metalfrance' ) );
        $pager->setCurrentPage( $request->query->get( 'page', 1 ) );

        // Forward to built-in ViewController and enrich default parameters passed to template.
        return $this->get( 'ez_content' )->viewLocation(
            $locationId,
            $viewType,
            $layout,
            [ 'blog_posts' => $pager ] + $params
        );
    }

    /**
     * Action used to display a blog_post
     *  - Adds the content's author to the response.
     * Note: This is a partly customized controller action. It is executed just before the original
     *       Viewcontroller's viewLocation method. To be able to do that, we need to implement it's
     *       full signature.
     *
     * @param $locationId
     * @param $viewType
     * @param bool $layout
     * @param array $params
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function showBlogPostAction( $locationId, $viewType, $layout = false, array $params = [] )
    {
        // We need the author, whatever the view type is.
        $repository = $this->getRepository();
        $location = $repository->getLocationService()->loadLocation( $locationId );
        $author = $repository->getUserService()->loadUser( $location->getContentInfo()->ownerId );

        // Delegate view rendering to the original ViewController
        // (makes it possible to continue using defined template rules)
        // We just add "author" to the list of variables exposed to the final template
        return $this->get( 'ez_content' )->viewLocation(
            $locationId,
            $viewType,
            $layout,
            [ 'author' => $author ] + $params
        );
    }
}
 