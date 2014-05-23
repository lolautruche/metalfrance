    <nav role="navigation">
      <div id="mf-nav">
        <ul class="mf-clear">
        {cache-block keys=array( 'menu', 'news' ) expiry=0 subtree_expiry=ezini( 'NodeSettings', 'News', 'metalfrance.ini' )}
          {def $newsPage = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'News', 'metalfrance.ini' ) ) )}
          <li>
            <a href={$newsPage.url_alias|ezurl} title="{"Toute l'actualité Métal musique"|i18n( 'extension/metalfrance/menu' )}">{'News'|i18n( 'extension/metalfrance' )}</a>
          </li>
        {/cache-block}
        {cache-block keys=array( 'menu', 'reviews' ) expiry=0 subtree_expiry=ezini( 'NodeSettings', 'Reviews', 'metalfrance.ini' )}
          {def $chroniques = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'Reviews', 'metalfrance.ini' ) ) )}
          <li>
            <a href={$chroniques.url_alias|ezurl} title="{"Retrouvez les critiques des derniers albums de métal"|i18n( 'extension/metalfrance/menu' )}">{'Chroniques'|i18n( 'extension/metalfrance' )}</a>
            <ul>
                <li><a href={$chroniques.url_alias|ezurl} rel="nofollow">{'Nouveautés'|i18n( 'extension/metalfrance' )}</a></li>
                <li><a href={concat( $chroniques.url_alias, "/(type)/decouvertes" )|ezurl}>{'Découvertes'|i18n( 'extension/metalfrance' )}</a></li>
            </ul>
          </li>
        {/cache-block}
        {cache-block keys=array( 'menu', 'concerts' ) expiry=0 subtree_expiry=ezini( 'NodeSettings', 'Agenda', 'metalfrance.ini' )}
          {def $concerts = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'Agenda', 'metalfrance.ini' ) ) )}
          <li><a href={$concerts.url_alias|ezurl} title="{"Tous les derniers concerts groupes de métal"|i18n( 'extension/metalfrance/menu' )}">{'Concerts'|i18n( 'extension/metalfrance' )}</a></li>
        {/cache-block}
        {cache-block keys=array( 'menu', 'livereports' ) expiry=0 subtree_expiry=ezini( 'NodeSettings', 'LiveReports', 'metalfrance.ini' )}
          {def $liveReports = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'LiveReports', 'metalfrance.ini' ) ) )}
          <li>
            <a href={$liveReports.url_alias|ezurl} title="{"Les derniers live reports sur les concerts de métal"|i18n( 'extension/metalfrance/menu' )}">{'Live reports'|i18n( 'extension/metalfrance' )}</a>
          </li>
        {/cache-block}
        {cache-block keys=array( 'menu', 'photos' ) expiry=0 subtree_expiry=ezini( 'NodeSettings', 'Photos', 'metalfrance.ini' )}
          {def $photos = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'Photos', 'metalfrance.ini' ) ) )}
          <li><a href={$photos.url_alias|ezurl} title="{"Venez découvrir les photos de concerts de métal"|i18n( 'extension/metalfrance/menu' )}">{'Photos'|i18n( 'extension/metalfrance' )}</a></li>
        {/cache-block}
        {cache-block keys=array( 'menu', 'interviews' ) expiry=0 subtree_expiry=ezini( 'NodeSettings', 'Interviews', 'metalfrance.ini' )}
          {def $interviews = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'Interviews', 'metalfrance.ini' ) ) )}
          <li><a href={$interviews.url_alias|ezurl} title="{"Les dernières interviews de groupes"|i18n( 'extension/metalfrance/menu' )}">{'Interviews'|i18n( 'extension/metalfrance' )}</a></li>
        {/cache-block}
          <li>
            <a href={ezini( 'LinkSettings', 'Forum', 'metalfrance.ini' )|ezurl}>{'Communauté'|i18n( 'extension/metalfrance' )}</a>
            <ul>
                <li><a href={ezini( 'LinkSettings', 'Forum', 'metalfrance.ini' )|ezurl}>{'Forum'|i18n( 'extension/metalfrance' )}</a></li>
                <li><a href={ezini( 'LinkSettings', 'Twitter', 'metalfrance.ini' )|ezurl} target="_blank">{'Twitter'|i18n( 'extension/metalfrance' )}</a></li>
                <li><a href={ezini( 'LinkSettings', 'Facebook', 'metalfrance.ini' )|ezurl} target="_blank">{'Facebook'|i18n( 'extension/metalfrance' )}</a></li>
                <li><a href={'/contact'|ezurl}>{'Contact'|i18n( 'extension/metalfrance' )}</a></li>
            </ul>
          </li>
          <li>
	        <div id="header-search">
	            {include uri="design:page_header_searchbox.tpl"}
	        </div>
          </li>
        </ul>
        <div class="mf-nav-left"></div>
        <div class="mf-nav-right"></div>
      </div>
    </nav>
