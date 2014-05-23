{* Blog post - Full view *}
{ezpagedata_append( 'main_section_classes', 'mf-clear' )}
{def $author = $node.object.owner.name|upfirst
     $aDefaultAuthorsID = array( 14, ezini( 'ImportSettings', 'RobotUserID', 'sqliimport.ini' ) )}
{* Si admin ou XML robot => Auteur par défaut *}
{if $aDefaultAuthorsID|contains( $node.object.owner.id )}{set $author = ezini( 'GeneralSettings', 'DefaultAuthor', 'metalfrance.ini' )}{/if}
{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'related_content', 'agenda' ) )}

  <article class="mf-actu">

    <div class="content-view-full">
        <div class="class-blog-post float-break">

            <header class="news-header">
                <h1 class="mf-title">/// {$node.data_map.title.content|wash}<span class="mf-sprite-header mf-sprite-news"></span></h1>

	            <div class="attribute-byline">
	                <p class="author">{'Publié le %date par %author'|i18n( 'extension/metalfrance',, hash(
	                                                                           '%date', $node.object.published|l10n( 'shortdatetime' ),
	                                                                           '%author', $author
	                                                                     ) )}</p>
                    
	                {attribute_view_gui attribute=$node.data_map.tags}
	            </div>
            </header>

            <div class="attribute-body float-break">
                {set-block variable=$body}{attribute_view_gui attribute=$node.data_map.body}{/set-block}
                {$body|autolink|wordtoimage}
            </div>
            
        </div>
        
    </div>
    
    <div class="mf-adsense-article">{include uri="design:adsense_block.tpl" adsenseIdentifier="article"}</div>

  </article>

{include uri="design:parts/share.tpl" url=$node.url_alias title=$node.name tweet=$node.name}

    <section class="mf-commentaires">
	    <h3 class="mf-hidden">{'Commentaires des internautes'|i18n( 'extension/metalfrance' )}</h3>
	    
	    {attribute_view_gui attribute=$node.data_map.comments}
    </section>
  