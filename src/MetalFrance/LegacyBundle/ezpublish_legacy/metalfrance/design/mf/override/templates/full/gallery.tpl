{def $titre = $node.data_map.titre.content|wash
     $lieu = $node.data_map.lieu.content|wash
     $date = $node.data_map.date.content.timestamp|l10n( 'shortdate' )}
{* Meta description *}
{def $description = 'Galerie photo %titre, à %lieu le %date'|i18n( 'extension/metalfrance/gallery',, hash(
                                                                            '%titre', $titre,
                                                                            '%lieu', $lieu,
                                                                            '%date', $date
                                                                     ) )}
{ezpagedata_set( 'description', $description )}
{* Meta author *}
{set-block variable=$authors}
    {foreach $node.data_map.auteur.content.author_list as $author}
        {delimiter}, {/delimiter}
        {$author.name}
    {/foreach}
{/set-block}
{set $authors = $authors|wash|trim|simplify}
{if $authors|not}{set $authors = ezini( 'GeneralSettings', 'DefaultAuthor', 'metalfrance.ini' )}{/if}
{ezpagedata_set( 'author', $authors )}
<article id="mf-gallery">
  <header class="mf-gallery-header" class="mf-clear">
    <h1 class="mf-title">{$titre}<span class="mf-sprite-header mf-sprite-photo"></span></h1>
    <div class="mf-gallery-presentation">
	    {if $node.data_map.image.has_content}<img class="mf-gallery-logo" src={$node.data_map.image.content.medium.url|ezroot} alt="{$description}" />{/if}
	    <h3>{$lieu} ({$date})</h3>
	    <p class="author">{'Photos : %author pour Metal France'|i18n( 'extension/metalfrance/gallery',, hash( '%author', $authors ) )}</p>
    </div>
  </header>
  <section class="mf-gallery-body">
  {if $node.data_map.description.has_content}
	<div class="mf-gallery-description">
	   {attribute_view_gui attribute=$node.data_map.description}
	</div>
  {/if}
	<ul class="mf-list mf-photos mf-clear">
	{foreach $node.children as $i => $photo}
	  {if $i|eq( 0 )}{ezpagedata_set( 'og:image', $photo.data_map.image.content.review.url|ezroot( 'no', 'full' ) )}{* Image pour Facebook *}{/if}
	  {cache-block keys=array( 'gallery_photo_item', $photo.node_id )}
	    <li>
	       <div class="mf-polaroid">
	           <div class="mf-polaroid-image">
	               <a href={$photo.data_map.image.content.imagelarge.url|ezroot} rel="prettyPhoto[pp_gal]">
	                 <img src={$photo.data_map.image.content.polaroid.url|ezroot} alt="{$photo.data_map.name.content|wash}" />
	               </a>
	           </div>
	       </div>
	    </li>
	  
	  {/cache-block}
	{/foreach}
	</ul>

    <div class="mf-adsense-article">{include uri="design:adsense_block.tpl" adsenseIdentifier="article"}</div>
	
{include uri="design:parts/share.tpl" url=$node.url_alias title=$node.name tweet=concat( 'Photos #metal ', $titre, ' - ', $lieu )}

    <section class="mf-commentaires">
        <h3 class="mf-hidden">{'Commentaires des internautes'|i18n( 'extension/metalfrance' )}</h3>
	    
	    {attribute_view_gui attribute=$node.data_map.comments}
    </section>
  </section>
</article>
