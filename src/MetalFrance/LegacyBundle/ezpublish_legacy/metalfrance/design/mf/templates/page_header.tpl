    <header id="mf-header" role="banner">
      {* Pub *}
      <div class="mf-pub-728x90" id="mf-pub-leaderboard">
        <script type='text/javascript'>GA_googleFillSlotWithSize("{ezini( 'AdSettings', 'DFPPubID', 'metalfrance.ini' )}", "{"Leaderboard_728x90"}", 728, 90);</script>
      </div>
      <div class="mf-clear">
        <div class="mf-col-first">
          <a href={'/'|ezurl}><img src={"img_logo_580x150.png"|ezimage} width="580" height="150" alt="{'Metal France - LE METAL A L’ESPRIT LARGE'|i18n( 'extension/metalfrance' )}" /></a>
        </div>
        <div class="mf-col-last">
        {if $current_user.is_logged_in}
          <section id="mf-profil">
            <a href={'/user/edit'|ezurl}>{'Mon profil'|i18n( 'extension/metalfrance' )} ({$current_user.contentobject.name|wash})</a>
            <a href={'/user/logout'|ezurl}>{'Déconnexion'|i18n( 'extension/metalfrance' )}</a>
          </section>
        {else}
          <section id="mf-connexion">
            <a href={"/user/login"|ezurl}><span>///</span> {'Connexion'|i18n( 'extension/metalfrance' )} <span>\\\</span></a>
            {def $janrainSigninURL = fetch( 'janrain', 'signin_url' )}
            <a href={$janrainSigninURL|ezurl} class="rpxnow"><img src={'bg_login.png'|ezimage} alt="{'Connexion via un service externe'|i18n( 'extension/metalfrance' )}" /></a>
          </section>
        {/if}

{include uri="design:parts/news_header.tpl"}

        </div>
      </div>
    </header>