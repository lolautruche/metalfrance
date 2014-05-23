{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{if $load_css_file_list}
  {ezcss_load( array( ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ),
                      'debug.css',
                      'websitetoolbar.css' ))}
{else}
  {ezcss_load( array( 'core.css',
                      'debug.css',
                      'pagelayout.css',
                      'content.css',
                      'websitetoolbar.css' ))}
{/if}

{include uri="design:page_head_style_ie.tpl"}

{*
<link rel="stylesheet" type="text/css" href={ezini('StylesheetSettings','ClassesCSS','design.ini')|ezroot()} />
<link rel="stylesheet" type="text/css" href={ezini('StylesheetSettings','SiteCSS','design.ini')|ezroot()} />
<link rel="stylesheet" type="text/css" href={"stylesheets/print.css"|ezdesign} media="print" />
<!-- IE conditional comments; for bug fixes for different IE versions -->
<!--[if IE 5]>     <style type="text/css"> @import url({"stylesheets/browsers/ie5.css"|ezdesign(no)});    </style> <![endif]-->
<!--[if lte IE 7]> <style type="text/css"> @import url({"stylesheets/browsers/ie7lte.css"|ezdesign(no)}); </style> <![endif]-->
*}