<?php

namespace MetalFrance\SiteBundle\Pagerfanta\View;

use MetalFrance\SiteBundle\Pagerfanta\View\Template\MetalFranceTemplate;
use Pagerfanta\View\DefaultView;

class MetalFranceView extends DefaultView
{
    public function getName()
    {
        return 'metalfrance';
    }

    protected function getDefaultProximity()
    {
        return 3;
    }

    protected function createDefaultTemplate()
    {
        return new MetalFranceTemplate();
    }
}
 