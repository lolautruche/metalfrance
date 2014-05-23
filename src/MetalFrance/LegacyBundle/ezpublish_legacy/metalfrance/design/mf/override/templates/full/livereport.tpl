{* Live report - Full view *}
{def $titre = $node.data_map.manifestation.content|wash
     $lieu = $node.data_map.lieu.content|wash
     $date = $node.data_map.date.content.timestamp|l10n( 'shortdate' )}
{* Meta description *}
{def $description = 'Live report de %titre, à %lieu le %date'|i18n( 'extension/metalfrance/gallery',, hash(
                                                                            '%titre', $titre,
                                                                            '%lieu', $lieu,
                                                                            '%date', $date
                                                                     ) )}
{ezpagedata_set( 'description', $description )}
{* Meta author *}
{set-block variable=$authors}
    {foreach $node.data_map.auteurs.content.author_list as $author}
        {delimiter}, {/delimiter}
        {$author.name}
    {/foreach}
{/set-block}
{set $authors = $authors|wash|trim|simplify}
{if $authors|not}{set $authors = ezini( 'GeneralSettings', 'DefaultAuthor', 'metalfrance.ini' )}{/if}
{ezpagedata_set( 'author', $authors )}
{ezpagedata_append( 'main_section_classes', 'mf-clear' )}

{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'related_content', 'interview' ) )}

<article id="mf-livereport">

    <header class="mf-livereport-header">
        <h1 class="mf-title">/// {$titre}<span class="mf-sprite-header mf-sprite-micro"></span></h1>
        <div class="mf-livereport-presentation">
	        <h3 class="lieu">{$lieu} ({$date})</h3>
	        
            {if $node.data_map.image.has_content}
            {ezpagedata_set( 'og:image', $node.data_map.image.content.review.url|ezroot( 'no', 'full' ) )}{* Image pour Facebook *}
            <p class="image-header-livereport">
              <a href={$node.data_map.image.content.imagelarge.url|ezroot} rel="prettyPhoto">
                <img src={$node.data_map.image.content.large.url|ezroot} alt="{$node.data_map.image.content.alternative_text}" />
              </a>
            </p>
            {/if}
	                
        </div>
    </header>

    <section class="mf-livereport-body">
        <p class="author">{'Publié le %date par %author'|i18n( 'extension/metalfrance',, hash(
                                                                   '%date', $node.object.published|l10n( 'shortdate' ),
                                                                   '%author', $authors
                                                             ) )}</p>
        {set-block variable=$body}{attribute_view_gui attribute=$node.data_map.contenu}{/set-block}
        {$body|autolink|wordtoimage}
    </section>

    <div class="mf-adsense-article">{include uri="design:adsense_block.tpl" adsenseIdentifier="article"}</div>
    
{include uri="design:parts/share.tpl" url=$node.url_alias title=$node.name tweet=concat( 'Live report #metal ', $node.name )}

    <section class="mf-commentaires">
        <h3 class="mf-hidden">{'Commentaires des internautes'|i18n( 'extension/metalfrance' )}</h3>
        
        {attribute_view_gui attribute=$node.data_map.comments}
    </section>

</article>
