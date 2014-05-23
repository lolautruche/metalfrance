<?php

namespace MetalFrance\LegacyBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class MetalFranceLegacyBundle extends Bundle
{
    public function getParent()
    {
        return 'MetalFranceSiteBundle';
    }
}
