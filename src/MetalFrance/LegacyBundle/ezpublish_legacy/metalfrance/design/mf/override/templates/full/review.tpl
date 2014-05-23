{* Meta description *}
{ezpagedata_set( 'description', $node.data_map.introduction.content|wash|trim|simplify|shortenw( 200 ) )}
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
{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'amazon_player', 'related_content', 'livereport' ) )}
{* Infos diverses *}
{ezpagedata_set( 'review_title', $node.name )}
{ezpagedata_append( 'main_section_classes', 'mf-clear' )}
  <div class="mf-chronique-entete mf-clear">
{def $artiste = fetch( 'content', 'related_objects', hash( 
          'object_id', $node.contentobject_id,
          'attribute_identifier', 'mf_chronique_cd/artiste' 
     ) ).0
     $album = $node.data_map.album.content|wash
     $note = $node.data_map.note.content
     $aKeywords = array( $artiste.name, $album, 'Chronique album' )
     $aMetaData = ezini( 'SiteSettings', 'MetaDataArray' )}
{* Meta Keywords *}
{set $aKeywords = $aKeywords|append( $node.data_map.styles.content.keyword_string )}
{ezpagedata_set( 'keywords', concat( $aKeywords|implode( ', ' ), ', ', $aMetaData['keywords'] ) )}
      <h1 class="mf-chronique-titre mf-title">{$artiste.name|upcase} - {$album}</h1>
      <div class="mf-chronique-note"><!--
      {for 1 to 5 as $counter}
        {* 
            Note sur 10 ramenée sur 5
            Chaque point (pastille) entier vaut donc 2 points
            A chaque passage on retire donc 2 points à $note. 
            - Si $note < 0 => pastille vide
            - Si $note - 2 >= 0 => pastille entière
            - Si $note -2 < 0 => demi-pastille 
            
            Note : Les commentaires HTML sont là pour supprimer les effets de bord liés aux espaces blancs
        *}
        {if and( $note|sub( 2 )|ge( 0 ), $note|gt( 0 ) )}
        --><div class="mf-note-full"></div><!--
        {elseif and( $note|sub( 2 )|lt( 0 ), $note|gt( 0 ) )}
        --><div class="mf-note-half"></div><!--
        {else}
        --><div class="mf-note-empty"></div><!--
        {/if}
        {set $note = $note|sub( 2 )}
      {/for}
      --></div>
      <div class="adsense">{include uri="design:adsense_block.tpl" adsenseIdentifier="thematiques460x15"}</div>
  </div>
  
  <article class="mf-chronique">
    <h3 class="mf-hidden">{'Chronique'|i18n( 'extension/metalfrance/review' )}</h3>
  
    <div class="mf-album">
    {if $node.data_map.pochette.has_content}
        <a rel="prettyPhoto" href={$node.data_map.pochette.content.imagelarge.url|ezroot}><img class="mf-pochette" src={$node.data_map.pochette.content.review.url|ezroot} alt="{"Pochette de l'album %album par %artiste"|i18n( 'extension/metalfrance/review',, hash( '%album', $album, '%artiste', $artiste.name ) )}" /></a>
        {ezpagedata_set( 'og:image', $node.data_map.pochette.content.review.url|ezroot( 'no', 'full' ) )}{* Image pour Facebook *}
        
    {/if}
        <ol>
        {def $playlist = $node.data_map.playlist.content|wash|trim}
        {foreach $playlist|explode( "\n" ) as $track}
            <li>{$track|preg_replace( '@^[0-9]+([.)-])?@', '' )|trim}</li>
        {/foreach}
        </ol>
        
        {* Adsense *}
        {include uri="design:adsense_block.tpl" adsenseIdentifier="review1"}
        
    {if or( $artiste.data_map.site.has_content, $artiste.data_map.myspace.has_content )}
        <h4>{'Site(s) du groupe'|i18n( 'extension/metalfrance' )} :</h4>
        {if $artiste.data_map.myspace.has_content}<a href={$artiste.data_map.myspace.content|ezurl} target="_blank" title="{'MySpace de %groupe'|i18n( 'extension/metalfrance/review',, hash( '%groupe', $artiste.name ) )}"><img src={'myspace_icon.png'|ezimage} alt="{'MySpace de %groupe'|i18n( 'extension/metalfrance/review',, hash( '%groupe', $artiste.name ) )}" /></a>{/if}
        {if $artiste.data_map.site.has_content}<a href={$artiste.data_map.site.content|ezurl} target="_blank" title="{'Site web de %groupe'|i18n( 'extension/metalfrance/review',, hash( '%groupe', $artiste.name ) )}"><img src={'website_icon.png'|ezimage} alt="{'Site web de %groupe'|i18n( 'extension/metalfrance/review',, hash( '%groupe', $artiste.name ) )}" /></a>{/if}
    {/if}
    </div>
    
    <div>
        <div class="mf-album-style">
	    {def $tag = ''}
	    {if $node.data_map.styles.content.tag_ids|count}
	      {foreach $node.data_map.styles.content.tag_ids as $tag_id}
	        {set $tag = fetch( tags, object, hash( tag_id, $tag_id ) )}
	        <a href={concat( '/tags/view/', $tag.url )|ezurl} title="{"Les chroniques Metal pour le style %style"|i18n( 'extension/metalfrance/review',, hash( '%style', $tag.keyword ) )}">{$tag.keyword|wash}</a>{delimiter}, {/delimiter}
	      {/foreach}
        {else}
            {'Style : voir chronique'|i18n( 'extension/metalfrance/review' )}
	    {/if}
	    {undef $tag}
        </div>
        <div class="mf-author">{'Par'|i18n( 'extension/metalfrance' )} <b>{$authors}</b></div>
    </div>
    
    <p class="date">{'Publié le %date'|i18n( 'extension/metalfrance',, hash( '%date', $node.object.published|l10n( 'shortdate' ) ) )}</p>
    {if $node.data_map.amazon_id.has_content}
        {def $amazonItem = fetch( 'amazonadvertising', 'item_lookup', hash( 'id', $node.data_map.amazon_id.content.product_id ) )}
		{ezpagedata_set( 'amazon_item', $amazonItem )}{* Amazon item pour le player *}
        <a href={$amazonItem.url|ezurl} class="mf-amazon-small" target="_blank">{'Télécharger légalement'|i18n( 'extension/metalfrance/review' )}</a>
    {else}
        <p>&nbsp;</p>
    {/if}
    
    {attribute_view_gui attribute=$node.data_map.contenu}
    
    <div class="mf-adsense-article">{include uri="design:adsense_block.tpl" adsenseIdentifier="article"}</div>
  </article>
  
{include uri="design:parts/share.tpl" url=$node.url_alias title=$node.name tweet=concat( 'Chronique #metal ', $node.name )}

  <section class="mf-notes-internautes">
    <h3>{'Notes des internautes'|i18n( 'extension/metalfrance/review' )} ({'cliquez pour noter'|i18n( 'extension/metalfrance/review' )}) :</h3>
    
    {attribute_view_gui attribute=$node.data_map.note_internautes}
  </section>

  <section class="mf-commentaires">
    <h3 class="mf-hidden">{'Commentaires des internautes'|i18n( 'extension/metalfrance' )}</h3>
    
    {attribute_view_gui attribute=$node.data_map.comments}
  </section>