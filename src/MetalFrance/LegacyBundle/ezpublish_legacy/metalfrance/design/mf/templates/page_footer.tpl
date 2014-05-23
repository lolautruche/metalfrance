<footer id="mf-footer">
    <section class="mf-authors">
        <a href={"http://www.autographique.net"|ezurl} target="_blank"><img src={"ico/autographique.png"|ezimage} alt="Autographique webdesign" /></a>
        <a href={"http://www.lolart.net"|ezurl} target="_blank"><img src={"ico/lolart.png"|ezimage} alt="Lolart.net, développement web, eZ Publish" /></a>
    </section>
    
    <section class="mf-footer-links">
    {cache-block keys='footer-links' expiry=0 subtree_expiry='footer'}
      {def $footer = fetch( 'content', 'node', hash( 'node_path', 'footer' ) )}
      {attribute_view_gui attribute=$footer.data_map.body}
        
    {/cache-block}
        <br />
        
        Powered by <a href={"http://share.ez.no"|ezurl} target="_blank" title="eZ Publish&#8482; CMS Open Source Web Content Management, Community edition">eZ Publish&#8482; Community Edition</a> &amp; <a href={"http://vanillaforums.org"|ezurl} target="_blank">Vanilla Forums</a>.
        {"Copyright © 2011 Metal France. Tous droits réservés."|i18n( 'extension/metalfrance' )}
    </section>   
</footer>
