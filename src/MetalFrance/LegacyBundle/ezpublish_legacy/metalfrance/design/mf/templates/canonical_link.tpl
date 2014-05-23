{if $pagedata.canonical_url}
    {* Multiple locations, pointing Search Engines to the original *}
    <link rel="canonical" href="{$pagedata.canonical_url|ezurl('no','full')}" />
{elseif $pagedata.canonical_language_url}
    {* Language url, generated with LanguageSwitcherClass *}
    <link rel="canonical" href="{$pagedata.canonical_language_url|wash}" />
{elseif $requested_uri_string}
    <link rel="canonical" href="{$requested_uri_string|ezurl('no','full')}" />
{/if}
