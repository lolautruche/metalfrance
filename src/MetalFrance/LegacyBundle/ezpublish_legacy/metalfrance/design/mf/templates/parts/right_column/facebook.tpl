        <section id="mf-facebook" class="mf-section">
          <h4 class="mf-title">/// {'Facebook'|i18n( 'extension/metalfrance' )}<span class="mf-sprite-header mf-sprite-facebook"></span></h4>
          <div class="mf-top">
	          <script src={"http://connect.facebook.net/fr_FR/all.js#xfbml=1"|i18n( 'extension/metalfrance/facebook', 'To localize, just change the locale part (fr_FR) in the URL' )}></script>
	          <fb:like-box href={ezini( 'SocialSettings', 'FacebookPage', 'metalfrance.ini' )|ezurl} width="280" colorscheme="light" show_faces="true" stream="false" header="true"></fb:like-box>
	      </div>
        </section>