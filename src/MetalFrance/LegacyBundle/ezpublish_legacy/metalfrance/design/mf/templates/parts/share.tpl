{*
    $url : URL à partager
    $title : Titre à partager
    $tweet : Contenu pour Twitter
*}
  <section class="mf-share">
    <h3 class="mf-hidden">{'Partager cet article'|i18n( 'extension/metalfrance' )}</h3>
    <script type="text/javascript">var shareTitle = "{$title|urlencode}";</script>
    
	<ul class="mf-clear">
	    <li class="share-twitter"><a href={"http://twitter.com/share"|ezurl} class="twitter-share-button" data-count="vertical" data-via="metalfrance" data-text="{$tweet}">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></li>
	    <li class="share-facebook"><script src="http://connect.facebook.net/fr_FR/all.js#xfbml=1"></script><fb:like href={$url|ezurl( 'yes', 'full' )} layout="box_count" show_faces="true" width="58"></fb:like></li>
	    <li class="share-google-plusone" id="mf-google-plusone"><g:plusone size="tall" callback="googlePlusOneCallback"></g:plusone></li>
	    <li class="share-myspace"><a href="javascript:void(window.open('http://www.myspace.com/Modules/PostTo/Pages/?u='+encodeURIComponent(document.location.toString())+'&amp;t='+shareTitle,'ptm','height=450,width=550').focus())"><img src="http://cms.myspacecdn.com/cms//ShareOnMySpace/Myspace_btn_ShareOnMyspace.png" border="0" alt="Share on Myspace" /></a></li>
	</ul>
  </section>