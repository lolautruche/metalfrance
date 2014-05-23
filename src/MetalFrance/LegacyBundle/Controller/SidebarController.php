<?php

namespace MetalFrance\LegacyBundle\Controller;

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
        $repository = $this->getRepository();
        $location = $repository->getLocationService()->loadLocation( $locationId );
        $contentType = $repository->getContentTypeService()->loadContentType( $location->getContentInfo()->contentTypeId );

        $response = new Response();
        $response->setTtl( strtotime( '1 day' ) );
        return $this->render(
            'file:' . __DIR__ . '/../ezpublish_legacy/metalfrance/design/mf/templates/parts/right_column/related_content.tpl',
            [
                // Template expects to have the module_result array as it was included in pagelayout.tpl.
                // Let's just fake it and fill it with expected values.
                'module_result' => [
                    'content_info' => [
                        'class_identifier' => $contentType->identifier,
                        'node_id' => $locationId
                    ]
                ]
            ],
            $response
        );
    }
}
