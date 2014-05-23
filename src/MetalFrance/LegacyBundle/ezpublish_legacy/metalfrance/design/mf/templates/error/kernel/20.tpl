<h2 class="mf-title mf-noicon">{"Erreur - Page introuvable"|i18n( "extension/metalfrance/error" )}</h2>
<div class="mf-body">
	<div class="warning mf-top">
		<p>{"La page que vous demandez est introuvable sur le site."}</p>
		<p>&nbsp;</p>
		<p><a href={"/"|ezurl}>{"Retourner à la page d'accueil"|i18n( 'extension/metalfrance' )}</a></p>
	</div>
	
	{cache-block keys=array( 'sitemap', '404' ) expiry=0}
	<div style="margin: 40px 0 0 -25px;">
	   {def $sitemapNode = fetch( 'content', 'node', hash( 'node_id', 2 ) )}
	   {node_view_gui content_node=$sitemapNode view="sitemap"}
	</div>
	{/cache-block}
</div>
