{* Categorie Analytics *}
{ezpagedata_set( 'categorie_analytics', 'Photos' )}
{def $limit = ezini( 'GallerySettings', 'ListLimit', 'metalfrance.ini' )
     $galleries = fetch( 'content', 'list', hash(
        'parent_node_id', $node.node_id,
        'class_filter_type', 'include',
        'class_filter_array', array( 'mf_gallerie' ),
        'sort_by', array( 'published', false() ),
        'offset', $view_parameters.offset,
        'limit', $limit
     ) )
     $galleriesCount = fetch( 'content', 'list_count', hash(
        'parent_node_id', $node.node_id,
        'class_filter_type', 'include',
        'class_filter_array', array( 'mf_gallerie' )
     ) )}
     
      <h1 class="mf-title">/// {$node.name}<span class="mf-sprite-header mf-sprite-photo"></span></h1>
 
      <section class="mf-gallery-list">
        <ul class="mf-list mf-photos mf-clear">
        
        {foreach $galleries as $gallery}
          {* Cache block to avoid overhead when gallery frontpage is expired *}
          {cache-block keys=array( 'gallery_list_item', $gallery.node_id ) subtree_expiry=$gallery.node_id expiry=0}
           {def $photo = fetch( 'content', 'list', hash(
                    'parent_node_id', $gallery.node_id,
                    'class_filter_type', 'include',
                    'class_filter_array', array( 'image' ),
                    'sort_by', array( 'published', false() ),
                    'limit', 1
                ) ).0}
           <li>
	           <div class="mf-polaroid">
	               <div class="mf-polaroid-image">
                       <img src={$photo.data_map.image.content.polaroid.url|ezroot} alt="{$photo.data_map.titre.content|wash}" />
	               </div>
	               <span><a href={$gallery.url_alias|ezurl} class="mf-polaroid-link">{$gallery.data_map.titre.content|wash}</a></span>
	               <div class="content">
                       <h3>{'Photos live Métal de %titre à %lieu'|i18n( 'extension/metalfrance/gallery',, hash( '%titre', $gallery.data_map.titre.content|wash,
                                                                                                                '%lieu', $gallery.data_map.lieu.content|wash ) )}</h3>
                     {if $gallery.data_map.description.has_content}
                       <p>{$gallery.data_map.description.content.output.output_text|striptags|trim|simplify|shortenw( 200 )}</p>
                     {/if}
                   </div>
	           </div>
	       </li>
	       {undef $photo}
	     
	     {/cache-block}
        {/foreach}
        </ul>
      </section>
     {include name=navigator
              uri='design:navigator/google.tpl'
              page_uri=$node.url_alias
              item_count=$galleriesCount
              view_parameters=$view_parameters
              item_limit=$limit}
