{* Interview - Full view *}
{def $artiste = $node.data_map.artiste.content|wash
     $date = $node.data_map.date.content.timestamp|l10n( 'shortdate' )}
{* Meta author *}
{if $node.data_map.auteur_v2.has_content}{* Retro compatibilite avec v2 *}
    {def $authors = $node.data_map.auteur_v2.content|wash}
{elseif $node.data_map.auteur.has_content}
	{set-block variable=$authors}
	    {foreach $node.data_map.auteur.content.author_list as $author}
	        {delimiter}, {/delimiter}
	        {$author.name}
	    {/foreach}
	{/set-block}
	{set $authors = $authors|wash|trim|simplify}
{else}
    {def $authors = ezini( 'GeneralSettings', 'DefaultAuthor', 'metalfrance.ini' )}
{/if}
{ezpagedata_set( 'author', $authors )}
{* Meta description *}
{def $description = 'Interview du groupe de metal %artiste par %auteur de Metal France'|i18n( 'extension/metalfrance/gallery',, hash(
						                                                                            '%artiste', $artiste,
						                                                                            '%auteur', $authors
						                                                                     ) )}
{ezpagedata_set( 'description', $description )}
{ezpagedata_append( 'main_section_classes', 'mf-clear' )}
{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'related_content', 'gallery' ) )}

<article id="mf-interview">

    <header class="mf-interview-header">
        <h1 class="mf-title">/// {'Interview de %artiste'|i18n( 'extension/metalfrance/interview',, hash( '%artiste', $artiste ) )}<span class="mf-sprite-header mf-sprite-micro"></span></h1>
        <div class="mf-interview-presentation">
            {if $node.data_map.image.has_content}
            {ezpagedata_set( 'og:image', $node.data_map.image.content.review.url|ezroot( 'no', 'full' ) )}{* Image pour Facebook *}
            <p class="image-header-interview">
              <a href={$node.data_map.image.content.imagelarge.url|ezroot} rel="prettyPhoto">
                <img src={$node.data_map.image.content.large.url|ezroot} alt="{$node.data_map.image.content.alternative_text}" />
              </a>
            </p>
            {/if}
            
	        <p class="author">{'Publié le %date par %author'|i18n( 'extension/metalfrance',, hash(
	                                                                   '%date', $node.object.published|l10n( 'shortdate' ),
	                                                                   '%author', $authors
	                                                             ) )}</p>
            
            <div class="mf-introduction">
                {attribute_view_gui attribute=$node.data_map.introduction}
            </div>
	                
        </div>
    </header>

    <section class="mf-interview-body">
        {set-block variable=$body}{attribute_view_gui attribute=$node.data_map.interview}{/set-block}
        {$body|autolink|wordtoimage}
    </section>
    
    {*<div class="mf-adsense-article">{include uri="design:adsense_block.tpl" adsenseIdentifier="article"}</div>*}
    
{include uri="design:parts/share.tpl" url=$node.url_alias title=$node.name tweet=concat( 'Interview #metal ', $node.name )}

    <section class="mf-commentaires">
        <h3 class="mf-hidden">{'Commentaires des internautes'|i18n( 'extension/metalfrance' )}</h3>
        
        {symfony_render(
            symfony_controller(
                'ez_comments.controller.comments_renderer:renderForContentAction',
                hash( 'contentId', $node.contentobject_id )
            )
        )}
    </section>

</article>
