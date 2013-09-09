<?php

namespace MetalFrance\SiteBundle\Twig;

use Twig_Extension;
use eZFunctionHandler;

/**
 * Twig extension for legacy helpers.
 */
class MetalFranceLegacyExtension extends Twig_Extension
{
    private $legacyKernelClosure;

    /**
     * @var \ezpWebBasedKernelHandler
     */
    private $legacyKernel;

    public function __construct( \Closure $legacyKernelClosure )
    {
        $this->legacyKernelClosure = $legacyKernelClosure;
    }

    /**
     * @return \ezpWebBasedKernelHandler
     */
    private function getLegacyKernel()
    {
        if ( isset( $this->legacyKernel ) )
        {
            return $this->legacyKernel;
        }

        $closure = $this->legacyKernelClosure;
        return $this->legacyKernel = $closure();
    }

    public function getFunctions()
    {
        return [
            new \Twig_SimpleFunction( 'janrain_signin_url', [$this, 'getJanrainSigninUrl'] ),
        ];
    }

    /**
     * Returns Signin URL for Janrain authentication.
     *
     * @return string
     */
    public function getJanrainSigninUrl()
    {
        return $this->getLegacyKernel()->runCallback(
            function ()
            {
                return eZFunctionHandler::execute( 'janrain', 'signin_url', [] );
            },
            false
        );
    }

    /**
     * Returns the name of the extension.
     *
     * @return string The extension name
     */
    public function getName()
    {
        return 'metalfrance.legacy';
    }
}
