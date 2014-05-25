<?php

namespace MetalFrance\LegacyBundle\EventListener;

use eZ\Publish\Core\MVC\ConfigResolverInterface;
use eZ\Publish\Core\MVC\Legacy\Event\PreBuildKernelEvent;
use eZ\Publish\Core\MVC\Legacy\LegacyEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Maps configuration set in Symfony stack to legacy settings.
 *
 * @author Jérôme Vieilledent <lolautruche@gmail.com>
 */
class ConfigurationMapper implements EventSubscriberInterface
{
    /**
     * @var \eZ\Publish\Core\MVC\ConfigResolverInterface
     */
    private $configResolver;

    /**
     * @var string
     */
    private $contactEmail;

    /**
     * @var string
     */
    private $solrUrl;

    /**
     * @var bool
     */
    private $debug;

    public function __construct( ConfigResolverInterface $configResolver, $contactEmail, $solrUrl, $debug )
    {
        $this->configResolver = $configResolver;
        $this->contactEmail = $contactEmail;
        $this->solrUrl = $solrUrl;
        $this->debug = (bool)$debug;
    }

    public static function getSubscribedEvents()
    {
        return array(
            LegacyEvents::PRE_BUILD_LEGACY_KERNEL => array( "onBuildKernel", 128 )
        );
    }

    public function onBuildKernel( PreBuildKernelEvent $e )
    {
        $settings = [
            'site.ini/InformationCollectionSettings/EmailReceiver' => $this->contactEmail,
            'site.ini/TemplateSettings/DevelopmentMode' => $this->debug ? 'enabled' : 'disabled',
            'site.ini/TemplateSettings/ShowUsedTemplates' => $this->debug ? 'enabled' : 'disabled',
            'site.ini/SiteSettings/GMapsKey' => $this->configResolver->getParameter( 'gmaps_key', 'metalfrance' ),
            'solr.ini/SolrBase/SearchServerURI' => $this->solrUrl,
        ];

        $e->getParameters()->set(
            "injected-settings",
            $settings + (array)$e->getParameters()->get( "injected-settings" )
        );
    }
}
