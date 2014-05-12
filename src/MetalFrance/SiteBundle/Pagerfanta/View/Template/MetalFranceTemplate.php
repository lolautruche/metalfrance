<?php

namespace MetalFrance\SiteBundle\Pagerfanta\View\Template;

use Pagerfanta\View\Template\TwitterBootstrapTemplate;

class MetalFranceTemplate extends TwitterBootstrapTemplate
{
    protected static $overrideOptions = [
        'css_container_class' => 'mf-pager',
        'css_list_container_class' => 'mf-clear',
        'css_prev_class'      => 'previous',
        'css_next_class'      => 'next',
    ];

    public function __construct()
    {
        static::$defaultOptions = static::$overrideOptions + static::$defaultOptions;
        parent::__construct();
    }

    public function container()
    {
        return sprintf(
            '<div class="%s"><ul class="%s">%%pages%%</ul></div>',
            $this->option( 'css_container_class' ),
            $this->option( 'css_list_container_class' )
        );
    }
}
 